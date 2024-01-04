import { Router } from 'express';
import { createUser, login } from "../controllers/userController";
const router = Router();

router.post("/create", createUser);

// Login endpoint
router.post("/login", login);

export default router;
