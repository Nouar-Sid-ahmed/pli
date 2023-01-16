const express = require('express');
const cors = require("cors");
const mongoose = require('mongoose');
const fileUpload = require('express-fileupload');
const app = express();
const userRoute = require("./routes/user");
const videoRoute = require("./routes/video");
//MONGODB
app.use(fileUpload({
    createParentPath: true
}));

app.use(express.json());
app.use(cors());
app.use("/", userRoute,videoRoute);
//app.use("/", videoRoute);

port = 8081
app.listen(port, () => console.log('Server listening on port '+ port));