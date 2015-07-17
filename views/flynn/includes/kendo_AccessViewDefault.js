// JavaScript Document
$(document).ready(function () {

	var serviceURL = kendoURL + "/services/_AccessViewService.cfc?RemoteToken=" + RemoteToken + "&method=",

	dataSource = new kendo.data.DataSource({

		transport: {

			read:  {

				url: serviceURL + "JsonRead_AccessView",

				dataType: "JSON"
			},

			update: {
				url: serviceURL + "JsonUpdate_AccessView",

				dataType: "JSON"
			},

			destroy: {

				url: serviceURL + "JsonDelete_AccessView",

				dataType: "JSON"
			},

			create: {

				url: serviceURL + "JsonCreate_AccessView",

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

				id: "AccessViewId",

				fields: {

					AccessViewId: { editable: false, nullable: true },
					Section: { type: "string", validation: { required: false, nullable: true } },

					View: { type: "string", validation: { required: false, nullable: true } },

					RoleName: { type: "string", validation: { required: false, nullable: true } }
					}
				}
			}
		} );

	var grid = $("#kendo_AccessViewDefault").kendoGrid({

		dataSource: dataSource,

		navigatable: true,

		pageable: true,

		scrollable: false,

		sortable: true,

		filterable: false,

		editable: "inline",

		columns: [

			{ filterable: false, sortable: false, template: kendo.template($("#_AccessViewTemplate").html()), width: "125px" },

			{ field: "Section", title: "Section"},

			{ field: "View", title: "View"},

			{ field: "RoleName", title: "Role Name"},

			{ command: ["edit", "destroy"], title: "&nbsp;", width: "200px" }]
	} );
} );
