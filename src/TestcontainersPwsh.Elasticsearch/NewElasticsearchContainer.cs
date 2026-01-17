using System.Management.Automation;
using Testcontainers.Elasticsearch;

namespace TestcontainersPwsh.Elasticsearch
{
    [Cmdlet(VerbsCommon.New, "ElasticsearchContainer")]
    [OutputType(typeof(ElasticsearchContainer))]
    public class NewElasticsearchContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new ElasticsearchBuilder().Build();
            WriteObject(container);
        }
    }
}
