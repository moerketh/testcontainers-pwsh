using DotNet.Testcontainers.Containers;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsLifecycle.Start, "Container")]
    [OutputType(typeof(IContainer))]
    public class StartContainer : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public IContainer Container { get; set; }

        protected override void ProcessRecord()
        {
            Container.StartAsync().GetAwaiter().GetResult();
            WriteObject(Container);
        }
    }
}