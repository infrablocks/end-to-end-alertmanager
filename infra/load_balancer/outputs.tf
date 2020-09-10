output "address" {
  value = module.load_balancer.address
}

output "arn" {
  value = module.load_balancer.arn
}

output "target_group_arn" {
  value = module.load_balancer.target_group_arn
}

output "listener_arn" {
  value = module.load_balancer.listener_arn
}
