console.log('Hello There');

const express = require("express");
const authRouter = require("./routes/auth");
const mongoose = require("mongoose");

//IMPORT from other files

const PORT = 3000;
const app = express();
const DB = "mongodb+srv://furqan:furqan614@cluster0.udjqcaj.mongodb.net/?retryWrites=true&w=majority"


//middleware
app.use(express.json());
app.use(authRouter);


//connection to the database

mongoose.connect(DB).then(()=> {console.log("Connection Succesfully");
})
.catch((e) => {console.log(e);});


app.listen(PORT , "0.0.0.0", ()=> {
    console.log("connected as " + PORT)
}


);  