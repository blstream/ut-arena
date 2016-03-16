(function() {
	'use strict';

	angular
	.module('angular-core')
	.run(routeRun);
	
	function routeRun ($rootScope, $location, $route) {
		$rootScope.$on('$routeChangeStart',
			function (event, next, current) {
			
  			});
	}
	
})();
