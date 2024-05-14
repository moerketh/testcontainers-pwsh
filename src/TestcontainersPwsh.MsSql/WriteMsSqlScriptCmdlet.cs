using System.Management.Automation;
using Testcontainers.MsSql;

namespace TestcontainersPwsh.MsSql
{
    [Cmdlet(VerbsCommunications.Write, "MsSqlScript")]
    public class WriteMsSqlScriptCmdlet : Cmdlet
    {
        [Parameter(Position = 0, Mandatory = true, ValueFromPipeline = true)]
        public MsSqlContainer Container { get; set; }

        [Parameter(Position = 1, Mandatory = true)]
        public string ScriptContent { get; set; }

        protected override void ProcessRecord()
        {
            WriteObject(Container.ExecScriptAsync(ScriptContent).GetAwaiter().GetResult());
        }
    }
}
