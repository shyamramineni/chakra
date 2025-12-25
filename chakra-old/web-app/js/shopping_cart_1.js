// JavaScript Document
// the following variables are used globally
var element_mesh_items = new Array();
var shopping_cart_summary = new Array();

// the folowing variables are used in tree traversal and item adding
var current_tree_element = null;
var tree_transferred_elements = new Array();
var current_selected_element = null;

// the following variables are for the add to cart grid
var current_active_edit_entry = null;
var backup_qty = 0;
var atcg_wirebrand_first_selection_flag = false;

// the following variables are for the shopping cart summary
var current_active_summary_entry = null;
var summary_backup_qty = 0;
var current_summary_element = null;
var summary_sum, summary_tax, summary_total;

// the following is used for the close button in shopping cart summary
var on_close_icon = false;

function group_state_toggle(e)
{
	var element = e.data;
	var img = $(element).children("img").eq(0);
	var uri = img.attr("src");
	var url = "";
	if(uri.indexOf('/',0) >= 0)
		url = uri.match(".*/");
	if(img.attr("name") == "close" || img.attr("name") == undefined)
	{
		img.attr("src",url+"icon_Tree_CollapseAll.jpg");
		//$(element).children("ul").css("display","block");
		$(element).children("ul").show("fast");
		img.attr("name","open");
	}
	else if(img.attr("name") == "open")
	{
		img.attr("src",url+"icon_Tree_ExpandAll.jpg");
		//$(element).children("ul").css("display","none");
		$(element).children("ul").hide("fast");
		img.attr("name","close");
	}
}

function final_item_group_state_toggle(e)
{
	var element = e.data;
	var img = $(element).children("img").eq(0);
	var uri = img.attr("src");
	var url = "";
	if(uri.indexOf('/',0) >= 0)
		url = uri.match(".*/");
	if(img.attr("name") == "close" || img.attr("name") == undefined)
	{
		img.attr("src",url+"icon_Tree_CollapseAll.jpg");
		//$(element).children("ul").css("display","block");
		$(element).children("ul").show("fast");
		img.attr("name","open");
	}
	else if(img.attr("name") == "open")
	{
		img.attr("src",url+"icon_Tree_ExpandAll.jpg");
		//$(element).children("ul").css("display","none");
		$(element).children("ul").hide("fast");
		img.attr("name","close");
	}
}

/*function close_row_edit_popup()
{
	$("#row_edit_popup").animate({
		left: 0,
		top: 0
	},"fast");
	$("#row_edit_popup").css("display","none");
}*/

function final_item_click(e)
{
	var element = e.data;
	
	if(current_tree_element != null)
	{
		$(current_tree_element).children("a").removeClass("final_item_selected_label");
	}
	console.log("inside final item click: "+ $(element).text());
	$(element).addClass("final_item_selected_label");
	current_tree_element=$(element).parent();
	
}

function create_ajax_request_object(reqType)
{
	var request = new Object();
	request.requestType = reqType;
	request.requestData = new Array();
	return request;
}

function update_mesh_item_row_price(jqRowTr)
{
	var wirebrand = $(jqRowTr).children(".header_pdesc").children(".header_pdesc_wirebrand_select").eq(0).val();
	var response;
	var request = create_ajax_request_object("MeshItemCostRequest");
	request.requestData[0] = new Object();
	request.requestData[0].wirebrand = wirebrand;
	request.requestData[0].itemid = $(jqRowTr).children(".header_pdesc").children(".header_pid").text();
	$.post("/index.html",request,function(data, textStatus, jqXHR) {
		response = jQuery.parseJSON(data);
	});
	$(jqRowTr).children(".header_pdesc").children(".header_price").text(response.responseData.price);
}

function mesh_item_wirebrand_change(e)
{
	var element = e.target;
	console.log("mesh_item_wirebrand_change element: "+$(element));
	var val = $(element).val();
	console.log("mesh_item_wirebrand_change val: "+val);
	if(atcg_wirebrand_first_selection_flag)
	{
		$("#add_to_cart_grid .item_entry_box .item_entry_table").find("tr").each(function(index, element) {
        	console.log(element);
			$(element).children(".header_pdesc").children(".header_pdesc_wirebrand_select").eq(0).val(val);
			console.log($(element).children(".header_pdesc").children(".header_pdesc_wirebrand_select").eq(0));
			update_mesh_item_row_price(element);
    	});
		atcg_wirebrand_first_selection_flag = false;
	}
	update_mesh_item_row_price(e.data);
}


