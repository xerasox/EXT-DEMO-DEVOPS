#!/usr/bin/env groovy
import hudson.model.*
import hudson.EnvVars
import groovy.json.JsonSlurperClassic
import groovy.json.JsonBuilder
import groovy.json.JsonOutput
import java.net.URL

//Compuware Envirnoment to connect
String HCI_Connection     = "cwcc:16196"
String CES_Connection     = "cwcc:2020"       

// Jenkins credential ID and CES Personal Access token to be used for mainframe access
String Jenkins_Id        = "c724dde9-7013-4a7d-a137-7c4b593bbb8e"        // A username with password credential containing your CWC2 ID/PW
String Jenkins_CES       = "${Parm_ISPW_Owner}-CES"                     // A secret text credential containing your CES token for CWC2
String CES_Token         = "02ba8cda-c206-4658-a8e1-aa30cee31ced" // Your CES token

// Github specifications
String github_credentials = "1d6072dd-6257-4194-8bfc-df6e9b765097"       // A username with password credential containing your github ID/PW
String github_url         = "https://github.com/xerasox/EXT-DEMO-DEVOPS" // The github URL where your TTT test is stored

// ISPW Levels and container to be used by the promote/deploy/generate/regress operations
String ISPW_Container     = Parm_ISPW_Container     // Assignment ContainerID
String ISPW_ContainerType = "assignments"           // Valid values are assignments or releases
String ISPW_Stream        = "GITDEMO"               // ISPW Stream (Ex. CWEZ)
String ISPW_Application   = "GIT1"                  // ISPW APplication (EX. TXXX)
String ISPW_RuntimeConfig = ""                      // ISPW Runtime config (Ex. ISP8)
String ISPW_FT_Level      = Parm_ISPW_FT_Level      // ISPW Dev Level (Ex. DEV1)
String ISPW_Prod_Level    = Parm_ISPW_Prd_Level     // ISPW Prod Level (Ex. PRD)
String ISPW_Owner         = "c724dde9-7013-4a7d-a137-7c4b593bbb8e"         // The user initiating the pipeline
String ISPW_Release       = Parm_ISPW_Release       // The ISPW release ID used in XLR

// Directory for tests that are downloaded to the jenkins workspace
String TTT_Project        = "Tests"  // The name of your TTT project

// Total Test JCL and Scenario/Testsuite used in CI process
String TTT_TestPackage    = "XEXTCOB_Scenario" // The filename name of your TTT Scenario
String TTT_PackageType    = ".testscenario"    // The suffix of your TTT Scenario
string TTT_PackageSonar   = "${TTT_Project}_${TTT_TestPackage}.sonar"  // The filename created by TTT for Sonar input   
String TTT_Jcl            = "Runner.jcl"       // The name of the JCL file
String CC_repository      = "MVSXYE.DEMOCI.COVERAGE" // The DSN of your code coverage repository

// SonarQube ID used for both project key and project name
String SQ_Project         = "PFHMKS0-Pipeline" // Your SonarQube project name

// XL Release values
String XLR_Template       = "FTSDEMO/Release from Jenkins (FTSDEMO)" // XL Release template 
String XLR_User           = "pfhmks0"   // XLR Credentials

// Debug statements
println "owner: " + ISPW_Owner
println "release: " + ISPW_Release



