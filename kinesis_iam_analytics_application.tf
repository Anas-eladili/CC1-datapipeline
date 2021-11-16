# Defines IAM resources for the Kinesis application

# First a role
# Specifies which type of resource assumes that role (who has that role)
resource "aws_iam_role" "kinesis_analytics_sql_streaming_application" {
  name = "kinesis-analytics-sql-streaming-application"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "kinesisanalytics.amazonaws.com"
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

# Then one or more policies which state permissions on specific ressources
# This is a fine grained custom policy (inline policy)
# Replace placeholders with the ARN of the target resource (ex ARN of the input data stream)
resource "aws_iam_role_policy" "datastream_read_firehose_write" {
  name = "datastream-read-firehose-write"
  role = aws_iam_role.kinesis_analytics_sql_streaming_application.id

  # Read data from the datastream: ReadInputKinesis policy
  # Write data to the delivery stream: WriteOutputFirehose policy
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
			"Sid": "ReadInputKinesis",
            "Effect": "Allow",
            "Action": [
                "kinesis:DescribeStream",
                "kinesis:GetShardIterator",
                "kinesis:GetRecords"
            ],
            "Resource": [
                "${aws_kinesis_stream.datastream_ingestion.arn}"
            ]
        },
        {
            "Sid": "WriteOutputFirehose",
            "Effect": "Allow",
            "Action": [
                "firehose:DescribeDeliveryStream",
                "firehose:PutRecord",
                "firehose:PutRecordBatch"
            ],
            "Resource": [
                "${aws_kinesis_firehose_delivery_stream.delivery_stream_summary.arn}"
            ]
        }
    ]
}
EOF

}
