(function (global) {
	"use strict";

	var LCC = global.LCC || {};
	LCC.Modules = LCC.Modules || {};

	LCC.Modules.InsiteContacts = function () {
		this.start = function (element) {

			var listItemId = element.attr("data-listitemid");

			var urlElem = element.find('.personalUrlPlaceholder')[0];
			var titleElem = element.find('.titlePlaceholder')[0];
			var jobTitleElem = element.find('.jobTitlePlaceholder')[0];
			var workPhoneElem = element.find('.workPhonePlaceholder')[0];
			var mobilePhoneElem = element.find('.mobilePhonePlaceholder')[0];
			var emailElem = element.find('.emailPlaceholder')[0];

			$(function () {
				$.ajax({
					url: _spPageContextInfo.siteAbsoluteUrl + "/_api/web/lists/getbytitle('insite%20contacts')/items(" + listItemId + ")?$select=LCCContact/Name,LCCContact/Title,LCCContact/FirstName,LCCContact/LastName,LCCContact/JobTitle,LCCContact/WorkPhone,LCCContact/MobilePhone,LCCContact/EMail&$expand=LCCContact",
							type: "GET",
							dataType: "json",
							headers: { "accept": "application/json;odata=verbose" },
					success: function (data) {			
						urlElem.href = "https://mysite.leeds.gov.uk/Person.aspx?accountname=" + encodeURIComponent(data.d.LCCContact.Name);
						titleElem.innerHTML = data.d.LCCContact.Title;
						jobTitleElem.innerHTML = data.d.LCCContact.JobTitle;
						if (data.d.LCCContact.WorkPhone === null) {
							workPhoneElem.parentNode.parentNode.style.display = "none";
						}
						else {
							workPhoneElem.href = "tel:" + data.d.LCCContact.WorkPhone;
							workPhoneElem.innerHTML = data.d.LCCContact.WorkPhone;
						}	
						if (data.d.LCCContact.MobilePhone === null) {
							mobilePhoneElem.parentNode.parentNode.style.display = "none";
						}
						else {
							mobilePhoneElem.href = "tel:" + data.d.LCCContact.MobilePhone;
							mobilePhoneElem.innerHTML = data.d.LCCContact.MobilePhone;
						}						
						emailElem.href = "mailto:" + data.d.LCCContact.EMail;
						emailElem.innerHTML = data.d.LCCContact.EMail;
					},
					error: function (jQxhr, errorCode, errorThrown) {
						alert(errorThrown);
					}
				})
			});		
		};
	};

	global.LCC = LCC;
})(window);