Provide next vars in CI/CD version:

`AWS_ACCESS_KEY_ID` - masked

`AWS_DEFAULT_REGION`

`AWS_SECRET_ACCESS_KEY`- masked

`TF_VAR_APP_NAME`

`TF_VAR_BUCKET_NAME`

`TF_VAR_CLUSTER_NAME`

`TF_VAR_DB_PASSWORD` - masked

`TF_VAR_DYNAMODB_NAME`

To test connectivity to RDS, execute in <b>pod</b>:
`mysql -h mysql-service -u petclinic -P 3306 -p$DB_PASSWORD`

To get LB endpoint, execute `kubectl get svc petclinic-lb`