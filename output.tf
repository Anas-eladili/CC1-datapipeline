# Output values about TF resources

output "tracker" {
  value = random_id.tracker.b64_url
}

output "current_region" {
  description = "current AWS region"
  value       = data.aws_region.current.name
}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}

output "student" {
  value = var.student_email
}

output "summary_destination_bucket" {
  value = aws_s3_bucket.summary_destination.bucket
}

output "ec2_vm_hostname" {
  value = aws_instance.ec2_vm.public_dns
}
