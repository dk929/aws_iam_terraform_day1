provider "aws" {
    region = "us-east1"
}

resource "aws_iam_user" "beginner_user" {
    name = "beginner-user"
}

#create a safe read-only s3 policy for this user
resource "aws_iam_policy" "read_only_s3" {
    name         = "ReadOnlyS3Policy"
    description  = "Allows List and Get on S3 only"
    policy       = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
                Action = [
                    "s3:ListBucket", # Allows listing s3 buckets
                    "s3:GetObject"  # Allows reading objects
                ],
                Effect = "Allow",
                Resource = "*"   #Applies to all resources
            }
        ] 
        
    })
}

#Attach the read-only s3 policy to the beginner-user
resource "aws_iam_user_policy_attachment" "attach" {
    user    = aws_iam_user.beginner_user.name
    policy_arn  = aws_iam_policy.read_only_s3.arn 
}