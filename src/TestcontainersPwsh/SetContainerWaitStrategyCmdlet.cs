using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Configurations;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerWaitStrategy")]
    public class SetContainerWaitStrategyCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public IWaitForContainerOS WaitStrategy { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithWaitStrategy = Builder.WithWaitStrategy(WaitStrategy);
            WriteObject(builderWithWaitStrategy);
        }
    }
}