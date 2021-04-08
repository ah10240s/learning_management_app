process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

const webpack = require('webpack')
environment.plugins.prepend('Provide',
    new webpack.ProvidePlugin({
    $: 'admin-lte/plugins/jquery/jquery',
    jQuery: 'admin-lte/plugins/jquery/jquery',
    })
)



module.exports = environment.toWebpackConfig()
