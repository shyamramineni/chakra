databaseChangeLog = {

	changeSet(author: "admin (generated)", id: "1338917129762-1") {
		createTable(tableName: "cage_design") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cage_designPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "bottom_depth", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "cage_design", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "cage_front", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "cage_height", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "double_bottom_centre_included", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "no_of_birds_per_cage_double_box", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_birds_per_cage_single_box", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_partitions_per_sheet_length", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_single_bottoms_per_sheet", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_length", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "top_depth", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-2") {
		createTable(tableName: "cage_design_sheet_spec_formula") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cage_design_sPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_design_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "formula", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_specification_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-3") {
		createTable(tableName: "cage_part_price") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cage_part_priPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_spec_formula_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "end_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "price", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "start_date", type: "datetime") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-4") {
		createTable(tableName: "cage_part_spec_formula") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cage_part_spePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_spec_name", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "formula", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-5") {
		createTable(tableName: "cage_part_specification") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cage_part_spePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_specification", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_type_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-6") {
		createTable(tableName: "cage_part_specification_cage_part_spec_formula") {
			column(name: "cage_part_specification_cage_part_spec_formula_list_id", type: "bigint")

			column(name: "cage_part_spec_formula_id", type: "bigint")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-7") {
		createTable(tableName: "cage_part_type") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "cage_part_typPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_type", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-8") {
		createTable(tableName: "corder") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "corderPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "balance", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "cage_design_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_length", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_cost", type: "decimal(19,2)")

			column(name: "comments", type: "varchar(255)")

			column(name: "cost", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "cost_per_bird", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "created_by_id", type: "bigint")

			column(name: "created_date", type: "datetime")

			column(name: "customer_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "delivery_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "double_box", type: "decimal(19,2)")

			column(name: "fulls", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "halfs", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "last_edited_by_id", type: "bigint")

			column(name: "last_edited_date", type: "datetime")

			column(name: "mesh_cost", type: "decimal(19,2)")

			column(name: "no_of_birds", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_cuttings_in_shed", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_sheds", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "order_id", type: "varchar(255)")

			column(name: "payment_due_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "payment_status", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "quotation_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "shipping_status", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "single_box", type: "decimal(19,2)")

			column(name: "status", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "tax", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "taxation_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "tiers", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "total_cost", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-9") {
		createTable(tableName: "corder_cage_parts") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "corder_cage_pPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_spec_formula_id", type: "bigint")

			column(name: "corder_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cost_of_cage_part", type: "decimal(19,2)")

			column(name: "no_of_cage_parts", type: "decimal(19,2)")

			column(name: "price_of_each_cage_part", type: "decimal(19,2)")

			column(name: "corder_cage_parts_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-10") {
		createTable(tableName: "corder_mesh_parts") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "corder_mesh_pPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "corder_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "mesh_cost", type: "decimal(19,2)")

			column(name: "no_of_mesh_parts", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_specification_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_price", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "corder_mesh_parts_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-11") {
		createTable(tableName: "corder_payment") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "corder_paymenPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "corder_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "created_by_id", type: "bigint")

			column(name: "created_date", type: "datetime")

			column(name: "customer_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "last_edited_by_id", type: "bigint")

			column(name: "last_edited_date", type: "datetime")

			column(name: "payment_amount", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "payment_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "corder_payments_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-12") {
		createTable(tableName: "customer") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "customerPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "address", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "company_name", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "customer_id", type: "varchar(255)")

			column(name: "customer_name", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "email", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "fax", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "mobile_number", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "phone_number", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-13") {
		createTable(tableName: "enquiry") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "enquiryPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "assigned_id", type: "bigint")

			column(name: "comments", type: "varchar(255)")

			column(name: "created_by_id", type: "bigint")

			column(name: "created_date", type: "datetime")

			column(name: "customer_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "enquiry_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "enquiry_id", type: "varchar(255)")

			column(name: "last_edited_by_id", type: "bigint")

			column(name: "last_edited_date", type: "datetime")

			column(name: "source", type: "varchar(9)") {
				constraints(nullable: "false")
			}

			column(name: "status", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-14") {
		createTable(tableName: "enquiry_cage_part_type") {
			column(name: "enquiry_cage_part_type_list_id", type: "bigint")

			column(name: "cage_part_type_id", type: "bigint")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-15") {
		createTable(tableName: "machine") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "machinePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "machine_name", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-16") {
		createTable(tableName: "notification") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "notificationPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "created_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "email", type: "varchar(255)")

			column(name: "error_message", type: "varchar(255)")

			column(name: "notif_display", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "notif_msg", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "notif_type", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "notif_url", type: "varchar(255)")

			column(name: "phone_number", type: "varchar(255)")

			column(name: "user_name", type: "varchar(255)")
		}
	}

	

	changeSet(author: "admin (generated)", id: "1338917129762-18") {
		createTable(tableName: "price") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "pricePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "effective_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "price", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_specification_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-19") {
		createTable(tableName: "production_reporting") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "production_rePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "created_by", type: "varchar(255)")

			column(name: "created_date", type: "datetime")

			column(name: "edited_date", type: "datetime")

			column(name: "last_edited_by", type: "varchar(255)")

			column(name: "machine_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "sheet_specifcation_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "stock_manufactured_time", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "total_quantity", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-20") {
		createTable(tableName: "production_reporting_wire_weight") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "production_rePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "diameter", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "production_reporting_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "weight", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_consumption_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "wire_receipt_reporting_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "production_reporting_wire_weight_list_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-21") {
		createTable(tableName: "quotation") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotationPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_length", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "created_by_id", type: "bigint")

			column(name: "created_date", type: "datetime")

			column(name: "customer_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "fulls", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "halfs", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "last_edited_by_id", type: "bigint")

			column(name: "last_edited_date", type: "datetime")

			column(name: "no_of_cuttings_in_shed", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_sheds", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "quotation_id", type: "varchar(255)")

			column(name: "status", type: "varchar(255)")

			column(name: "tiers", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-22") {
		createTable(tableName: "quotation_cage_part") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotation_cagPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_part_spec_formula_id", type: "bigint")

			column(name: "cost_of_cage_part", type: "decimal(19,2)")

			column(name: "no_of_cage_parts", type: "decimal(19,2)")

			column(name: "price_of_each_cage_part", type: "decimal(19,2)")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-23") {
		createTable(tableName: "quotation_cage_part_model") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotation_cagPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_design_id", type: "bigint")

			column(name: "cage_part_cost", type: "decimal(19,2)")

			column(name: "cost_per_bird", type: "decimal(19,2)")

			column(name: "no_of_birds", type: "decimal(19,2)")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-24") {
		createTable(tableName: "quotation_cage_part_model_quotation_cage_part") {
			column(name: "quotation_cage_part_model_quotation_cage_parts_id", type: "bigint")

			column(name: "quotation_cage_part_id", type: "bigint")

			column(name: "quotation_cage_parts_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-25") {
		createTable(tableName: "quotation_mesh_model") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotation_mesPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_design_id", type: "bigint")

			column(name: "cost_per_bird", type: "decimal(19,2)")

			column(name: "double_box", type: "decimal(19,2)")

			column(name: "mesh_cost", type: "decimal(19,2)")

			column(name: "no_of_birds", type: "decimal(19,2)")

			column(name: "single_box", type: "decimal(19,2)")

			column(name: "wire_brand_id", type: "bigint")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-26") {
		createTable(tableName: "quotation_mesh_model_quotation_mesh_part") {
			column(name: "quotation_mesh_model_quotation_mesh_parts_id", type: "bigint")

			column(name: "quotation_mesh_part_id", type: "bigint")

			column(name: "quotation_mesh_parts_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-27") {
		createTable(tableName: "quotation_mesh_part") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotation_mesPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "created_by", type: "varchar(255)")

			column(name: "created_date", type: "datetime")

			column(name: "edited_date", type: "datetime")

			column(name: "last_edited_by", type: "varchar(255)")

			column(name: "mesh_cost", type: "decimal(19,2)")

			column(name: "no_of_mesh_parts", type: "decimal(19,2)")

			column(name: "sheet_specification_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_price", type: "decimal(19,2)")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-28") {
		createTable(tableName: "quotation_model") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotation_modPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_design_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cost", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "cost_per_bird", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_birds", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "quotation_cage_part_model_id", type: "bigint")

			column(name: "quotation_mesh_model_id", type: "bigint")

			column(name: "tax", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "taxation_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "total_cost", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-29") {
		createTable(tableName: "quotation_models") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "quotation_modPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cage_design_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cost_per_bird", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "double_box", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_birds", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "single_box", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "total_cost", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-30") {
		createTable(tableName: "quotation_models_quotation_cage_part") {
			column(name: "quotation_models_quotation_cage_parts_id", type: "bigint")

			column(name: "quotation_cage_part_id", type: "bigint")

			column(name: "quotation_cage_parts_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-31") {
		createTable(tableName: "quotation_quotation_model") {
			column(name: "quotation_quotation_models_id", type: "bigint")

			column(name: "quotation_model_id", type: "bigint")

			column(name: "quotation_models_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-32") {
		createTable(tableName: "role") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "rolePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "authority", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-33") {
		createTable(tableName: "sheet_specification") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "sheet_specifiPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "cross_wire_diameter", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "factory_pitch", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "length", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "line_wire_diameter1", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "line_wire_diameter2", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_cross_wires", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_line_wires1", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_line_wires2", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "pitch", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "projection", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_name", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_spec_id", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_weight", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "textual", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "width", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-34") {
		createTable(tableName: "stock") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "stockPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "availability_status", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "created_by_id", type: "bigint")

			column(name: "created_date", type: "datetime")

			column(name: "last_edited_by_id", type: "bigint")

			column(name: "last_edited_date", type: "datetime")

			column(name: "machine_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "no_of_in_stock", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "no_of_manufactured", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "sheet_spec_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "stock_id", type: "varchar(255)")

			column(name: "stock_manufactured_time", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-35") {
		createTable(tableName: "stock_order") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "stock_orderPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "corder_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "created_by_id", type: "bigint")

			column(name: "created_date", type: "datetime")

			column(name: "last_edited_by_id", type: "bigint")

			column(name: "last_edited_date", type: "datetime")

			column(name: "stock_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "stock_for_order", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "stock_order_block_time", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "stock_order_items_idx", type: "integer")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-36") {
		createTable(tableName: "taxation") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "taxationPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "percent", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "taxation", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-37") {
		createTable(tableName: "user") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "userPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "account_expired", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "account_locked", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "enabled", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "password", type: "varchar(255)") {
				constraints(nullable: "false")
			}

			column(name: "password_expired", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "username", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-38") {
		createTable(tableName: "user_cage_part_type") {
			column(name: "user_cage_part_type_list_id", type: "bigint")

			column(name: "cage_part_type_id", type: "bigint")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-39") {
		createTable(tableName: "user_role") {
			column(name: "role_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "user_id", type: "bigint") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-40") {
		createTable(tableName: "wire_brand") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "wire_brandPK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "wire_brand", type: "varchar(255)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-41") {
		createTable(tableName: "wire_price") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "wire_pricePK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "conversion", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "description", type: "varchar(255)")

			column(name: "end_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "freight_handling_per_metric_ton", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "price", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "start_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "wastage", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_price", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_price_trending", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-42") {
		createTable(tableName: "wire_receipt_reporting") {
			column(autoIncrement: "true", name: "id", type: "bigint") {
				constraints(nullable: "false", primaryKey: "true", primaryKeyName: "wire_receipt_PK")
			}

			column(name: "version", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "availability_status", type: "bit") {
				constraints(nullable: "false")
			}

			column(name: "comments", type: "varchar(255)")

			column(name: "created_by", type: "varchar(255)")

			column(name: "created_date", type: "datetime")

			column(name: "edited_date", type: "datetime")

			column(name: "last_edited_by", type: "varchar(255)")

			column(name: "purchase_date", type: "datetime") {
				constraints(nullable: "false")
			}

			column(name: "weight_in_stock", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "weight_purchased", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}

			column(name: "wire_brand_id", type: "bigint") {
				constraints(nullable: "false")
			}

			column(name: "wire_diameter", type: "decimal(19,2)") {
				constraints(nullable: "false")
			}
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-43") {
		addPrimaryKey(columnNames: "role_id, user_id", constraintName: "user_rolePK", tableName: "user_role")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-44") {
		addForeignKeyConstraint(baseColumnNames: "cage_design_id", baseTableName: "cage_design_sheet_spec_formula", constraintName: "FKAAF56320E3175CFC", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_design", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-45") {
		addForeignKeyConstraint(baseColumnNames: "sheet_specification_id", baseTableName: "cage_design_sheet_spec_formula", constraintName: "FKAAF56320444E1384", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-46") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_spec_formula_id", baseTableName: "cage_part_price", constraintName: "FK86B42460CF673E02", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_spec_formula", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-47") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_type_id", baseTableName: "cage_part_specification", constraintName: "FK4A41AD1A282034E9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_type", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-48") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_spec_formula_id", baseTableName: "cage_part_specification_cage_part_spec_formula", constraintName: "FK54C64EB0CF673E02", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_spec_formula", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-49") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_specification_cage_part_spec_formula_list_id", baseTableName: "cage_part_specification_cage_part_spec_formula", constraintName: "FK54C64EB0AAEE79B8", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-50") {
		addForeignKeyConstraint(baseColumnNames: "cage_design_id", baseTableName: "corder", constraintName: "FKAF414CCBE3175CFC", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_design", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-51") {
		addForeignKeyConstraint(baseColumnNames: "created_by_id", baseTableName: "corder", constraintName: "FKAF414CCBDA2CD5E2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-52") {
		addForeignKeyConstraint(baseColumnNames: "customer_id", baseTableName: "corder", constraintName: "FKAF414CCB5ADA1CC7", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "customer", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-53") {
		addForeignKeyConstraint(baseColumnNames: "last_edited_by_id", baseTableName: "corder", constraintName: "FKAF414CCBFF80FD6C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-54") {
		addForeignKeyConstraint(baseColumnNames: "quotation_id", baseTableName: "corder", constraintName: "FKAF414CCB2EDD5C95", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-55") {
		addForeignKeyConstraint(baseColumnNames: "taxation_id", baseTableName: "corder", constraintName: "FKAF414CCBEE58B9A3", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "taxation", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-56") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "corder", constraintName: "FKAF414CCB39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-57") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_spec_formula_id", baseTableName: "corder_cage_parts", constraintName: "FKFF2B6691CF673E02", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_spec_formula", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-58") {
		addForeignKeyConstraint(baseColumnNames: "corder_id", baseTableName: "corder_cage_parts", constraintName: "FKFF2B66911E07B2DD", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "corder", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-59") {
		addForeignKeyConstraint(baseColumnNames: "corder_id", baseTableName: "corder_mesh_parts", constraintName: "FK585C5A021E07B2DD", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "corder", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-60") {
		addForeignKeyConstraint(baseColumnNames: "sheet_specification_id", baseTableName: "corder_mesh_parts", constraintName: "FK585C5A02444E1384", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-61") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "corder_mesh_parts", constraintName: "FK585C5A0239213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-62") {
		addForeignKeyConstraint(baseColumnNames: "corder_id", baseTableName: "corder_payment", constraintName: "FK1F252A921E07B2DD", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "corder", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-63") {
		addForeignKeyConstraint(baseColumnNames: "created_by_id", baseTableName: "corder_payment", constraintName: "FK1F252A92DA2CD5E2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-64") {
		addForeignKeyConstraint(baseColumnNames: "customer_id", baseTableName: "corder_payment", constraintName: "FK1F252A925ADA1CC7", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "customer", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-65") {
		addForeignKeyConstraint(baseColumnNames: "last_edited_by_id", baseTableName: "corder_payment", constraintName: "FK1F252A92FF80FD6C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-66") {
		addForeignKeyConstraint(baseColumnNames: "assigned_id", baseTableName: "enquiry", constraintName: "FKA0F99CC3CDA93922", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-67") {
		addForeignKeyConstraint(baseColumnNames: "created_by_id", baseTableName: "enquiry", constraintName: "FKA0F99CC3DA2CD5E2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-68") {
		addForeignKeyConstraint(baseColumnNames: "customer_id", baseTableName: "enquiry", constraintName: "FKA0F99CC35ADA1CC7", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "customer", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-69") {
		addForeignKeyConstraint(baseColumnNames: "last_edited_by_id", baseTableName: "enquiry", constraintName: "FKA0F99CC3FF80FD6C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-70") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_type_id", baseTableName: "enquiry_cage_part_type", constraintName: "FK62F303F282034E9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_type", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-71") {
		addForeignKeyConstraint(baseColumnNames: "enquiry_cage_part_type_list_id", baseTableName: "enquiry_cage_part_type", constraintName: "FK62F303F6422BDB1", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "enquiry", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-72") {
		addForeignKeyConstraint(baseColumnNames: "corder_id", baseTableName: "order_mesh_parts", constraintName: "FK26AB7F9F1E07B2DD", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "corder", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-73") {
		addForeignKeyConstraint(baseColumnNames: "sheet_specification_id", baseTableName: "order_mesh_parts", constraintName: "FK26AB7F9F444E1384", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-74") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "order_mesh_parts", constraintName: "FK26AB7F9F39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-75") {
		addForeignKeyConstraint(baseColumnNames: "sheet_specification_id", baseTableName: "price", constraintName: "FK65FB149444E1384", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-76") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "price", constraintName: "FK65FB14939213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-77") {
		addForeignKeyConstraint(baseColumnNames: "machine_id", baseTableName: "production_reporting", constraintName: "FK9087DE28D1111F11", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "machine", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-78") {
		addForeignKeyConstraint(baseColumnNames: "sheet_specifcation_id", baseTableName: "production_reporting", constraintName: "FK9087DE28E478C8DD", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-79") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "production_reporting", constraintName: "FK9087DE2839213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-80") {
		addForeignKeyConstraint(baseColumnNames: "production_reporting_id", baseTableName: "production_reporting_wire_weight", constraintName: "FK9A101FDB10ED16B5", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "production_reporting", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-81") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "production_reporting_wire_weight", constraintName: "FK9A101FDB39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-82") {
		addForeignKeyConstraint(baseColumnNames: "wire_receipt_reporting_id", baseTableName: "production_reporting_wire_weight", constraintName: "FK9A101FDBB43EBA8A", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_receipt_reporting", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-83") {
		addForeignKeyConstraint(baseColumnNames: "created_by_id", baseTableName: "quotation", constraintName: "FKA771958CDA2CD5E2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-84") {
		addForeignKeyConstraint(baseColumnNames: "customer_id", baseTableName: "quotation", constraintName: "FKA771958C5ADA1CC7", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "customer", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-85") {
		addForeignKeyConstraint(baseColumnNames: "last_edited_by_id", baseTableName: "quotation", constraintName: "FKA771958CFF80FD6C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-86") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_spec_formula_id", baseTableName: "quotation_cage_part", constraintName: "FKABC169A3CF673E02", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_spec_formula", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-87") {
		addForeignKeyConstraint(baseColumnNames: "cage_design_id", baseTableName: "quotation_cage_part_model", constraintName: "FKDC36C18DE3175CFC", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_design", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-88") {
		addForeignKeyConstraint(baseColumnNames: "quotation_cage_part_id", baseTableName: "quotation_cage_part_model_quotation_cage_part", constraintName: "FK875B6FF146D01E0D", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation_cage_part", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-89") {
		addForeignKeyConstraint(baseColumnNames: "cage_design_id", baseTableName: "quotation_mesh_model", constraintName: "FK25789EEAE3175CFC", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_design", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-90") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "quotation_mesh_model", constraintName: "FK25789EEA39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-91") {
		addForeignKeyConstraint(baseColumnNames: "quotation_mesh_part_id", baseTableName: "quotation_mesh_model_quotation_mesh_part", constraintName: "FK2FB8573DE9B14EF", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation_mesh_part", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-92") {
		addForeignKeyConstraint(baseColumnNames: "sheet_specification_id", baseTableName: "quotation_mesh_part", constraintName: "FK95DBC412444E1384", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-93") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "quotation_mesh_part", constraintName: "FK95DBC41239213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-94") {
		addForeignKeyConstraint(baseColumnNames: "cage_design_id", baseTableName: "quotation_model", constraintName: "FK25669AB6E3175CFC", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_design", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-95") {
		addForeignKeyConstraint(baseColumnNames: "quotation_cage_part_model_id", baseTableName: "quotation_model", constraintName: "FK25669AB691BC2D00", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation_cage_part_model", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-96") {
		addForeignKeyConstraint(baseColumnNames: "quotation_mesh_model_id", baseTableName: "quotation_model", constraintName: "FK25669AB658E5ABA5", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation_mesh_model", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-97") {
		addForeignKeyConstraint(baseColumnNames: "taxation_id", baseTableName: "quotation_model", constraintName: "FK25669AB6EE58B9A3", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "taxation", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-98") {
		addForeignKeyConstraint(baseColumnNames: "cage_design_id", baseTableName: "quotation_models", constraintName: "FK876CBC7DE3175CFC", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_design", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-99") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "quotation_models", constraintName: "FK876CBC7D39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-100") {
		addForeignKeyConstraint(baseColumnNames: "quotation_cage_part_id", baseTableName: "quotation_models_quotation_cage_part", constraintName: "FKB53692E146D01E0D", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation_cage_part", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-101") {
		addForeignKeyConstraint(baseColumnNames: "quotation_model_id", baseTableName: "quotation_quotation_model", constraintName: "FK7B14EE0378E2BAC6", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "quotation_model", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-102") {
		addForeignKeyConstraint(baseColumnNames: "created_by_id", baseTableName: "stock", constraintName: "FK68AF716DA2CD5E2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-103") {
		addForeignKeyConstraint(baseColumnNames: "last_edited_by_id", baseTableName: "stock", constraintName: "FK68AF716FF80FD6C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-104") {
		addForeignKeyConstraint(baseColumnNames: "machine_id", baseTableName: "stock", constraintName: "FK68AF716D1111F11", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "machine", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-105") {
		addForeignKeyConstraint(baseColumnNames: "sheet_spec_id", baseTableName: "stock", constraintName: "FK68AF716C892E80C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "sheet_specification", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-106") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "stock", constraintName: "FK68AF71639213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-107") {
		addForeignKeyConstraint(baseColumnNames: "corder_id", baseTableName: "stock_order", constraintName: "FKCE6CB8E51E07B2DD", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "corder", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-108") {
		addForeignKeyConstraint(baseColumnNames: "created_by_id", baseTableName: "stock_order", constraintName: "FKCE6CB8E5DA2CD5E2", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-109") {
		addForeignKeyConstraint(baseColumnNames: "last_edited_by_id", baseTableName: "stock_order", constraintName: "FKCE6CB8E5FF80FD6C", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-110") {
		addForeignKeyConstraint(baseColumnNames: "stock_id", baseTableName: "stock_order", constraintName: "FKCE6CB8E5161A665F", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "stock", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-111") {
		addForeignKeyConstraint(baseColumnNames: "cage_part_type_id", baseTableName: "user_cage_part_type", constraintName: "FKB558F037282034E9", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "cage_part_type", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-112") {
		addForeignKeyConstraint(baseColumnNames: "user_cage_part_type_list_id", baseTableName: "user_cage_part_type", constraintName: "FKB558F037DD5A544A", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-113") {
		addForeignKeyConstraint(baseColumnNames: "role_id", baseTableName: "user_role", constraintName: "FK143BF46AB7E57A25", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "role", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-114") {
		addForeignKeyConstraint(baseColumnNames: "user_id", baseTableName: "user_role", constraintName: "FK143BF46A5D103E05", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "user", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-115") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "wire_price", constraintName: "FK27CC8D0F39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	changeSet(author: "admin (generated)", id: "1338917129762-116") {
		addForeignKeyConstraint(baseColumnNames: "wire_brand_id", baseTableName: "wire_receipt_reporting", constraintName: "FKF1282FAD39213646", deferrable: "false", initiallyDeferred: "false", referencedColumnNames: "id", referencedTableName: "wire_brand", referencesUniqueColumn: "false")
	}

	/*changeSet(author: "admin (generated)", id: "1338917129762-117") {
		createIndex(indexName: "FKAAF56320444E1384", tableName: "cage_design_sheet_spec_formula") {
			column(name: "sheet_specification_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-118") {
		createIndex(indexName: "FKAAF56320E3175CFC", tableName: "cage_design_sheet_spec_formula") {
			column(name: "cage_design_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-119") {
		createIndex(indexName: "FK86B42460CF673E02", tableName: "cage_part_price") {
			column(name: "cage_part_spec_formula_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-120") {
		createIndex(indexName: "FK4A41AD1A282034E9", tableName: "cage_part_specification") {
			column(name: "cage_part_type_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-121") {
		createIndex(indexName: "FK54C64EB0AAEE79B8", tableName: "cage_part_specification_cage_part_spec_formula") {
			column(name: "cage_part_specification_cage_part_spec_formula_list_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-122") {
		createIndex(indexName: "FK54C64EB0CF673E02", tableName: "cage_part_specification_cage_part_spec_formula") {
			column(name: "cage_part_spec_formula_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-123") {
		createIndex(indexName: "FKAF414CCB2EDD5C95", tableName: "corder") {
			column(name: "quotation_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-124") {
		createIndex(indexName: "FKAF414CCB39213646", tableName: "corder") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-125") {
		createIndex(indexName: "FKAF414CCB5ADA1CC7", tableName: "corder") {
			column(name: "customer_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-126") {
		createIndex(indexName: "FKAF414CCBDA2CD5E2", tableName: "corder") {
			column(name: "created_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-127") {
		createIndex(indexName: "FKAF414CCBE3175CFC", tableName: "corder") {
			column(name: "cage_design_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-128") {
		createIndex(indexName: "FKAF414CCBEE58B9A3", tableName: "corder") {
			column(name: "taxation_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-129") {
		createIndex(indexName: "FKAF414CCBFF80FD6C", tableName: "corder") {
			column(name: "last_edited_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-130") {
		createIndex(indexName: "FKFF2B66911E07B2DD", tableName: "corder_cage_parts") {
			column(name: "corder_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-131") {
		createIndex(indexName: "FKFF2B6691CF673E02", tableName: "corder_cage_parts") {
			column(name: "cage_part_spec_formula_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-132") {
		createIndex(indexName: "FK585C5A021E07B2DD", tableName: "corder_mesh_parts") {
			column(name: "corder_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-133") {
		createIndex(indexName: "FK585C5A0239213646", tableName: "corder_mesh_parts") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-134") {
		createIndex(indexName: "FK585C5A02444E1384", tableName: "corder_mesh_parts") {
			column(name: "sheet_specification_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-135") {
		createIndex(indexName: "FK1F252A921E07B2DD", tableName: "corder_payment") {
			column(name: "corder_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-136") {
		createIndex(indexName: "FK1F252A925ADA1CC7", tableName: "corder_payment") {
			column(name: "customer_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-137") {
		createIndex(indexName: "FK1F252A92DA2CD5E2", tableName: "corder_payment") {
			column(name: "created_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-138") {
		createIndex(indexName: "FK1F252A92FF80FD6C", tableName: "corder_payment") {
			column(name: "last_edited_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-139") {
		createIndex(indexName: "FKA0F99CC35ADA1CC7", tableName: "enquiry") {
			column(name: "customer_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-140") {
		createIndex(indexName: "FKA0F99CC3CDA93922", tableName: "enquiry") {
			column(name: "assigned_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-141") {
		createIndex(indexName: "FKA0F99CC3DA2CD5E2", tableName: "enquiry") {
			column(name: "created_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-142") {
		createIndex(indexName: "FKA0F99CC3FF80FD6C", tableName: "enquiry") {
			column(name: "last_edited_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-143") {
		createIndex(indexName: "FK62F303F282034E9", tableName: "enquiry_cage_part_type") {
			column(name: "cage_part_type_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-144") {
		createIndex(indexName: "FK62F303F6422BDB1", tableName: "enquiry_cage_part_type") {
			column(name: "enquiry_cage_part_type_list_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-145") {
		createIndex(indexName: "FK26AB7F9F1E07B2DD", tableName: "order_mesh_parts") {
			column(name: "corder_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-146") {
		createIndex(indexName: "FK26AB7F9F39213646", tableName: "order_mesh_parts") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-147") {
		createIndex(indexName: "FK26AB7F9F444E1384", tableName: "order_mesh_parts") {
			column(name: "sheet_specification_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-148") {
		createIndex(indexName: "FK65FB14939213646", tableName: "price") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-149") {
		createIndex(indexName: "FK65FB149444E1384", tableName: "price") {
			column(name: "sheet_specification_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-150") {
		createIndex(indexName: "FK9087DE2839213646", tableName: "production_reporting") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-151") {
		createIndex(indexName: "FK9087DE28D1111F11", tableName: "production_reporting") {
			column(name: "machine_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-152") {
		createIndex(indexName: "FK9087DE28E478C8DD", tableName: "production_reporting") {
			column(name: "sheet_specifcation_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-153") {
		createIndex(indexName: "FK9A101FDB10ED16B5", tableName: "production_reporting_wire_weight") {
			column(name: "production_reporting_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-154") {
		createIndex(indexName: "FK9A101FDB39213646", tableName: "production_reporting_wire_weight") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-155") {
		createIndex(indexName: "FK9A101FDBB43EBA8A", tableName: "production_reporting_wire_weight") {
			column(name: "wire_receipt_reporting_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-156") {
		createIndex(indexName: "FKA771958C5ADA1CC7", tableName: "quotation") {
			column(name: "customer_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-157") {
		createIndex(indexName: "FKA771958CDA2CD5E2", tableName: "quotation") {
			column(name: "created_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-158") {
		createIndex(indexName: "FKA771958CFF80FD6C", tableName: "quotation") {
			column(name: "last_edited_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-159") {
		createIndex(indexName: "FKABC169A3CF673E02", tableName: "quotation_cage_part") {
			column(name: "cage_part_spec_formula_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-160") {
		createIndex(indexName: "FKDC36C18DE3175CFC", tableName: "quotation_cage_part_model") {
			column(name: "cage_design_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-161") {
		createIndex(indexName: "FK875B6FF146D01E0D", tableName: "quotation_cage_part_model_quotation_cage_part") {
			column(name: "quotation_cage_part_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-162") {
		createIndex(indexName: "FK25789EEA39213646", tableName: "quotation_mesh_model") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-163") {
		createIndex(indexName: "FK25789EEAE3175CFC", tableName: "quotation_mesh_model") {
			column(name: "cage_design_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-164") {
		createIndex(indexName: "FK2FB8573DE9B14EF", tableName: "quotation_mesh_model_quotation_mesh_part") {
			column(name: "quotation_mesh_part_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-165") {
		createIndex(indexName: "FK95DBC41239213646", tableName: "quotation_mesh_part") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-166") {
		createIndex(indexName: "FK95DBC412444E1384", tableName: "quotation_mesh_part") {
			column(name: "sheet_specification_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-167") {
		createIndex(indexName: "FK25669AB658E5ABA5", tableName: "quotation_model") {
			column(name: "quotation_mesh_model_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-168") {
		createIndex(indexName: "FK25669AB691BC2D00", tableName: "quotation_model") {
			column(name: "quotation_cage_part_model_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-169") {
		createIndex(indexName: "FK25669AB6E3175CFC", tableName: "quotation_model") {
			column(name: "cage_design_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-170") {
		createIndex(indexName: "FK25669AB6EE58B9A3", tableName: "quotation_model") {
			column(name: "taxation_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-171") {
		createIndex(indexName: "FK876CBC7D39213646", tableName: "quotation_models") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-172") {
		createIndex(indexName: "FK876CBC7DE3175CFC", tableName: "quotation_models") {
			column(name: "cage_design_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-173") {
		createIndex(indexName: "FKB53692E146D01E0D", tableName: "quotation_models_quotation_cage_part") {
			column(name: "quotation_cage_part_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-174") {
		createIndex(indexName: "FK7B14EE0378E2BAC6", tableName: "quotation_quotation_model") {
			column(name: "quotation_model_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-175") {
		createIndex(indexName: "authority_unique_1338917129658", tableName: "role", unique: "true") {
			column(name: "authority")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-176") {
		createIndex(indexName: "FK68AF71639213646", tableName: "stock") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-177") {
		createIndex(indexName: "FK68AF716C892E80C", tableName: "stock") {
			column(name: "sheet_spec_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-178") {
		createIndex(indexName: "FK68AF716D1111F11", tableName: "stock") {
			column(name: "machine_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-179") {
		createIndex(indexName: "FK68AF716DA2CD5E2", tableName: "stock") {
			column(name: "created_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-180") {
		createIndex(indexName: "FK68AF716FF80FD6C", tableName: "stock") {
			column(name: "last_edited_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-181") {
		createIndex(indexName: "FKCE6CB8E5161A665F", tableName: "stock_order") {
			column(name: "stock_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-182") {
		createIndex(indexName: "FKCE6CB8E51E07B2DD", tableName: "stock_order") {
			column(name: "corder_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-183") {
		createIndex(indexName: "FKCE6CB8E5DA2CD5E2", tableName: "stock_order") {
			column(name: "created_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-184") {
		createIndex(indexName: "FKCE6CB8E5FF80FD6C", tableName: "stock_order") {
			column(name: "last_edited_by_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-185") {
		createIndex(indexName: "username_unique_1338917129673", tableName: "user", unique: "true") {
			column(name: "username")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-186") {
		createIndex(indexName: "FKB558F037282034E9", tableName: "user_cage_part_type") {
			column(name: "cage_part_type_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-187") {
		createIndex(indexName: "FKB558F037DD5A544A", tableName: "user_cage_part_type") {
			column(name: "user_cage_part_type_list_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-188") {
		createIndex(indexName: "FK143BF46A5D103E05", tableName: "user_role") {
			column(name: "user_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-189") {
		createIndex(indexName: "FK143BF46AB7E57A25", tableName: "user_role") {
			column(name: "role_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-190") {
		createIndex(indexName: "FK27CC8D0F39213646", tableName: "wire_price") {
			column(name: "wire_brand_id")
		}
	}

	changeSet(author: "admin (generated)", id: "1338917129762-191") {
		createIndex(indexName: "FKF1282FAD39213646", tableName: "wire_receipt_reporting") {
			column(name: "wire_brand_id")
		}
	}*/
	
	/*changeSet(author: "shyam", id: "1338917129762-192") {
		sqlFile( path: "cleanconfig.sql")
	}*/
}
