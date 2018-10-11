pipeline {
    agent { label "dockeragent"}
    stages {
    
        stage ('Bundler Setup'){   
            steps {
                sh 'bundle install'
                echo 'finished installing gem file'
            }
        }

        stage ('KitchenCi Create instance'){
            steps {
                sh 'kitchen create ${NAME}'
            }
        }
        
        stage ('KitchenCi Converge instance'){
            steps {
                sh 'kitchen converge ${NAME}'
            }
        }
        
        stage ('KitchenCi Verify instance'){
            steps {
                sh 'kitchen verify ${NAME}'
            }
        }

        stage ('KitchenCi Destroy instance'){
            steps {
                sh 'kitchen destroy ${NAME}'
            }
        }
        
        stage ('cleanup workspace'){   
            steps {
                
                echo 'deleting last workspace file'
                deleteDir()
            }
        }
    }
}
