pipeline {
  agent any
  stages {
    stage('pod install') {
      parallel {
        stage('pod install') {
          steps {
            dir(path: 'Example') {
              sh '''export LANG=en_US.UTF-8
rm -f Podfile.lock
/usr/local/bin/pod install'''
            }

          }
        }

        stage('log') {
          steps {
            echo 'pod install'
          }
        }

      }
    }

    stage('build') {
      parallel {
        stage('build') {
          steps {
            dir(path: 'Example') {
              xcodeBuild(ipaOutputDirectory: 'ipas', target: 'LRSEntranceSourceLoader_Example', xcodeWorkspaceFile: 'LRSEntranceSourceLoader', xcodeSchema: 'LRSEntranceSourceLoader-Example', bundleIDInfoPlistPath: 'LRSEntranceSourceLoader/LRSEntranceSourceLoader-Info.plist', developmentTeamID: '3EZ8YQY6LK', developmentTeamName: 'junc', buildIpa: true, ignoreTestResults: true, ipaName: 'LRSEntrance_Example', ipaExportMethod: 'development', buildDir: 'buildDir')
            }

          }
        }

        stage('log') {
          steps {
            echo 'build'
          }
        }

      }
    }

    stage('upload ipa') {
      steps {
        dir(path: 'build')
      }
    }

  }
}