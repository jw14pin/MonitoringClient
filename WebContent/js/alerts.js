//get alerts for each machine
alldata = "";
/*function getAlerts(machine, count, itemCount) {
	$.ajax({
		url:"alert?machine="+machine,
		type:'POST',
		success: function(data) {
			$alldata = $(data);
			$alerts = $(data).find("#alert-results");
			
			//$('#alert-results').empty();
			$('#alert-results').append($alerts.html());
			
			$raw = $(data).find("#raw-output");
			//$('#raw-output').empty();
			$('#raw-output').append($raw.html()+"<br/>");
			
			count.value++;
			
			//check to see if all loads are done
			if(count.value >= itemCount) {
				//stop and remove the load icon
				removeLoadIcon();
				if($('#alert-results').children().length == 0) {
					showNoAlerts();
				}
			}
		}
	});
}*/

function getAlerts(machine, count, itemCount) {
	getNextAlert(machine, count, itemCount, 1);
}

function getNextAlert(machineName, count, itemCount, index) {
	$.ajax({
		url:"monitor?machine="+machineName+"&index="+index,
		type:'POST',
		dataType:'json',
		success: function(data) {			
			alldata = data;
			
			var finish = true;
			
			//Server returns NoMoreTests message, discontinue
			if(data[0].message != null || data[0].resources.length == 0) {
				count.value++;
				
				//check to see if all loads are done
				if(count.value >= itemCount) {
					//stop and remove the load icon
					removeLoadIcon();
					if($('#alert-results').children().length == 0) {
						showNoAlerts();
					}
				}
				finish = false;
				return;
			}
			
			if(finish) {				
				var raw = prettyPrint(data, {maxDepth:10});
				$('#raw-output').append("<div style='overflow:auto'>"+raw.innerHTML+"</div>");
				$('#raw-output').append("<br/>");
				
				
				//$alerts = $(data).find("#alert-results");
				
				//$('#alert-results').empty();
				//this part is harcoded cause we know the exact format of the json response
				//check machine first
				var machine = data[0];
				
				//TODO put back
				//if(machine.status != 'true') {
				
					//TODO put back
					//$('#alert-results').append(formatMachineAlert(machine));
					
					//check each resource on machine
					for(var i = 0; i < machine.resources.length; i++) {
						var resource = machine.resources[i];
		
						if(resource.status == 'true') {
							$('#alert-results').append(formatOkAlert(resource));
						} else {
							$('#alert-results').append(formatAlert(resource));
						}
					}
				
				
				//}
				
				getNextAlert(machineName, count, itemCount, index+1); //keep getting the next alert until server returns NoMoreTests message
			}
		}
	});
}

function getHeaderRow() {
	return "<h4 class='content alert-block paddedbox fade in'>"+
	"<div style='display:inline-block;width:400px'>"+
	"Test Name"+
	"</div>" +
	"<div style='display:inline-block;width:250px;padding-right:10px;'>"+
	"Status"+
	"</div>" +
	"<div style='display:inline-block;width:150px'>"+
	"Machine"+
	"</div>" +
	"</h4>";
}

function formatMachineAlert(alert) {
	return "<div class=\"alert alert-block alert-error fade in\">"+
			"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>"+
			"<h4 class=\"alert-heading wordwrap\">"+alert.name+" has some test failures</h4>"+
			"</div>";
}

function formatAlert(alert) {
	var status = alert.status;
	if(status.length > 120) {  //if the status is too long, then truncate part of it to fit and leave the rest for if they want to see more
		status = alert.status.substring(0,121);
		return "<div class=\"alert alert-block alert-error fade in\">"+
		"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>"+
		"<h4 class=\"alert-heading wordwrap\"><div style='display:inline-block;width:400px;vertical-align:top' data-status='hide'>"+alert.name+"</div><div class='showLess' style='display:inline-block;width:250px;vertical-align:top;padding-right:8px;'>"+status+"... <a class='toggleStatus' href='#' onClick='toggleStatus(this)'>show more</a></div><div class='showMore' style='display:none;width:250px;vertical-align:top;padding-right:8px;'>"+alert.status+"  <a class='toggleStatus' href='#' onClick='toggleStatus(this)'>show less</a></div><div style='display:inline-block;width:150px;vertical-align:top'>"+alert.machine+"</div></h4>"+
		"</div>";
	} else {
		return "<div class=\"alert alert-block alert-error fade in\">"+
		"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>"+
		"<h4 class=\"alert-heading wordwrap\"><div style='display:inline-block;width:400px;vertical-align:top' data-status='hide'>"+alert.name+"</div><div class='showLess' style='display:inline-block;width:250px;vertical-align:top;padding-right:8px;'>"+status+"</div><div style='display:inline-block;width:150px;vertical-align:top'>"+alert.machine+"</div></h4>"+
		"</div>";
	}
}

function formatOkAlert(alert) {
	return "<div class=\"alert alert-block alert-error fade in greenAlert\">"+
	"<button type=\"button\" class=\"close\" data-dismiss=\"alert\">×</button>"+
	"<h4 class=\"alert-heading wordwrap greenAlert\"><div style='display:inline-block;width:400px;vertical-align:top'>"+alert.name+"</div><div style='display:inline-block;width:250px;vertical-align:top;padding-right:8px;'>PASSED</div><div style='display:inline-block;width:150px;vertical-align:top'>"+alert.machine+"</div></h4>"+
	"</div>";
}

function showLoadIcon() {
	$("#alert-results-loading").append('<div id="loading" style="text-align:center" class="alert-block fade in"><img src="img/ajax-loader.gif" /></div>');
}

function removeLoadIcon() {
	$("#alert-results-loading").remove();
}

function showNoAlerts() {
	$("#alert-results").append('<div class="content alert-block paddedbox fade in">You have no alerts.</div>');
}

function toggleStatus(element) {
	if($(element).closest("h4").attr('data-status') == 'show') {
		$(element).closest("h4").attr('data-status','hide');
		$(element).closest("h4").find('.showLess').css('display','inline-block');
		$(element).closest("h4").find('.showMore').css('display','none');
	} else {
		$(element).closest("h4").attr('data-status','show');
		$(element).closest("h4").find('.showLess').css('display','none');
		$(element).closest("h4").find('.showMore').css('display','inline-block');
	}
	return false;
}