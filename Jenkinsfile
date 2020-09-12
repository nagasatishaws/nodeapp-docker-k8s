pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
        }
  stages{
    stage('Build Docker Image'){
             steps{
                     sh "docker build . -t nagasatishdocker/nodeapp-docker-k8s:${DOCKER_TAG} "   
    }
}
    
    stage("Docker push"){
          steps{
           withCredentials([string(credentialsId: 'Docker_Hub_credentails', variable: 'Docker_Hub_credentails')]) {
           sh "docker login -u nagasatishdocker -p ${Docker_Hub_credentails}"
           sh "docker push nagasatishdocker/nodeapp-docker-k8s:${DOCKER_TAG}"   
        }
      }
    }
         stage('Deploy to k8s'){
        steps{
            sh "chmod +x changeTag.sh"
            sh "./changeTag.sh ${DOCKER_TAG}"
     
             sshagent(['kubernetes']) {
             sh "scp -o StrictHostKeyChecking=no services.yml  node-app-pod.yml  ubuntu@54.242.129.44:/home/ubuntu/"
            script{
          try{
                  sh "ssh ubuntu@54.242.129.44  kubectl apply -f ."
              } catch(error){
                 sh "ssh ubuntu@54.242.129.44  kubectl create -f ."

                  }
             }
         }
      }
   }
}

 
