using System.Management.Automation;
using Testcontainers.RabbitMq;

namespace TestcontainersPwsh.RabbitMq
{
    [Cmdlet(VerbsCommon.New, "RabbitMqContainer")]
    [OutputType(typeof(RabbitMqContainer))]
    public class NewRabbitMqContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new RabbitMqBuilder().Build();
            WriteObject(container);
        }
    }
}
