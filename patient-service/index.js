const express = require('express');
const app = express();
const port = 3001;  // Or use 3002 to avoid port clash with appointment-service

app.get('/', (req, res) => {
  res.send('✅ Patient service is working!');
});

app.listen(port, () => {
  console.log(`✅ Patient service running on port ${port}`);
});

