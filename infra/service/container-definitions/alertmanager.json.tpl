[
  {
    "name": "$${name}",
    "image": "$${image}",
    "memoryReservation": 256,
    "memory": 512,
    "essential": true,
    "command": $${command},
    "portMappings": [
      {
        "containerPort": ${container_web_port},
        "hostPort": ${host_web_port}
      },
      {
        "containerPort": ${container_cluster_port},
        "hostPort": ${host_cluster_port}
      }
    ],
    "environment": [
      { "name": "AWS_S3_BUCKET_REGION", "value": "$${region}" },
      { "name": "AWS_S3_ENV_FILE_OBJECT_PATH", "value": "${env_file_object_path}" }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "$${log_group}",
        "awslogs-region": "$${region}"
      }
    }
  }
]
