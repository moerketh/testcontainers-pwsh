using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerResourceMapping")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerResourceMappingCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Source { get; set; }

        [Parameter(Position = 2, Mandatory = true)]
        public string Target { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithResourceMapping = Builder.WithResourceMapping(Source, Target);
            WriteObject(builderWithResourceMapping);
        }
    }
}