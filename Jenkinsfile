pipeline {
    agent any
    stages{
        stage('first stage:download codeRules&rulesite, and build codeRules'){
             parallel{
                 stage('download and build codeRules'){
                     steps{
                         dir('codeRules') {
                             checkout([$class: 'GitSCM', branches: [[name: '**']], doGenerateSubmoduleConfigurations: false, extensions: [], gitTool: '', submoduleCfg: [], userRemoteConfigs: [[url: 'git@github.com:wangmengqiang001/codeRules.git']]])
                            sh label: '', script: '''export JENKINS_VOLUME=/root/datavol/jenkins
                             $PWD/tools/buildbc.sh'''
                         }

                     }
                 }
                 stage('download rulesite'){
                     steps{
                         checkout([$class: 'GitSCM', branches: [[name: '*/main']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: 'rulesite']], gitTool: '', submoduleCfg: [], userRemoteConfigs: [[url: 'git@github.com:wangmengqiang001/rulesite.git']]])
                     }
                     
                 }
             }
        }
        stage('build the image'){
            steps{
                dir('rulesite'){
                    sh label: '', script: '''export CODERULE_PROJECT=codeRules 
./buildimg.sh'''
                }
            }
        }
    }
}

