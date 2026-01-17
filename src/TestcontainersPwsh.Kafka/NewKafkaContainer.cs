using System.Management.Automation;
using Testcontainers.Kafka;

namespace TestcontainersPwsh.Kafka
{
    [Cmdlet(VerbsCommon.New, "KafkaContainer")]
    [OutputType(typeof(KafkaContainer))]
    public class NewKafkaContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new KafkaBuilder().Build();
            WriteObject(container);
        }
    }
}
