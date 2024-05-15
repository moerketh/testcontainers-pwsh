using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerEnvironment")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerEnvironmentCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Name { get; set; }

        [Parameter(Position = 2, Mandatory = true)]
        public string Value { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithEnvironment = Builder.WithEnvironment(Name,Value);
            WriteObject(builderWithEnvironment);
        }
    }
}