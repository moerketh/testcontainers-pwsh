using System.Management.Automation;
using Testcontainers.Kusto;

namespace TestcontainersPwsh.Kusto
{
    [Cmdlet(VerbsCommon.New, "KustoContainer")]
    [OutputType(typeof(KustoContainer))]
    public class NewKustoContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new KustoBuilder().Build();
            WriteObject(container);
        }
    }
}
