using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerHostname")]
    public class SetContainerHostnameCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Hostname { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithHostname = Builder.WithHostname(Hostname);
            WriteObject(builderWithHostname);
        }
    }
}