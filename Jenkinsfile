pipeline {
    agent {
        dockerfile true
    }

    stages {
        /*
        stage('Change working directory'){
            steps{
                sh 'cd mlops_poc'
            }
        }
        */
        stage('Lab: Unit and Integration Tests') {
            when {
                /* only run when a PR is made against branch 'develop' */
                changeRequest target: 'develop'
            }
            environment {
                /* Set environment for Lab workspace */
                ARM_TENANT_ID = credentials('LAB_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('LAB_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('LAB_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                echo 'Running unit tests'
                /* TODO: Fix spark session for testing */
                /* Run pytest */
                /* sh 'pytest --junitxml=test-unit.xml' */
                
                /* Run integration tests */
                echo 'Running integration tests'
                /* Deploy with target test-lab and run workflow? */

                /* Validate Databricks bundle with staging target */
                echo 'Validate Bundle with staging target'
                sh 'databricks bundle validate -t staging'


            }
        }
        stage('Lab: Deploy to Lab with staging config'){
            when {
                /* only run when a change (merge) is made to the develop branch */
                branch 'develop'
            }
            environment {
                /* Set environment for Lab workspace */
                ARM_TENANT_ID = credentials('LAB_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('LAB_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('LAB_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                sh 'databricks bundle validate -t staging'
                sh 'databricks bundle deploy -t staging'
            }
        }
        stage('Factory: Prerelease tests'){
            when {
                /* only run when a PR is made against branch 'main' */
                changeRequest target: 'main'
            }
            environment {
                /* Set environment for Factory workspace */
                ARM_TENANT_ID = credentials('FACTORY_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('FACTORY_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('FACTORY_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                echo 'Validate bundle with prod target'
                sh 'databricks bundle validate -t prod'
                echo 'Run unit tests'
            }
        }
        stage('Factory: Deploy to Factory with prod config') {
            when {
                /* only run when a change (merge) is made to the main branch */
                branch 'main'
            }
            environment {
                /* Set environment for Factory workspace */
                ARM_TENANT_ID = credentials('FACTORY_AZURE_SP_TENANT_ID')
                ARM_CLIENT_ID = credentials('FACTORY_AZURE_SP_APPLICATION_ID')
                ARM_CLIENT_SECRET = credentials('FACTORY_AZURE_SP_CLIENT_SECRET') 
            }
            steps {
                /* Validate and deploy Databricks bundle with prod target */
                dir('mlops_poc'){
                    echo 'Deploy bundle to prod target'
                    sh 'databricks bundle validate -t prod'
                    sh 'databricks bundle deploy -t prod'
                }

            }
        }
    }
}
