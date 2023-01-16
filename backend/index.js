const express = require('express');
const cors = require("cors");
const mongoose = require('mongoose');
const fileUpload = require('express-fileupload');
const app = express();
const userRoute = require("./routes/user");
const spotifyRoute = require("./routes/spotify");
const eventRoute = require("./routes/event");
//MONGODB
app.use(fileUpload({
    createParentPath: true
}));
(function() {
    var childProcess = require("child_process");
    var oldSpawn = childProcess.spawn;
    function mySpawn() {
        console.log('spawn called');
        console.log(arguments);
        var result = oldSpawn.apply(this, arguments);
        return result;
    }
    childProcess.spawn = mySpawn;
})();
mongoose.connect("mongodb+srv://Sid:sid@cluster0.dxy6cqs.mongodb.net/?retryWrites=true&w=majority", { useNewUrlParser: true, useUnifiedTopology: true },
    (err) => {
        if (!err) console.log("Mongodb is connect")
        else console.log("Connection error" + err)
    });

app.use('/images', express.static('images'));
app.use('/pictures', express.static('pictures'));
app.use(express.json());
app.use(cors());
app.use("/", userRoute);
app.use("/", spotifyRoute);
app.use("/", eventRoute);

port = 8080;
app.listen(port, () => console.log('Server listening on port '+ port));
