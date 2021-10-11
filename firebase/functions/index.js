const functions = require("firebase-functions");
const admin=require("firebase-admin");

admin.initializeApp();


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });


// http request method
exports.sendHttpPushNotification=functions.https.onRequest((req,res)=>{
    const userId=req.body.userId;

});


// listener method

exports.sendListenerPushNotification=functions.database.ref('/sendMessage/{userId}/').onWrite((data, context)=>{
    const userId = context.params.userId; //get params like this
});