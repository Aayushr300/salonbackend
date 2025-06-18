const express = require("express");
const router = express.Router();
const couponController = require("../controllers/coupon.controller");
const {
  isLoggedIn,
  isAuthenticated,
  isSubscriptionActive,
} = require("../middlewares/auth.middleware");

router.get("/", isLoggedIn, isAuthenticated, couponController.getCoupons);

router.post("/add", isLoggedIn, isAuthenticated, couponController.addNewCoupon);
router.post(
  "/:id/update",
  isLoggedIn,
  isAuthenticated,
  couponController.updateCoupon
);
router.delete(
  "/:id",
  isLoggedIn,
  isAuthenticated,
  couponController.deleteCoupon
);

module.exports = router;
