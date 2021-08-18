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
          sh 'cd Example'
          sh '''export LANG=en_US.UTF-8
cd ${XCS_PRIMARY_REPO_DIR}
pwd
rm -f Podfile.lock
/usr/local/bin/pod install
'''
        }

      }
    }

  }
}