using System.Management.Automation;
using Testcontainers.Minio;

namespace TestcontainersPwsh.Minio
{
    [Cmdlet(VerbsCommon.New, "MinioContainer")]
    [OutputType(typeof(MinioContainer))]
    public class NewMinioContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new MinioBuilder().Build();
            WriteObject(container);
        }
    }
}
