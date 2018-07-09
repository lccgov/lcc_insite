(function (global) {
    "use strict";

    var LCC = global.LCC || {};
    LCC.Modules = LCC.Modules || {};
    LCC.Settings = LCC.Settings || {};

    LCC.Modules.KeywordFilter = function () {
        this.start = function (element) {
			
			element.find('h3').html("View by keyword"); 
			
			var input = element.find('.js-keyword');
			input.keyup(function(event) {
				event.preventDefault();
				if (event.keyCode === 13) {
					changeLocation();
				}
			});
            element.on('click', '.js-keyword-submit', function () {
                changeLocation();
            });
			
			function changeLocation () {
				var queryString = "?k=" + input.val();
                var newsUrl = ( LCC.Settings.NewsUrl !== undefined ) ? LCC.Settings.NewsUrl : ((_spPageContextInfo.webServerRelativeUrl.length === 1) ? _spPageContextInfo.webServerRelativeUrl.substr(1) : _spPageContextInfo.webServerRelativeUrl) + "/news";                   
                window.location = newsUrl + queryString + '*';
			}
        };
    };

    global.LCC = LCC;
})(window);