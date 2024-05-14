using DotNet.Testcontainers.Builders;
using DotNet.Testcontainers.Configurations;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerOutputConsumer")]
    public class SetContainerOutputConsumerCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public IOutputConsumer OutputConsumer { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithOutputConsumer = Builder.WithOutputConsumer(OutputConsumer);
            WriteObject(builderWithOutputConsumer);
        }
    }
}