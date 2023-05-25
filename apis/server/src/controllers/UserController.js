const User = require('../models/UserModel')
const bcrypt = require('bcrypt');


const Get = (req, res) => {
    User.find((err, users) => {
        if (!err) {
            res.status(200).json(users)
        } else {
            res.status(400).send(err.message)
        }
    })
}

const Add = async (req, res) => {
    console.log(req.body);
    const { name, email, password } = req.body;
    const Pass = await bcrypt.hash(password, 10)
    const Usuario = new User({
        name,
        email,
        password: Pass,
    });

    try {
        const data_recivida = await Usuario.save()
        if (!data_recivida) {
            res.status(400).json('no se puede agregar')
        }
        res.status(200).json({ status: 'Agregado' })
    } catch (error) {
        res.status(400).send(error.message)
    }
}

const Update_User = async (req, res) => {
    const { name, email, password } = req.body;
    const Pass = await bcrypt.hash(password, 10)
    const id = req.params.id;
    const UPDATE_DATA = ({
        name, email, password: Pass,
    });
    try {
        const update_data = await User.findByIdAndUpdate(
            id,
            UPDATE_DATA
        )
        if (!update_data) {
            res.status(400).json({status: 'NO SE PUEDE ACTAULIZAR'})
        } 
        res.status(200).json({status: 'Actualizado'})
    } catch (error) {
        res.status(400).send(error.message)
    }
}

const Delete = async (req, res) => {
    const id = req.params.id
    try {
        const delete_user = await User.findByIdAndDelete(id)
        if(!delete_user) {
            res.status(400).json({status: 'no se pudo eliminar'})
        } else {
            res.status(200).json({status: "Su peticion fue aceptada usuario eliminado"})
        }
    } catch (error) {
        res.status(400).send(error.message)
    }
}

module.exports = { Get, Add, Update_User, Delete };