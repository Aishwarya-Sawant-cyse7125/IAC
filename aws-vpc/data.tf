data "aws_caller_identity" "current" {
  provider = aws.prod
}
# data.aws_caller_identity.current.account_id
# data.aws_caller_identity.current.arn
# data.aws_caller_identity.current.user_id