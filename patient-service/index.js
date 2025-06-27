const express = require('express');
const app = express();
const port = 3000;

app.get('/patient', (req, res) => {
  res.send('Patient Service running!');
});

app.listen(port, () => {
  console.log(`Patient service running on port ${port}`);
});

