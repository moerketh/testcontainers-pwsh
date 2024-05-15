using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerNetworkAliases")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerNetworkAliasesCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string[] NetworkAliases { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithNetworkAliases = Builder.WithNetworkAliases(NetworkAliases);
            WriteObject(builderWithNetworkAliases);
        }
    }
}