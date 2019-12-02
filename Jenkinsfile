
library(
    identifier: 'pipeline-lib@4.6.1',
    retriever: modernSCM([$class: 'GitSCMSource',
                          remote: 'https://github.com/SmartColumbusOS/pipeline-lib',
                          credentialsId: 'jenkins-github-user'])
)

properties([
    pipelineTriggers([scos.dailyBuildTrigger()]),
    parameters([
        booleanParam(defaultValue: false, description: 'Deploy to development environment?', name: 'DEV_DEPLOYMENT'),
        string(defaultValue: 'development', description: 'Image tag to deploy to dev environment', name: 'DEV_IMAGE_TAG')
    ])
])

def doStageIf = scos.&doStageIf
def doStageIfDeployingToDev = doStageIf.curry(env.DEV_DEPLOYMENT == "true")
def doStageIfMergedToMaster = doStageIf.curry(scos.changeset.isMaster && env.DEV_DEPLOYMENT == "false")
def doStageIfRelease = doStageIf.curry(scos.changeset.isRelease)

node ('infrastructure') {
    environment {
      DOCKERHUB_LOGIN = credentials('dockerhub_login')
    }


    ansiColor('xterm') {
        scos.doCheckoutStage()


        doStageIfDeployingToDev('Deploy to Dev') {
            deployTo('dev', "--recreate-pods")
        }

        doStageIfMergedToMaster('Deploy to Staging') {
            withCredentials([usernamePassword(credentialsId: 'dockerhub_login', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                sh "./deploy.sh master"
                deployTo('staging')
            }
        }

        doStageIfRelease('Deploy to Production') {
            sh "./deploy.sh release"
            deployTo('prod')
        }
    }
}

def deployTo(environment, extraArgs = '') {
    scos.withEksCredentials(environment) {
        sh("""#!/bin/bash
            echo wassup
            set -e

            helm init --client-only
            helm upgrade --install kube-bench ./chart --set image="smartcolumbusos/scos-kube-bench:development"
            helm upgrade --install kube-bench ./chart \
                --namespace=testing \
                ${extraArgs}""")
    }
}

