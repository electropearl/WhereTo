const WebSocket = require('ws');
const PORT = process.env.PORT || 8080;

const wss = new WebSocket.Server({ port: PORT });
const users = new Map();
const matches = new Map();

wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    try {
      const data = JSON.parse(message);

      if (data.type === 'register') {
        users.set(data.userId, ws);
        ws.userId = data.userId;
      }

      if (data.type === 'init_match') {
        matches.set(data.matchId, data.userIds);
      }

      if (data.type === 'location') {
        const matchUsers = matches.get(data.matchId);
        if (matchUsers) {
          matchUsers.forEach((uid) => {
            if (uid !== data.userId && users.get(uid)) {
              users.get(uid).send(JSON.stringify({
                type: 'location',
                lat: data.lat,
                lng: data.lng,
                from: data.userId
              }));
            }
          });
        }
      }
    } catch (err) {
      console.error('Invalid message:', message);
    }
  });

  ws.on('close', function () {
    users.delete(ws.userId);
  });
});

console.log(`WebSocket server running on port ${PORT}`);
