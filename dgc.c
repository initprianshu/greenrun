#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#define MAX 80
#define PORT 8080
#define SA struct sockaddr

   
int main()
{
    int sockfd, connfd;
    struct sockaddr_in servaddr,cli;
    int SenderAddrSize = sizeof (servaddr);
   
    // socket create and verification
    sockfd = socket(AF_INET, SOCK_DGRAM, 0);
    if (sockfd == -1) {
        printf("socket creation failed...\n");
        exit(0);
    }
    else
        printf("Socket successfully created..\n");
    bzero(&servaddr, sizeof(servaddr));
   
   // assign IP, PORT
    servaddr.sin_family = AF_INET;
    servaddr.sin_addr.s_addr = inet_addr("127.0.0.1");
    servaddr.sin_port = htons(PORT);
  
    char buff[MAX];
    int n;
   while(1) {
        bzero(buff, sizeof(buff));
        printf("Enter the string : ");
        n = 0;
        //while ((buff[n++] = getchar()) != '\n');
        fgets(buff,MAX,stdin);
        sendto(sockfd,buff,sizeof(buff),0,(struct sockaddr*)&servaddr,sizeof(servaddr));
        bzero(buff, sizeof(buff));
        int rec=recvfrom(sockfd,buff,sizeof(buff),MSG_WAITALL,(struct sockaddr*)&servaddr,&SenderAddrSize);
        printf("From Server : %s", buff);
        if ((strncmp(buff, "exit", 4)) == 0) {
            printf("Client Exit...\n");
            break;
        }
   }

    // close the socket
    close(sockfd);
}
