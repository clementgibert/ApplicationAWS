const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
const port = 5000;

app.use(cors());
app.use(express.json());

// Create MySQL connection using environment variables
const db = mysql.createConnection({
  host: process.DB_HOST || 'localhost',
  user: process.DB_USER || 'shopuser',
  password: process.DB_PASSWORD || 'shoppass',
  database: process.DB_NAME || 'motorbike_shop'
});

// Connect to the database
db.connect(err => {
  if (err) {
    console.error('Error connecting to MySQL:', err);
  } else {
    console.log('Connected to MySQL');
  }
});

// API endpoint to retrieve motorbike data
app.get('/api/motorbikes', (req, res) => {
  db.query('SELECT * FROM motorbikes', (err, results) => {
    if (err) {
      console.error('Error fetching motorbikes:', err);
      return res.status(500).json({ error: 'Failed to fetch motorbikes' });
    }
    res.json(results);
  });
});

// Root endpoint for a quick check
app.get('/', (req, res) => {
  res.send('Motorbike Shop API');
});


//app.listen(5000, '0.0.0.0', () => {
//  console.log('Server running on port 5000');
//});
app.listen(port, () => {
  console.log(`Backend server listening on port ${port}`);
});
