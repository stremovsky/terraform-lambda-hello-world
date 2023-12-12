data "aws_iam_policy_document" "AWSLambdaTrustPolicy" {
  statement {
    actions    = ["sts:AssumeRole"]
    effect     = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "hello_role" {
  name               = "hello_role"
  assume_role_policy = "${data.aws_iam_policy_document.AWSLambdaTrustPolicy.json}"
}

resource "aws_iam_role_policy_attachment" "terraform_lambda_policy" {
  role       = "${aws_iam_role.hello_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "hello_lambda" {
  filename      = "hello.zip"
  function_name = "tf_hello"
  handler       = "hello.lambda_handler"
  #role          = "arn:aws:iam::186285203186:role/BasicLambda"
  role          = "${aws_iam_role.hello_role.arn}"
  source_code_hash = filebase64sha256("hello.zip")
  runtime = "python3.10"
  timeout = 30
}
