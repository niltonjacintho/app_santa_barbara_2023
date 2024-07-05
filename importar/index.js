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
            limparHtml();
            console.log(currentName);
            await getPaginaDetalhes(currentId).then(function (data) { this.htmlDetalhes = data; });
            if (currentId == 2 | true) {
                // console.log('DETALHES DE HTMLDETALHES ', htmlDetalhes);
                getBaseParoquia();
                console.log('VALOR DE P', p);
                getCapelas();
                getPadres();
            }
            p.currentId = currentId;
            p.currentName = currentName;
            paroquias.push(p);
            existeItem = this.html.indexOf('"recuperaDetalhes(') != -1
        }
        console.log('end')
        //existPagina = false;
    }
}

function limparHtml(){
    this.html = this.html.substring(this.html.indexOf("recuperaDetalhes('panel-body")+41);
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

function getCapelas() {
    p.capelas = [];
    let html = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('Locais de culto'));
    html = html.substring(html.indexOf('<ul>'));
    html.split('<li>').forEach(element => {
        if (element.trim().length > 10) {
            capela = {};
            if (element.length > 2) {
                capela.nome = element.substring(0, element.indexOf('<')).replace('&nbsp;', '').trim();
                if (element.indexOf('exibirMapa') != -1) {
                    htmlLat = element.substring(element.indexOf('exibirMapa') + 11, element.indexOf('DIVMAP') - 3).split(',')
                    try {
                        capela.latitude = htmlLat[0];
                        capela.longitude = htmlLat[1];
                    } catch (error) {
                        capela.latitude = '';
                        capela.longitude = '';
                    }
                } else {
                    capela.latitude = '';
                    capela.longitude = '';
                }

                let htmlEnd = element.substring(element.indexOf('<div '));
                //htmlEnd =  element.substring(element.indexOf('<div>') );
                htmlEnd = htmlEnd.substring(htmlEnd.indexOf('br/>') + 4, htmlEnd.indexOf('</li'));
                arrayEndereco = htmlEnd.split('<br>')
                capela.endereco = arrayEndereco[0] != undefined ? arrayEndereco[0].replaceAll('  ', ' ') : '';
                capela.endereco2 = arrayEndereco[1] != undefined ? arrayEndereco[1].replaceAll('  ', ' ') : '';
                capela.email = arrayEndereco[2] != undefined ? arrayEndereco[2].replaceAll('  ', ' ') : '';
                capela.telefones = arrayEndereco[3] != undefined ? arrayEndereco[3].replaceAll('  ', ' ') : '';
                p.capelas.push(capela)


                // capela.nome = capela.nome.replace('&nbsp;', '');
                console.log(element)
            }
        }
    })
    return '';
}

function getPadres() {
    p.padres = [];
    const html = this.htmlDetalhes.substring(this.htmlDetalhes.indexOf('<ul>') + 4, this.htmlDetalhes.indexOf('</ul>') - 4);
    html.split('<li>').forEach(element => {
        if (element.trim().length > 2) {
            p.padres.push(element)
            console.log(element)
        }
    })
    return html.substring(0, html.indexOf("</a>")).trim();


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
