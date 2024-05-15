using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerExtraHost")]
    [OutputType(typeof(ContainerBuilder))]
    public class SetContainerExtraHostCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Hostname { get; set; }

        [Parameter(Position = 2, Mandatory = true)]
        public string IpAddress { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithExtraHost = Builder.WithExtraHost(Hostname, IpAddress);
            WriteObject(builderWithExtraHost);
        }
    }
}