using System.Management.Automation;
using Testcontainers.PostgreSql;

namespace TestcontainersPwsh.PostgreSql
{
    [Cmdlet(VerbsCommon.New, "PostgreSqlContainer")]
    [OutputType(typeof(PostgreSqlContainer))]
    public class NewPostgreSqlContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new PostgreSqlBuilder().Build();
            WriteObject(container);
        }
    }
}
