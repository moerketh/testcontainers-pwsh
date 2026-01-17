@{
    # Severity levels: Error, Warning, Information
    Severity = @('Error', 'Warning')
    
    # Rules to exclude globally
    ExcludeRules = @()
    
    # Include default rules
    IncludeDefaultRules = $true
    
    # Custom rule configurations
    Rules = @{
        PSAvoidGlobalVars = @{
            Enable = $true
        }
        PSAvoidUsingCmdletAliases = @{
            Enable = $true
        }
        PSAvoidUsingWriteHost = @{
            Enable = $false
        }
    }
}
