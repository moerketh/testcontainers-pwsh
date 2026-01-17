using System.Management.Automation;
using Testcontainers.Azurite;

namespace TestcontainersPwsh.Azurite
{
    [Cmdlet(VerbsCommon.New, "AzuriteContainer")]
    [OutputType(typeof(AzuriteContainer))]
    public class NewAzuriteContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new AzuriteBuilder().Build();
            WriteObject(container);
        }
    }
}
