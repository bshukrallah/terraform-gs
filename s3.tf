module "web_app_s3" {
  source = "./modules/s3"

  bucket_name = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags = local.common_tags
}


resource "aws_s3_object" "website" {
  for_each = local.website_content
  bucket   = module.web_app_s3.web_bucket.id
  key      = each.value
  source   = ".${each.value}"

  tags = local.common_tags

}

resource "aws_s3_object" "graphic" {
  bucket = module.web_app_s3.web_bucket.id
  key    = "/website/Globo_logo_Vert.png"
  source = "./website/Globo_logo_Vert.png"

  tags = local.common_tags

}