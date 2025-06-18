const axios = require("axios");
const {
  updateTenantSubscriptionAccess,
  updateSubscriptionHistory,
  getSubscriptionDetailsDB,
  getSusUserDB,
} = require("../services/auth.service");
require("dotenv").config();

//             message: "Login to access this area!"
const CASHFREE_APP_ID = process.env.CASHFREE_APP_ID;
const CASHFREE_SECRET_KEY = process.env.CASHFREE_SECRET_KEY;
const BASE_URL = process.env.CASHFREEPAYMENTURL;

function formatDateToISTWithOffset(date) {
  // Convert to IST manually
  const istOffsetMs = 5.5 * 60 * 60 * 1000;
  const istDate = new Date(date.getTime() + istOffsetMs);

  // Extract date parts
  const yyyy = istDate.getFullYear();
  const mm = String(istDate.getMonth() + 1).padStart(2, "0");
  const dd = String(istDate.getDate()).padStart(2, "0");
  const hh = String(istDate.getHours()).padStart(2, "0");
  const min = String(istDate.getMinutes()).padStart(2, "0");
  const ss = String(istDate.getSeconds()).padStart(2, "0");

  return `${yyyy}-${mm}-${dd}T${hh}:${min}:${ss}+05:30`;
}

const createCashfreeOrder = async (req, res) => {
  const orderId = "order_" + Date.now();
  const amount = req.query.amount;

  const payload = {
    order_id: orderId,
    order_amount: amount, // Amount in smallest currency unit (e.g., paise for INR)
    order_currency: "INR",
    customer_details: {
      customer_id: "CUST123",
      customer_email: "test@example.com",
      customer_phone: "9876543210",
    },
    order_meta: {
      return_url: `${process.env.BACKEND_URL}/dashboard/payment-success?order_id=${orderId}`,
    },
  };

  try {
    const response = await axios.post(`${BASE_URL}/orders`, payload, {
      headers: {
        "x-client-id": CASHFREE_APP_ID,
        "x-client-secret": CASHFREE_SECRET_KEY,
        "x-api-version": "2022-09-01",
        // <- This is required!
        "Content-Type": "application/json",
      },
    });

    res.json(response.data);
  } catch (error) {
    console.error(
      "Cashfree order error:",
      error.response?.data || error.message
    );
    res.status(500).json({
      error: "Failed to create payment",
      message: error.response?.data || error.message,
    });
  }
};

function formatDuration(months) {
  if (months < 12) {
    return `${months} month${months === 1 ? "" : "s"}`;
  }

  const years = months / 12;
  return `${years} year${years === 1 ? "" : "s"}`;
}

const verifyPayment = async (req, res) => {
  const { orderId, tenant_id } = req.query; // Get orderId from query parameters
  const month = parseInt(req.query.month, 10);
  try {
    console.log(`Verifying payment for order ID: ${orderId}...`);
    const response = await axios.get(`${BASE_URL}/orders/${orderId}`, {
      headers: {
        "x-client-id": CASHFREE_APP_ID,
        "x-client-secret": CASHFREE_SECRET_KEY,
        "x-api-version": "2022-09-01",
      },
    });

    const suscriptionText = formatDuration(month);

    const suscriptionAmmount = response.data.order_amount;

    const orderStatus = response.data.order_status;

    // You can update DB here if needed

    const { order_id } = response.data;

    // function date calculate

    function addMonths(date, months) {
      const newDate = new Date(date);
      const d = newDate.getDate();
      newDate.setMonth(newDate.getMonth() + months);
      if (newDate.getDate() < d) {
        newDate.setDate(0);
      }
      return newDate;
    }

    function formatToMySQLDatetime(date) {
      const yyyy = date.getFullYear();
      const mm = String(date.getMonth() + 1).padStart(2, "0");
      const dd = String(date.getDate()).padStart(2, "0");
      const hh = String(date.getHours()).padStart(2, "0");
      const mi = String(date.getMinutes()).padStart(2, "0");
      const ss = String(date.getSeconds()).padStart(2, "0");
      return `${yyyy}-${mm}-${dd} ${hh}:${mi}:${ss}`;
    }

    const createdDate = new Date();
    const expiryDate = addMonths(createdDate, month);

    const subscription_start = formatToMySQLDatetime(createdDate);
    const subscription_end = formatToMySQLDatetime(expiryDate);

    const responseData = await getSusUserDB(tenant_id);

    const { username } = responseData;

    const status = 1;

    // Update subscription access if the order is successful
    const updateData = await updateTenantSubscriptionAccess(
      username,
      status,
      order_id,
      tenant_id,
      createdDate,
      expiryDate,
      month,
      suscriptionAmmount,
      suscriptionText
    );

    res.json({
      success: true,
      status: orderStatus,
      data: response.data,
    });
  } catch (error) {
    console.error(
      "Error verifying payment:",
      error.response?.data || error.message
    );
    res.status(500).json({
      success: false,
      message: "Failed to verify payment",
      error: error.response?.data || error.message,
    });
  }
};

module.exports = { createCashfreeOrder, verifyPayment };
