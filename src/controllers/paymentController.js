const axios = require("axios");
const { v4: uuidv4 } = require("uuid");
require("dotenv").config();

exports.cashfreeCreateSubscription = async (req, res) => {
  try {
    const { planId } = req.body;
    const user = req.user; // Make sure you're using authentication middleware

    const subscriptionId = "sub_" + uuidv4();

    const response = await axios.post(
      "https://sandbox.cashfree.com/pg/subscriptions",
      {
        subscriptionId,
        planId,
        customerDetails: {
          customerId: user.id.toString(),
          customerEmail: user.username,
          customerPhone: user.phone || "9999999999",
        },
        returnUrl: `${process.env.FRONTEND_DOMAIN}/success?subscription_id={subscription_id}`,
        notifyUrl: `${process.env.BACKEND_DOMAIN}/api/payment/cashfree/webhook`,
      },
      {
        headers: {
          "Content-Type": "application/json",
          "x-api-version": "2022-09-01",
          "x-client-id": process.env.CASHFREE_APP_ID,
          "x-client-secret": process.env.CASHFREE_SECRET_KEY,
        },
      }
    );

    return res.status(200).json({
      success: true,
      url: response.data.paymentLink,
    });
  } catch (error) {
    console.error(error?.response?.data || error);
    return res.status(500).json({
      success: false,
      message: "Failed to create Cashfree subscription",
    });
  }
};
