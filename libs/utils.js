const CryptoJS = require('crypto-js');
const moment = require('moment');
const rs = require('jsrsasign');

// Function to create the HMAC-SHA512 signature
// parameters:
// - url: The URL of the request
// - httpMethod: The HTTP method used (e.g., "POST")
// - accessToken: The access token for authentication
// - clientSecret: The client secret for authentication
// - timestamp: The timestamp for the request
// - bodyPayload: The body payload to be signed
function createTrxSignature(signatureObj) {
    // Hash the body payload using SHA-256
    const sha256Hash = CryptoJS.SHA256(signatureObj.bodyPayload);
    const sha256SecretKey = sha256Hash.toString(CryptoJS.enc.Hex).toLowerCase();
    
    // Create the string to sign
    const hmac512Body = `${signatureObj.httpMethod}:${signatureObj.url}:${signatureObj.accessToken}:${sha256SecretKey}:${signatureObj.timestamp}`;
    console.log('Create TrxSignature string to sign', hmac512Body);

    // Create the HMAC-SHA512 signature
    const hmac512 = CryptoJS.HmacSHA512(CryptoJS.enc.Utf8.parse(hmac512Body), CryptoJS.enc.Utf8.parse(signatureObj.clientSecret));
    const signatureToken = CryptoJS.enc.Base64.stringify(hmac512);

    return signatureToken;
}

function createAuthSignature(privateKey, clientId, timestamp) {
  const string2sign = clientId + "|" + timestamp;
  console.log("Create Auth Signature string to sign", string2sign);

  const sig = new rs.KJUR.crypto.Signature({"alg": "SHA256withRSA"});
  sig.init(privateKey);
  
  const hash = sig.signString(string2sign);
  const signedEncoded = CryptoJS.enc.Base64.stringify(CryptoJS.enc.Hex.parse(hash));

  return signedEncoded;
}

function getTimestamp() {
  const formattedDate = moment().format();

  return formattedDate;
}

module.exports = {
  createTrxSignature,
  createAuthSignature,
  getTimestamp,
}