const express = require('express');
const app = express();

// ✅ Use environment variable PORT, default to 80
const port = process.env.PORT || 80;

// ✅ Bind to all interfaces (important for Docker/Fargate)
const host = '0.0.0.0';

app.get('/patient', (req, res) => {
  res.send('✅ Patient Service running on port 80!');
});

app.listen(port, host, () => {
  console.log(`✅ Patient service running on http://${host}:${port}`);
});

// test trigger
// trigger deploy
