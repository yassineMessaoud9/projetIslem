import express from 'express';
import {register,login} from '../controllers/userControllers.js'
const router = express.Router();

router.post("/create",register);
router.post("/login",login)

export default router;