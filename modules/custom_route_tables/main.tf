#Data source existing route table
data "aws_route_table" "main" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  tags = each.value.tags
}


# Route via Internet Gateway
module "internet_gateway_route" {
    for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
    source = "./internet_gateway_route"
    #route_table_id = module.route_tables[each.key].route_table_id
    route_table_id = data.aws_route_table.main[each.key].id
    internet_gateway_route_conf = lookup(each.value.routes, "internet_gateway_route" , "")
    depends_on = [
      data.aws_route_table.main
    ]
}

# Route via Virtual Private Gateway
module "virtual_private_gateway_route" {
    for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
    source = "./virtual_private_gateway_route"
    route_table_id = data.aws_route_table.main[each.key].id
    virtual_private_gateway_route_conf = lookup(each.value.routes, "virtual_private_gateway_route" , "")
    depends_on = [
      data.aws_route_table.main
    ]
}

# Route via Egress Only Internet Gateway
module "egress_only_internet_gateway_route" {
    for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
    source = "./egress_only_internet_gateway_route"
    #route_table_id = module.route_tables[each.key].route_table_id
    route_table_id = data.aws_route_table.main[each.key].id
    egress_only_internet_gateway_route_conf = lookup(each.value.routes, "egress_only_internet_gateway_route" , "")
    depends_on = [
      data.aws_route_table.main
    ]
}


# Route via Nat Gateway
module "nat_gateway_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./nat_gateway_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  nat_gateway_route_conf = lookup(each.value.routes, "nat_gateway_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}

# Route via vpc_peering connection
module "peering_connection_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./peering_connection_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  peering_connection_route_conf = lookup(each.value.routes, "peering_connection_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}


# Route via instance
module "instance_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./instance_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  instance_route_conf = lookup(each.value.routes, "instance_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}


# # Route via network interface
module "network_interface_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./network_interface"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  network_interface_route_conf = lookup(each.value.routes, "network_interface_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}


# Route via vpc_endpoint
module "vpc_endpoint_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./vpc_endpoint_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  vpc_endpoint_route_conf = lookup(each.value.routes, "vpc_endpoint_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}


# Route via Transit Gateway
module "transit_gateway_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./transit_gateway_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  transit_gateway_route_conf = lookup(each.value.routes, "transit_gateway_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}

# Route via Carrier Gateway
module "route_table_A_carrier_gateway_route" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./carrier_gateway_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  carrier_gateway_route_conf = lookup(each.value.routes, "carrier_gateway_routes" , "")
  depends_on = [
    data.aws_route_table.main
  ]
}


# Route via Local Gateway
module "outpost_local_gateway_routes" {
  for_each = {for idx, route_tables in var.route_tables_conf.route_tables: idx =>route_tables}
  source = "./outpost_local_gateway_route"
  #route_table_id = module.route_tables[each.key].route_table_id
  route_table_id = data.aws_route_table.main[each.key].id
  local_gateway_route_conf = lookup(each.value.routes, "outpost_local_gateway_routes" , "")

  depends_on = [
    data.aws_route_table.main
  ]
}