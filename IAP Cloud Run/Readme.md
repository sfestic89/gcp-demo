# Accessing Cloud Run via IAP

🧩 Key Components:

Cloud Run Service: A fully managed serverless platform for running containerized applications.

HTTPS External Load Balancer: Fronts the Cloud Run service and ensures secure external access.

Identity-Aware Proxy (IAP): Controls access to the Cloud Run service by enforcing authentication and authorization.

Google Secret Manager: Stores the IAP OAuth credentials securely.

IAM Roles & Policies: Defines who can access the Cloud Run service through IAP.

✅ Benefits:

🔒 Secure Authentication & Authorization – Only allowed users can access Cloud Run.

🔑 OAuth-Based Access Control – Ensures user authentication via Google accounts.

🌍 Global Accessibility – Securely expose Cloud Run to the public without exposing it directly.

🚀 Serverless & Scalable – Leverages Cloud Run's auto-scaling features with IAP's access control.

🚨 Important: Enforced Secure Access Only

As shown in the diagram:

![IAP with Cloud Run Use case](IAP-Cloud_run.png)

➤ This ensures secure access management and prevents unauthorized access.

🛠️ Real-World Scenario

A user wants to access a Cloud Run service.

The request goes through an HTTPS external load balancer.

IAP enforces authentication, checking if the user has the necessary IAM role.

If authorized, the request is forwarded to the Cloud Run service.

If unauthorized, access is denied.

🛠 Terraform Implementation

The Terraform module sets up:

Cloud Run service with an external HTTPS load balancer.

IAP for access control with OAuth credentials stored in Secret Manager.

IAM bindings to grant access to specific users.