# PVE_API_Wrapper
This is a wrapper written in bash that will interact with Proxmox VE's RESTful API.  
It is designed that you should be able to copy and paste the URL present in the documentation directly into the CLI.  
  
Be sure to change the following variables before using (found at the beginning of the script):  
  
PROXURL="https://URLGOESHERE:8006"  
TARGETNODE=""  
USERNAME=""  
  
  
This script has a very long train of if/else statements to find and replace the various variables present in the PVE API Documentation. If you can figure out a better way to handle this, please go ahead and make the changes.
