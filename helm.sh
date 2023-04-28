
HELM_CHART='idac-auth'
HELM_VALUE='values/values_aws_argosandbox.yaml'


### STATIC PARAMS
HELM_FOLDER='/root/helm'
HELM_RELEASE='releasename'
NAMESPACE='infra'

### RUN OPTIONS
UPGRADE="upgrade ${HELM_RELEASE} ${HELM_FOLDER}/${HELM_CHART}/ -f ${HELM_FOLDER}/${HELM_CHART}/${HELM_VALUE}  -n ${NAMESPACE}  --install --debug --dry-run"
LINT="lint  ${HELM_FOLDER}/${HELM_CHART}/ -f ${HELM_FOLDER}/${HELM_CHART}/${HELM_VALUE}"
TEMPLATE="template  ${HELM_FOLDER}/${HELM_CHART}/ -f ${HELM_FOLDER}/${HELM_CHART}/${HELM_VALUE}"

### COMMAND: Make sure you append UPGRADE/LINT/TEMPLATE to the end of the command
docker run -it --rm -v $(pwd):$HELM_FOLDER alpine/helm $LINT


