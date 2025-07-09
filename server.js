const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const cors = require('cors');

const app = express();
app.use(cors());

const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

let users = {}; // userId -> ws
let matchGroups = {}; // matchId -> [userId1, userId2]

wss.on('connection', function connection(ws) {
  ws.on('message', function incoming(message) {
    try {
      const data = JSON.parse(message);

      if (data.type === 'register') {
        users[data.userId] = ws;
      }

      if (data.type === 'init_match') {
        matchGroups[data.matchId] = data.userIds;
      }

      if (data.type === 'location') {
        const { matchId, userId, lat, lng } = data;
        const peers = matchGroups[matchId] || [];
        const peerId = peers.find((id) => id !== userId);

        if (users[peerId]) {
          users[peerId].send(JSON.stringify({
            type: 'location',
            lat,
            lng,
            from: userId,
          }));
        }
      }
    } catch (err) {
      console.error('Invalid message:', message);
    }
  });

  ws.on('close', () => {
    for (const [uid, sock] of Object.entries(users)) {
      if (sock === ws) delete users[uid];
    }
  });
});

server.listen(8080, () => {
  console.log('WebSocket server is running on port 8080');
});
