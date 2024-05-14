using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsLifecycle.Start, "ContainerBuild")]
    public class StartContainerBuildCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        protected override void ProcessRecord()
        {
            var container = Builder.Build();
            WriteObject(container);
        }
    }
}