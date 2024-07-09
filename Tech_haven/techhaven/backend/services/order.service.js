module.exports = (knex) => {
  const createOrder = async (orderData) => {
    try {
      const [insertedOrderId] = await knex("orders")
        .insert(orderData)
        .returning("id");
      return insertedOrderId;
    } catch (error) {
      throw new Error(`Error creating order: ${error.message}`);
    }
  };

  const createOrderItems = async (orderItems) => {
    try {
      await knex("order_items").insert(orderItems);
    } catch (error) {
      throw new Error(`Error creating order items: ${error.message}`);
    }
  };

  const getAllOrders = async () => {
    try {
      console.log("Retrieving all orders");
      const orders = await knex("orders").select("*");
      console.log("Retrieved orders:", orders);
      return orders;
    } catch (err) {
      console.error("Error retrieving orders:", err);
      throw new Error(err.message);
    }
  };

  const getOrderById = async (orderId) => {
    try {
      console.log("Retrieving order with ID:", orderId);
      const order = await knex("orders").where("id", orderId).first();
      if (!order) throw new Error("Order not found");
      console.log("Retrieved order:", order);
      return order;
    } catch (err) {
      console.error("Error retrieving order:", err);
      throw new Error(err.message);
    }
  };

  const updateOrderById = async (orderId, params) => {
    try {
      console.log("Updating order with ID:", orderId, "and params:", params);
      const updatedOrder = await knex("orders")
        .where("id", orderId)
        .update(params);
      if (!updatedOrder) throw new Error("Order not found");
      console.log("Updated order:", updatedOrder);
      return updatedOrder;
    } catch (err) {
      console.error("Error updating order:", err);
      throw new Error(err.message);
    }
  };

  const deleteOrderById = async (orderId) => {
    try {
      console.log("Deleting order with ID:", orderId);
      const deletedOrder = await knex("orders").where("id", orderId).del();
      if (!deletedOrder) throw new Error("Order not found");
      console.log("Deleted order:", deletedOrder);
      return deletedOrder;
    } catch (err) {
      console.error("Error deleting order:", err);
      throw new Error(err.message);
    }
  };

  return {
    createOrder,
    getAllOrders,
    getOrderById,
    updateOrderById,
    deleteOrderById,
    createOrderItems,
  };
};
