variable "is_storage_private_endpoint_enabled" {
  type        = bool
  description = "(Optional - default to false) Enable private endpoints for dbfs"
  default     = false
}

variable "location" {
  type        = string
  description = "(Required) The location for the spoke deployment"
}

variable "vnet_cidr" {
  # Note: following chart assumes a Vnet between /16 and /24, inclusive

  # | Subnet Size (CIDR) | Maximum ADB Cluster Nodes |
  # | /17	| 32763 |
  # | /18	| 16379 |
  # | /19	| 8187 |
  # | /20	| 4091 |
  # | /21	| 2043 |
  # | /22	| 1019 |
  # | /23	| 507 |
  # | /24	| 251 |
  # | /25	| 123 |
  # | /26	| 59 |

  type        = string
  description = "(Required) The CIDR block for the spoke Virtual Network"
  # default     = "10.2.1.0/24"
  validation {
    condition     = tonumber(split("/", var.vnet_cidr)[1]) > 15 && tonumber(split("/", var.vnet_cidr)[1]) < 25
    error_message = "CIDR block must be between /16 and /24, inclusive"
  }
}

variable "key_vault_id" {
  type        = string
  description = "(Required) ID of the Azure Key Vault containing the keys for CMK"

}
variable "route_table_id" {
  type        = string
  description = "(Required) The ID of the route table to associate with the Databricks subnets"
}

variable "metastore_id" {
  type        = string
  description = "(Required) The ID of the metastore to associate with the Databricks workspace"
}

variable "ipgroup_id" {
  type        = string
  description = "(Required) The ID of the IP Group used for firewall egress rules"
}

variable "hub_vnet_name" {
  type        = string
  description = "(Required) The name of the hub VNet to peer"
}

variable "hub_resource_group_name" {
  type        = string
  description = "(Required) The name of the hub Resource Group to peer"
}

variable "hub_vnet_id" {
  type        = string
  description = "(Required) The ID of the hub VNet to peer"
}

variable "managed_disk_key_id" {
  type    = string
  default = "(Required) The key for managed disk encryption"
}

variable "managed_services_key_id" {
  type    = string
  default = "(Required) The key for the managed services encryption"
}

variable "prefix" {
  type        = string
  description = "(Required) Naming prefix for resources"
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Map of tags to attach to resources"
  default     = {}
}
