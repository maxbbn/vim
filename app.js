/**
 * Module dependencies.
 */

var express = require('express');

var mongod = require('mongodb');

var app = module.exports = express.createServer();

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

var db = new mongod.Db(
    'firebird',
    new mongod.Server('127.0.0.1', 27017),
    {
        native_parser:true
    }
);

// Routes

app.get('/', function(req, res){
  res.render('index', {
    title: 'Express'
  });
});

//** jsonp
app.get('/insert/:data', function(req, res){
    var doc;

    doc = JSON.parse(req.params.data);
    console.log(req.params.data);
    console.log(doc);
    doc.name = encodeURIComponent(doc.name);
    doc.title = encodeURIComponent(doc.title);
    doc.ts_save = new Date();

    if(!doc){
        res.send("error");
        return;
    }

    db.open(function(err,db){
        db.collection("rate", function(err,collection){
            collection.insert(doc,function(err, doc){
                res.send(req.param("callback") + "(" + JSON.stringify(doc[0]) + ")");
                db.close();
            });
        });
    });

});

//** jsonp
app.get('/getrate/:rid', function(req, res){
    var rateid = parseInt(req.params.rid,16);
    var query = rateid?{"_id" : rateid}:{};
    var result = {};

    db.open(function(err,db){
        db.collection("rate", function(err,collection){
            collection.find(query,function(err,cursor){
                cursor.each(function(err,rate){
                    console.log(rate);
                    if(rate !== null) {
                        result = rate;
                    }
                    if(rate === null){
                        res.send(req.param("callback") + "(" + JSON.stringify(result) + ")");
                        db.close();
                    }
                });
            });
        });
    });
});

app.get('/list/:rid',function(req,res){
    
});

app.listen(3000);
console.log("Express server listening on port %d", app.address().port);
