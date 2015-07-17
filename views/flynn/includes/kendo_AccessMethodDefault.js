// JavaScript Document
$(document).ready(function () {

	var serviceURL = kendoURL + "/services/_AccessMethodService.cfc?RemoteToken=" + RemoteToken + "&method=",

	dataSource = new kendo.data.DataSource({

		transport: {

			read:  {

				url: serviceURL + "JsonRead_AccessMethod",

				dataType: "JSON"
			},

			update: {
				url: serviceURL + "JsonUpdate_AccessMethod",

				dataType: "JSON"
			},

			destroy: {

				url: serviceURL + "JsonDelete_AccessMethod",

				dataType: "JSON"
			},

			create: {

				url: serviceURL + "JsonCreate_AccessMethod",

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

				id: "AccessMethodId",

				fields: {

					AccessMethodId: { editable: false, nullable: true },
					Component: { type: "string", validation: { required: false, nullable: true } },

					MethodName: { type: "string", validation: { required: false, nullable: true } },

					Section: { type: "string", validation: { required: false, nullable: true } },

					View: { type: "string", validation: { required: false, nullable: true } }
					}
				}
			}
		} );

	var grid = $("#kendo_AccessMethodDefault").kendoGrid({

		dataSource: dataSource,

		navigatable: true,

		pageable: true,

		scrollable: false,

		sortable: true,

		filterable: false,

		editable: "inline",

		columns: [

			{ filterable: false, sortable: false, template: kendo.template($("#_AccessMethodTemplate").html()), width: "125px" },

			{ field: "Component", title: "Component"},

			{ field: "MethodName", title: "Method Name"},

			{ field: "Section", title: "Section"},

			{ field: "View", title: "View"},

			{ command: ["edit", "destroy"], title: "&nbsp;", width: "200px" }]
	} );
} );
