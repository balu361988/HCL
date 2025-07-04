const express = require('express');
const app = express();

// ✅ Use environment variable PORT, default to 80
const port = process.env.PORT || 80;

// ✅ Bind to all interfaces (important for Docker/Fargate)
const host = '0.0.0.0';

app.get('/patient', (req, res) => {
  res.send('✅ Patient Service running on port 361988!');
});

app.listen(port, host, () => {
  console.log(`✅ Patient service running on http://${host}:${port}`);
});

// test trigger
// trigger deploy
// force trigger
// force ECS deploy
// trigger deploy Fri Jul  4 12:51:20 IST 2025
// deploy trigger at Fri Jul  4 13:48:54 IST 2025
// 🚀 Triggering GitHub Action at Fri Jul  4 14:06:13 IST 2025
// trigger redeploy Fri Jul  4 14:16:14 IST 2025
