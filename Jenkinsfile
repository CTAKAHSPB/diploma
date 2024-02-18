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
					sh('echo hello')
				}
			}
		}
        stage('Upload docker image') {
			steps{
				dir("testapp") {
					sh('echo hello')
				}
			}
		}
        stage('Copy helm chart to master) {
			steps{
				dir("helm") {
					sh('echo hello')
				}
			}
		}
        stage('Upgrade helm chart) {
			steps{
				dir("helm") {
					sh('echo hello')
				}
			}
		}
		
    }
}
