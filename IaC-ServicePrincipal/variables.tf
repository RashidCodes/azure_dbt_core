variable "TENANT_ID" {
   description = "Tenant Id of the application running terraform"
   sensitive   = true
}

variable "CONTAINERAPP_JOB_SCOPE" {
   description = "The scope of the container app job"
   sensitive = false
}
