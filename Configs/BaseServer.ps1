﻿Configuration BaseServer {

    Import-DSCResource -ModuleName PSDesiredStateConfiguration
    Import-DSCResource -ModuleName xWindowsUpdate

    Node BaseServer {

        # ----- Create Temp Directory on C:
        File Temp {
            DestinationPath = 'c:\Temp'
            Type = 'Directory'
            Ensure = 'Present'
        }

        # ----- Patch : Install Security, Important and Optional patches from MSUpdate
        xWindowsUpdateAgent MSUpdates {
            IsSingleInstance = 'Yes'
            UpdateNow = $True
            Category = @('Security','Important','Optional')
            Source = 'MicrosoftUpdate'
            Notifications = 'Disabled'
        }
    }
}

baseserver -OutputPath 'C:\DSC Configs\' -verbose 

New-DscChecksum -Path 'C:\DSC Configs\BaseServer.mof' -OutPath 'C:\DSC Configs' -Force

