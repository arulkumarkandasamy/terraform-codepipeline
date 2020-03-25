resource "aws_codepipeline" "project" {
  name     = "${var.app}-pipeline"
  role_arn = "arn:aws:iam::399274362427:role/vb-iot-pipelines-codepipeline-role"

  artifact_store {
    location = "tmp-399274362427-eu-central-1"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["${var.app}"]
      configuration = {
        S3Bucket             = "tmp-399274362427-eu-central-1"
        S3ObjectKey          = "auth-service-charts.zip"
        PollForSourceChanges = "true"
      }

     }
  }


  stage {
    name = "DeployDev"

    action {
      name            = "Deploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "Lambda"
      input_artifacts = ["${var.app}"]
      version         = "1"
      configuration = {
        FunctionName   = "iot-k8s-cicd-PRD-deployhelm-lambda"
        UserParameters = "dev"
      }

      }
  }

}
