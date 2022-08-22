const { environment } = require('@rails/webpacker')

module.exports = environment

// sqliteバージョンアップに伴い、jqueryが読み込まれなくなったので、追記
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    Popper: 'popper.js'
  })
)