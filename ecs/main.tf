resource "aws_ecs_cluster" "demo-ecs-cluster" {
  name = "ecs-cluster-for-demo"
}

resource "aws_ecs_service" "demo-ecs-service-two" {
  name            = "demo-app"
  cluster         = aws_ecs_cluster.demo-ecs-cluster.id
  task_definition = aws_ecs_task_definition.demo-ecs-task-definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-042932e82d8b802ed"]
    assign_public_ip = true
  }
  desired_count = 2
}

resource "aws_ecs_task_definition" "demo-ecs-task-definition" {
  family                   = "ecs-task-definition-demo"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "arn:aws:iam::365299945243:role/ecsTaskExecutionRole"
  container_definitions    = jsonencode([
  {
    "name": "demo-container",
    "image": "365299945243.dkr.ecr.us-east-2.amazonaws.com/mydockerrepo:latest",
    "memory": 1024,
    "cpu": 10,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  },
  {
    "name": "demo-container1",
    "image": "365299945243.dkr.ecr.us-east-2.amazonaws.com/demo-repo:latest",
    "memory": 512,
    "cpu": 10,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 4000,
        "hostPort": 4000
      }
    ]
  }
])
}