const { getMySqlPromiseConnection } = require("../config/mysql.db");

// Get all active subscriptions
exports.getSubscriptions = async (req, res) => {
  try {
    const connection = await getMySqlPromiseConnection();
    const [rows] = await connection.query(
      `SELECT * FROM subscriptions WHERE is_active = 1 ORDER BY created_at DESC`
    );
    res.json({ subscriptions: rows });
  } catch (err) {
    console.error("Error fetching subscriptions:", err);
    res.status(500).json({ message: "Failed to fetch subscriptions" });
  }
};

// Create a new subscription
exports.createSubscription = async (req, res) => {
  const { name, duration_months, amount, description, admin_username } =
    req.body;

  if (!name || !duration_months || !amount || !admin_username) {
    return res.status(400).json({ message: "Missing required fields" });
  }

  try {
    const connection = await getMySqlPromiseConnection();
    await connection.query(
      `INSERT INTO subscriptions (name, duration_months, amount, description, admin_username) VALUES (?, ?, ?, ?, ?)`,
      [name, duration_months, amount, description || "", admin_username]
    );
    res.json({ message: "Subscription created successfully" });
  } catch (err) {
    console.error("Error creating subscription:", err);
    res.status(500).json({ message: "Failed to create subscription" });
  }
};

// Update an existing subscription
exports.updateSubscription = async (req, res) => {
  const id = req.params.id;
  const { name, duration_months, amount, description } = req.body;

  if (!name || !duration_months || !amount) {
    return res.status(400).json({ message: "Missing required fields" });
  }

  try {
    const connection = await getMySqlPromiseConnection();
    await connection.query(
      `UPDATE subscriptions SET name = ?, duration_months = ?, amount = ?, description = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?`,
      [name, duration_months, amount, description || "", id]
    );
    res.json({ message: "Subscription updated successfully" });
  } catch (err) {
    console.error("Error updating subscription:", err);
    res.status(500).json({ message: "Failed to update subscription" });
  }
};

// Soft-delete a subscription
exports.deleteSubscription = async (req, res) => {
  const id = req.params.id;

  try {
    const connection = await getMySqlPromiseConnection();
    await connection.query(
      `UPDATE subscriptions SET is_active = 0 WHERE id = ?`,
      [id]
    );
    res.json({ message: "Subscription deleted successfully" });
  } catch (err) {
    console.error("Error deleting subscription:", err);
    res.status(500).json({ message: "Failed to delete subscription" });
  }
};