function selected_item_click(e)
{
	var element = e.data;
	if(current_selected_element != null)
	{
		$(current_selected_element).children("a").removeClass("selected_item_highlighted_label");
	}
	$(element).children("a").addClass("selected_item_highlighted_label");
	current_selected_element=element;
	var table = $("#add_to_cart_grid").children(".item_entry_box").children(".item_entry_table");
	var id = $(element).children("span[name=id]").text();
    var type = $(element).attr("name");
	//console.log("id: "+id);
	//close_row_edit_popup();
	current_active_edit_entry = null;
	/*$("#row_edit_popup").css("display","none");
	$(table).find("tr").each(function(index, element) {
		$(element).unbind("dblclick");
    });*/
	var request = new Object();
	request.requestType = "AddToGridBoxItemsRequest";
	request.requestData = new Array();
	var data = new Object();
	data.id = id;
	request.requestData.push(data);
	request = JSON.stringify(request);
	console.log("reqdata="+request);
	var response = null;
	if(type == "mesh_item_tree")
	{
		$.ajax({
	        type:'POST',
	        url:"http://localhost:8080/chakrap/cageDesign/getSheetSpecifications",
	        data: "id="+id+"&requestType=AddToGridBoxItemsRequest",
	        success: function(data, textStatus, jqXHR) {
	        	console.log(jqXHR.responseText);
	            response = jQuery.parseJSON(jqXHR.responseText);
	        },
	        async: false
		});
	}
	else if(type =="cage_item_tree")
	{
		$.ajax({
	        type:'POST',
	        url:"http://localhost:8080/chakrap/cagePartType/getCageParts",
	        data: "id="+id+"&requestType=AddToGridBoxItemsRequest",
	        success: function(data, textStatus, jqXHR) {
	        	console.log(jqXHR.responseText);
	            response = jQuery.parseJSON(jqXHR.responseText);
	        },
	        async: false
		});
		
	}
	/*$.post("http://localhost:8080/chakrap/cageDesign/getSheetSpecifications","id="+id+"&requestType=AddToGridBoxItemsRequest",function(data, textStatus, jqXHR) {
		console.log("reponse: "+jqXHR.responseText);
		//alert(data);
		response = jQuery.parseJSON(jqXHR.responseText);
		alert(response);
	});*/
	//alert("out");
	console.log("test: "+response);
	table.html("");
	//console.log("first: "+response);
	
	/*response = new Object();
	response.responseData = new Object();
	response.responseData.meshItems = new Array();
	response.responseData.meshItems[0] = new Object();
	response.responseData.meshItems[0].id="1";
	response.responseData.meshItems[0].name="n1";
	response.responseData.meshItems[0].desc="d1";
	response.responseData.meshItems[0].price='"1';
	response.responseData.meshItems[0].pic_url="/1";
	
	response.responseData.cageParts = new Array();
	response.responseData.cageParts[0] = new Object();
	response.responseData.cageParts[0].id="1";
	response.responseData.cageParts[0].name="n1";
	response.responseData.cageParts[0].desc="d1";
	response.responseData.cageParts[0].price='"1';
	response.responseData.cageParts[0].pic_url="/1";*/
	var itemsArray = null;
	console.log(type);
	if(type == "mesh_item_tree")
		itemsArray = response.responseData.meshItems;
	else if(type == "cage_item_tree")
		itemsArray = response.responseData.cageParts;
	console.log(itemsArray);
	for(var index in itemsArray)
	{
		var element = itemsArray[index];
	//$(element_mesh_items[id][type]).each(function(index, element) {
		//console.log(element);
        /*var mid = $(element).children("span[name=id]").text();
		var mname = $(element).children("span[name=name]").text();
		var mdesc = $(element).children("span[name=desc]").text();
		var mpic_url = $(element).children("span[name=pic_url]").text();
		var mprice = $(element).children("span[name=price]").text();*/

		console.log(element);
		var mid = element.id;
		var mname = element.sheetName;
		var mdesc = element.desc;
		var mpic_url = element.pic_url;
		var mprice = "&nbsp;";//element.price;
		console.log("name="+mname);
		var newdesc, newname;
		var max_len = 20;
		
		
		if( mdesc!=null && mdesc.length > max_len)
		{
			newdesc = mdesc.substr(0, max_len);
			newdesc += "...";
		}
		else
			newdesc = mdesc;
		if(mname.length > max_len)
		{
			newname = mname.substr(0, max_len);
			newname += "...";
		}
		else
			newname = mname;
		if(newdesc == null)
			newdesc = "&nbsp;";
		var wirebrand_options = $("#wirebrand_options").html();
		var entry = null;
	
		var resetbtn = "";
		console.log(index);
		if(index == 0)
			resetbtn = '<img src="resetIcon.jpg" style="position:absolute; top:0px; right:0px; width:20px; height:20px;" title="Reset Add to Cart Grid" onclick="add_to_cart_reset_click(this)" />';
		console.log("second: "+type);
		if(type == "mesh_item_tree")
		{
			entry = $('<tr class="mesh_item_selection_entry" name="'+type+'">\
                            <td class="header_pid">'+mid+'</td>\
                            <td class="header_pname" name="'+mname+'">'+newname+'</td>\
                            <td class="header_pdesc" name="'+mdesc+'" style="position:relative;"><span class="header_pdesc_desc">'+newdesc+'</span> \
							<br /><select name="wire_brand" class="header_pdesc_wirebrand_select">'+wirebrand_options+'</select> \
							'+resetbtn+'</td>\
                            <td class="header_pic"><img class="mesh_item_pic" src="'+mpic_url+'" /></td>\
                            <td class="header_quantity">0</td>\
                            <td class="header_price">'+mprice+'</td>\
                        </tr>');
		}
		else if ( type == "cage_item_tree")
		{
			entry = $('<tr class="mesh_item_selection_entry" name="'+type+'">\
                            <td class="header_pid">'+mid+'</td>\
                            <td class="header_pname" name="'+mname+'">'+newname+'</td>\
                            <td class="header_pdesc" name="'+mdesc+'" style="position:relative;"><span class="header_pdesc_desc">'+newdesc+'</span> \
							'+resetbtn+'</td>\
                            <td class="header_pic"><img class="mesh_item_pic" src="'+mpic_url+'" /></td>\
                            <td class="header_quantity">0</td>\
                            <td class="header_price">'+mprice+'</td>\
                        </tr>');
		}
		table.append(entry);
		var tr = entry;
		if(/*mdesc.length > max_len || */mname.length > max_len)
		{
			console.log("in if");
			$(tr).mouseenter(tr, function(e) {
				var tr = e.data;
				console.log(tr);
				var offset = $(tr).offset();
				console.log("selected_item_click position: "+offset);
				var desc = $(tr).children(".header_pdesc").attr("name");
				var src = $(tr).children(".header_pic").children("img").attr("src");
				var name = $(tr).children(".header_pname").attr("name");
				$("#add_to_cart_grid_field_popup").css("display","block").children("img").attr("src",src)
					.parent().children("div.element_data").children(".element_name").text(name)
					.parent().children(".element_desc").text(desc);
				var width = $("#add_to_cart_grid_field_popup").width();
				var height = $("#add_to_cart_grid_field_popup").outerHeight();
                $("#add_to_cart_grid_field_popup").css({left: offset.left + width/2, top: offset.top - height});
            });
			$(tr).mouseleave(function(e) {
				$("#add_to_cart_grid_field_popup").css("display","none");
			});
		}
    //});
	}
	atcg_wirebrand_first_selection_flag = true;
	
	// The below code is related to add to cart grid
	$("#add_to_cart_grid").children(".item_entry_box").children("table").find("tr").each(function(index, element) {
        $(element).dblclick(element,item_entry_double_click);
		$(element).children(".header_pdesc").find(".header_pdesc_wirebrand_select").change(element ,mesh_item_wirebrand_change);
    });
	
}

