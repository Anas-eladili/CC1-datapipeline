resource "aws_kinesis_analytics_application" "kinesis_sql_streaming_application" {

  name = "sql-streaming-application"

  # Define the SOURCE of the application
  inputs {
    # Prefix for the source stream name 
    name_prefix = "SOURCE_SQL_STREAM"

    kinesis_stream {
      resource_arn = aws_kinesis_stream.datastream_ingestion.arn
      role_arn     = aws_iam_role.kinesis_analytics_sql_streaming_application.arn
    }

    parallelism {
      count = 1
    }

    schema {
      record_columns {
        mapping  = "$.host"
        name     = "host"
        sql_type = "VARCHAR(16)"
      }

      record_columns {
        mapping  = "$.datetime"
        name     = "datetime"
        sql_type = "VARCHAR(32)"
      }

      record_columns {
        mapping  = "$.request"
        name     = "request"
        sql_type = "VARCHAR(64)"
      }
      record_columns {
        mapping  = "$.response"
        name     = "response"
        sql_type = "INTEGER"
      }
      record_columns {
        mapping  = "$.bytes"
        name     = "bytes"
        sql_type = "INTEGER"
      }

      record_encoding = "UTF-8"
      record_format {
        mapping_parameters {
          json {
            record_row_path = "$"
          }
        }

      }

    }

    # Starting position in the stream
    starting_position_configuration {
      starting_position = "NOW"
    }

  }

  outputs {
    kinesis_firehose {
      resource_arn = aws_kinesis_firehose_delivery_stream.delivery_stream_summary.arn
      role_arn     = aws_iam_role.kinesis_analytics_sql_streaming_application.arn
    }

    name = "DESTINATION_SQL_STREAM"

    schema {
      record_format_type = "JSON"
    }

  }

  # SQL code of the application 
  code = <<EOF
CREATE OR REPLACE PUMP "STREAM_PUMP" AS INSERT INTO "DESTINATION_SQL_STREAM"
SELECT STREAM ROWTIME as datetime, "response" as status, COUNT(*) AS statusCount FROM "SOURCE_SQL_STREAM_001" GROUP BY "response", FLOOR(("SOURCE_SQL_STREAM_001".ROWTIME - TIMESTAMP '1970-01-01 00:00:00') minute / 1 TO MINUTE);  
EOF

  start_application = true

}
