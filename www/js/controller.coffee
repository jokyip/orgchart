env = require './env.coffee'
	
MenuCtrl = ($scope) ->
	$scope.env = env
	$scope.navigator = navigator

UserListCtrl = ($scope, $location, model) ->
	_.extend $scope,
		model: model

UserUpdateCtrl = ($scope, $state, resource, model) ->
	_.extend $scope,
		resource: resource
		model: model


config = ->
	return
	
angular.module('starter.controller', ['ionic', 'ngCordova', 'http-auth-interceptor', 'starter.model', 'platform']).config [config]	
angular.module('starter.controller').controller 'MenuCtrl', ['$scope', MenuCtrl]
angular.module('starter.controller').controller 'UserListCtrl', ['$scope', '$location', 'model', UserListCtrl]
angular.module('starter.controller').controller 'UserUpdateCtrl', ['$scope', '$state', 'resource', 'model', UserUpdateCtrl]