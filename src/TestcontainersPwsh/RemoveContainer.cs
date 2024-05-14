using DotNet.Testcontainers.Containers;
using System.Management.Automation;

namespace TestcontainersPwsh
{

    [Cmdlet(VerbsCommon.Remove, "Container")]
    public class RemoveContainer : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public IContainer Container { get; set; }

        protected override void ProcessRecord()
        {
            Container.DisposeAsync().AsTask().Wait();
        }
    }
}