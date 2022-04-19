resource "aws_cloudwatch_dashboard" "ghost" {
  dashboard_name = "ghost-app-dashboard"

  dashboard_body = <<EOF
  
{
  "widgets": [
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EC2",
            "CPUUtilization",
            "InstanceId",
            "i-0808d34ab1e963d7a"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EC2 Instance CPU"
      }
    },
    {
      "type": "metric",
      "x": 7,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ECS",
            "CPUUtilization",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "ECS CPU"
      }
    },
    {
      "type": "metric",
      "x": 14,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ECS",
            "RunningCount",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "ECS Running tasks count"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EFS",
            "StorageBytes",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EFS StorageBytes in Mb"
      }
    },
    {
      "type": "metric",
      "x": 7,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/EFS",
            "ClientConnections",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "EFS ClientConnections"
      }
    },
     {
      "type": "metric",
      "x": 14,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/RDS",
            "DatabaseConnections",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "RDS DB connections"
      }
    },
     {
      "type": "metric",
      "x": 0,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/RDS",
            "CPUUtilization",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "CPU utilization"
      }
    },
      {
      "type": "metric",
      "x": 7,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/RDS",
            "ReadIOPS",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "RDS storage read IOPS"
      }
    },
      {
      "type": "metric",
      "x": 14,
      "y": 0,
      "width": 7,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/RDS",
            "WriteIOPS",
            "InstanceId",
            "i-012345"
          ]
        ],
        "period": 300,
        "stat": "Average",
        "region": "us-east-1",
        "title": "RDS storage write IOPS"
      }
    }
  ]
}
EOF
}
/*
CPU utilization      #ECS Service CPU Utilization
runningCount         #ECS Running tasks count
StorageBytes         #EFS StorageBytes in Mb 
ClientConnections    #EFS ClientConnections
DatabaseConnections  #RDS DB connections
CPUUtilization       #RDS CPU utilization
ReadIOPS             #RDS storage read IOPS
WriteIOPS            #RDS storage write IOPS
*/