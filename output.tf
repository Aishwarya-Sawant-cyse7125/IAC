# output "cluster_name" {
#   value = module.cluster-vpc.cluster_name
# }

output "node_autoscaling_group_ids" {
  value = module.cluster-vpc.node_autoscaling_group_ids
}