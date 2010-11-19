var curr_focuses = null;
var delete_focuses = null;
var new_focuses = null;
var curr_talents = null;
var new_talents = null;
var delete_talents = null;
var new_wg = null;
var curr_wg = null;
var delete_wg = null;
$(function(){
	curr_focuses = $("#curr_focuses");
	delete_focuses = $("#delete_focuses");
	new_focuses = $("#new_focuses");
	curr_talents = $("#curr_talents");
	delete_talents = $("#delete_talents");	
	new_talents = $("#new_talents");
	new_wg = $("#new_wg");
	curr_wg = $("#curr_wg");
	delete_wg = $("#delete_wg");
	$("#focusBut").click(function(){
		
		var theFocus = $("select[name=focusList]").find("option:selected");
		/*Check to see if the focus already exists on this character*/
		var checkArr = curr_focuses.val();
		if (checkArr.length)
			checkArr += ",";
		checkArr += new_focuses.val();	
		checkArr = checkArr.split(",");
		if (checkArr.indexOf(theFocus.val()) == -1) {
			var theAbility = theFocus.parent();
			var theSpan = $("#focusSpan" + theAbility.attr("id"));
			/*var str = theSpan.html();
			if (str.length) 
				theSpan.append(", ");*/
			var liveSpan = $("<span>").html(theFocus.html());
			theSpan.append(" ");			
			theSpan.append(liveSpan);
			liveSpan.addClass("focusDelete").attr("focusid",theFocus.val());
			str = new_focuses.val();
			if (str.length) 
				new_focuses.val(new_focuses.val() + ",");
			new_focuses.val(new_focuses.val() + theFocus.val());
		}
	});
	$("#talentBut").click(function(){
		var theTalent = $("select[name=talentList]").find("option:selected");
		str = new_talents.val();
		if (str.length) 
			new_talents.val(new_talents.val() + ",");
		new_talents.val(new_talents.val() + theTalent.val());
		var select = $("<select>").attr("name","talent" + theTalent.val());
		//talentRanks loop options to append
		$.each(talentRanks,function(key,value){
			var x = value.split("-");
			select.append($("<option>").val(x[0]).html(x[1]));
		});		
		var tableRow = $("<tr>").append($("<td>").addClass("talentName").html(theTalent.html())).append($("<td>").append(select)).append($("<td>").addClass("talentDelete").attr("talentID",theTalent.val()).html("Remove"));
		$("#talentTable").append(tableRow);
	});
	$("#wgBut").click(function(){
		var theWG = $("select[name=wgList]").find("option:selected");
		str = new_wg.val();
		if (str.length) 
			new_wg.val(new_wg.val() + ",");
		new_wg.val(new_wg.val() + theWG.val());		
		var tableRow = $("<tr>").append($("<td>").addClass("wgName").html(theWG.html())).append($("<td>").addClass("wgDelete").attr("wgID",theWG.val()).html("Remove"));
		$("#wgTable").append(tableRow);
	});
	$(".focusDelete").live("click",function(){
		//alert("really delete:" + $(this).attr("focusid"));
		var x = confirm("Really remove: " + $(this).html() + "?");
		if (x)
		{
			var checkArr = new_focuses.val();
			checkArr = checkArr.split(",");
			var i = checkArr.indexOf($(this).attr("focusid"));
			if (i != -1) {
				checkArr.splice(i, 1);
				new_focuses.val(checkArr.join(","));
			}
			else {
				var str = delete_focuses.val();
				if (str.length) 
					delete_focuses.val(delete_focuses.val() + ",");
				delete_focuses.val(delete_focuses.val() + $(this).attr("focusid"));
			}
			$(this).fadeOut("slow",function(){
				$(this).remove();
			});
		}		
	});
	$(".talentDelete").live("click",function(){
		var x = confirm("Really remove: " + $(this).parent().children("td.talentName").html() + "?");
		if (x)
		{
			var checkArr = new_talents.val();
			checkArr = checkArr.split(",");
			var i = checkArr.indexOf($(this).attr("talentID"));
			if (i != -1)
			{
				checkArr.splice(i,1);
				new_talents.val(checkArr.join(","));
			}
			else
			{
				var str = delete_talents.val();
				if (str.length)
					delete_talents.val(delete_talents.val() + ",");
				delete_talents.val(delete_talents.val() + $(this).attr("talentID"));
			}
			$(this).parent().fadeOut("slow",function(){
				$(this).parent("tr").remove();				
			});
			
			checkArr = curr_talents.val();
			checkArr = checkArr.split(",");
			var i = checkArr.indexOf($(this).attr("talentID"));
			if (i != -1)
			{
				checkArr.splice(i,1);
				curr_talents.val(checkArr.join(","));
			}
		}
	});
	$(".wgDelete").live("click",function(){
		var x = confirm("Really remove: " + $(this).parent().children("td.wgName").html() + "?");
		if (x)
		{
			var checkArr = new_wg.val();
			checkArr = checkArr.split(",");
			var i = checkArr.indexOf($(this).attr("wgID"));
			if (i != -1)
			{
				checkArr.splice(i,1);
				new_wg.val(checkArr.join(","));
			}
			else
			{
				var str = delete_talents.val();
				if (str.length)
					delete_wg.val(delete_wg.val() + ",");
				delete_wg.val(delete_wg.val() + $(this).attr("wgID"));
			}
			$(this).parent().fadeOut("slow",function(){
				$(this).parent("tr").remove();				
			});
			
			checkArr = curr_wg.val();
			checkArr = checkArr.split(",");
			var i = checkArr.indexOf($(this).attr("wgID"));
			if (i != -1)
			{
				checkArr.splice(i,1);
				curr_talents.val(checkArr.join(","));
			}
		}
	});
});
