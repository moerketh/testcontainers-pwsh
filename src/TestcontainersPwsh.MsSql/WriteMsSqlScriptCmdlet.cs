using System.Management.Automation;
using DotNet.Testcontainers.Containers;
using Testcontainers.MsSql;

namespace TestcontainersPwsh.MsSql
{
    [Cmdlet(VerbsCommunications.Write, "MsSqlScript")]
    [OutputType(typeof(ExecResult))]
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
