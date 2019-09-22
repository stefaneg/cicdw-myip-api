
export INFRASTRUCTURE_STACK_NAME=$1
export BRANCH_NAME=$2

requireVariable INFRASTRUCTURE_STACK_NAME
requireVariable BRANCH_NAME


export STACK_PARAMETERS="ParameterKey=branchName,ParameterValue=${BRANCH_NAME} ParameterKey=infrastructureStackName,ParameterValue=${INFRASTRUCTURE_STACK_NAME}"

echo ${STACK_PARAMETERS}
