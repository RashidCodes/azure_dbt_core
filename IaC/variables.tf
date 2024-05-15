variable "SNOWFLAKE_PASSWORD" {
   description = "The snowflake password"
   type        = string
   sensitive   = true
}

variable "SNOWFLAKE_USERNAME" {
   description = "Snowflake username"
   type        = string
}

variable "CLIENT_ID" {
   description = "Service Principal Client Id"
   sensitive   = true
}

variable "CLIENT_SECRET" {
   description = "Service Principal Client Secret"
   sensitive   = true
}

variable "TENANT_ID" {
   description = "Tenant Id of the application running terraform"
   sensitive   = true
}

variable "SUBSCRIPTION_ID" {
   description = "Subscription Id of the application running terraform"
   sensitive   = true
}
