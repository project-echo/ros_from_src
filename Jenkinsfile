def imageExistsInECR(repository, tag) {
    try {
        sh "aws ecr describe-images --repository-name=${repository} --image-ids=imageTag='${tag}'"
    } catch (err) {
        println("Image ${repository}:${tag} does not yet exist: let's build it")
        return false
    }
    println("Image ${repository}:${tag} already exists: skip the build")
    return true
}

pipeline {
    agent none
    options {
        timeout(time: 60, unit: 'MINUTES')
        disableConcurrentBuilds()
    }

    parameters {
        booleanParam(name: 'force_build', defaultValue: false, description: 'Force rebuild even if images already exist in ECR')
    }

    environment {
        DOCKER_REPO = '194203576681.dkr.ecr.eu-west-1.amazonaws.com'
        DEVEL_IMAGE = 'ros-noetic-devel'
        RUNTIME_IMAGE = 'ros-noetic-runtime'
    }

    stages {
        stage('Check existing images') {
            agent { label 'master' }
            steps {
                script {
                    if (params.force_build) {
                        env.BUILD_IMAGES = true
                    } else {
                        develExists = imageExistsInECR(DEVEL_IMAGE, env.GIT_COMMIT)
                        runtimeExists = imageExistsInECR(RUNTIME_IMAGE, env.GIT_COMMIT)
                        env.BUILD_IMAGES = !(develExists && runtimeExists)
                    }
                }
            }
        }

        stage('Build and push') {
            agent { label 'arm64-docker' }
            when {
                expression { env.BUILD_IMAGES == "true" }
            }
            steps {
                sh """
                    eval \$(aws ecr get-login --no-include-email --region eu-west-1)

                    docker build -f Dockerfile.24_04 --target devel \
                        -t ${DOCKER_REPO}/${DEVEL_IMAGE}:${GIT_COMMIT} \
                        -t ${DOCKER_REPO}/${DEVEL_IMAGE}:${BUILD_NUMBER} .
                    docker push ${DOCKER_REPO}/${DEVEL_IMAGE}:${GIT_COMMIT}
                    docker push ${DOCKER_REPO}/${DEVEL_IMAGE}:${BUILD_NUMBER}

                    docker build -f Dockerfile.24_04 --target runtime \
                        -t ${DOCKER_REPO}/${RUNTIME_IMAGE}:${GIT_COMMIT} \
                        -t ${DOCKER_REPO}/${RUNTIME_IMAGE}:${BUILD_NUMBER} .
                    docker push ${DOCKER_REPO}/${RUNTIME_IMAGE}:${GIT_COMMIT}
                    docker push ${DOCKER_REPO}/${RUNTIME_IMAGE}:${BUILD_NUMBER}
                """
            }
        }
    }

    post {
        success {
            slackSend(channel: '#server_changelog', color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.RUN_DISPLAY_URL})")
        }
        failure {
            slackSend(channel: '#server_changelog', color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.RUN_DISPLAY_URL})")
        }
    }
}
