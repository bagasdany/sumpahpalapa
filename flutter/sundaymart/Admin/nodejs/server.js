const {readFileSync} = require("fs");
const {createServer} = require("https");
const {Server} = require("socket.io");
const server = createServer({
    key: readFileSync("/etc/letsencrypt/live/sundaymart.net/privkey.pem"),
    cert: readFileSync("/etc/letsencrypt/live/sundaymart.net/fullchain.pem")
});
const io = new Server(server, {cors: {origin: "https://sundaymart.net", methods: ["GET", "POST"]}});

//SSLCertificateFile /etc/letsencrypt/live/demo.sundaymart.net/fullchain.pem
// SSLCertificateKeyFile /etc/letsencrypt/live/demo.sundaymart.net/privkey.pem

var redis = require('redis');

io.engine.on("connection_error", (err) => {
    console.log(err.req);      // the request object
    console.log(err.code);     // the error code, for example 1
    console.log(err.message);  // the error message, for example "Session ID unknown"
    console.log(err.context);  // some additional error context
});

io.on('connection', function (socket) {
    console.log("client connected");
    var redisClient = redis.createClient();
    redisClient.subscribe('message');

    redisClient.on("error", function (error) {
        console.log("Error " + error);
    });

    redisClient.on("message", function (channel, data) {
        console.log("mew message add in queue " + data + " channel: " + channel);
        socket.emit(channel, data);
    });

    socket.on('disconnect', function () {
        redisClient.quit();
    });
})

var server_port = process.env.PORT || 3001;
server.listen(server_port, function (err) {
    if (err) throw err
    console.log('Listening on port %d', server_port);
});
