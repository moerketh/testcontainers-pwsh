using DotNet.Testcontainers.Containers;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsLifecycle.Stop, "Container")]
    [OutputType(typeof(IContainer))]
    public class StopContainer : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public IContainer Container { get; set; }

        protected override void ProcessRecord()
        {
            Container.StopAsync().GetAwaiter().GetResult();
            WriteObject(Container);
        }
    }
}