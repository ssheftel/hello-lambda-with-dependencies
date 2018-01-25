# Simple Lambda With Dependencies and Terraform

```bash
aws configure
pushd terraform/
tf plan
tf apply
popd
```

to test: `aws lambda invoke --invocation-type RequestResponse --function-name hello_lambda --region us-east-1 --log-type Tail --payload '{"key1":"value1"}' /tmp/resp.json | jq .LogResult | sed 's/"//g' | base64 --decode`