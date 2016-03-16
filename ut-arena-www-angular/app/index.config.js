(function() {
	'use strict';

	angular
	.module('angular-core')
	.config(function ($translateProvider, LOCALES) {
    
    $translateProvider.useStaticFilesLoader({
		prefix: 'resources/locale-',
		suffix: '.json'
    });

    $translateProvider.preferredLanguage(LOCALES.preferredLocale);
  })
	

})();
