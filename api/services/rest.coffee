_ = require 'lodash'
oauth2 = require 'oauth2_client'
http = require 'needle'
Promise = require 'bluebird'

module.exports = () ->
  get: (url) ->
    new Promise (fulfill, reject) ->
      users =
        id: process.env.USER_ID.split ','
        secret: process.env.USER_SECRET.split ','
      users = _.map users.id, (id, index) ->
        id: id
        secret: users.secret[index]
      user = _.head(users)
      client =
        id: process.env.PASS_CLIENT_ID
        secret: process.env.PASS_CLIENT_SECRET
      scope = process.env.SCOPE.split ' '
      oauth2
        .token process.env.TOKENURL, client, user, scope
        .then (token) ->
          opts =
            headers:
              Authorization: "Bearer #{token}"
          http.get url, opts, (err, res) ->
            if err
              return reject err
            fulfill res
