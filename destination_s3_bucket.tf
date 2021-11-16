# Create a S3 bucket - destination of the data pipeline
resource "aws_s3_bucket" "analytics_destination" {
  bucket = "analytics-destination-wxcft6azeiuza6uigy54uh696"
  acl    = "private"

  tags = {
    Name        = "S3 bucket"
    Environment = "test"
  }
}
