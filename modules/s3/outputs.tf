#bucket object
output "web_bucket" {
    value = aws_s3_bucket.web_bucket
}

#instance profile object
output "instance_profile" {
    value = aws_iam_instance_profile.nginx_profile
}

#iam role policy
output "iam_role_policy" {
    value = aws_iam_role_policy.allow_s3_all
}