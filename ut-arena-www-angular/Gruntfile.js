/*global module*/ 

module.exports = function(grunt) { 
	'use strict'; 
	
	var path = require('path');
	
	grunt.initConfig({ 
		
		pkg: grunt.file.readJSON('package.json'),
		connect: {
			example: {
				port: 2000,
				base: 'app'
			}
		}	
	}); 

	grunt.loadNpmTasks('grunt-connect');
	grunt.registerTask('serve', 'connect:example');
}; 




