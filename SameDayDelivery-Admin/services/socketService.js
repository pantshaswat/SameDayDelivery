const socketIO = require('socket.io');

function initializeSocketIO(server) {
    const io = socketIO(server,{
        connectionStateRecovery: {}
    });
    var riderId ={};
    io.on('connection', (socket) => {
        
        console.log(`Client connected ${socket.id}`);
        socket.emit('1st msg','hello from socket');

        //on riders connected,
        //their mongodb _id is sent from frontend
        //storing _id:socket.io in a object
        socket.on('riderConnected',(id)=>{
            riderId[id] = socket.id;
            console.log(userId);
        });

        socket.on('requestRide',(request)=>{
            //ToDo:
            //store requesting user socket.id in a var
            
            //for each rider in riderId object 
            //put their socket id to emit request to drivers only
            io.to(socket.id).emit('request',request);
        })
        
        //bid should consist riders mongo _id and Rs amount.
        socket.on('bid',(bid)=>{
            //from _id we can get rider info from mongodb
            //and send rider and his Rs amount to requesting user


            //here keep .to(requesting user socket.id)
            socket.to().emit('bid',bid);
            //this will emit bid in frontend
        });
        //now user will select a rider
        socket.on('riderSelected',(rider)=>{
            //from the riderId object, find the rider 

            //.to(found rider socket id)
            socket.to().emit('success','You are selected to be the rider');
            //handle this in frontend
        })
        
    });
}

module.exports = initializeSocketIO;
