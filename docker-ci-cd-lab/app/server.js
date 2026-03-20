// Code Source: https://gitlab.com/nanuchi/techworld-js-docker-demo-app/-/blob/master/app/server.js

var express = require('express');
var path = require('path');
var fs = require('fs');
var MongoClient = require('mongodb').MongoClient;
var bodyParser = require('body-parser');
var app = express();

app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

app.get('/', function(req, res){
    res.sendFile(path.join(__dirname, "index.html"));
});

// app.get('/', function(req, res){
//     console.log("GET / request received");
//     res.send("Hello world");
// });

app.get('/profile-picture', function(req, res){
    var img = fs.readFileSync('images/pic1.jpg');
    res.writeHead(200, {'Content-Type':'image/jpg'});
    res.end(img, 'binary');

});

// use when starting application locally
let mongoUrlLocal = "mongodb://admin:password@localhost:27017";

// use when starting application as docker container
let mongoUrlDocker = "mongodb://admin:password@mongodb";

// pass these options to mongo client connect request to avoid DeprecationWarning for current Server Discovery and Monitoring engine
let mongoClientOptions = { useNewUrlParser: true, useUnifiedTopology: true };

// "user-account" in demo with docker. "my-db" in demo with docker-compose
let databaseName = "user-account";

app.get('/get-profile', function (req, res) {
    let response = res;
    // Connect to the db
    MongoClient.connect(mongoUrlLocal, mongoClientOptions, function (err, client) {
      if (err) throw err;
  
      let db = client.db(databaseName);
  
      let query = { userid: 1 };
  
      db.collection("users").findOne(query, function (err, result) {
        if (err) throw err;
        client.close();
  
        // Send response
        res.send(result);
      });
    });
  });

  app.post('/update-profile', function (req, res) {
    let userObj = req.body;
    let response = res;

    console. log(' connecting to the db...');
  
    MongoClient.connect(mongoUrlLocal, mongoClientOptions, function (err, client) {
      if (err) throw err;
  
      let db = client.db(databaseName);
      userObj['userid'] = 1;
  
      let query = { userid: 1 };
      let newValues = { $set: userObj };

      console. log('successfully connected to the user-account db');
  
      db.collection("users").updateOne(query, newValues, {upsert: true}, function(err, res) {
        if (err) throw err;
        console. log(' successfully updated or inserted');
        client.close();
        // Send response
        response.send(userObj)
        
      });
  
    });
    
  });


app.listen(3001,function(){
    console.log("app listening on port 3001: http://localhost:3001");
});

