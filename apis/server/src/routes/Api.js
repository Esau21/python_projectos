const express = require('express')
const UserController = require('../controllers/UserController')
const router = express.Router();

router.get('/users', UserController.Get);
router.post('/agree', UserController.Add);
router.put('/update/:id', UserController.Update_User);
router.delete('/delete/:id', UserController.Delete);


module.exports = router;