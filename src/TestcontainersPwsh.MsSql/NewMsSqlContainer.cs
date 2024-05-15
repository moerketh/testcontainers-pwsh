using System.Management.Automation;
using Testcontainers.MsSql;

namespace TestcontainersPwsh.MsSql
{
    [Cmdlet(VerbsCommon.New, "MsSqlContainer")]
    [OutputType(typeof(MsSqlContainer))]
    public class NewMsSqlContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new MsSqlBuilder().Build();
            WriteObject(container);
        }
    }
}
