var mongod = require('mongodb');
var db = new mongod.Db(
    'firebird',
    new mongod.Server('127.0.0.1', 27017),
    {
        native_parser:true
    }
);
db.open(function(err,db){
    db.collection("rate", function(err,collection){
        collection.find({},function(err,cursor){
            cursor.each(function(err, rate){
                console.log('cursor');
                if(rate !== null) {
                    console.log(rate);
                    db.close();
                }
            });
        });

    });
});
