const errorHandles = (err, req, res, next) => {
  if (typeof err === "string") {
    // Custom error message
    return res.status(400).json({ message: err });
  }

  if (err.name === "ValidationError") {
    // Mongoose validation error
    return res.status(400).json({ message: err.message });
  }

  if (err.name === "UnauthorizedError") {
    // JWT authorization error
    return res.status(401).json({ message: "Unauthorized" });
  }

  // Handle other errors
  return res.status(500).json({ message: err.message || "Internal Server Error" });
};

module.exports = { errorHandles };
