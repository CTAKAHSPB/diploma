pipeline {

    agent any

    options {
        buildDiscarder(logRotator(numToKeepStr: '45'))
        timestamps()
    }

    stages {
        stage('Build docker image') {
			steps{
				dir("testapp") {
					sh('docker build . -f Dockerfile')
				}
			}
		}
        stage('Upload docker image') {
			steps{
				dir("testapp") {
					sh('docker push thepit/testapp')
				}
			}
		}
        stage('Copy helm chart to master) {
			steps{
				dir("helm") {
					sh('scp -r testapp master:/tmp')
				}
			}
		}
        stage('Upgrade helm chart) {
			steps{
				dir("helm") {
					sh('ssh testapp "cd /tmp; helm upgrade testapp . --install"')
				}
			}
		}
		
    }
}
