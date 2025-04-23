output "redis_instances" {
  description = "Details of the created Redis instances"
  value       = google_redis_instance.redis
}