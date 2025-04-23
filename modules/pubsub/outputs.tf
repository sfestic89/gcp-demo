output "topic_names" {
  description = "Names of created Pub/Sub topics"
  value       = [for topic in google_pubsub_topic.topics : topic.name]
}

output "subscription_names" {
  description = "Names of created Pub/Sub subscriptions"
  value       = [for sub in google_pubsub_subscription.subscriptions : sub.name]
}