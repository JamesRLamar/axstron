// JavaScript Document
$(document).ready(function () {

	var serviceURL = kendoURL + "/services/_ViewService.cfc?RemoteToken=" + RemoteToken + "&method=",

	dataSource = new kendo.data.DataSource({

		transport: {

			read:  {

				url: serviceURL + "JsonRead_View",

				dataType: "JSON"
			},

			update: {
				url: serviceURL + "JsonUpdate_View",

				dataType: "JSON"
			},

			destroy: {

				url: serviceURL + "JsonDelete_View",

				dataType: "JSON"
			},

			create: {

				url: serviceURL + "JsonCreate_View",

				dataType: "JSON"
			},

			parameterMap: function(options, operation) {

				if (operation !== "read" && options.models) {

					return {models: kendo.stringify(options.models)};
				}
			}
		},

		batch: true,

		pageSize: 10,

		schema: {

			model: {

				id: "ViewId",

				fields: {

					ViewId: { editable: false, nullable: true },
					SectionFolderName: { type: "string", validation: { required: false, nullable: true } },

					DisplayName: { type: "string", validation: { required: false, nullable: true } },

					FileName: { type: "string", validation: { required: false, nullable: true } },

					ViewOrder: { type: "number", validation: { required: false, nullable: true } },

					IsPublished: { type: "number", validation: { required: false, nullable: true } },

					IsSection: { type: "number", validation: { required: false, nullable: true } },

					Icon: { type: "string", validation: { required: false, nullable: true } },

					Content: { type: "string", validation: { required: false, nullable: true } }
					}
				}
			}
		} );

	var grid = $("#kendo_ViewDefault").kendoGrid({

		dataSource: dataSource,

		toolbar: kendo.template($("#template").html()),

		navigatable: true,

		pageable: true,

		scrollable: false,

		sortable: {
				mode: "multiple", // a value of "single" would only allow the user to sort one column at a time
				allowUnsort: true
			},

		filterable: false,

		editable: "inline",

		columns: [

			//{ filterable: false, sortable: false, template: kendo.template($("#_ViewTemplate").html()), width: "125px" },

			{ field: "SectionFolderName", title: "Section Folder Name"},

			{ field: "DisplayName", title: "Display Name"},

			{ field: "FileName", title: "File Name"},

			{ field: "ViewOrder", title: "View Order"},

			{ field: "IsPublished", title: "Is Published"},

			{ field: "IsSection", title: "Is Section"},

			{ field: "Icon", title: "Icon"},

			{ field: "Content", title: "Content"},

			{ command: ["edit", "destroy"], title: "&nbsp;", width: "200px" }]
	} );

	var dropDown = grid.find("#search").kendoAutoComplete({

		dataTextField: "DisplayName",

		autoBind: false,

		dataSource: dataSource,

		filter: 'contains',

		delay: 0,

		change: function() {
			
		   var value = this.value();
		  
		   if (value) {
			  
			  grid.data("kendoGrid").dataSource.filter(

				{ field: "DisplayName", operator: "contains", value: value }
			  );
		   } 
		   
		   else {
			  
			  grid.data("kendoGrid").dataSource.filter({});
		   }
		}
	});
} );
