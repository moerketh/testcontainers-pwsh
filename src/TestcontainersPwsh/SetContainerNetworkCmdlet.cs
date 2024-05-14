using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerNetwork")]
    public class SetContainerNetworkCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string NetworkName { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithNetwork = Builder.WithNetwork(NetworkName);
            WriteObject(builderWithNetwork);
        }
    }
}