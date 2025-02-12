CREATE TABLE IF NOT EXISTS motorbikes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2),
  image_url VARCHAR(255)
);

INSERT INTO motorbikes (name, description, price, image_url) VALUES
('Yamaha YZF-R1', 'Une moto sportive performante.', 17399.99, 'https://source.unsplash.com/featured/?yamaha'),
('Ducati Panigale V4', 'Un design Italien au bonne performance de course.', 21999.99, 'https://source.unsplash.com/featured/?ducati'),
('Kawasaki Ninja H2R', 'Une moto iconique super alimentée.', 29000.00, 'https://source.unsplash.com/featured/?kawasaki');
