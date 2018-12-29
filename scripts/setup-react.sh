#!/bin/sh

# echo "Adding React packes ----------------------"
yarn add react react-dom --save

# echo "Adding Babel packages ----------------------"
yarn add @babel/core babel-loader @babel/preset-env @babel/preset-react --save-dev

# echo "Adding CSS loaders ----------------------"
yarn add css-loader style-loader --save-dev

# Create .babelrc set presets
cat <<EOF > webpack.config.js
const path = require("path");

module.exports = {
  entry: "./src/index.js",
  output: {
    path: path.join(__dirname, "/dist"),
    filename: "index_bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.js$/,
        exclude: /node_modules/,
        use: {
          loader: "babel-loader"
        },
      },
      {
        test: /\.css$/,
        use: ["style-loader", "css-loader"]
      }
    ]
  }
};
EOF

cat <<EOF > .babelrc
  {
    "presets": ["@babel/preset-env", "@babel/preset-react"]
  }
EOF

#TODO(aeissa): Add clean option and functionality