function add_item_button_click(e)
{
	if(current_tree_element!=null)
	{
		var type = $(current_tree_element).attr("name");
		var label = $(current_tree_element).children("a").eq(0).text();
		var id = $(current_tree_element).children("span[name=id]").eq(0).text();
        if(tree_transferred_elements[id]==undefined)
            tree_transferred_elements[id] = new Array();
        if(tree_transferred_elements[id][type]==0 || tree_transferred_elements[id][type]==undefined)
        {
            if(element_mesh_items[id] == undefined)
                element_mesh_items[id] = new Array();
			if( type == "mesh_item_tree")
            	element_mesh_items[id][type] = $(current_tree_element).children("span[name=mesh_item]");
			else if( type == "cage_item_tree" )
				element_mesh_items[id][type] = $(current_tree_element).children("span[name=cage_item]");
            //console.log(tree_transferred_elements[id]);
            tree_transferred_elements[id][type]=1;
            var parent = $(current_tree_element).parent();
            var path_stack = new Array();
            while($(parent).attr("class") != "item_tree")
            {
                parent= $(parent).parent();
                //path+=" > "+$(parent).children("a").text();
                path_stack.push($(parent).children("a").text());
                parent= $(parent).parent();
            }
            var tmp = "";
            var path="";
            while(path_stack.length != 0)
            {
                path+=" > " + path_stack.pop();
            }
            path+=" > "+label;
            var element = $('<div class="selected_item" name="'+type+'">\
                                    <a class="selected_item_label" title="'+path+'" name="label">'+label+'</a>\
                                    <span class="data_field" name="id">'+id+'</span>\
                                </div>');
            $(".selected_item_box").append(element);
            $(element).click(element,selected_item_click);
            $(element).mouseenter(function() {
                $(element).addClass("selected_item_hover");
            });
            $(element).mouseleave(function() {
                $(element).removeClass("selected_item_hover");
            });
        }
        else
        {
            alert("Item: '"+label+"' is already added!");
        }
        //console.log(tree_transferred_elements[id]);
        //$(current_tree_element).css("display","none");
        //current_tree_element = null;
	}
}

