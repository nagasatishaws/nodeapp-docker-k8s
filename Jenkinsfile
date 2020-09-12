pipeline {
    agent any
    
    stage('Build Docker Image'){
             sh "docker build . -t nagasatishdocker/nodeapp-docker-k8s ." 
    }
    stage("Docker push"){
           withCredentials([string(credentialsId: 'Docker_Hub_credentails', variable: 'Docker_Hub_credentails')]) {
             sh "docker login -u nagasatishdocker -p ${Docker_Hub_credentails}"
           }        
             sh "docker push nagasatishdocker/nodeapp-docker-k8s"   
        }
      
    stage('Deploy to k8s'){
       
            sh "chmod +x changeTag.sh"
            sh "./changeTag.sh"
     
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
  
 

 
