const { Router } = require("express");

const {
  isLoggedIn,
  isAuthenticated,
  authorize,
  isSubscriptionActive,
} = require("../middlewares/auth.middleware");
const { SCOPES } = require("../config/user.config");
const { getDashboardData } = require("../controllers/dashboard.controller");
const {
  createCashfreeOrder,
  verifyPayment,
} = require("../controllers/cashfree.controller");

const router = Router();

router.get(
  "/",
  isLoggedIn,
  isAuthenticated,
  isSubscriptionActive,
  authorize([SCOPES.DASHBOARD]),
  getDashboardData
);

router.get("/payment", createCashfreeOrder);
router.get("/verify", verifyPayment); // Correct route for verifyPayment

module.exports = router;
