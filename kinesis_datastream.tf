resource "aws_kinesis_stream" "kinesis_input_stream" { # le nom sous terraform 
  name        = "input-stream"  #nom sous terraform
  shard_count = 1
  # The defaut retention period is 24h
  retention_period = 24

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags = {
    Environment = "test"
  } # tag pour retrouver sous amazon rapidements le sservices 
}

# ça c'est la partie streams ingestion 
