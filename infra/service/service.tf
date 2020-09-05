data "template_file" "alertmanager_task_container_definitions" {
  template = file("${path.root}/container-definitions/alertmanager.json.tpl")

  vars = {
    env_file_object_path = data.template_file.env_file_object_path.rendered
    container_port = var.alertmanager_service_container_port
    host_port = var.alertmanager_service_host_port
    storage_location = var.alertmanager_storage_location
  }
}

module "alertmanager_service" {
  source  = "infrablocks/ecs-service/aws"
  version = "3.0.0-rc.4"

  component = var.component
  deployment_identifier = var.deployment_identifier

  region = var.region
  vpc_id = data.aws_vpc.vpc.id
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  service_task_container_definitions = data.template_file.alertmanager_task_container_definitions.rendered

  service_name = var.component
  service_image = var.alertmanager_image
  service_port = var.alertmanager_service_container_port

  service_desired_count = var.service_desired_count
  service_deployment_maximum_percent = 200
  service_deployment_minimum_healthy_percent = 50

  service_network_mode = 'awsvpc'

  service_elb_name = ""

  service_volumes = [
    {
      name = "alertmanager-storage"
      host_path = var.alertmanager_storage_location
    }
  ]

  ecs_cluster_id = data.terraform_remote_state.cluster.outputs.ecs_cluster_id
  ecs_cluster_service_role_arn = data.terraform_remote_state.cluster.outputs.ecs_service_role_arn
}
