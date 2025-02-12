import React, { useState, useEffect } from 'react';

function App() {
  const [motorbikes, setMotorbikes] = useState([]);

  useEffect(() => {
    // Use the API URL from the environment variable, fallback to localhost for local development.
    const apiUrl = process.BACKEND_REACT || 'http://localhost:5000';
    fetch(`${apiUrl}/api/motorbikes`)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => setMotorbikes(data))
      .catch(error => console.error('Error fetching motorbikes:', error));
  }, []);

  return (
    <div className="App">
      <h1>Motorbike Shop</h1>
      <div className="motorbike-list">
        {motorbikes.map(bike => (
          <div key={bike.id} className="motorbike-item">
            <img src={bike.image_url} alt={bike.name} style={{ width: '300px' }} />
            <h2>{bike.name}</h2>
            <p>{bike.description}</p>
            <p>Price: ${bike.price}</p>
          </div>
        ))}
      </div>
    </div>
  );
}

export default App;
