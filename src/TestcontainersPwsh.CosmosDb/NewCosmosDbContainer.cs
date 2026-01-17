using System.Management.Automation;
using Testcontainers.CosmosDb;

namespace TestcontainersPwsh.CosmosDb
{
    [Cmdlet(VerbsCommon.New, "CosmosDbContainer")]
    [OutputType(typeof(CosmosDbContainer))]
    public class NewCosmosDbContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new CosmosDbBuilder().Build();
            WriteObject(container);
        }
    }
}
