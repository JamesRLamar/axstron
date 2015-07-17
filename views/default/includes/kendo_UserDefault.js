// JavaScript Document
$(document).ready(function () {

	var serviceURL = kendoURL + "/services/_UserService.cfc?RemoteToken=" + RemoteToken + "&method=",

	dataSource = new kendo.data.DataSource({

		transport: {

			read:  {

				url: serviceURL + "JsonRead_User",

				dataType: "JSON"
			},

			update: {
				url: serviceURL + "JsonUpdate_User",

				dataType: "JSON"
			},

			destroy: {

				url: serviceURL + "JsonDelete_User",

				dataType: "JSON"
			},

			create: {

				url: serviceURL + "JsonCreate_User",

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

				id: "UserId",

				fields: {

					UserId: { editable: false, nullable: true },

					UserName: { type: "string", validation: { required: false, nullable: true } },

					Email: { type: "string", validation: { required: false, nullable: true } },

					//Password: { type: "string", validation: { required: false, nullable: true } },

					RoleName: { type: "string", validation: { required: false, nullable: true } },

					Status: { type: "string", validation: { required: false, nullable: true }, defaultValue: "Active" },

					LastLogin: { type: "string", editable: false, validation: { required: false, nullable: true } }
					}
				}
			}
		} );

	var grid = $("#kendo_UserDefault").kendoGrid({

		dataSource: dataSource,

		navigatable: true,

		pageable: true,

		scrollable: false,

		sortable: true,

		filterable: false,

		editable: "inline",

		columns: [

			//{ filterable: false, sortable: false, template: kendo.template($("#_UserTemplate").html()), width: "125px" },

			{ field: "UserName", title: "User Name"},

			{ field: "Email", title: "Email"},

			//{ field: "Password", title: "Password"},

			{ field: "RoleName", title: "Role Name"},

			{ field: "Status", title: "Status"},

			{ field: "LastLogin", title: "Last Login"},

			{ command: ["edit"], title: "&nbsp;", width: "200px" }]
	} );
} );
