const { getMySqlPromiseConnection } = require("../config/mysql.db");

// Create or update a policy (terms, rules, privacy)
exports.createOrUpdatePolicy = async (req, res) => {
  const { type, content, admin_username } = req.body;
  console.log("Received body:", req.body);

  const validTypes = ["terms", "rules", "privacy"];
  if (!validTypes.includes(type)) {
    return res.status(400).json({ message: "Invalid policy type" });
  }

  try {
    const connection = await getMySqlPromiseConnection();

    await connection.query(
      `INSERT INTO policies (type, content, admin_username, created_at, updated_at)
       VALUES (?, ?, ?, NOW(), NOW())
       ON DUPLICATE KEY UPDATE 
         content = VALUES(content), 
         admin_username = VALUES(admin_username), 
         updated_at = NOW()`,
      [type, content, admin_username]
    );

    res.json({ message: "Policy saved successfully" });
  } catch (err) {
    console.error("Error saving policy:", err);
    res.status(500).json({ message: "Failed to save policy" });
  }
};

// adjust path as needed

exports.createOrUpdatePolicy = async (req, res) => {
  const { type, content, admin_username } = req.body;

  const validTypes = ["terms", "refund", "privacy"];
  if (!validTypes.includes(type)) {
    return res.status(400).json({ message: "Invalid policy type" });
  }

  try {
    const connection = await getMySqlPromiseConnection();

    await connection.query(
      `INSERT INTO policies (type, content, admin_username, created_at, updated_at)
       VALUES (?, ?, ?, NOW(), NOW())
       ON DUPLICATE KEY UPDATE 
         content = VALUES(content), 
         admin_username = VALUES(admin_username), 
         updated_at = NOW()`,
      [type, content, admin_username]
    );

    res.json({ message: "Policy saved successfully" });
  } catch (err) {
    console.error("Error saving policy:", err);
    res.status(500).json({ message: "Failed to save policy" });
  }
};

exports.getPoliciesByAdmin = async (req, res) => {
  const { admin_username } = req.query;

  if (!admin_username) {
    return res.status(400).json({ message: "admin_username is required" });
  }

  try {
    const connection = await getMySqlPromiseConnection();

    const [rows] = await connection.query(
      `SELECT id, type, content, admin_username, created_at, updated_at 
       FROM policies 
       WHERE admin_username = ?`,
      [admin_username]
    );

    res.json({ policies: rows });
  } catch (err) {
    console.error("Error fetching policies:", err);
    res.status(500).json({ message: "Failed to fetch policies" });
  }
};

exports.getPolicyByType = async (req, res) => {
  const { type } = req.params;
  console.log("Type backend: ", type);
  const validTypes = ["privacy", "refund", "terms"];
  if (!validTypes.includes(type)) {
    return res.status(400).json({ message: "Invalid policy type" });
  }

  try {
    const connection = await getMySqlPromiseConnection();

    const [rows] = await connection.query(
      `SELECT content FROM policies WHERE type = ? ORDER BY updated_at DESC LIMIT 1`,
      [type]
    );

    if (rows.length === 0) {
      return res.status(404).json({ message: "Policy not found" });
    }

    res.json({ content: rows[0].content });
  } catch (err) {
    console.error("Error fetching policy:", err);
    res.status(500).json({ message: "Failed to fetch policy" });
  }
};
