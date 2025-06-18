const { Router } = require("express");
const {
  hasRefreshToken,
  isAuthenticated,
  isLoggedIn,
  isSuperAdmin,
} = require("../middlewares/auth.middleware");
const {
  signIn,
  signOut,
  getNewAccessToken,
  getSuperAdminDashboardData,
  getTenants,
  getSuperAdminTenantsCntData,
  addTenant,
  updateTenant,
  deleteTenant,
  getSuperAdminReportsData,
  getTenantsDataByStatus,
  getTenantSubscriptionHistory,
} = require("../controllers/superadmin.controller");

const {
  createSubscription,
  getSubscriptions,
  updateSubscription,
  deleteSubscription,
} = require("../controllers/superadminSubscription.controller");

const {
  createOrUpdatePolicy,
  getPoliciesByAdmin,
  getPolicyByType,
} = require("../controllers/superadminPolicies.controller");

const router = Router();

router.post("/signin", signIn);
router.post("/signout", hasRefreshToken, signOut);
router.post("/refresh-token", hasRefreshToken, getNewAccessToken);

router.get(
  "/dashboard",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  getSuperAdminDashboardData
);

router.get(
  "/tenantsData",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  getSuperAdminTenantsCntData
);
router.get("/tenants", isLoggedIn, isAuthenticated, isSuperAdmin, getTenants);
router.get(
  "/tenants/:id/subscription-history",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  getTenantSubscriptionHistory
);
router.post(
  "/tenants/add",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  addTenant
);
router.patch(
  "/tenants/update/:id",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  updateTenant
);
router.delete(
  "/tenants/delete/:id",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  deleteTenant
);
router.get(
  "/tenantsData/:status",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  getTenantsDataByStatus
);

router.get(
  "/reports",
  isLoggedIn,
  isAuthenticated,
  isSuperAdmin,
  getSuperAdminReportsData
);

// Creating the Suscription Routes
router.post(
  "/subscription",

  createSubscription
);

// Get all active subscriptions
router.get("/subscriptions", getSubscriptions);
// Update a subscription
router.put("/subscription/:id", updateSubscription);
// Soft delete a subscription
router.delete("/subscription/:id", deleteSubscription);

// Create or update policy
router.post("/policies", createOrUpdatePolicy);
router.get("/policies", getPoliciesByAdmin);
router.get("/policies/:type", getPolicyByType);

module.exports = router;
