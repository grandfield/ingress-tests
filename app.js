const express = require('express');
const app = express();
var os = require("os");

var ip = require("ip");

app.get('/', (req, res)=>{res.send(`Hello AIDEN kubernetes Version2: ${ ip.address()}, ${os.hostname()}`);});

const PORT = process.env.PORT || 9000;

app.listen(PORT, ()=>{
 console.log(`Node listening on port ${PORT}`);
});