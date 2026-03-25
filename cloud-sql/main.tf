resource "google_sql_database_instance" "main" {
  name             = "${var.db_name}-${random_id.db_suffix.hex}"
  database_version = "POSTGRES_14"
  region           = var.region
  project          = var.project_id
  deletion_protection = false # ¡Importante para demos!

  settings {
    # Tier más bajo posible para demo
    tier = "db-f1-micro"
    availability_type = "ZONAL"

    ip_configuration {
      ipv4_enabled = true # Para simplificar conexión en demo
    }
  }
}

resource "google_sql_user" "users" {
  name     = "admin"
  instance = google_sql_database_instance.main.name
  password = "changeme123" # En prod usaríamos Secret Manager
  project  = var.project_id
}

resource "random_id" "db_suffix" {
  byte_length = 4
}
