const express = require("express");
const router = express.Router();
const productController = require("../controller/products.controller");

router.post("/products", productController.create);
router.get("/products", productController.findAll);
router.get("/products/categories", productController.getDistinctCategories);
router.get("/products/category/:category", productController.findByCategory);
router.get("/products/:id", productController.findOne);
router.put("/products/:id", productController.updateById);
router.delete("/products/:id", productController.deleteOne);

module.exports = router;
