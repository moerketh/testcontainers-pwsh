using System.Management.Automation;
using Testcontainers.MySql;

namespace TestcontainersPwsh.MySql
{
    [Cmdlet(VerbsCommon.New, "MySqlContainer")]
    [OutputType(typeof(MySqlContainer))]
    public class NewMySqlContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new MySqlBuilder().Build();
            WriteObject(container);
        }
    }
}
