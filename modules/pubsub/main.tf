resource "google_pubsub_topic" "topics" {
  for_each = var.topics

  name    = each.value.name
  project = var.project_id

  labels = each.value.labels
}

resource "google_pubsub_subscription" "subscriptions" {
  for_each = var.subscriptions

  name  = each.value.name
  topic = google_pubsub_topic.topics[each.value.topic_name].name

  project = var.project_id

  ack_deadline_seconds  = each.value.ack_deadline_seconds
  retain_acked_messages = each.value.retain_acked_messages

  expiration_policy {
    ttl = each.value.expiration_policy_ttl
  }

  dynamic "push_config" {
    for_each = each.value.push_endpoint != null ? [each.value.push_endpoint] : []
    content {
      push_endpoint = each.value.push_endpoint
    }
  }
}