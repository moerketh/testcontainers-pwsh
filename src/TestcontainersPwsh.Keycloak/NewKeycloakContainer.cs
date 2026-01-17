using System.Management.Automation;
using Testcontainers.Keycloak;

namespace TestcontainersPwsh.Keycloak
{
    [Cmdlet(VerbsCommon.New, "KeycloakContainer")]
    [OutputType(typeof(KeycloakContainer))]
    public class NewKeycloakContainerCmdlet : Cmdlet
    {
        protected override void ProcessRecord()
        {
            var container = new KeycloakBuilder().Build();
            WriteObject(container);
        }
    }
}
