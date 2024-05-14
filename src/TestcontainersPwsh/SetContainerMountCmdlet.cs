using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Configurations;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerMount")]
    public class SetContainerMountCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public IMount Mount { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithMount = Builder.WithMount(Mount);
            WriteObject(builderWithMount);
        }
    }
}