const express = require('express');
const app = express();
const port = 3000;

app.get('/appointment', (req, res) => {
  res.send('Appointment Service running!');
});

app.listen(port, () => {
  console.log(`Appointment service running on port ${port}`);
});

