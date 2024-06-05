using Example;
using Grpc.Net.Client;
using UnityEngine;
using Cysharp.Net.Http;
using TMPro;

public class ClientUnity : MonoBehaviour
{
    public TMP_Text txtResult;
    async void Start()
    {
        using var handler = new YetAnotherHttpHandler() { Http2Only = true };
        using var channel = GrpcChannel.ForAddress("http://14.225.9.13:9912", new GrpcChannelOptions() { HttpHandler = handler });
        var greeter = new Greeter.GreeterClient(channel);

        var result = await greeter.SayHelloAsync(new HelloRequest { Name = "Unity" });
        Debug.Log("Received response from gRPC server: " + result.Message);
        txtResult.text = result.Message;
    }
}
