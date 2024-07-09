// product.services.js

module.exports = async (knex) => {
  try {
    const tableExists = await knex.schema.hasTable("products");

    if (!tableExists) {
      await knex.schema.createTable("products", (table) => {
        table.increments("id").primary();
        table.string("productName");
        table.string("productDescription");
        table.decimal("productPrice");
        table.string("productImage");
        table.string("productCode");
        table
          .enum("productStatus", ["pending", "complete"])
          .defaultTo("pending");
        table.string("category");
        table.string("productColor");
        table.string("productSize");
        table.timestamps(true, true); // Adds `created_at` and `updated_at` columns
      });

      console.log("Products table created");
    } else {
      console.log("Products table already exists");
    }
  } catch (error) {
    console.error("Error creating products table:", error);
  }

  // Methods to interact with the 'products' table
  return {
    // Define methods here
  };
};
