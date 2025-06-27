const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('✅ Appointment service is working!');
});

app.listen(port, () => {
  console.log(`✅ Appointment service running on port ${port}`);
});

