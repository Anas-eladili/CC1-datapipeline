# IAM role for the summary delivery stream
resource "aws_iam_role" "delivery_stream_summary_role" {
  name = "delivery-stream-summary-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    student = "${var.student_email}"
  }
}

# Policy to write to the S3 bucket
resource "aws_iam_role_policy" "delivery_stream_summary_policy" {
  name = "delivery-stream-summary-policy"
  role = aws_iam_role.delivery_stream_summary_role.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [ 
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "s3:AbortMultipartUpload",
                "s3:GetBucketLocation",
                "s3:GetObject",
                "s3:ListBucket",
                "s3:ListBucketMultipartUploads",
                "s3:PutObject"
            ],
            "Resource": [
                "${aws_s3_bucket.summary_destination.arn}",
                "${aws_s3_bucket.summary_destination.arn}/*"
            ]
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/kinesisfirehose/${aws_kinesis_firehose_delivery_stream.delivery_stream_summary.name}:log-stream:*"
            ]
        }
    ]
}
EOF

}
