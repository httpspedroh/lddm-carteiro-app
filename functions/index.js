const functions = require('firebase-functions');
const { rastrearEncomendas } = require('correios-brasil');

exports.rastrearEncomendas = functions.https.onRequest(async (req, res) => {

    try {

        const codRastreio = req.body.codigosRastreio; // Recebe o array de códigos de rastreio da requisição
        const response = await rastrearEncomendas(codRastreio);
    
        // Processar a resposta da API aqui
        res.status(200).send(response);
    } 
    catch (error) {

        console.error(error);
        res.status(500).send('Erro ao rastrear encomendas');
    }
});
  