using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerPortBinding")]
    public class SetContainerPortBindingCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public int HostPort { get; set; }

        [Parameter(Position = 2, Mandatory = true)]
        public int ContainerPort { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithEntrypoint = Builder.WithPortBinding(HostPort,ContainerPort);
            WriteObject(builderWithEntrypoint);
        }
    }
}