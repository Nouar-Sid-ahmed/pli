require('dotenv').config();
const nodemailer = require('nodemailer');
const User = require('../model/usermodel');

// module.exports.transport = nodemailer.createTransport({
//     host: "smtp.gmail.com",
//     port: 465,
//     secure: true,
//     auth: {
//         user: process.env.EMAIL_USERNAME,
//         pass: process.env.EMAIL_PASSWORD
//     }
// });
module.exports.mailcreateur = (Type, user, name, message) => {
    switch (Type) {
        case 'upload':
            return {
                from: "myYoutube",
                to: user.email,
                subject: 'Status de l\'enregistrement de '+name,
                text: 'Your message in text',
                html: '<h2>Your myYoutube</h2><p>Est fière de vous annoncer que la vidéo '+name+' est enfin téléchargé sur nos serveur, merci '+user.username+' pour ta contribution.<br>'+
                'Veuillez patienter le temps de créer les différents formats.<br>'+
                'En attendant profitez de nos autres programmes,</p>',
            };
        case 'uploadForma':
            return {
                from: "myYoutube",
                to: user.email, // List of recipients
                subject: 'Status de l\'enregistrement de '+name,
                text: 'Your message in text',
                html: '<h2>Your myYoutube</h2><p>Est fière de vous annoncer que la vidéo '+name+' est enfin téléchargé et encodé aux format'+message+', merci '+user.username+' pour ta contribution.</p>',
            };
        case 'ChangePassword':
            return {
                from: "myYoutube",
                to: user.email, // List of recipients
                subject: 'Mot de passe oublié',
                text: 'Your message in text',
                html: '<h2>Your myYoutube</h2><p>Cliqué <a href="'+message+'">ici</a>, pour modifier votre mot de passe.</p>',
            };
        case 'ChangePassewordValidet':
            return {
                from: "myYoutube",
                to: user.email, // List of recipients
                subject: 'Mot de passe oublié',
                text: 'Your message in text',
                html: '<h2>Your myYoutube</h2><p>Voila '+user.username+', ton mot de passe à êtes modifier avec succes.</p>',
            };
        case 'Register':
            return {
                from: "myYoutube",
                to: user.email, // List of recipients
                subject: 'Confirmation de email',
                text: 'Your message in text',
                html: '<h2>Your myYoutube</h2><p>Voila '+user.username+', ton compte à étes créé avec succes.<br>'+
                'Pour finaliser ton inscription tu peux cliquer <a href'+message+'>ici</a> pour valider ton inscription.</p>',
            };
        default:
            return {
                from: "myYoutube",
                to: user.email, // List of recipients
                subject: 'Erreur Serveur',
                text: 'Your message in text',
                html: '<h2>MyYoutube</h2><p>rencontre une erreur coté serveur vous pris de bien vouloir excuser le dérengement, veuillé retenter la maneuvre d\'ici quelque minutes merci</p>',
            };
    }
}

// var mailUploadVideo = {
//     from: "myYoutube",
//     to: userof.email, // List of recipients
//     subject: 'Status de l\'enregistrement de '+name,
//     text: 'Your message in text',
//     html: '<h2>Your myYoutube</h2><p>Est fière de vous annoncer que la vidéo '+name+' est enfin téléchargé sur nos serveur, merci '+userof.username+' pour ta contribution.<br>'+
//     'Veuillez patienter le temps de créer les différents formats.<br>'+
//     'En attendant profitez de nos autres programmes,</p>',
// };
