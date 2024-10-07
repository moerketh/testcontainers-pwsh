using System.Management.Automation;

namespace TestcontainersPwsh.K3s
{
    [Cmdlet(VerbsCommon.New, "K3sContainer")]
    [OutputType(typeof(WrappedK3sContainer))]
    public class NewK3sContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new WrappedK3sContainer();
            WriteObject(container);
        }
    }
}
