import express from 'express';
import {addForum,getAll} from '../controllers/formController.js';
import multer from '../middlewares/multer-config.js'; // Importer la configuration de multer

const router = express.Router();

router.post("/addForum",multer,addForum)
router.get("/getAll",getAll)


export default router;