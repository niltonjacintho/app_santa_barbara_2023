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

        await getPagina(pagina).then(function (data) { html = data; });
        var existeItem = true;
        while (existeItem) {
            var currentId = getCurrentId();
            var currentName = getObjParoquia();
            await getPaginaDetalhes(currentId).then(function (data) { htmlDetalhes = data; });
            if (currentId == 2) {
                console.log(htmlDetalhes);
                getBaseParoquia();
                console.log('VALOR DE P', p);
            }



            // p.currentId = currentId;
            // p.currentName = currentName;

            // console.log(html.indexOf('"recuperaDetalhes('))
            // html = html.substring(html.indexOf('"recuperaDetalhes('));
            // console.log(html.substring(0, 100))
            // console.log('resultado ', parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", "")));
            // var id = getCurrentId(html);
            // var htmlDetalhes = getPaginaDetalhes(id);
            // var objParoquia = getObjParoquia(htmlDetalhes);
            // console.log(objParoquia);
            existeItem = html.indexOf('"recuperaDetalhes(') != -1
        }
        existPagina = false;
    }
}
function getCurrentId() {
    html = html.substring(html.indexOf('"recuperaDetalhes('));
    return parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", ""));
}

function getObjParoquia() {
    html = html.substring(html.indexOf('"lista-link">') + 13);
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
                console.log(response.statusCode); // Print the response status code if a response was received
                resultado = body;
                resolve(body)
            }
        });
    })
}

async function getPaginaDetalhes(id) {
    var resultado = 'nada';
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
    p.nome = htmlDetalhes.substring(htmlDetalhes.indexOf('<b>') + 3, htmlDetalhes.indexOf('</b>'));
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('</b>'));
    p.forania = htmlDetalhes.substring(htmlDetalhes.indexOf('<br>') + 4, htmlDetalhes.indexOf('<br>Data')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('<br>Data'));
    p.nascimento = htmlDetalhes.substring(htmlDetalhes.indexOf(':') + 1, htmlDetalhes.indexOf('<br><br')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('<br><br>') + 8);
    p.endereco2 = htmlDetalhes.substring(0, htmlDetalhes.indexOf('<br>')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('<br>') + 4);
    p.endereco = htmlDetalhes.substring(0, htmlDetalhes.indexOf('<br>')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('<br>') + 4);
    p.endereco += ' - CEP:' + htmlDetalhes.substring(0, htmlDetalhes.indexOf('<br>')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('<br>') + 4);
    p.telefones = htmlDetalhes.substring(0, htmlDetalhes.indexOf('<br>')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('<br>') + 4);
    p.email = htmlDetalhes.substring(htmlDetalhes.indexOf(':') + 1, htmlDetalhes.indexOf('</p>')).trim();
    htmlDetalhes = htmlDetalhes.substring(htmlDetalhes.indexOf('</p>') + 4);




    //    return parseInt(html.substring(0, html.indexOf("')") + 1).split(',')[1].replace("'", ""));
}
