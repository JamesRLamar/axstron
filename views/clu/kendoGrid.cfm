<article class="container12">
	<section>
		<div class="block-border">
			<div class="block-content">
				<div class="h1">
					<cfoutput>
#NavigationBlockHeading()#
					</cfoutput>
				</div>
				<div id="tab-home" class="with-margin" style="height:auto;">
					<div id="grid">
					</div>
					<script type="text/x-kendo-template" id="template">
						 <div class="toolbar">
							<label class="category-label" for="category">Show products by category:</label>
							<input type="search" id="category" style="width: 230px"></input>
						 </div>
					  </script>
					<script>
					 $(document).ready(function() {
						var grid = $("#grid").kendoGrid({
						    dataSource: {
							   type: "odata",
							   transport: {
								  read: "http://demos.kendoui.com/service/Northwind.svc/Products"
							   },
							   pageSize: 15,
							   serverPaging: true,
							   serverSorting: true,
							   serverFiltering: true
						    },
						    toolbar: kendo.template($("#template").html()),
						    height: 450,
						    sortable: true,
						    pageable: true,
						    columns: [
							   { field: "ProductID", width: 100 },
							   { field: "ProductName", title: "Product Name" },
							   { field: "UnitPrice", title: "Unit Price", width: 100 },
							   { field: "QuantityPerUnit", title: "Quantity Per Unit" }
						    ]
						});
						var dropDown = grid.find("#category").kendoAutoComplete({
						    dataTextField: "ProductName",
						    autoBind: false,
						    dataSource: {
							   type: "odata",
							   severFiltering: true,
							   transport: {
								  read: "http://demos.kendoui.com/service/Northwind.svc/Products"
							   }
						    },
						    change: function() {
							   var value = this.value();
							   if (value) {
								  grid.data("kendoGrid").dataSource.filter(
								  
								  	{
									    logic: "or",
									    filters: [
										 { field: "ProductName", operator: "contains", value: value },
										 { field: "QuantityPerUnit", operator: "contains", value: value }
									    ]
									}
								  );
							   } else {
								  grid.data("kendoGrid").dataSource.filter({});
							   }
						    }
						});
					 });
		
				  </script>
					<style scoped>
                #grid .k-toolbar
                {
                    min-height: 27px;
                }
                .category-label
                {
                    vertical-align: middle;
                    padding-right: .5em;
                }
                #category
                {
                    vertical-align: middle;
                }
                .toolbar {
                    float: right;
                    margin-right: .8em;
                }
            </style>
				</div>
			</div>
		</div>
	</section>
	<div class="clear">
	</div>
</article>
