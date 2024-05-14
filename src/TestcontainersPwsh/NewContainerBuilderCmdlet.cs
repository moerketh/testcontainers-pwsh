using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.New, "ContainerBuilder")]
    public class NewContainerBuilderCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var builder = new ContainerBuilder();
            WriteObject(builder);
        }
    }    
}