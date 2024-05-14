using DotNet.Testcontainers.Builders;
using System.Management.Automation;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Set, "ContainerImage")]
    public class SetContainerImageCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public ContainerBuilder Builder { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string Image { get; set; }

        protected override void ProcessRecord()
        {
            var builderWithImage = Builder.WithImage(Image);
            WriteObject(builderWithImage);
        }
    }
}