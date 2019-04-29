(function (global) {
	"use strict";

	var LCC = global.LCC || {};
	LCC.Modules = LCC.Modules || {};

	LCC.Modules.EventCarousel = function () {
		this.start = function (element) {

			var eventDates = element.find('.js-event-start');
			var i;
			for (i = 0; i < eventDates.length; ++i) {
				var startElem = eventDates[i];
				var endElem = startElem.nextElementSibling;
				var parsedStartDate = new Date(startElem.innerText);
				var parsedEndDate = new Date(endElem.innerText);

				if (parsedStartDate.format("HH:mm") == "01:00" && parsedEndDate.format("HH:mm") == "00:59") {
					parsedStartDate.setMinutes(parsedStartDate.getMinutes() - 60);
					parsedEndDate.setMinutes(parsedEndDate.getMinutes() - 60);
					startElem.innerText = parsedStartDate.format('dd MMMM yyyy HH:mm');
					endElem.innerText = parsedEndDate.format('dd MMMM yyyy HH:mm');
				}
			}			
		};
	};

	global.LCC = LCC;
})(window);