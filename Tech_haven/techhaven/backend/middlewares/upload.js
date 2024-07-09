const multer = require('multer');
const path = require('path');
const fs = require('fs');

// Ensure the uploads directory exists
const uploadDir = './uploads';
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  },
});

const fileFilter = (req, file, callback) => {
  const validExts = ['.png', '.jpg', '.jpeg'];

  if (!validExts.includes(path.extname(file.originalname).toLowerCase())) {
    return callback(new Error('Only .png, .jpg, .jpeg format allowed'));
  }

  callback(null, true);
};

let upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 1048576, // 1MB
  },
});

module.exports = upload.single('productImage');
