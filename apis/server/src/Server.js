const express = require('express')
const mongoose = require('mongoose')
const cors = require('cors')
const body_parser = require('body-parser')
const app = express()
require('dotenv').config()
const API = require('./routes/Api');


app.set('port', process.env.PORT || 3000)

app.use(cors())
app.use(body_parser.urlencoded({ extended: false }))
app.use(body_parser.json())
app.use(express.json())


app.use('/api/dev', API);

app.get('/', function(req, res) {
    res.status(200).json({status:
        'Nombre: Edgar Esau Zelaya Moran'
    })
})

mongoose.connect(process.env.MONGO_URL, {
    useNewUrlParser: true,
    useUnifiedTopology: true
}).then(() => {
    console.log("Conectado");
}).catch((error) => {
    console.log(error.message);
});

app.listen(app.get('port'), () => {
    console.log("RUN SERVER", app.get('port'));
});