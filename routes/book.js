import express from 'express';
import {AddBook,GetAllBooks,ClickedBook,NumberofClickedNotClicked,getBookCreationStatistics} from '../controllers/bookController.js'
const router = express.Router();


router.post("/addBook",AddBook)
router.get("/AllBooks",GetAllBooks)
router.get("/NumberofClickedNotClicked",NumberofClickedNotClicked)
router.get('/getBookCreationStatistics', getBookCreationStatistics);

router.put('/updateClickedBook/:id', ClickedBook);
export default router;