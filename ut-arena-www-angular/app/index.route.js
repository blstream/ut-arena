(function() {
	'use strict';

	angular
	.module('angular-core')
	.config(routeConfig)

	function routeConfig($routeProvider, $locationProvider) {
		$routeProvider
			.when('/', {
				templateUrl: 'home/home.html',
				controller: 'HomeController'
			})
			.when('/home', {
				templateUrl: 'home/home.html',
				controller: 'HomeController'
			})
			.otherwise({
				redirectTo: '/'
			});
	}

})();
