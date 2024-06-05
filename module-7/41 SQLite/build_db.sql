DROP TABLE IF EXISTS rental;
DROP TABLE IF EXISTS tool;
DROP TABLE IF EXISTS user;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT, 
  name TEXT NOT NULL
);

CREATE TABLE tool (
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
  FOREIGN KEY (user_id) REFERENCES user(id),
  FOREIGN KEY (tool_id) REFERENCES tool(id)
); 

CREATE INDEX idx_user_name ON user (name);
CREATE INDEX idx_tool_name ON tool (name);
CREATE INDEX idx_rental_user_id ON rental (user_id);
CREATE INDEX idx_rental_tool_id ON rental (tool_id);

INSERT INTO user (name) VALUES 
  ("Will Kurt"),
  ("Anna Smith"),
  ("John Doe");

INSERT INTO tool (name, description) VALUES 
  ("Hammer", "Drives nails"),
  ("Saw", "Cuts wood"),
  ("Screwdriver", "Turns screws"),
  ("Sledgehammer", "Breaks things"),
  ("Shovel", "Digs holes");

INSERT INTO rental (user_id, tool_id, checkoutAt, returnAt) VALUES 
  (1, 1, '2024-05-01 09:30:00', NULL),
  (2, 3, '2024-05-02 14:00:00', '2024-05-10 16:30:00'),
  (3, 2, '2024-05-03 11:15:00', NULL);
