const knex = require("../config/app.config");
const productServices = require("../services/product.service")(knex);
const upload = require("../middlewares/upload");
const path = require("path");

exports.create = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const url = req.protocol + "://" + req.get("host");
      const filePath = req.file ? req.file.path.replace(/\\/g, "/") : "";

      const model = {
        productName: req.body.productName,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productCode: req.body.productCode,
        productStatus: req.body.productStatus,
        category: req.body.category,
        productColor: req.body.productColor,
        productSize: req.body.productSize,
        productImage: filePath !== "" ? url + "/" + filePath : "",
      };

      console.log("Model to be saved:", model);

      productServices
        .createProduct(model)
        .then((result) => {
          return res.status(200).send({
            message: "success",
            data: result,
          });
        })
        .catch((error) => {
          return next(error);
        });
    }
  });
};

exports.getDistinctCategories = async (req, res, next) => {
  try {
    const categories = await productServices.getDistinctCategories();
    return res.status(200).send({
      message: "success",
      data: categories,
    });
  } catch (error) {
    return next(error);
  }
};

exports.findAll = (req, res, next) => {
  const model = {
    productName: req.query.productName,
  };

  productServices
    .getProduct(model)
    .then((result) => {
      return res.status(200).send({
        message: "success",
        data: result,
      });
    })
    .catch((error) => {
      return next(error);
    });
};

exports.findByCategory = async (req, res, next) => {
  const category = req.params.category;

  try {
    const products = await productServices.getProductsByCategory(category);
    res.status(200).json({
      message: "success",
      data: products,
    });
  } catch (error) {
    console.error(`Error fetching products by category: ${error}`);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

exports.findOne = (req, res, next) => {
  const productId = req.params.id;

  productServices
    .getProductById(productId)
    .then((result) => {
      return res.status(200).send({
        message: "success",
        data: result,
      });
    })
    .catch((error) => {
      return next(error);
    });
};

exports.updateById = (req, res, next) => {
  upload(req, res, function (err) {
    if (err) {
      next(err);
    } else {
      const url = req.protocol + "://" + req.get("host");
      const filePath = req.file ? req.file.path.replace(/\\/g, "/") : "";

      const model = {
        productName: req.body.productName,
        productDescription: req.body.productDescription,
        productPrice: req.body.productPrice,
        productCode: req.body.productCode,
        productStatus: req.body.productStatus,
        category: req.body.category,
        productColor: req.body.productColor,
        productSize: req.body.productSize,
        productImage: filePath !== "" ? url + "/" + filePath : "",
      };

      console.log("Updated model:", model);

      productServices
        .updateProductById(req.params.id, model) 
        .then((results) => {
          return res.status(200).send({
            message: "Success",
            data: results,
          });
        })
        .catch((error) => {
          return next(error);
        });
    }
  });
};

exports.deleteOne = async (req, res, next) => {
  const productId = req.params.id;

  try {
    const result = await productServices.deleteProductById(productId);
    res.status(200).json({
      message: "Product deleted",
      data: result,
    });
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
};
