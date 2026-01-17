using System.Management.Automation;
using Testcontainers.Redis;

namespace TestcontainersPwsh.Redis
{
    [Cmdlet(VerbsCommon.New, "RedisContainer")]
    [OutputType(typeof(RedisContainer))]
    public class NewRedisContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new RedisBuilder().Build();
            WriteObject(container);
        }
    }
}
