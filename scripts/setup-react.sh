#!/bin/sh

echo "Adding React packes ----------------------"
yarn add react react-dom

echo "Adding Babel packages ----------------------"
yarn add @babel/core babel-loader @babel/preset-env @babel/preset-react --dev

echo "Adding CSS loaders ----------------------"
yarn add css-loader style-loader --dev

echo "Adding webpack packages ----------------------"
yarn add webpack webpack-cli webpack-dev-server --dev

# Create index.js file
cat <<EOF > index.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(<App />, document.getElementById('root'));
EOF

# Create .babelrc set presets
cat <<EOF > webpack.config.js
const path = require("path");

module.exports = {
  entry: path.join(__dirname, 'src', 'index.js'),
  output: {
    path: path.join(__dirname, "/dist"),
    filename: "index_bundle.js"
  },
  devServer: {
    contentBase: path.join(__dirname, 'dist'),
    historyApiFallback: true // Needed to make React router work without using # in URL
  },
  mode: "development",
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
