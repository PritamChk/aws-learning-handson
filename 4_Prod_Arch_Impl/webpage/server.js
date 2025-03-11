const express = require("express");
const app = express();
const path = require("path");

const PORT = 3000; // You can change this to any port

// Serve static files (HTML, CSS, JS, PDF)
app.use(express.static(path.join(__dirname)));

// Route for homepage
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "index.html"));
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
});