function remove_item_button_click(e)
{
	if(current_selected_element!=null)
	{
		var id=$(current_selected_element).children("span[name=id]").eq(0).text();
        var type = $(current_selected_element).attr("name");
		$(current_selected_element).unbind("click").unbind("mouseenter").unbind("mouseleave");		
		$(current_selected_element).remove();
		tree_transferred_elements[id][type]=0;
		//$(element).css("display","block");
		current_selected_element=null;
		close_row_edit_popup();
		var table = $("#add_to_cart_grid").children(".item_entry_box").children(".item_entry_table");
		table.find("tr").each(function(index, element) {
			$(element).unbind("dblclick");
    	});
		table.html("");
	}
}

function row_edit_action_key_press(e)
{
	console.log("keyCode == " + e.keyCode);
	if(current_active_edit_entry != null && ( e.keyCode == 13 || e.keyCode == 27 ))
	{
		
		if(e.keyCode == 13)
		{
			var new_qty = $(current_active_edit_entry).children(".header_quantity").eq(0).children("input").attr("value");
			//new_qty = new_qty + "";
			var pos = new_qty.match("^[0-9]*$");
			console.log(pos);
			console.log($(current_active_edit_entry).children(".header_pdesc").children(".header_pdesc_wirebrand_select").eq(0).val());
			if(pos == null)//(new_qty == "" || new_qty == undefined)
			{
				alert("Invalid value given. Please enter a number");
			}
			else if($(current_active_edit_entry).children(".header_pdesc").children(".header_pdesc_wirebrand_select").eq(0).val() == "null" && new_qty != 0)
			{
				alert("Wirebrand Selection has to be made!");
			}
			else
			{
				$(current_active_edit_entry).children(".header_quantity").children(".row_input_field").unbind("keydown");
				//new_qty = 0;
				$(current_active_edit_entry).children(".header_quantity").eq(0).html(new_qty);
				$(current_active_edit_entry).removeClass("mesh_item_selection_entry_edit_mode");
			//$("#row_edit_popup").css("display","none");
				current_active_edit_entry = null;
			}
		}
		else if(e.keyCode == 27)
		{
			$(current_active_edit_entry).children(".header_quantity").children(".row_input_field").unbind("keydown");
			$(current_active_edit_entry).children(".header_quantity").eq(0).html(backup_qty);
			$(current_active_edit_entry).removeClass("mesh_item_selection_entry_edit_mode");
			//$("#row_edit_popup").css("display","none");
			current_active_edit_entry = null;
		}
	}
}

