module.exports = (knex) => {
  //? drustkrdny product
  const createProduct = async (params) => {
    if (!params.productName) {
      throw new Error("Product Name Required");
    }

    try {
      const insertedProduct = await knex("products").insert(params);
      return insertedProduct;
    } catch (err) {
      throw new Error(err.message);
    }
  };

  // ? dozinaway product products bapey name
  const getProduct = async (params) => {
    const productName = params.productName;
    const condition = productName ? { productName: `%${productName}%` } : {};

    try {
      const products = await knex("products").where(condition);
      return products;
    } catch (err) {
      throw new Error(err.message);
    }
  };

  //? henanaway products bapey category
  const getProductsByCategory = async (category) => {
    try {
      const products = await knex("products").where("category", category);
      return products;
    } catch (err) {
      throw new Error(err.message);
    }
  };

  //? henanaway products bapey ID
  const getProductById = async (productId) => {
    try {
      const product = await knex("products").where("id", productId).first();
      if (!product) throw new Error("Product Id invalid");
      return product;
    } catch (err) {
      throw new Error(err.message);
    }
  };

  //? update krdnaway products bapey ID
  const updateProductById = async (productId, params) => {
    try {
      const updatedProduct = await knex("products")
        .where("id", productId)
        .update(params);
      if (!updatedProduct) throw new Error("Product Id invalid");
      return updatedProduct;
    } catch (err) {
      throw new Error(err.message);
    }
  };

  //? delete krdny products bapey ID
  const deleteProductById = async (productId) => {
    try {
      const deletedProduct = await knex("products")
        .where("id", productId)
        .del();
      if (!deletedProduct) throw new Error("Product Id invalid");
      return deletedProduct;
    } catch (err) {
      throw new Error(`Error deleting product: ${err.message}`);
    }
  };

  const getDistinctCategories = async () => {
    try {
      const categories = await knex("products").distinct("category");
      return categories.map((cat) => cat.category);
    } catch (err) {
      throw new Error(err.message);
    }
  };

  return {
    createProduct,
    getProduct,
    getProductById,
    updateProductById,
    deleteProductById,
    getProductsByCategory,
    getDistinctCategories,
  };
};
