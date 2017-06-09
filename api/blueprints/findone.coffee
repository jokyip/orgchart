_ = require 'lodash'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
  Model = actionUtil.parseModel req
  pk = actionUtil.requirePk(req)

  Model.findOne(email: pk)
    .populateAll()
    .then (result) ->
      sails.services.rest().get "#{process.env.IMURL}/api/user?email=#{result.email}"
        .then (detail)->
          _.extend result, _.pick(detail.body.results[0],'status','title','phone','organization')
          result: result
    .then res.ok, res.serverError
