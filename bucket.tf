provider "aws" {
    region ="eu-west-2"
  
}

resource "aws_s3_bucket" "keni-bucket" {
    bucket = "keni-bucket"
    acl    = "private" 

versioning {
  enabled = true
}
server_side_encryption_configuration {
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
} 
}
resource "aws_s3_bucket_policy" "my_bucket_policy" {
    bucket = aws_s3_bucket.keni-bucket.id

    policy = jsonencode({
        "Version" : "2012-10-17",
        "Id" : "Policy1522250877451",
        "Statement" : [
            {
                "Sid": "stmt1522250877451",
                "Effect": "Allow",
                "Principal": { 
                    "AWS": "arn:aws:iam::891377185359:root"
                },
                "Action": "s3:GetObject",
                "Resource": "${aws_s3_bucket.keni-bucket.arn}/*"
            }
        ]
    })
}
