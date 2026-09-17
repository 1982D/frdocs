# How to store FusionReactor logs in a persistent location using Docker volumes

Your FusionReactor logs can be stored in a persistent location using Docker volumes by following the instructions below.

## Define your local log and archive folders

Find the default instance log/archive folder locations in the instance’s **Log Settings**, under **Log Engine Settings** (image 1) and **Log Archive Settings** (image 2). 

!!! info
    For ephemeral instances these folders are located within the container, so they cannot be changed to a location outside of the container via these fields.

![!Screenshot](/Troubleshooting/images/logsettings1.png)

![!Screenshot](/Troubleshooting/images/logsettings2.png)

With Docker volumes you can specify and mount any persistent local folders as the folders used for logs and archived logs inside your container, in your docker-compose.yaml file. 

Docker will check if the local folders you state in your docker-compose.yaml file exist when you run the file, and if they do not, it will also create the local folders for you when the file is run. In doing so, you can create uniquely named local log and archive folders for each container.


If necessary, you can also manually create and name the local folders that you wish to use for persistent log storage.

!!! warning
    You must ensure that each instance is writing to unique log and archive folders. If multiple instances are pointing to the same log and archive folders, this can cause logging issues.


### Example

In the example below, a local **logs** and **archive** folder have been named under Volumes, which will be created and located in the same directory as the docker-compose.yaml file. 

![!Screenshot](/Troubleshooting/images/example.png)

## Configure FusionReactor logging with Docker-Compose

Bring up your container with the edited docker-compose.yaml file containing the specified log and archive volumes, and the instance will now write your FusionReactor logs and archived logs to your persistent local folders outside of its container. 

___

!!! question "Need more help?"
    Contact support in the chat bubble and let us know how we can assist. 
