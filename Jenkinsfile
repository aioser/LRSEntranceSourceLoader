pipeline {
  agent any
  stages {
    stage('pod install') {
      steps {
        sh '''export LANG=en_US.UTF-8
pwd
cd Example
rm -f Podfile.lock
/usr/local/bin/pod install'''
      }
    }

    stage('build') {
      steps {
        xcodeBuild(ipaOutputDirectory: 'ipas', generateArchive: true, target: 'LRSEntranceSourceLoader_Example', xcodeWorkspaceFile: 'LRSEntranceSourceLoader')
        dir(path: 'Example')
      }
    }

  }
}