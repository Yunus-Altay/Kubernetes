# create a github repo
# clone the remote repo into the home directory
git clone https://github.com/Yunus-Altay/phonebook-heml-github-repo.git
cd phonebook-helm-github-repo/
create the chart package in the local git repo
helm package ../phonebookApp-chart/
helm repo index .
git add .
git config --global user.email "xxx"
git config --global user.name "xxx"
git commit -m "xxx"
git push
# github repo can be now used as helm repo
---
helm repo add phonebook https://raw.githubusercontent.com/Yunus-Altay/phonebook-helm-github-repo/main
helm repo ls # see, the chart is added to the list
helm install myapp phonebook/phonebook-app-chart
# helm install myapp phonebook/phonebook-app-chart --set volumes.storage=8Gi
# you may install the release with different values as in the example above