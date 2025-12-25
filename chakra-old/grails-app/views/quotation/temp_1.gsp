<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Test Document</title>
<link rel="stylesheet" href="bootstrap.css" />
<link rel="stylesheet" href="bootstrap-responsive.css" />
<script type="text/javascript" src="jquery-1.8.2.js"></script>
<script type="text/javascript" src="json2.js"></script>
<script type="text/javascript" src="shopping_cart.js"></script>
<link rel="stylesheet" href="shopping_cart.css" />
</head>
<body>
<span class="data_field" id="wirebrand_options">
	<option value="null">Wire Brand Select</option>
	<option value="tata">Tata</option>
	<option value="comp2">Comp</option>
</span>
<div class="container-fluid">
	<div class="row-fluid item_selection_container">
		<div class="span4 box_holder">
        	<div class="item_tree_box well">
				<ul class="item_tree">
                	<li class="item_group"><img src="icon_Tree_ExpandAll.jpg" class="group_state_icon" /><a href="#">Item 1</a>
                    	<ul>
                        	<li class="item_group"><img src="icon_Tree_ExpandAll.jpg" class="group_state_icon" /><a href="#">Sub Item 1</a>
                            	<ul>
                                	<li class="final_item"><img src="icon_Tree_ExpandAll.jpg" class="group_state_icon" />
                                    	<a class="final_item_label">Sub Sub Item 1</a>
                                    	<span class="data_field" name="id">SSI1</span>
                                        <ul>
                                        	<li class="final_item" name="mesh_item_tree"><a class="final_item_label">Custom Sub Sub Item 2</a>
                                    			<span class="data_field" name="id">CSSI2</span>
                                                <span class="data_field" name="mesh_item">
                                                    <span class="data_field" name="id">M1</span>
                                                    <span class="data_field" name="name">Mesh Item 1</span>
                                                    <span class="data_field" name="desc">this is from tree 1</span>
                                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
                                                    <span class="data_field" name="price">4</span>
                                                </span>
                                                <span class="data_field" name="mesh_item">
                                                    <span class="data_field" name="id">M2</span>
                                                    <span class="data_field" name="name">Mesh Item 2</span>
                                                    <span class="data_field" name="desc">tommy is a good boy. His nick name is jhonny.</span>
                                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
                                                    <span class="data_field" name="price">8</span>
                                                </span>
                                    		</li>
                                            <li class="final_item"><a class="final_item_label">Custom Sub Sub Item 4</a>
                                    			<span class="data_field" name="id">CSSI4</span>
                                    		</li>
                                        </ul>
                                    </li>
                                    <li class="final_item"><a class="final_item_label">Sub Sub Item 2</a>
                                    	<span class="data_field" name="id">SSI2</span>
                                    </li>
                                </ul>
                            </li>
                            <li class="final_item" name="mesh_item_tree"><a class="final_item_label">Sub Item 1</a>
                            	<span class="data_field" name="id">SI1</span>
                                <span class="data_field" name="mesh_item">
                                	<span class="data_field" name="id">M1</span>
                                    <span class="data_field" name="name">Mesh Item 1</span>
                                    <span class="data_field" name="desc">aksjdna smdasdka kjasda skdjba</span>
                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
                                    <span class="data_field" name="price">4</span>
                                </span>
                                <span class="data_field" name="mesh_item">
                                	<span class="data_field" name="id">M2</span>
                                    <span class="data_field" name="name">Mesh Item 2</span>
                                    <span class="data_field" name="desc">tommy is a good boy. His nick name is jhonny.</span>
                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
                                    <span class="data_field" name="price">8</span>
                                </span>
                            </li>
                            <li class="final_item"><a class="final_item_label">Sub Item 2</a>
                            	<span class="data_field" name="id">SI2</span>
                            </li>
                        </ul>
                    </li>
                    <li class="item_group"><img src="icon_Tree_ExpandAll.jpg" class="group_state_icon" /><a href="#">Item 1</a>
                    	<ul>
                        	<li class="item_group"><img src="icon_Tree_ExpandAll.jpg" class="group_state_icon" /><a href="#">Sub Item 1</a>
                            	<ul>
                                	<li class="final_item" name="cage_item_tree">
                                    	<a class="final_item_label">Sub Sub Item 1</a>
                                    	<span class="data_field" name="id">SSI1</span>
                                    </li>
                                    <li class="final_item" name="cage_item_tree"><a class="final_item_label">Sub Sub Item 2</a>
                                    	<span class="data_field" name="id">SSI2</span>
                                    </li>
                                </ul>
                            </li>
                            <li class="final_item" name="cage_item_tree"><a class="final_item_label">Sub Item 1</a>
                            	<span class="data_field" name="id">SI1</span>
                                <span class="data_field" name="cage_item">
                                	<span class="data_field" name="id">M1</span>
                                    <span class="data_field" name="name">Mesh Item 1</span>
                                    <span class="data_field" name="desc">aksjdna smdasdka kjasda skdjba</span>
                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
                                    <span class="data_field" name="price">4</span>
                                </span>
                                <span class="data_field" name="cage_item">
                                	<span class="data_field" name="id">M2</span>
                                    <span class="data_field" name="name">Mesh Item 2</span>
                                    <span class="data_field" name="desc">tommy is a good boy. His nick name is jhonny.</span>
                                    <span class="data_field" name="pic_url">sample_pic.jpg</span>
                                    <span class="data_field" name="price">8</span>
                                </span>
                            </li>
                            <li class="final_item"><a class="final_item_label">Sub Item 2</a>
                            	<span class="data_field" name="id">SI2</span>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
		<div class="span2 box_holder">
        	<div class="button_box">
            	<input type="button" id="add_item_button" class="select_button_style btn" value=">" />
                <input type="button" id="remove_item_button" class="select_button_style btn" value="" />
            </div>
        </div>
        <div class="span2 box_holder">
        	<div class="selected_item_box well">
				<!--<div title="asdfgg" class="selected_item">
                	<a class="selected_item_label selected_item_highlighted_label" name="label">Asdf</a>
                    <span class="data_field" name="id">qww</span>
                </div>
                <div class="selected_item">
                	<a class="selected_item_label" name="label">1234</a>
                    <span class="data_field" name="id">qwwr</span>
                </div>-->
            </div>
        </div>
	</div>

	<h5>Mesh Items:</h5>
    <div class="row-fluid mesh_item_selection_container">
        <div class="span8">
        	<div id="add_to_cart_grid" class="well mesh_item_selection_box">
            	<div class="header_bar">
                	<span class="header_pid">Product ID</span>
                    <span class="header_pname">Product Name</span>
                    <span class="header_pdesc">Product Description</span>
                    <span class="header_pic">Picture</span>
                    <span class="header_quantity">Quantity</span>
                    <span class="header_price">Price</span>
                    <span class="header_extra_box">&nbsp;</span>
                </div>
                <div class="item_entry_box">
                    <table class="item_entry_table">
                        <!--<tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Itemthis is a 12' X 17' Itemthis is a 12' X 17' Itemthis is a 12' X 17' Itemthis is a 12' X 17' Itemthis is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>-->
                    </table>
                    <div id="row_edit_popup">
                        <input type="button" id="row_edit_cancel" value="Cancel"  />
                        <input type="button" id="row_edit_ok" value="Ok" style="margin-left:10px;" />
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="button" id="add_to_cart_button" value="Add to cart" />
    
                    <div id="add_to_cart_grid_field_popup">
                    	<img class="element_icon" src="" />
                        <div class="element_data">
                        	<span style="font-weight:bold">Name: </span><span class="element_name"></span>
                            <br />
                            <span style="font-weight:bold">Description: </span><span class="element_desc"></span>
                        </div>
                    </div>
    <div class="row-fluid mesh_item_selection_container">
    	<div class="span8">
        	<div id="shopping_cart_summary" class="well mesh_item_selection_box">
            	<div class="summary_header_bar">
                	<span class="summary_header_pid">Product ID</span>
                    <span class="summary_header_pname">Product Name</span>
                    <span class="summary_header_pdesc">Product Description</span>
                    <span class="summary_header_pic">Picture</span>
                    <span class="summary_header_quantity">Quantity</span>
                    <span class="summary_header_price">Price</span>
                    <span class="summary_header_total">Total</span>
                    <span class="summary_header_extra_box">&nbsp;</span>
                </div>
                <div class="item_entry_box">
                    <table class="item_entry_table">
                        <!--<tr class="mesh_item_selection_entry">
                            <td class="summary_header_pid">ABCD</td>
                            <td class="summary_header_pname">Item 1</td>
                            <td class="summary_header_pdesc">this is a 12' X 17' Item</td>
                            <td class="summary_header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="summary_header_quantity">5</td>
                            <td class="summary_header_price">80</td>
                            <td class="summary_header_total">400</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>
                        <tr class="mesh_item_selection_entry">
                            <td class="header_pid">ABCD</td>
                            <td class="header_pname">Item 1</td>
                            <td class="header_pdesc">this is a 12' X 17' Item</td>
                            <td class="header_pic"><img class="mesh_item_pic" src="sample_pic.jpg" /></td>
                            <td class="header_quantity">5</td>
                            <td class="header_price">480</td>
                        </tr>-->
                    </table>
                    <!--<div id="summary_edit_popup">
                        <input type="button" id="summary_edit_cancel" value="Cancel"  />
                        <input type="button" id="summary_edit_ok" value="Ok" style="margin-left:10px;" />
                    </div>-->
					<img src="close.png" id="summary_row_delete_icon" />
                </div>
            </div>
        </div>
    </div>
    <input type="button" id="submit_shopping_cart" value="submit" />
</div>
</body>
</html>
