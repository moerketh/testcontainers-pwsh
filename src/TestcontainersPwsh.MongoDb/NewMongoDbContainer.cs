using System.Management.Automation;
using Testcontainers.MongoDb;

namespace TestcontainersPwsh.MongoDb
{
    [Cmdlet(VerbsCommon.New, "MongoDbContainer")]
    [OutputType(typeof(MongoDbContainer))]
    public class NewMongoDbContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new MongoDbBuilder().Build();
            WriteObject(container);
        }
    }
}
