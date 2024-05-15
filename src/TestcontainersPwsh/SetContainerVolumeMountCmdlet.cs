using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerVolumeMount")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerVolumeMountCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Source { get; set; }

        [Parameter(Position = 2, Mandatory = true)]
        public string Destination { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithVolumeMount = Builder.WithVolumeMount(Source, Destination);
            WriteObject(builderWithVolumeMount);
        }
    }
}