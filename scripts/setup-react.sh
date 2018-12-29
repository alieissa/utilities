#!/bin/sh

echo "Adding React packes ----------------------"
yarn add react react-dom

echo "Adding Babel packages ----------------------"
yarn add @babel/core babel-loader @babel/preset-env @babel/preset-react --dev

echo "Adding CSS loaders ----------------------"
yarn add css-loader style-loader --dev

echo "Adding webpack packages ----------------------"
yarn add webpack webpack-cli webpack-dev-server html-webpack-plugin --dev

echo "Adding testing packages ----------------------"
yarn add --dev jest jest-cli enzyme enzyme-adapter-react-16 sinon
# This is needed to make jest work with babel version 7
yarn add --dev babel-jest babel-core@^7.0.0-bridge.0 @babel/core

# Create index.js file
cat <<EOF > src/index.js
import React from 'react';
import ReactDOM from 'react-dom';
import App from './App';

ReactDOM.render(<App />, document.getElementById('app-container'));
EOF

# styleMocks determines how css modules are to be handled
# in this case they are ignored
mkdir __mocks__
cat<<EOF > __mocks__/styleMock.js
module.exports = {};
EOF

# Create jest.config.js. This is necessary to run tests
# moduleNAmeMApper is needed in order disregard css modules
# enzyme.setup.js is needed because we setup an adapter before running test
cat <<EOF > jest.config.js
const path = require("path")
module.exports = {
  verbose: true,
  moduleNameMapper: {
    ".css$": path.join(__dirname, "__mocks__/styleMock.js")  
 },
 setupTestFrameworkScriptFile: path.join(__dirname, "enzyme.setup.js")
};
EOF

# Create enzyme config file
cat <<EOF >enzyme.setup.js
import Enzyme, { mount, render, shallow } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';
Enzyme.configure({ adapter: new Adapter() });
EOF
# Create .babelrc set presets
cat <<EOF > webpack.config.js
const HtmlWebpackPlugin = require("html-webpack-plugin");
const path = require("path");

module.exports = {
  entry: path.join(__dirname, "src", "index.js"),
  output: {
    path: path.join(__dirname, "dist"),
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
  },
  plugins: [new HtmlWebpackPlugin({
    template: "index.html"
  })]
};
EOF

cat <<EOF > .babelrc
  {
    "presets": ["@babel/preset-env", "@babel/preset-react"]
  }
EOF

#TODO(aeissa): Add clean option and functionality
