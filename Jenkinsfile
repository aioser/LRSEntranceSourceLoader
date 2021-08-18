pipeline {
  agent any
  stages {
    stage('clone') {
      steps {
        git(url: 'git@github.com:aioser/LRSEntranceSourceLoader.git', branch: 'master', changelog: true)
      }
    }

    stage('pod install') {
      steps {
        sh 'cd Example;'
        sh '''export LANG=en_US.UTF-8
pwd
rm -f Podfile.lock
/usr/local/bin/pod install'''
      }
    }

  }
}