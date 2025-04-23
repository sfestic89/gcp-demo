import base64
import json
import os
from google.cloud import storage, bigquery
from flask import Request

# ENV vars from Terraform
BQ_DATASET = os.getenv("BQ_DATASET")
BQ_TABLE = os.getenv("BQ_TABLE")

storage_client = storage.Client()
bq_client = bigquery.Client()

def entrypoint_handler(request: Request):
    try:
        envelope = request.get_json()
        print("📨 Raw Pub/Sub Envelope:", json.dumps(envelope, indent=2))

        if not envelope or "message" not in envelope:
            print("❌ Invalid message format")
            return "Bad Request", 400

        # Decode base64 data
        pubsub_message = envelope["message"]
        data = base64.b64decode(pubsub_message["data"]).decode("utf-8")
        print("✅ Decoded PubSub message:", data)

        # Parse the data payload (GCS Event Format)
        attributes = json.loads(data)
        bucket_name = attributes["bucket"]
        file_name = attributes["name"]

        print(f"📂 File uploaded: gs://{bucket_name}/{file_name}")

        # Load CSV into BigQuery
        uri = f"gs://{bucket_name}/{file_name}"
        table_id = f"{bq_client.project}.{BQ_DATASET}.{BQ_TABLE}"

        job_config = bigquery.LoadJobConfig(
            source_format=bigquery.SourceFormat.CSV,
            skip_leading_rows=1,
            autodetect=True,
            write_disposition=bigquery.WriteDisposition.WRITE_APPEND,
        )

        load_job = bq_client.load_table_from_uri(
            uri, table_id, job_config=job_config
        )

        load_job.result()  # Wait for job to complete

        print(f"✅ CSV from {file_name} imported to {table_id}")

        return "Success", 200

    except Exception as e:
        print("❌ Error during ingestion:", str(e))
        return f"Internal Server Error: {e}", 500
