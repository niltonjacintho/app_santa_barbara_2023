const express = require('express');
const app = express();
var request = require('request');
var pagina = 1;
var existPagina = true;
var paroquias = []
var p = Object();
var html = '';
var htmlDetalhes = '';
main();

async function main() {
    while (existPagina) {

        await getPagina(pagina).then(function (data) { this.html = data; });
        var existeItem = true;
        while (existeItem) {
            var currentId = getCurrentId();
            var currentName = getObjParoquia();
            console.log(currentName);
            await getPaginaDetalhes(currentId).then(function (data) { this.htmlDetalhes = data; });
            if (currentId == 2 | true) {
                // console.log('DETALHES DE HTMLDETALHES ', htmlDetalhes);
                getBaseParoquia();
                console.log('VALOR DE P', p);
            }
            p.currentId = currentId;
            p.currentName = currentName;

            // console.log(html.indexOf('"recuperaDetalhes('))
            html = html.substring(html.indexOf('"recuperaDetalhes('));
            // console.log(html.substring(0, 100))
            // console.log('resultado ', parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", "")));
            var id = getCurrentId(html);
            var htmlDetalhes = getPaginaDetalhes(id).then(v => {
                //   console.log('detalhes => ', v)
            });
            var objParoquia = getObjParoquia(htmlDetalhes);
            // console.log('OBJ PAROQUIA ', objParoquia, 'DETALHES ', htmlDetalhes);
            existeItem = html.indexOf('"recuperaDetalhes(') != -1
        }
        existPagina = false;
    }
}
function getCurrentId() {
    const html = this.html.substring(this.html.indexOf('"recuperaDetalhes('));
    return parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", ""));
}

function getObjParoquia() {
    const html = this.html.substring(this.html.indexOf('"lista-link">') + 13);
    return html.substring(0, html.indexOf("</a>")).trim();
}

async function getPagina(pagina) {
    var resultado = 'nada';
    return new Promise(async (resolve, reject) => {
        await request({
            url: 'https://www.arqrio.com.br/curia/paroquias.php?pagina=' + pagina, //URL to hit
            method: 'GET',
            headers: {
                'Content-Type': 'MyContentType',
                'Custom-Header': 'Custom Value'
            },
        }, function (error, response, body) {
            if (error) {
                resultado = error;
                reject(error);
            } else {
                console.log(response.statusCode, body); // Print the response status code if a response was received
                resultado = body;
                resolve(body)
            }
        });
    })
}

async function getPaginaDetalhes(id) {
    // var resultado = 'nada';
    console.log('https://www.arqrio.com.br/curia/ajaxParoquiasRecuperarDetalhes.php?id=' + id)
    return new Promise(async (resolve, reject) => {
        await request({
            url: 'https://www.arqrio.com.br/curia/ajaxParoquiasRecuperarDetalhes.php?id=' + id, //URL to hit
            method: 'GET',
            headers: {
                'Content-Type': 'MyContentType',
                'Custom-Header': 'Custom Value'
            },
        }, function (error, response, body) {
            if (error) {
                resultado = error;
                reject(error);
            } else {
                resultado = body;
                resolve(body)
            }
        });
    })
}

function getBaseParoquia() {

    p.nome = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<b>') + 3, this.htmlDetalhes.indexOf('</b>'));
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('</b>'));
    p.forania = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4, this.htmlDetalhes.indexOf('<br>Data')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>Data'));
    p.nascimento = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf(':') + 1, this.htmlDetalhes.indexOf('<br><br')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br><br>') + 8);
    p.endereco2 = this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    p.endereco = this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    p.endereco += ' - CEP:' + this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    p.telefones = this.htmlDetalhes.substring(0, this.htmlDetalhes.indexOf('<br>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<br>') + 4);
    p.email = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf(':') + 1, this.htmlDetalhes.indexOf('</p>')).trim();
    this.htmlDetalhes = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('</p>') + 4);

    console.log('BASE PAROQUIA ', p)


    //    return parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", ""));
}
