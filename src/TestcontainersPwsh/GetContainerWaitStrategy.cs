using System.Management.Automation;
using DotNet.Testcontainers.Builders;
using System;
using DotNet.Testcontainers.Configurations;

namespace TestcontainersPwsh
{
    [Cmdlet(VerbsCommon.Get, "ContainerWaitStrategy")]
    [OutputType(typeof(IWaitForContainerOS))]
    public class GetContainerWaitStrategyCmdlet : Cmdlet
    {
        [Parameter()]
        public SwitchParameter ForWindowsContainer { get; set; }

        [Parameter()]
        public SwitchParameter ForUnixContainer { get; set; }

        protected override void BeginProcessing()
        {
            //Not using ParameterSet, handle exception logic here to have more control over the error message.
            if (ForWindowsContainer.IsPresent && ForUnixContainer.IsPresent)
            {
                ThrowTerminatingError(
                    new ErrorRecord(
                        new ArgumentException("Cannot process command because both -ForWindowsContainer and -ForUnixContainer options were given. Please specify only one."),
                        "AmbiguousParameters",
                        ErrorCategory.InvalidArgument,
                        null));
            }
            else if (!ForWindowsContainer.IsPresent && !ForUnixContainer.IsPresent)
            {
                ThrowTerminatingError(
                    new ErrorRecord(
                        new ArgumentException("Cannot process command because neither -ForWindowsContainer nor -ForUnixContainer options were given. Please specify one."),
                        "MissingParameters",
                        ErrorCategory.InvalidArgument,
                        null));
            }
        }

        protected override void ProcessRecord()
        {
            if (ForWindowsContainer.IsPresent)
            {
                var strategy = Wait.ForWindowsContainer();
                WriteObject(strategy);
            }
            else if (ForUnixContainer.IsPresent)
            {
                var strategy = Wait.ForUnixContainer();
                WriteObject(strategy);
            }
        }
    }
}
