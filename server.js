const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 10000 });

const clients = {}; // userId => socket
const matches = {}; // matchId => [userId1, userId2]

console.log("WebSocket server running on ws://localhost:10000");

wss.on('connection', (ws) => {
  let userId = null;

  ws.on('message', (message) => {
    try {
      const data = JSON.parse(message);

      switch (data.type) {
        case 'register':
          userId = data.userId;
          clients[userId] = ws;
          console.log(`User ${userId} registered`);
          break;

        case 'init_match':
          const { matchId, userIds } = data;
          matches[matchId] = userIds;
          console.log(`Match ${matchId} initialized between ${userIds.join(' & ')}`);
          break;

        case 'location':
          const senderId = data.userId;
          const matchId2 = data.matchId;
          const lat = data.lat;
          const lng = data.lng;

          const peers = matches[matchId2];
          if (!peers || peers.length !== 2) return;

          const otherUserId = peers.find((id) => id !== senderId);
          const otherSocket = clients[otherUserId];

          if (otherSocket && otherSocket.readyState === WebSocket.OPEN) {
            otherSocket.send(JSON.stringify({
              type: 'location',
              lat,
              lng,
              from: senderId,
            }));
          }
          break;

        default:
          console.log("Unknown message type", data);
      }
    } catch (err) {
      console.error("Error handling message:", err);
    }
  });

  ws.on('close', () => {
    if (userId && clients[userId]) {
      delete clients[userId];
      console.log(`User ${userId} disconnected`);
    }
  });
});
