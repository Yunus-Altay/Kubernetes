######## Initialize an S3 bucket as a Helm repository ########
# create a s3 bucket
# assign the required roles to the instance
# configure aws cli
helm plugin install https://github.com/hypnoglow/helm-s3.git # install the helm-s3 plugin on your client machine
helm s3 init s3://phonebook-helm-s3-repo/stable/myapp # the pattern as the target chart repo will be so
aws s3 ls s3://phonebook-helm-s3-repo/stable/myapp/ # verify that the index.yaml file was created
helm repo add phonebook-s3 s3://phonebook-helm-s3-repo/stable/myapp/ # add the target repository alias to the Helm client machine

######## Package and publish charts in the Amazon S3 Helm repository ########
helm package ./phonebookApp-chart/ #  package the chart
# chart package is named using the version number that is mentioned in the Chart.yaml file
helm s3 push ./phonebook-app-chart-0.1.7.tgz phonebook-s3 # upload the local package to the Helm repository in Amazon S3
# phonebook-app-chart is your chart folder name, 0.1.7 is the chart version mentioned in Chart.yaml, and phonebook-s3 is the target repository alias
helm search repo phonebook-s3 # confirm that the chart appears both locally and in the Amazon S3 Helm repository
# let's test it
helm install myapp phonebook-s3/phonebook-app-chart
helm ls

######## Upgrade your Helm repository ########
# Change the value/s in the values.yaml and then package the chart, this time changing the version in Chart.yaml to 0.1.8
helm package ./phonebookApp-chart/
helm s3 push ./phonebook-app-chart-0.1.8.tgz phonebook-s3
helm search repo phonebook-s3
helm search repo phonebook-s3 -l
helm install myapp-new phonebook-s3/phonebook-app-chart
# see, a new release of the upgraded chart is installed