function add_to_cart_reset_click(e)
{
	var tmp = new Object();
	tmp.keyCode = 27;
	row_edit_action_key_press(tmp);
	$("#add_to_cart_grid").children(".item_entry_box").children(".item_entry_table").find("tr").each(function(index, element) {
        $(element).children(".header_quantity").text(0);
    });
}

function item_entry_double_click(e)
{
	var element = e.data;
	if(current_active_edit_entry != null)
	{
		$(current_active_edit_entry).children(".header_quantity").eq(0).html(backup_qty);
		$(current_active_edit_entry).removeClass("mesh_item_selection_entry_edit_mode");
	}
	current_active_edit_entry = element;
	backup_qty = $(element).children(".header_quantity").eq(0).text();
	/*var width = $(element).innerWidth();
	var height = $(element).innerHeight();
	var pos = $(element).position();
	var scrx = $("#row_edit_popup").parent().scrollTop();*/
	$(element).addClass("mesh_item_selection_entry_edit_mode");
	$(element).children(".header_quantity").eq(0).html('<input type="text" class="row_input_field" value="'+backup_qty+'" />');
	/*$("#row_edit_popup").css("display","block");
	var popup_width = $("#row_edit_popup").outerWidth();
	var popup_height = $("#row_edit_popup").outerHeight();
	var new_loc = new Object();
	//console.log("scroll: "+scrx);
	//console.log("top: "+ (pos.top+scrx) );
	new_loc.top = pos.top + height;
	new_loc.left = (width - popup_width)/2;
	//console.log(new_loc.left +":"+new_loc.top);
	$("#row_edit_popup").css({left: new_loc.left, top: new_loc.top});
	$("#row_edit_popup").slideDown("fast");*/
	$(element).children(".header_quantity").children(".row_input_field").focus()
		.keydown(row_edit_action_key_press);
}

function summary_edit_action_key_press(e)
{
	if(current_active_summary_entry != null && (e.keyCode == 13 || e.keyCode == 27))
	{
		$(current_active_edit_entry).children(".summary_header_quantity").children(".row_input_field").unbind("keydown");
		if( e.keyCode == 13 )
		{
			var new_qty = $(current_active_summary_entry).children(".summary_header_quantity").eq(0).children("input").attr("value");
			if(new_qty == "" || new_qty == undefined)
				new_qty = 0;
			var id = $(current_active_summary_entry).children(".summary_header_pid").text();
			$(current_active_summary_entry).children(".summary_header_quantity").eq(0).html(new_qty);
			$(current_active_summary_entry).children(".summary_header_total").text(shopping_cart_summary[id].price * new_qty);
			$(current_active_summary_entry).removeClass("mesh_item_selection_entry_edit_mode");
			
			var oldsum = summary_sum;//$("#summary_sum").children(".summary_header_total").text();
			//oldsum = new Number(oldsum);
			summary_backup_qty = new Number(summary_backup_qty);
			shopping_cart_summary[id].qty = new_qty = new Number(new_qty);
			var newsum = (new_qty - summary_backup_qty) * shopping_cart_summary[id].price + oldsum;
			summary_sum = parseFloat(newsum).toFixed(2);
			summary_tax = parseFloat(newsum * 0.1).toFixed(2);
			summary_total = parseFloat(newsum * 1.1).toFixed(2);
			$("#summary_sum").children(".summary_header_total").text(summary_sum);
			$("#summary_tax").children(".summary_header_total").text(summary_tax);
			$("#summary_total").children(".summary_header_total").text(summary_total);
			//$("#summary_edit_popup").css("display","none");
			current_active_summary_entry = null;
		}
		else if( e.keyCode == 27 )
		{
			$(current_active_summary_entry).children(".summary_header_quantity").eq(0).html(summary_backup_qty);
			$(current_active_summary_entry).removeClass("mesh_item_selection_entry_edit_mode");
			//$("#summary_edit_popup").css("display","none");
			current_active_summary_entry = null;
		}
	}
}

