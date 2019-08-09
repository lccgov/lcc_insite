(function (global) {
	"use strict";

	var LCC = global.LCC || {};
	LCC.Modules = LCC.Modules || {};

	LCC.Modules.RatingModule = function () {
		this.start = function (element) {
			
			var listIdDivContents = document.getElementById('rateThis').getAttribute('data-list-id');
			var listId = listIdDivContents == "" ? _spPageContextInfo.pageListId : listIdDivContents;
			JSRequest.EnsureSetup(); 
			var itemId = JSRequest.QueryString["ID"] === undefined ? _spPageContextInfo.pageItemId : JSRequest.QueryString["ID"];	
				
			var modal = document.getElementById('ratingModal');
			
			SP.SOD.registerSod('reputation.js', '/_layouts/15/reputation.js');
			
			SP.SOD.executeFunc('sp.js', 'SP.ClientContext', getPageRating);
			
			function getPageRating() {
				
				var ctx = new SP.ClientContext.get_current();
				var list = ctx.get_web().get_lists().getById(listId);
				var item = list.getItemById(itemId);
						 
				ctx.load(item, "AverageRating");
						
				ctx.executeQueryAsync(
					function (s, e) {		
						var avgRating = Math.round(item.get_item("AverageRating"));
						if (avgRating >= 1) {
							$("#oneStar").addClass("rating-checked");
						}
						if (avgRating >= 2) {
							$("#twoStar").addClass("rating-checked");
						}
						if (avgRating >= 3) {
							$("#threeStar").addClass("rating-checked");
						}
						if (avgRating >= 4) {
							$("#fourStar").addClass("rating-checked");
						}
						if (avgRating === 5) {
							$("#fiveStar").addClass("rating-checked");
						}
					}, function (s, e) {
						document.getElementById("ratingMessage").innerHTML = "We are unable to retrieve the rating for this page";
					});
			}
			
			function updatePageRating(rating) {
				
				EnsureScriptFunc('reputation.js', 'Microsoft.Office.Server.ReputationModel.Reputation', function() {
				
					var ctx = new SP.ClientContext();
					rating = Microsoft.Office.Server.ReputationModel.Reputation.setRating(ctx, listId, itemId , rating);
					ctx.executeQueryAsync(done, fail);

				});
				
				function done() {
					console.log('Rating updated');	
					clearAverageRating();
					getPageRating();
					document.getElementById("ratingMessage").innerHTML = "Thank you for your feedback";	
					document.getElementById('commentBox').value = "";					
				}

				function fail() {
					console.log('Failed to update rating');
				}		
						
			}
			
			function createRatingComment(rating) {
				
				var clientContext = new SP.ClientContext.get_current();
				var oSite = clientContext.get_site();
				var oWebsite = oSite.get_rootWeb();
				var oList = oWebsite.get_lists().getByTitle('ratingComments');			
				var itemCreateInfo = new SP.ListItemCreationInformation();
				var oListItem = oList.addItem(itemCreateInfo);
				
				oListItem.set_item('Rating', rating);		
				oListItem.set_item('_Comments', document.getElementById('commentBox').value);
				oListItem.set_item('URL', _spPageContextInfo.siteAbsoluteUrl + _spPageContextInfo.serverRequestPath);
				oListItem.set_item('Item_x0020_Id', itemId);
					
				oListItem.update();

				clientContext.load(oListItem);
					
				clientContext.executeQueryAsync(done, fail);

				function done() {
					console.log('Item created');
				}

				function fail(sender, args) {
					console.log('Request failed. ' + args.get_message());
				}

			}
			
			function clearAverageRating () {
				$("#oneStar").removeClass("rating-checked");
				$("#twoStar").removeClass("rating-checked");
				$("#threeStar").removeClass("rating-checked");
				$("#fourStar").removeClass("rating-checked");
				$("#fiveStar").removeClass("rating-checked");
			}
			
			element.on('click', '.js-open-modal', function () {	
				modal.style.display = "block";
				return false;
			});
			
			element.on('click', '.js-rating-submit', function () {	
				var ratingChosen;
				var radioValue = $('input[name=rating]:checked').attr('id');
				
				switch (radioValue) {
					case "oneStarClickable":
						ratingChosen = 1;
						break;
					case "twoStarClickable":
						ratingChosen = 2;
						 break;
					case "threeStarClickable":
						ratingChosen = 3;
						 break;
					case "fourStarClickable":
						ratingChosen = 4;
						 break;
					case "fiveStarClickable":
						ratingChosen = 5;
						 break;
					default:
						ratingChosen = 0;
						 break;
				} 
				
				if (ratingChosen === 0) {
					return false;
				}
				else {		
					updatePageRating(ratingChosen);
					createRatingComment(ratingChosen);									
					modal.style.display = "none";															
					return false;
				}
			});			
			
			element.on('click', '.js-rating-cancel', function () {		
				modal.style.display = "none";
				return false;
			});

			element.on('click', '.js-close-modal', function () {
				modal.style.display = "none";
			});

			window.onclick = function(event) {
				if (event.target == modal) {
					modal.style.display = "none";
				}
			} 
	
		};
	};

	global.LCC = LCC;
})(window)