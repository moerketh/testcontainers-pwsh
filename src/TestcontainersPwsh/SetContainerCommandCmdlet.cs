using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerCommand")]
    public class SetContainerCommandCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string[] Command { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithCommand = Builder.WithCommand(Command);
            WriteObject(builderWithCommand);
        }
    }
}