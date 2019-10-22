# Building AWS layers
This is an example project for building custom AWS lambda layer combining pandas and numpy.

## Prerequisites
You'll need Docker installed

## Instructions

0. Fill in the specific requirements (with their versions) in the requirements.txt file.
1. Run: 
```
cd ./aws_layer_builder
./get_layer_packages.sh
zip -r <some-meaningful-layer-name>.zip python
```
Behind the scenes: It installs the requirements.txt into a python folder. 
It generates a zip which you can now use to create AWS layer for your lambda function(s).

2. In the AWS console navigate to: Services > Lambda > Layers. Hit "Create Layer" and use the created zip. Copy the ARN.

3. Attach the layer to a lambda:

Option 1: Using the AWS console: Go to your lambda function. In the Designer section of the Configuration tab select Layers. Layers section appears below the Designer. Hit Add Layer and fill in the form.

or

Option 2: Using zappa, configure layers in the zappa_settings file.
`"layers": ["arn:aws:lambda:<region>:<account_id>:layer:<layer_name>:<layer_version>"] `
Note: Layers support is currently available here https://github.com/Miserlou/Zappa/pull/1842

## Notes:
Current example illustrates building a pandas+numpy layer for python3.6.
The script uses Docker to get Lambda-compatible versions of the libraries listed in requirements.txt.
It uses lambci/lambda:build-python3.6 (a public Docker image providing environment that replicates the live AWS Lambda environment almost identically.)

If you need a different environment, set IMAGE_NAME and PACKAGES_PATH accordingly (check get_layer_packages.sh).