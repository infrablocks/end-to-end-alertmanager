locals {
  alertmanager_task_container_definitions = templatefile("${path.root}/container-definitions/alertmanager.json.tpl", {
    env_file_object_path = local.env_file_object_path
    container_web_port = var.alertmanager_service_container_web_port
    host_web_port = var.alertmanager_service_host_web_port
    container_cluster_port = var.alertmanager_service_container_cluster_port
    host_cluster_port = var.alertmanager_service_host_cluster_port
    storage_location = var.alertmanager_storage_location
  })
}

module "alertmanager_service" {
  source  = "infrablocks/ecs-service/aws"
  version = "3.2.0"

  component = var.component
  deployment_identifier = var.deployment_identifier

  region = var.region
  vpc_id = data.aws_vpc.vpc.id
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  service_task_container_definitions = local.alertmanager_task_container_definitions

  service_name = "${var.service_name}-${var.instance}"
  service_image = var.alertmanager_image
  service_port = var.alertmanager_service_container_web_port

  service_desired_count = var.service_desired_count
  service_deployment_maximum_percent = 100
  service_deployment_minimum_healthy_percent = 0

  service_task_network_mode = "awsvpc"

  target_group_arn = data.terraform_remote_state.load_balancer.outputs.target_group_arn

  service_discovery_namespace_id = data.terraform_remote_state.service_registry.outputs.service_discovery_namespace_id

  service_volumes = [
    {
      name = "alertmanager-storage"
      host_path = var.alertmanager_storage_location
    }
  ]

  ecs_cluster_id = data.terraform_remote_state.cluster.outputs.ecs_cluster_id
  ecs_cluster_service_role_arn = data.terraform_remote_state.cluster.outputs.ecs_service_role_arn

  register_in_service_discovery = "yes"
}
