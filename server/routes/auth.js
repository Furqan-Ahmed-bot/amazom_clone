const express = require("express");
const { model } = require("mongoose");
const User = require("../models/user")
const bcryptjs = require('bcryptjs');
const jwt = require("jsonwebtoken");
const authRouter = express.Router();


//SignUp Api
authRouter.post("/api/signup" , async (req , res) =>{
    try{
        const {name , email , password} = req.body;
    
        const existinguser =  await User.findOne({ email });
    
        if(existinguser) {
            return res.status(400).json({ msg: "Username with same email already exist"}); 
        }
        const hashedPassword = await bcryptjs.hash(password , 8);
    
        let user = new User({
            email,
            password: hashedPassword,
            name,
        });
        user = await user.save();
        res.json(user);
    
    }
    catch(e){ 
        res.status(500).json({ error: e.message });

    }


},

); 

authRouter.post('/api/signin' , async (req , res) => {
    try{
        const {email , password} = req.body;

        const user = await User.findOne({email: email});
        if(!user) {
            return res
              .status(400)
              .json({msg: "User with same email does not exist"});
        }
        const isMatch = await bcryptjs.compare(password , user.password) 
        if(!isMatch){
            return res
            .status(400)
            .json({msg: "Incorrect password"});

        }
        const token = jwt.sign({id: user._id}, "passwordKey");
        res.json({token, ...user._doc});


    }
    catch(e) {
        res.status(500).json({error: e.message});

    }
});

//SignIn Api
module.exports = authRouter;