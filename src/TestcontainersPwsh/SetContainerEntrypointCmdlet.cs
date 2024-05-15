using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerEntrypoint")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerEntrypointCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string[] Entrypoint { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithEntrypoint = Builder.WithEntrypoint(Entrypoint);
            WriteObject(builderWithEntrypoint);
        }
    }
}