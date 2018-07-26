(function (global) {
	    "use strict";

	    var LCC = global.LCC || {};
	    LCC.Modules = LCC.Modules || {};

	    LCC.Modules.BuildingLocations = function () {
	        this.start = function (element) {
				
				function populateList(menuId)
				{
					$.ajax({
						url: _spPageContextInfo.webAbsoluteUrl + "/_api/web/lists(guid'8973E6C5-CBA5-4064-AF35-C772EFCD9D87')/Items?$select=Title,PostCode&$top=1000",
						type: "GET",
						dataType: "json",
						headers: { "accept": "application/json;odata=verbose" },
						success: function (data) {
							$.each(data.d.results, function (index, item) {
								addOption(item.Title, item.PostCode, menuId);
							});
						},
						fail: function (err) { alert('Error: ' + err);}
					});
				}

				function addOption(buildingValue, postcodeValue, menuId)
				{
					var node = document.createElement("OPTION");
					var textnode = document.createTextNode(buildingValue);
					node.value = postcodeValue;
					node.appendChild(textnode);
					document.getElementById(menuId).appendChild(node);
				}
				
				populateList("selectStart");
				populateList("selectEnd");
				
				element.on('click', '.js-build-map-url', function () {
					var startLocation = $('input[name=radio-from-location-group]:checked').val() === 'LCC Building' ? document.getElementById("selectStart").value : document.getElementById("from-postcode-location").value;

					var endLocation = $('input[name=radio-to-location-group]:checked').val()  === 'LCC Building' ? document.getElementById("selectEnd").value : document.getElementById("to-postcode-location").value;
					
					var mapURL = "https://www.google.com/maps/dir/"+ startLocation + "/" + endLocation;
					
					window.open(mapURL);
					return false;         
				});
				
				element.on('click', '.js-toggle-active', function () {		
					var parentElement = this.parentElement;
					var parentElementSiblings = getSiblings(parentElement);
					if(this.type =='radio')
					{
						for (var i = 0; i < parentElementSiblings.length; i++)
						{
							parentElementSiblings[i].classList.remove("active");
						}
						if (this.checked)
						{
							parentElement.classList.add("active");
						}
					}
				});
				
				function getSiblings(elem)
				{
					var siblings = [];
					var sibling = elem.parentNode.firstChild;
					for (; sibling; sibling = sibling.nextSibling)
						if (sibling.nodeType == 1 && sibling != elem)
							siblings.push(sibling);
					return siblings;
				}				

		    };
	    };

	    global.LCC = LCC;
	})(window);