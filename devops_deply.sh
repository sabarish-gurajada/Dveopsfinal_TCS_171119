#!/bin/bash
# Bash Menu Script Example

#Variable declaration
DIR="/home/sabarishgurajada_cloud/"
IMAGE="myfinaltcsdevopsss"
VERSION="latest"
PROJECTID="tcsdevopsathon"
TAG="gcr.io/$PROJECTID/$IMAGE:$VERSION"


Get_Repo()
{
    echo "Please enter repository name for clone"
    read repository
    echo "You can connect to $repository in your github"
    echo ""
    echo ""
NDIR=$DIR/$repository
}



####Menu for deployment
######Do clone with guthub

Clone_Github()
{
       cd $HOME
echo "Cloning in progress... Please wait"
sleep 2
git clone https://github.com/sabarish-gurajada/$repository.git
echo "Cloned Successfully with repository $repository"
echo ""
echo ""
}
 
			  #Function to build image from github 
			  Build_Image()
			  {
			  cd $NDIR
               echo "Building Image.... please wait this may take few minutes"
			  docker build -t $IMAGE .
			  echo "Build completed successfully"
              echo ""
              echo ""
			  }
			  
				#Function to tag image 
				Tag_Image()
				{
					cd $NDIR
					echo "Tagging in progress...."
					docker tag $IMAGE $TAG
					echo "Image tagging completed"
				}
				
				#Function to push image
				Push_Image()
				{
				  echo "Docker image push in progress...."
				  cd $NDIR
				  docker push $TAG
				  echo "Docker pushed successfully"
				}
				
				Pull_Image()
				{
				  cd $NDIR
				  echo "Docker pull in progress...."
				  docker pull $TAG
			      echo "Docker pulled successfully......"
                }
				
				Deploy_Image()
				{
				  cd $NDIR
				  echo "We are deploying using Kubectl....This may take minutes before completion"
                  echo "Deleting old deployements and services...."
                  kubectl delete deployment.apps/tcsdevops2 service/tcsdevops2
                  echo "old entries removed succesfully"
                  echo "creating new deployments"
				  kubectl create -f $HOME/deployment.yaml
				  kubectl create -f $HOME/service.yaml
				  echo "Generating Ipaddress... please wait it may take around 6-7 minutes"
                  sleep 200
                  echo "Container created successfully, waiting for ipaddresss"
                  sleep 200
                  echo "Please check whether generated ipaddress is working if not  try 'kubectl logs <podname>'"
                  kubectl get all | grep "80:30592" | awk '{print $4}'
				 }
All()
{
    cd $DIR
    Get_Repo
    Clone_Github
    Build_Image
    Tag_Image
    Push_Image
    Pull_Image
    Deploy_Image

}

PS3='Please enter your choice: '
options=("Get Repo" "Clone Github" "Build image" "Tag Image" "Push Image" "Pull Image" "Deploy Image" "All" "Quit")
select opt in "${options[@]}"
do
    case $opt in
           "Get Repo")
				Get_Repo
				;;
			"Clone Github")
				Clone_Github
				;;
			"Build image")
				Build_Image
				;;
			"Tag Image")
				Tag_Image
				;;
			"Push Image")
                Push_Image
            ;;
			"Pull Image")
                Pull_Image
            ;;
			"Deploy Image")
                Deploy_Image
            ;;
            "All")
                All
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option";;
    esac
done