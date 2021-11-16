# Create a Kinesis firehose delivery stream to a S3 bucket to save the output of the analytics application

# Delivery stream to S3
resource "aws_kinesis_firehose_delivery_stream" "delivery_stream_summary" {
  name        = "delivery-stream-summary"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.delivery_stream_summary_role.arn
    bucket_arn = aws_s3_bucket.summary_destination.arn
  }

  tags = {
    student = "${var.student_email}"
  }
}