function summary_entry_double_click(e)
{
	var element = e.data;
	if(current_active_summary_entry != null)
	{
		$(current_active_summary_entry).children(".summary_header_quantity").eq(0).html(summary_backup_qty);
		$(current_active_summary_entry).removeClass("mesh_item_selection_entry_edit_mode");
	}
	current_active_summary_entry = element;
	summary_backup_qty = $(element).children(".summary_header_quantity").eq(0).text();
	/*var width = $(element).innerWidth();
	var height = $(element).innerHeight();
	var pos = $(element).position();
	var scrx = $("#summary_edit_popup").parent().scrollTop();*/
	$(element).addClass("mesh_item_selection_entry_edit_mode");
	$(element).children(".summary_header_quantity").eq(0).html('<input type="text" class="row_input_field" value="'+summary_backup_qty+'" />');
	/*$("#summary_edit_popup").css("display","block");
	var popup_width = $("#summary_edit_popup").outerWidth();
	var popup_height = $("#summary_edit_popup").outerHeight();
	var new_loc = new Object();
	//console.log("scroll: "+scrx);
	//console.log("top: "+ (pos.top+scrx) );
	new_loc.top = pos.top + height;
	new_loc.left = (width - popup_width)/2;
	//console.log(new_loc.left +":"+new_loc.top);
	$("#summary_edit_popup").css({left: new_loc.left, top: new_loc.top});
	$("#summary_edit_popup").slideDown("fast");*/
	$(element).children(".summary_header_quantity").children(".row_input_field").focus()
		.keydown(summary_edit_action_key_press);
} 

