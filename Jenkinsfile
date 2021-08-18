pipeline {
  agent any
  stages {
    stage('clone') {
      steps {
        git(url: 'git@github.com:aioser/LRSEntranceSourceLoader.git', branch: 'master', changelog: true)
      }
    }

    stage('pod') {
      steps {
        dir(path: 'Example') {
          sh 'pod install'
        }

      }
    }

  }
}