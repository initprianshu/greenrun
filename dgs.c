#include <stdio.h>
#include <netdb.h>
#include <netinet/in.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <arpa/inet.h>
#include <fcntl.h>
#include <unistd.h>
#define MAX 80
#define PORT 8080



int main()
{
    int sockfd, connfd, len;
    struct sockaddr_in servaddr,cli;
    int SenderAddrSize = sizeof (cli);
   
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
    servaddr.sin_addr.s_addr = INADDR_ANY;
    servaddr.sin_port = htons(PORT);
   
    // created socket to given IP and verification
   if ((bind(sockfd, (struct sockaddr*) &servaddr, sizeof(servaddr))) != 0) {
        printf("socket bind failed...\n");
        exit(0);
    }
    else
        printf("Socket successfully binded..\n");

    char buff[MAX];
    int n;
    while(1) {
        bzero(buff, MAX);
   
        recvfrom(sockfd,buff,sizeof(buff),MSG_WAITALL,(struct sockaddr*)&cli,&SenderAddrSize);
        printf("From client: %s", buff);
        printf("To client : ");
        bzero(buff, MAX);
        n = 0;
        //while ((buff[n++] = getchar()) != '\n');
        fgets(buff,MAX,stdin);
   
        sendto(sockfd,buff,sizeof(buff),0,(struct sockaddr*)&cli,sizeof(cli));
        printf("MSGG SENT\n");
       }
  
    close(sockfd);
}
