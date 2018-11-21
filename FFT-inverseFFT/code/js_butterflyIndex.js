autowatch = 1;
var butterfly_256 = new Buffer("butterfly_256samp");
var butterfly_512 = new Buffer("butterfly_512samp");
var butterfly_1024 = new Buffer("butterfly_1024samp");

function bang(){
    butterfly_256.send("sizeinsamps", 256);
    butterfly_512.send("sizeinsamps", 512);
    butterfly_1024.send("sizeinsamps", 1024);

    storeBuf(butterfly_256);
    storeBuf(butterfly_512);
    storeBuf(butterfly_1024);
}

function storeBuf(buffer){
    var samps = buffer.framecount();
    var levels = Math.log(samps) / Math.log(2);
    for(var i=0; i<samps; i++){
        buffer.poke(1, i, bitRev(i, levels));
        buffer.poke(2, i, Math.cos(2*Math.PI*i/samps));
        buffer.poke(3, i, Math.sin(2*Math.PI*i/samps));
    }
}

//bit reverse function
function bitRev(x, bits) {
    var y = 0;
    for (var i = 0; i < bits; i++) {
        y = (y << 1) | (x & 1);
        x >>>= 1;
    }
    return y;
}

//for log function
function log(message) {
    for(var i=0, len=arguments.length; i<len; i++){
        var message = arguments[i];
        if(message && message.toString){
            var s = message.toString();
            if(s.indexOf("[object ") >= 0){
                s = JSON.stringify(message);
            }
            post(s);
        }
        else if(message===null){
            post("<null>");
        }
        
        else {
            post(message);
        }
    }
    post("\n");
}
