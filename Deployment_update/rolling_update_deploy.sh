kubectl set image deploy web-flask-deploy web-flask-pod=clarusway/cw_web_flask2
kubectl scale deploy web-flask-deploy --replicas=10