
/**
 * Module dependencies.
 */

var express = require('express');

var mongod = requrie('mongodb');

var app = module.exports = express.createServer();

var db = new mongod.Db(
            'firebird',
            new mongo.Server('127.0.0.1', 27017),
            {native_parser:true}
        );
db.open(function(){});


// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true })); 
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

app.get('/', function(req, res){
  res.render('index', {
    title: 'Express'
  });
});

app.get('/insert/$data', function(req, res){
});

app.get('/list/$id', function(req, res){
});

app.listen(3000);
console.log("Express server listening on port %d", app.address().port);
