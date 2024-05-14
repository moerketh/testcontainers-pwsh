using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerPrivileged")]
    public class SetContainerPrivilegedCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public bool Privileged { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithPrivileged = Builder.WithPrivileged(Privileged);
            WriteObject(builderWithPrivileged);
        }
    }
}