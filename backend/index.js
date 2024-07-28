//require('dotenv').config();

const express = require('express');
const cors = require('cors')
const app = express();
const port = 3000;

app.use(cors());

app.get('/api', (req, res) => {
  res.json({message: 'Hello World!'});
});

app.listen(port, () => {
  console.log(`Backend is running on port ${port}`);
});
