/* eslint-disable @typescript-eslint/no-var-requires */
const path = require('path');

const withSass = require('@zeit/next-sass');
const withCSS = require('@zeit/next-css');
const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin');

const environment = process.env.NODE_ENV || 'production';

module.exports = withCSS(withSass({
  webpack(config) {
    const { rules } = config.module;
    const { modules } = config.resolve;

    rules.push({
      test: /\.tsx?$/,
      use: [
        { loader: 'baggage-loader?{"[file].scss":{}}' },
      ],
    });

    modules.push(
      path.resolve(__dirname, 'node_modules'),
      path.resolve(__dirname, 'source'),
    );

    if (Array.isArray(config.optimization.minimizer)) {
      config.optimization.minimizer.push(
        new OptimizeCSSAssetsPlugin({}),
      );
    }

    return config;
  },
  env: {
    environment,
    isDevelopment: environment === 'development',
    isProduction: environment === 'production',
    isStaging: environment === 'staging',
    isLocal: environment === 'local',
  },
  exportPathMap() {
    return {
      '/': { page: '/' },
    };
  },
}));
