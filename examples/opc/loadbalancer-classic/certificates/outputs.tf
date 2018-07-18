output "ca_cert_pem" {
  value = "${tls_self_signed_cert.ca.cert_pem}"
}

output "cert_pem" {
  value = "${tls_locally_signed_cert.example.cert_pem}"
}

output "private_key_pem" {
  value = "${tls_private_key.example.private_key_pem}"
}
