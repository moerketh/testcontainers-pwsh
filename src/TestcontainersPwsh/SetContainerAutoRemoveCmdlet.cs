using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerAutoRemove")]
    public class SetContainerAutoRemoveCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public bool AutoRemove { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithAutoRemove = Builder.WithAutoRemove(AutoRemove);
            WriteObject(builderWithAutoRemove);
        }
    }
}