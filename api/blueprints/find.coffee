_= require 'lodash'
Promise = require 'bluebird'
actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res) ->
  Model = actionUtil.parseModel req
  cond = actionUtil.parseCriteria req

  count = Model
    .count()
    .toPromise()
  query = Model
    .find()
    .where cond
    .sort actionUtil.parseSort req
    .toPromise()

  Promise
    .all [count, query]
    .then (result) ->
      count: result[0]
      Promise
        .all _.map result[1], (user) ->
           sails.services.rest().get "#{process.env.IMURL}/api/user?email=#{user.email}"
             .then (detail) ->
                return  _.extend user, _.pick(detail.body.results[0],'status','title','phone','organization', 'photoUrl')
        .then (allUserDetails) ->
           results: allUserDetails
    .then res.ok, res.serverError
