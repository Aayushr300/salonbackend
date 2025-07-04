const { CONFIG } = require("./index");

const mySqlPromise = require("mysql2/promise");

const pool = mySqlPromise.createPool(
  `${CONFIG.DATABASE_URL}?ssl={"rejectUnauthorized":false}&multipleStatements=true&dateStrings=true&waitForConnections=true&connectionLimit=99&enableKeepAlive=true&keepAliveInitialDelay=10000`
);

console.log(`DB Pool Created.`);

exports.getMySqlPromiseConnection = async () => {
  try {
    await pool.query("SELECT 1");
    console.log("Pool Connection Successful.");
    // Return a connection from the pool
    // This will automatically handle connection management
    // and reuse connections as needed.
    console.log("Returning a connection from the pool.");

    return await pool.getConnection();
  } catch (error) {
    console.error("Pool Connection Error: =======>");
    console.error(error);
    throw error;
  }
};
