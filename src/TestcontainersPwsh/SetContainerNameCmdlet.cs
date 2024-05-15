using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerName")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerNameCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Name { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithName = Builder.WithName(Name);
            WriteObject(builderWithName);
        }
    }
}