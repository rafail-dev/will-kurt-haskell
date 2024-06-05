DROP TABLE IF EXISTS rental;
DROP TABLE IF EXISTS tools;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  username TEXT NOT NULL
);

CREATE TABLE tools (
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  name TEXT NOT NULL,
  description TEXT
); 

CREATE TABLE rental (
  user_id INTEGER,
  tool_id INTEGER,
  checkoutAt DATETIME DEFAULT CURRENT_TIMESTAMP,
  returnAt DATETIME NULL,
  PRIMARY KEY (user_id, tool_id, returnAt),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (tool_id) REFERENCES tools(id)
); 

CREATE INDEX idx_users_username ON users (username);
CREATE INDEX idx_tools_name ON tools (name);
CREATE INDEX idx_rental_user_id ON rental (user_id);
CREATE INDEX idx_rental_tool_id ON rental (tool_id);

INSERT INTO users (username) VALUES 
  ("Will Kurt"),
  ("Anna Smith"),
  ("John Doe");

INSERT INTO tools (name, description, lastReturned, timesBorrowed) VALUES 
  ("Hammer", "Drives nails"),
  ("Saw", "Cuts wood"),
  ("Screwdriver", "Turns screws"),
  ("Sledgehammer", "Breaks things"),
  ("Shovel", "Digs holes");

INSERT INTO rental (user_id, tool_id, checkoutAt, returnAt) VALUES 
  (1, 1, '2024-05-01 09:30:00', NULL),
  (2, 3, '2024-05-02 14:00:00', '2024-05-10 16:30:00'),
  (3, 2, '2024-05-03 11:15:00', NULL);
