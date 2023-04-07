if kubectl get deployment ${APP_NAME} -n ${NAMESPACE} &> /dev/null
then
  echo "Update image of ${APP_NAME} deployment"
  kubectl set image deployment/${APP_NAME} ${APP_NAME}=${IMAGE} --namespace=${NAMESPACE}
  echo "Waiting for rollout to finish"
  kubectl rollout status deployment/${APP_NAME} --namespace=${NAMESPACE} --timeout=30s
else
  echo "Initial deployment: ${APP_NAME}"
  envsubst < app.yaml | kubectl apply -f -
  kubectl wait deployment ${APP_NAME} --for condition=Ready -n ${NAMESPACE} --timeout=60s
fi
