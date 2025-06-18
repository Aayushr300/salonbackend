const {
  getCouponsDB,
  addCouponDB,
  updateCouponDB,
  deleteCouponDB,
} = require("../services/settings.service");

// Get all coupons
exports.getCoupons = async (req, res) => {
  try {
    const tenantId = req.user.tenant_id;
    const coupons = await getCouponsDB(tenantId);
    res.status(200).json({ success: true, coupons });
  } catch (error) {
    console.error(error); // <--- This will show the real error in your backend console
    res
      .status(500)
      .json({ success: false, message: "Failed to fetch coupons" });
  }
};

// Add a new coupon
exports.addNewCoupon = async (req, res) => {
  try {
    const tenantId = req.user.tenant_id;
    const { code, discount, expiry } = req.body;
    if (!code || !discount) {
      return res
        .status(400)
        .json({ success: false, message: "Code and discount required" });
    }
    await addCouponDB(code, discount, expiry, tenantId);
    res.status(200).json({ success: true, message: "Coupon added" });
  } catch (error) {
    res.status(500).json({ success: false, message: "Failed to add coupon" });
  }
};

// Update a coupon
exports.updateCoupon = async (req, res) => {
  try {
    const tenantId = req.user.tenant_id;
    const id = req.params.id;
    const { code, discount, expiry } = req.body;
    await updateCouponDB(id, code, discount, expiry, tenantId);
    res.status(200).json({ success: true, message: "Coupon updated" });
  } catch (error) {
    res
      .status(500)
      .json({ success: false, message: "Failed to update coupon" });
  }
};

// Delete a coupon
exports.deleteCoupon = async (req, res) => {
  try {
    const tenantId = req.user.tenant_id;
    const id = req.params.id;
    await deleteCouponDB(id, tenantId);
    res.status(200).json({ success: true, message: "Coupon deleted" });
  } catch (error) {
    res
      .status(500)
      .json({ success: false, message: "Failed to delete coupon" });
  }
};
