require.paths.unshift('support/mongoose/lib');

var mongoose = require('mongoose');
var Schema = mongoose.Schema,
    Module = mongoose.Module;

console.log(Module);

//mongoose.connect('mongodb://127.0.0.1/firebird');
var Share = new Schema({
    rates   : [Number],
    title   : {type:String},
    name    : {type:String},
    id      : {type:String},
    ts_save : {type:Date}
});



//var Share = mongoose.model("Share");


//Share.find({},function(a,b,c){
    //b.forEach(function(item){
        //console.log(item.title);
    //});
//});

//var myshare = new Share({
    //title : "王",
    //name : "bb",
    //id : "cc"
//});

//myshare.save();
