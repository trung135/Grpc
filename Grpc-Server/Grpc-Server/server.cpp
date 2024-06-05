#include <iostream>
#include <memory>
#include <string>
#include <grpcpp/grpcpp.h>
#include "example.grpc.pb.h"

using grpc::Server;
using grpc::ServerBuilder;
using grpc::ServerContext;
using grpc::Status;

using example::Greeter;
using example::HelloRequest;
using example::HelloReply;

class GreeterServiceImpl final : public Greeter::Service
{
	Status SayHello(ServerContext* context, const HelloRequest* request,
		HelloReply* reply) override {
		std::string prefix("Hello ");
		reply->set_message(prefix + request->name());
		return Status::OK;
	}
};

void RunServer()
{
	std::string server_address("14.225.9.13:9912");
	GreeterServiceImpl service;

	ServerBuilder builder;
	builder.AddListeningPort(server_address, grpc::InsecureServerCredentials());
	builder.RegisterService(&service);

	std::unique_ptr<Server> server(builder.BuildAndStart());
	std::cout << "Server listening on " << server_address << std::endl;
	server->Wait();
}

int main()
{
	RunServer();
	return 0;
}