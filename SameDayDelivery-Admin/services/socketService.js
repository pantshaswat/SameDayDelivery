const socketIO = require('socket.io');

function initializeSocketIO(server) {
    const io = socketIO(server, {
        connectionStateRecovery: {}
    });
    var riderId = {};
    var requestUserId = {};
    io.on('connection', (socket) => {

        console.log(`Client connected ${socket.id}`);

        //on riders connected,
        //their mongodb _id is sent from frontend
        //storing _id:socket.io in a object
        socket.on('riderConnected', (id) => {
            riderId[id.riderId] = socket.id;
            console.log(`rider connected ${id.riderId}`)
        });

        socket.on('requestRide', (request) => {
            console.log(request);
            //ToDo:
            //store requesting user socket.id in a var
            requestUserId[request.userId] = socket.id;
            //for each rider in riderId object 
            //put their socket id to emit request to drivers only
            Object.keys(riderId).forEach(key => {
                io.to(riderId[key]).emit('request', request);
            })

        })

        //bid should consist riders mongo _id and Rs amount.
        //bid also should consist of id of requesting user.
        socket.on('bid', (bid) => {
            //from _id we can get rider info from mongodb
            //and send rider and his Rs amount to requesting user
            const userId = bid.userId;

            //here keep .to(requesting user socket.id)
            socket.to(requestUserId[userId]).emit('bid', bid);
            //this will emit bid in frontend
        });
        //now user will select a rider
        socket.on('riderSelected', (rider) => {
            //from the riderId object, find the rider 
            console.log(rider);
            const id = rider.riderId;
            //.to(found rider socket id)
            socket.to(riderId[id]).emit('success', 'You are selected to be the rider');
            //handle this in frontend
        })

    });
}

module.exports = initializeSocketIO;
