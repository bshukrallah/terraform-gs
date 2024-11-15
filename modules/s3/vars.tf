# bucket_name
variable "bucket_name" {
    type = string
    description = "Name of the bucket"
}

# elb_service_account_arn
variable "elb_service_account_arn" {
    type = string
    description = "arn of the service account"
}

# common_tags
variable "common_tags" {
    type = map(string)
    description = "Map of tags for all resources"
    default = {}
}