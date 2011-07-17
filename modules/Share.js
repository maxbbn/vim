var Share = new Schema({
    rates   : [Number],
    title   : {type:String},
    name    : {type:String},
    id      : {type:String},
    ts_save : {type:Date}
});
Share.path("ts_save")
    .default(function(){
        return new Date();
    })
    .set(function(v){
        return v == "now"? new Date():v;
    });

Share.path("title")
    .set(function(v){
        return encodeURIComponent(v);
    });
Share.path("title")
    .set(function(v){
        return encodeURIComponent(v);
    });
mongoose.model("Share", Share);
