(function (global) {
	    "use strict";

	    var LCC = global.LCC || {};
	    LCC.Modules = LCC.Modules || {};
		LCC.Settings = LCC.Settings || {};

	    LCC.Modules.NewsArchiveFilter = function () {
	        this.start = function (element) {
				
				element.find('h3').html("News archive"); 
				
				getArchiveMonths();
			
	            element.on('click', '.js-news-archive-filter-submit', function () {

	                var year = $(this).data('year');
	                var month = $(this).data('month');

	                var d = new Date(year, month, 0);
	                var start = year + "/" + month + "/1";
	                var end = year + "/" + month + "/" + d.getDate();

	                var queryString = "?startdate=" + start + "&enddate=" + end;
	                var newsUrl = ( LCC.Settings.NewsUrl !== undefined ) ? LCC.Settings.NewsUrl : ((_spPageContextInfo.webServerRelativeUrl.length === 1) ? _spPageContextInfo.webServerRelativeUrl.substr(1) : _spPageContextInfo.webServerRelativeUrl) + "/news";                   
                	window.location = newsUrl + queryString;


	            });	            

	            function getArchiveMonths() {
	                var source = $("#archive-template").html();
	                var template = Handlebars.compile(source);

					var today = new Date();
					var thisMonth = today.getMonth();
					var thisYear = today.getFullYear();
					var monthsAsString = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];

					var years = [];
					var months = [];

					years.push({ 'year': thisYear, 'months': [{ 'month': thisMonth+1, 'monthAsString': monthsAsString[thisMonth] }] });
					
					var i = 0;
					for (i = 0; i < 11; i++) {				  
						thisMonth--;
						if (thisMonth < 0) {
							thisMonth = 11;
							thisYear--;		
							years.push({ 'year': thisYear, 'months': [{ 'month': thisMonth+1, 'monthAsString': monthsAsString[thisMonth] }] });
						}
						else {
						  years[years.length - 1].months.push({ 'month': thisMonth+1, 'monthAsString': monthsAsString[thisMonth] });
						}			  
					}
					
					var html = template({ Years: years });
					$("#archive").html(html);

					if (window.location.href.indexOf("news?") > -1) {
					$('h1').after('<a href="#" class="reset btn-default btn"><i class="fa fa-refresh" aria-hidden="true"></i> Reset Filters</a><hr class="resetHr"/>');
					$(".reset").click(function(){
					window.location.href = window.location.href.split('?')[0];
					});
    	            }

					LCC.modules.start($("#newsAccordion"));
				}				
				
	        };
	    };

	    global.LCC = LCC;
	})(window);