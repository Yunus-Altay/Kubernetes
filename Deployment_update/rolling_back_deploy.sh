kubectl rollout history deploy web-flask-deploy
kubectl rollout undo deploy web-flask-deploy --to-revision=1