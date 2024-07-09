const knex = require("../config/app.config");
const orderService = require("../services/order.service")(knex);

exports.createOrder = async (req, res, next) => {
  try {
    const order = {
      city: req.body.city,
      town: req.body.town,
      address: req.body.address,
      phone_number: req.body.phoneNumber || "N/A",
      comment: req.body.comment,
    };

    const items = req.body.items || [];

    // Create the main order
    const createdOrderId = await orderService.createOrder(order);

    // If there are items in the order, create order items
    if (items.length > 0) {
      const orderItems = items.map((item) => ({
        order_id: createdOrderId,
        product_id: item.productId,
        quantity: item.quantity,
        price: item.productPrice,
        total_price: item.quantity * item.productPrice,
      }));

      // Create order items in the database
      await orderService.createOrderItems(orderItems);
    }

    res.status(200).json({
      message: "Order created successfully",
      data: { orderId: createdOrderId },
    });
  } catch (error) {
    next(error); // Pass any caught error to the global error handler
  }
};
exports.getAllOrders = async (req, res, next) => {
  try {
    const orders = await orderServices.getAllOrders();
    res.status(200).json({
      message: "Success",
      data: orders,
    });
  } catch (error) {
    next(error);
  }
};

exports.getOrderById = async (req, res, next) => {
  const orderId = req.params.id;

  try {
    const order = await orderServices.getOrderById(orderId);
    res.status(200).json({
      message: "Success",
      data: order,
    });
  } catch (error) {
    next(error);
  }
};

exports.updateOrderById = async (req, res, next) => {
  const orderId = req.params.id;

  try {
    const model = {
      city: req.body.city,
      town: req.body.town,
      address: req.body.address,
      phone_number: req.body.phone_number,
      comment: req.body.comment,
      total_price: req.body.total_price,
    };

    const updatedOrder = await orderServices.updateOrderById(orderId, model);
    res.status(200).json({
      message: "Order updated successfully",
      data: updatedOrder,
    });
  } catch (error) {
    next(error);
  }
};

exports.deleteOrderById = async (req, res, next) => {
  const orderId = req.params.id;

  try {
    const result = await orderServices.deleteOrderById(orderId);
    res.status(200).json({
      message: "Order deleted successfully",
      data: result,
    });
  } catch (error) {
    next(error);
  }
};
