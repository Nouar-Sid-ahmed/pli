# CesuerCTw
This project use a Node.js API.

# Setting

For the project wee use MongoDB database on [CesuerCTw](API/) folder.

#### CHOICE 1: <ins>Create new MongoDB database :</ins>
You can follow [the official tutorial of MongoDB](https://www.mongodb.com/fr-fr/basics/create-database).

#### CHOICE 2: <ins>Use an existing MongoDB database :</ins>

Wee must change the connection string in [index.js](API/index.js) file :
```Javascript
mongoose.connect("mongodb+srv://<user>:<database>@<cluster>.mongodb.net?retryWrites=true&w=majority", { useNewUrlParser: true, useUnifiedTopology: true },
```
#### For both choices

Now we juste need to run the server:
```bash
npm install
npm ci
npm start
```
It's done.

# Documentation

### [Routes](Documentation/)

 * [Users](Documentation/README-users.md)
 * [Post](Documentation/README-post.md)
 * [Sub Post](Documentation/README-subpost.md)
 * [Comments](Documentation/README-comments.md)
 * [Favori](Documentation/README-fav.md)

## Authors

Sid-Ahmed NOUAR  [Linkedin](https://www.linkedin.com/in/sid-ahmed-nouar-4347b5159/)

## Version History

* 0.1
    * Initial Release

## License

This project is an CesuerCTw License.