function populate_shopping_cart_summary()
{
	var table = $("#shopping_cart_summary").children(".item_entry_box").children(".item_entry_table");
	var final_entry = "";
	$(table).find("tr").each(function(index, element) {
		$(element).unbind("dblclick");
    });
	table.html("");
	var total_price = 0;
	//console.log(element_mesh_items[id]);
	for(var index in shopping_cart_summary) {
		var element = shopping_cart_summary[index];
		if(element != null)
		{
			console.log(element);
			var mid = element.id;
			var mname = element.name;
			var mdesc = element.desc;
			var mpic_url = element.pic_url;
			var mprice = element.price;
			var mqty = element.qty;
			var newdesc, newname;
			var max_len = 20;
			var type = element.type;
			var wirebrand = element.wirebrand;
			total_price += mprice * mqty;
			console.log("selected_item_click: " + mdesc.length);
			
			if(mdesc.length > max_len)
			{
				newdesc = mdesc.substr(0, max_len);
				newdesc += "...";
			}
			else
				newdesc = mdesc;
			if(mname.length > max_len)
			{
				newname = mname.substr(0, max_len);
				newname += "...";
			}
			else
				newname = mname;
            var wirebrand_options = $("#wirebrand_options").html();
            var entry = null;
            entry = $('<tr class="mesh_item_selection_entry">\
								<td class="summary_header_pid">'+mid+'</td>\
								<td class="summary_header_pname" name="'+mname+'">'+newname+'</td>\
								<td class="summary_header_pdesc" name="'+mdesc+'">'+newdesc+'</td>\
								<td class="summary_header_pic"><img class="mesh_item_pic" src="'+mpic_url+'" /></td>\
								<td class="summary_header_quantity">'+mqty+'</td>\
								<td class="summary_header_price">'+mprice+'</td>\
								<td class="summary_header_total">'+(mprice * mqty)+'</td>\
							</tr>');
							
			table.append(entry);
			var tr = entry;
			$(tr).children(".summary_header_pdesc").children(".summary_header_pdesc_wirebrand_select").val(wirebrand);
			if(mdesc.length > max_len || mname.length > max_len)
			{
				console.log("in if");
				$(tr).mouseenter(tr, function(e) {
					var tr = e.data;
					console.log(tr);
					var offset = $(tr).offset();
					console.log("selected_item_click position: "+offset);
					var desc = $(tr).children(".summary_header_pdesc").attr("name");
					var src = $(tr).children(".summary_header_pic").children("img").attr("src");
					var name = $(tr).children(".summary_header_pname").attr("name");
					$("#add_to_cart_grid_field_popup").css("display","block").children("img").attr("src",src)
						.parent().children("div.element_data").children(".element_name").text(name)
						.parent().children(".element_desc").text(desc);
					var width = $("#add_to_cart_grid_field_popup").width();
					var height = $("#add_to_cart_grid_field_popup").outerHeight();
					$("#add_to_cart_grid_field_popup").css({left: offset.left + width/2, top: offset.top - height});
				});
				
				$(tr).mouseleave(function(e) {
					$("#add_to_cart_grid_field_popup").css("display","none");
				});
			}
		}
    }
	
	// The below code is related to shopping cart summary
	$("#shopping_cart_summary").children(".item_entry_box").children("table").find("tr").each(function(index, element) {
        $(element).dblclick(element,summary_entry_double_click);
		$(element).mouseenter(function(e) {
			var width = $(element).outerWidth();
			var height = $(element).innerHeight();
			var pos = $(element).position();
			console.log("mouseenter - element pos: "+pos);
			var new_loc = new Object();
			new_loc.left = width - $("#summary_row_delete_icon").innerWidth() - 5;
			new_loc.top = pos.top + (height - $("#summary_row_delete_icon").innerHeight())/2 ;
			$("#summary_row_delete_icon").css({left: new_loc.left, top: new_loc.top});
			console.log("mouseenter - new loc: "+new_loc);
			current_summary_element = element;
			//$("#summary_row_delete_icon").offset(new_loc);
			$("#summary_row_delete_icon").css("display","block");
			
		});
    });
	
	final_entry += '<tr class="mesh_item_selection_entry" style="border-width:0px;" name="sum" id="summary_sum">\
						<td class="summary_header_pid"> </td>\
						<td class="summary_header_pname"> </td>\
						<td class="summary_header_pdesc"> </td>\
						<td class="summary_header_pic"> </td>\
						<td class="summary_header_quantity"> </td>\
						<td class="summary_header_price">Sum:</td>\
						<td class="summary_header_total">'+parseFloat(total_price).toFixed(2)+'</td>\
					</tr>';
	summary_sum = total_price;
	final_entry += '<tr class="mesh_item_selection_entry" style="border-width:0px;" name="tax" id="summary_tax">\
						<td class="summary_header_pid"> </td>\
						<td class="summary_header_pname"> </td>\
						<td class="summary_header_pdesc"> </td>\
						<td class="summary_header_pic"> </td>\
						<td class="summary_header_quantity"> </td>\
						<td class="summary_header_price">Tax:</td>\
						<td class="summary_header_total">'+parseFloat(total_price * 0.1).toFixed(2)+'</td>\
					</tr>';
	summary_tax = total_price * 0.1;
	final_entry += '<tr class="mesh_item_selection_entry" style="border-width:0px;" name="total" id="summary_total">\
						<td class="summary_header_pid"> </td>\
						<td class="summary_header_pname"> </td>\
						<td class="summary_header_pdesc"> </td>\
						<td class="summary_header_pic"> </td>\
						<td class="summary_header_quantity"> </td>\
						<td class="summary_header_price">Total:</td>\
						<td class="summary_header_total">'+parseFloat(total_price * 1.1).toFixed(2)+'</td>\
					</tr>';
	summary_total = total_price * 1.1;
	$(table).append(final_entry);
}

