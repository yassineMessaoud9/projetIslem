import User from '../models/user.js';
import bcrypt from 'bcrypt';

//create user with bcrypt
export async function  register(req,res){
try{
    const {username,email,password} = req.body;
    //check if the email is already in use
    
    const existedEmail = await User.findOne(
        {'email':email},
    )

    if(existedEmail){
        return res.status(400).json("Account Existed");
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser=await User.create({
        username:username,
        email:email,
        password:hashedPassword
    })
    return res.status(201).json(newUser);
} catch(error){
    return res.status(500).json(error)
}   
}

//login

export async function login (req,res){
    try{
        const user=await User.findOne({'email':req.body.email})
        
        if(!user){
            return res.status(401).json('No such user')
        }
        const validPassword= await bcrypt.compare(req.body.password,user.password)
        if (!validPassword) {
            return res.status(401).send('Wrong Password').end()
        }

        //wirthout token
        const userWithoutPassword = { ...user.toObject(), password: undefined };

        return res.status(201).json(userWithoutPassword)
    

    }catch(error){
        return res.status(500).json(error)
    }
}