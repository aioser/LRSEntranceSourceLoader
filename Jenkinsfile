pipeline {
  agent any
  stages {
    stage('clone') {
      steps {
        git(url: 'git@github.com:aioser/LRSEntranceSourceLoader.git', branch: 'master', changelog: true)
      }
    }

    stage('cd example') {
      steps {
        sh 'cd Example'
        sh 'ls'
      }
    }

    stage('pod install') {
      steps {
        sh '''export LANG=en_US.UTF-8
cd ${XCS_PRIMARY_REPO_DIR}
pwd
rm -f Podfile.lock
/usr/local/bin/pod install'''
      }
    }

  }
}