function add_to_cart_button_click(e)
{
	var new_cnt = 0;
	var old_cnt = 0;
	$("#add_to_cart_grid").children(".item_entry_box").children(".item_entry_table").find("tr").each(function(index, element) {
        var qty = $(element).children("td[class=header_quantity]").text();
		if(qty != 0)
		{
			var mid = $(element).children("td[class=header_pid]").text();
			if(shopping_cart_summary[mid] == undefined)
				new_cnt++;
			else
				old_cnt++;
			var obj = new Object();
			obj.id = mid;
			obj.name = $(element).children("td[class=header_pname]").text();
			obj.desc = $(element).children("td[class=header_pdesc]").attr("name");
			obj.qty = qty;
			obj.price = $(element).children("td[class=header_price]").text();
			obj.pic_url = $(element).children("td[class=header_pic]").children("img").attr("src");
			obj.type = $(element).attr("name");
			obj.wirebrand = $(element).children("td[class=header_pdesc]").children(".header_pdesc_wirebrand_select").val();
			shopping_cart_summary[mid] = obj;
			console.log("mid: "+mid);
			console.log(shopping_cart_summary[mid]);
		}
    });
	var alertmsg = "Shopping cart updated!\n";
	if(new_cnt > 0)
		alertmsg+=new_cnt + " new items added.\n";
	if(old_cnt > 0)
		alertmsg+=old_cnt + " existing items updated.";
	alert(alertmsg);
	populate_shopping_cart_summary();
}
function summary_row_delete_icon_click(e)
{
	var element = current_summary_element;
	if(element != null)
	{
		var id = $(element).children(".summary_header_pid").text();
		console.log(element);
		var price = shopping_cart_summary[id].price * shopping_cart_summary[id].qty;
		console.log(price);
		shopping_cart_summary[id] = null;
		summary_sum -= price;
		summary_tax = summary_sum * 0.1;
		summary_total = summary_sum * 1.1;
		$("#summary_sum").children(".summary_header_total").text(summary_sum);
		$("#summary_tax").children(".summary_header_total").text(summary_tax);
		$("#summary_total").children(".summary_header_total").text(summary_total);
		$(element).css("display","none");
		$("#summary_row_delete_icon").css("display","none");
	}
}

function submit_shopping_cart_click(e)
{
	var item_pairs = null;
	for( var i in shopping_cart_summary )
	{
		if(item_pairs == null)
			item_pairs = "";
		else
			item_pairs += ", ";
		item_pairs+='{"id":"'+i+'", "qty":"'+shopping_cart_summary[i].qty+'"}\n';
	}
	console.log(item_pairs);
	var json = '{"sum":"'+summary_sum+'"\n,\
				"items":[\n\
					'+item_pairs+'\
				]}';
	var as = jQuery.parseJSON(json);
	console.log(as);
	alert(json);
}

$(function() {
	// Setting the display of all subgroups to none
	$(".item_tree").find(".item_group").each(function(index, element) {
        $(element).children("ul").css("display","none");
    });
	
	// Setting the display of all final item subgroups to none
	$(".item_tree").find(".final_item").each(function(index, element) {
        $(element).children("ul").css("display","none");
    });
	
	// Setting all final_item hover effects
	$(".item_tree").find(".final_item").children(".final_item_label").each(function(index, element) {
        $(element).mouseenter(function() {
			$(element).addClass("final_item_label_hover");
		});
		$(element).mouseleave(function() {
			$(element).removeClass("final_item_label_hover");
		});
    });
	
	// Handling item selection
	$(".item_tree").find(".final_item").children(".final_item_label").each(function(index, element) {
        $(element).click(element,final_item_click);
    });
	
	// Handling the move buttons
	$("#add_item_button").click(add_item_button_click);	
	$("#remove_item_button").click(remove_item_button_click);
		
	// registering handlers for all the tree groups
	$(".item_tree").find(".item_group").each(function(index, element) {
        $(element).children("img").eq(0).click(element,group_state_toggle);
    });
	
	// Registering handlers for all the custom item groups
	$(".item_tree").find(".final_item").each(function(index, element) {
        $(element).children("img").eq(0).click(element,final_item_group_state_toggle);
    });
	
	/*// Registring handlers for add to cart grid Row edit buttons
	$("#row_edit_cancel").click(row_edit_cancel_click);
	$("#row_edit_ok").click(row_edit_ok_click);*/
	
	/*// Registring handlers for Shopping cart summary row edit buttons
	$("#summary_edit_cancel").click(summary_edit_cancel_click);
	$("#summary_edit_ok").click(summary_edit_ok_click);*/
	
	// Registering handler for add to cart button
	$("#add_to_cart_button").click(add_to_cart_button_click);
	
	// Regisering handlers for shopping cart summary entry close icon
	$("#shopping_cart_summary").children(".item_entry_box").mouseleave(function(e) {
        $("#summary_row_delete_icon").css("display","none");
    });
	$("#summary_row_delete_icon").click(summary_row_delete_icon_click);
	
	// registering handler for shopping cart summary submit button
	$("#submit_shopping_cart").click(submit_shopping_cart_click);
	
});