/*
stage("Generate Programs")
{
    node 
    {
        // Define variables to be used to call ISPW
        def ces
        def container
        ces                 = "${Jenkins_CES}"
        String ispwRequestBdy = /assignmentId=${ISPW_Container}
           level=${ISPW_Dev_Level} 
           runtimeConfiguration=${ISPW_RuntimeConfig} 
           events.name=Completed events.body=Generated
           events.httpHeaders=Jenkins-Crumb:no-crumb
           events.credentials=admin:library/

        // Call ISPW Operation
        ispwOperation connectionId: '91bae501-8b4d-4155-909d-2ad5aa9f3131', credentialsId: ces, ispwAction: 'GenerateTasksInAssignment', ispwRequestBody: ispwRequestBdy
        }
}

stage("Promote Code")
{
    node
    {
        // Define variables to be used to call ISPW
        def ces
        def container
        ces                 = "${Jenkins_CES}"
        String ispwRequestBdy = /assignmentId=${ISPW_Container}
           level=${ISPW_Dev_Level} 
           runtimeConfiguration=${ISPW_RuntimeConfig} 
           events.name=Completed events.body=Promoted
           events.httpHeaders=Jenkins-Crumb:no-crumb
           events.credentials=admin:library/

        // Call ISPW Operation
        ispwOperation connectionId: '91bae501-8b4d-4155-909d-2ad5aa9f3131', credentialsId: ces, ispwAction: 'PromoteAssignment', ispwRequestBody: ispwRequestBdy
        }
}

*/
pipeline {
    agent any

parameters {
  string defaultValue: 'value', description: 'Assignment ContainerID', name: 'Parm_ISPW_Container'
  string defaultValue: 'FT1', description: 'ISPW Dev Level (Ex. DEV1)', name: 'Parm_ISPW_FT_Level'
  string defaultValue: 'value', description: 'ISPW QA Level (Ex. QA1)', name: 'Parm_ISPW_QA_Level'
  string defaultValue: 'value', description: 'ISPW Stage Level (Ex. STG1)', name: 'Parm_ISPW_Stg_Level'
  string defaultValue: 'value', description: 'ISPW Prod Level (Ex. PRD)', name: 'Parm_ISPW_Prd_Level'
  string defaultValue: 'value', description: 'The user initiating the pipeline', name: 'Parm_ISPW_Owner'
  string defaultValue: 'value', description: 'The ISPW release ID used in XLR', name: 'Parm_ISPW_Release'
}

stages {
stage("Download Tests from Github")
{
    steps{
        println "${ISPW_Release}"
        
       //Download the test from github
        checkout changelog: false, 
           poll: false, 
           scm: [$class: 'GitSCM', 
           branches: [[name: '*/master']], 
           doGenerateSubmoduleConfigurations: false, 
           extensions: [], 
           submoduleCfg: [], 
           userRemoteConfigs: 
              [[credentialsId: github_credentials, 
              name: 'origin', 
              url: github_url]]]

    }
}

stage("Download Source from ISPW")
{

    steps{
        //Download the source
        checkout([$class: 'IspwConfiguration', 
        componentType: 'COB, COPY',                             //Retrieve only cobol code and copybooks
        //connectionId: '91bae501-8b4d-4155-909d-2ad5aa9f3131',   //This is the ID for CWCC's HCI
        connectionId: 'de2ad7c3-e924-4dc2-84d5-d0c3afd3e756',   //This is the ID for CWCC's HCI
        credentialsId: "${Jenkins_Id}",  
        levelOption: '0',                                       //0-selected level only 1-first found and above
        serverApplication: "${ISPW_Application}", 
        serverConfig: "${ISPW_RuntimeConfig}", 
        serverLevel: "${ISPW_FT_Level}", 
        serverStream: "${ISPW_Stream}"])
    }

} 

stage("Run Total Tests")
{
    steps{
        // Run Total Test Jenkins Plugin
        step([$class: 'TotalTestBuilder', 
        ccRepo: "${CC_repository}",
        ccSystem: "${TTT_Project}", 
        ccTestId: "${BUILD_DISPLAY_NAME}",  //resolves to build number, i.e. #177 
        credentialsId: "${Jenkins_Id}", 
        deleteTemp: true, 
        hlq: '', 
        //hostPort: "${HCI_Connection}", 
        connectionId: 'de2ad7c3-e924-4dc2-84d5-d0c3afd3e756',
        jcl: "${TTT_Jcl}", 
        projectFolder: "${TTT_Project}", 
        testSuite: "${TTT_TestPackage}${TTT_PackageType}", 
        useStubs: true])
        
        // Process the Total Test result files into Jenkins
        junit keepLongStdio: true, testResults: 'TTTUnit/*.xml'
    }
    /*
    totaltest collectCCRepository: 'Repo', 
    collectCCSystem: 'A', 
    collectCCTestID: '1', 
    collectCodeCoverage: true, 
    connectionId: 'de2ad7c3-e924-4dc2-84d5-d0c3afd3e756', 
    credentialsId: 'c724dde9-7013-4a7d-a137-7c4b593bbb8e', 
    environmentId: '', 
    folderPath: 'Tests', 
    selectEnvironmentRadio: '-hci',
     serverCredentialsId: 'c724dde9-7013-4a7d-a137-7c4b593bbb8e',
    serverUrl: 'http://cwcc.bmc.com:2020'
    */
}
/*
stage("Retrieve Code Coverage Data")
{
    steps{
        // Retrieve code coverage data
        string sources="${ISPW_Application}\\MF_Source"
        def ccproperties   = 'cc.sources=' + sources + '\rcc.repos=' + CC_repository + '\rcc.system=' + TTT_Project + '\rcc.test=' + BUILD_DISPLAY_NAME + '\rcc.ddio.overrides='
        step([$class: 'CodeCoverageBuilder',
        analysisProperties: ccproperties,
            analysisPropertiesPath: '',
            connectionId: 'de2ad7c3-e924-4dc2-84d5-d0c3afd3e756',
            credentialsId: Jenkins_Id])
    }
}

stage("SonarQube Analysis") 
{
    steps{
        // Requires SonarQube Scanner 2.8+
        def scannerHome = tool 'scanner';
        withSonarQubeEnv('localhost') 
        {
            // Run SonarQube Scanner 
            def SQ_Tests                = " -Dsonar.tests=${TTT_Project} -Dsonar.testExecutionReportPaths=TTTSonar/${TTT_PackageSonar}.xml -Dsonar.coverageReportPaths=Coverage/CodeCoverage.xml"
            def SQ_ProjectKey           = " -Dsonar.projectKey=${SQ_Project} -Dsonar.projectName=${SQ_Project} -Dsonar.projectVersion=1.0"
            def SQ_Source               = " -Dsonar.sources=${ISPW_Application}\\MF_Source"
            def SQ_Copybook             = " -Dsonar.cobol.copy.directories=${ISPW_Application}"
            def SQ_Cobol_conf           = " -Dsonar.cobol.file.suffixes=cbl,testsuite,testscenario,stub -Dsonar.cobol.copy.suffixes=cpy -Dsonar.sourceEncoding=UTF-8"
            bat "${scannerHome}/bin/sonar-scanner" + SQ_Tests + SQ_ProjectKey + SQ_Source + SQ_Copybook + SQ_Cobol_conf
        }
    }
}
stage("Check Quality Gate")
{
    steps{ 
        timeout(time: 2, unit: 'MINUTES') {
            // Wait for webhook call back from SonarQube
            def qg = waitForQualityGate()
            if (qg.status != 'OK')
            {
                echo "Pipeline aborted due to quality gate failure: ${qg.status}"
                
                // If the quality gate is anything other than Green, regress the promoted code
               // Define variables to be used to call ISPW
               def ces
               def container
               ces                 = "${Jenkins_CES}"
               String ispwRequestBdy = /assignmentId=${ISPW_Container}
                  level=${ISPW_QA_Level} 
                  runtimeConfiguration=${ISPW_RuntimeConfig} 
                  events.name=Completed events.body=Regressed
                  events.httpHeaders=Jenkins-Crumb:no-crumb
                  events.credentials=admin:library/

               // Call ISPW Operation
               ispwOperation connectionId: 'de2ad7c3-e924-4dc2-84d5-d0c3afd3e756',
               credentialsId: ces,
               ispwAction: 'RegressAssignment',
               ispwRequestBody: ispwRequestBdy
                
                error "Exiting Pipeline"
            }
            else{
                echo "Quality Gate status is: {${qg.status}"
            }
        }   
    }
}


stage("Promote to STG Level")
{
    node
    {
        
        // Define variables to be used to call ISPW
        def ces
        def container
        ces                 = "${Jenkins_CES}"
        String ispwRequestBdy = /assignmentId=${ISPW_Container}
           level=${ISPW_QA_Level} 
           runtimeConfiguration=${ISPW_RuntimeConfig} 
           events.name=Completed events.body=Promoted
           events.httpHeaders=Jenkins-Crumb:no-crumb
           events.credentials=admin:library/

        // Call ISPW Operation
        ispwOperation connectionId: '91bae501-8b4d-4155-909d-2ad5aa9f3131', credentialsId: ces, ispwAction: 'PromoteAssignment', ispwRequestBody: ispwRequestBdy
        //ispwOperation connectionId: '91bae501-8b4d-4155-909d-2ad5aa9f3131', credentialsId: ces, ispwAction: 'PromoteAssignment', ispwRequestBody: ispwRequestBdy
        }
}

stage("Start Release") {
    steps{
        build(
            job: 'MKS-DevOps-Pipeline-PROD-Release',
            wait: false,  
            parameters: [
                string(
                    name:   'Parm_ISPW_Runtime_Config', 
                    value:  'ICCGA'
                ),
                string(
                    name:   'Parm_ISPW_QA_Level', 
                    value:  'QA1'
                ),
                 string(
                    name:   'Parm_ISPW_Stg_Level', 
                    value:  'STG'
                ),
                string(
                    name:   'Parm_ISPW_Release', 
                    value:  "${ISPW_Release}"
                )                
            ], 
            waitForStart: true
        )
    }
}

stage("Send Email")
{
    steps{
    def mailRecipients = "manoj_singh@bmc.com"
            
            // Email
            emailext subject: '$DEFAULT_SUBJECT',
                        body: '$DEFAULT_CONTENT',
                        //body: '$DEFAULT_CONTENT',
                        replyTo: '$DEFAULT_REPLYTO',
                        //attachmentsPattern: 'reports/*.zip',
                        to: "${mailRecipients}"
    }
} */

}
}