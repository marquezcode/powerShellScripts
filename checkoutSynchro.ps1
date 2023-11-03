# Declare lastEvent variable
$global:lastNameCopy = "start"
$global:rename = $false
$global:newName = ""

# Define source and destination paths
$sourcePath = "C:\Users\gerar\Desktop\SYNCHRO\1"
$mirrorPath = "C:\Users\gerar\Desktop\SYNCHRO\2"



# Function to copy the source folder to the destination
function createObject{
    param (
        [string]$itemPath,
        [string]$itemName
    )
    $item = Get-Item -Path $itemPath
    $global:millisNow = [System.Math]::Round((Get-Date).Ticks / 10000)
    $millis = $global:millisNow - $global:millisLast
    if ( $global:lastNameCopy -ne $itemName ){
        Write-Host $global:eventName
        # Construct the full destination path, including the folder you want to delete
        $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
        Write-Host "relativePath: $relativePath"
        $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
        Write-Host "fullMirrorPath: $fullMirrorPath"
        $destinationPath = $fullMirrorPath.Substring(0, $fullMirrorPath.Length - $item.Name.Length)
        Write-Host "destinationPath: $destinationPath"
        Copy-Item -Path $itemPath -Destination $destinationPath
        $global:lastNameCopy = $itemName
        $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
        Write-Host "- $item.Name created successfully."
        Write-Host " "
    } elseif ( $millis -gt 500 ){
        Write-Host "$global:eventName $millis"
        # Construct the full destination path, including the folder you want to delete
        $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
        Write-Host "relativePath: $relativePath"
        $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
        Write-Host "fullMirrorPath: $fullMirrorPath"
        $destinationPath = $fullMirrorPath.Substring(0, $fullMirrorPath.Length - $item.Name.Length)
        Write-Host "destinationPath: $destinationPath"
        Copy-Item -Path $itemPath -Destination $destinationPath
        $global:lastNameCopy = $itemName
        $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
        Write-Host "- $item.Name created successfully."
        Write-Host " "
    }  
}

function copyObject{
    param (
        [string]$itemPath,
        [string]$itemName
    )
    $item = Get-Item -Path $itemPath
    $global:millisNow = [System.Math]::Round((Get-Date).Ticks / 10000)
    $millis = $global:millisNow - $global:millisLast
    # check for change events for folders. If folder and change event = true, then it should not copy the folder,(allowing the events from the files inside, if exist, to let them copy each one individually)
    elseif ( $global:lastNameCopy -ne $itemName ){
        if (-not $item.PSIsContainer ){
            Write-Host $global:eventName 
            # Construct the full destination path, including the folder you want to delete
            $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
            Write-Host "relativePath: $relativePath"
            $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
            Write-Host "fullMirrorPath: $fullMirrorPath"
            $destinationPath = $fullMirrorPath.Substring(0, $fullMirrorPath.Length - $item.Name.Length)
            Write-Host "destinationPath: $destinationPath"
            Copy-Item -Path $itemPath -Destination $destinationPath
            $global:lastNameCopy = $itemName
            $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
            Write-Host "- $item.Name saved changes successfully."
            Write-Host " "
        } elseif ( $millis -gt 500 ){
            Write-Host "$global:eventName $millis"
            # Construct the full destination path, including the folder you want to delete
            $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
            Write-Host "relativePath: $relativePath"
            $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
            Write-Host "fullMirrorPath: $fullMirrorPath"
            $destinationPath = $fullMirrorPath.Substring(0, $fullMirrorPath.Length - $item.Name.Length)
            Write-Host "destinationPath: $destinationPath"
            Copy-Item -Path $itemPath -Destination $destinationPath
            $global:lastNameCopy = $itemName
            $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
            Write-Host "- $item.Name saved changes successfully."
            Write-Host " "
        }  
    }
}


function deleteObject{
    param (
        [string]$itemPath,
        [string]$itemName
    )
    $global:millisNow = [System.Math]::Round((Get-Date).Ticks / 10000)
    $millis = $global:millisNow - $global:millisLast
    if ( $global:lastNameCopy -ne $itemName ){
        Write-Host $global:eventName
        # Construct the full destination path, including the folder you want to delete
        $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
        Write-Host "relativePath: $relativePath"
        $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
        Write-Host "fullMirrorPath: $fullMirrorPath"
        Remove-Item -Path $fullMirrorPath
        $global:lastNameCopy = $itemName
        $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
        Write-Host "- $item.Name deleted successfully."
        Write-Host " "
    } elseif ( $millis -gt 500 ){
        Write-Host "$global:eventName $millis"
        # Construct the full destination path, including the folder you want to delete
        $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
        Write-Host "relativePath: $relativePath"
        $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
        Write-Host "fullMirrorPath: $fullMirrorPath"
        Remove-Item -Path $fullMirrorPath
        $global:lastNameCopy = $itemName
        $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
        Write-Host "- $item.Name deleted successfully."
        Write-Host " "
    }
}


function renameObject{
    param (
        [string]$itemPath,
        [string]$itemName,
        [string]$oldPath
    )
    $item = Get-Item -Path $itemPath
    $olditem = Get-Item -Path $oldPath
    $global:millisNow = [System.Math]::Round((Get-Date).Ticks / 10000)
    Write-Host "Renamed event $oldPath"
    $millis = $global:millisNow - $global:millisLast
    if ( $global:lastNameCopy -ne $itemName ){
        # Construct the full destination path, including the folder you want to delete
        $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
        $oldRelativePath = $oldPath.Substring($sourcePath.Length, $oldPath.Length - $sourcePath.Length)
        Write-Host "relativePath: $relativePath"
        $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
        $oldFullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $oldRelativePath
        Write-Host "fullMirrorPath: $fullMirrorPath"
        $destinationPath = $fullMirrorPath.Substring(0, $fullMirrorPath.Length - $item.Name.Length)
        Write-Host "destinationPath: $destinationPath"
        Rename-Item -Path $oldfullMirrorPath -NewName $item.Name
        $global:lastNameCopy = $itemName
        $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
        Write-Host "- $item.Name renamed successfully."
        Write-Host " "
    } elseif ( $millis -gt 500 ){
        # Construct the full destination path, including the folder you want to delete
        $relativePath = $itemPath.Substring($sourcePath.Length, $itemPath.Length - $sourcePath.Length)
        $oldRelativePath = $oldPath.Substring($sourcePath.Length, $oldPath.Length - $sourcePath.Length)
        Write-Host "relativePath: $relativePath"
        $fullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $relativePath
        $oldFullMirrorPath = Join-Path -Path $mirrorPath -ChildPath $oldRelativePath
        Write-Host "fullMirrorPath: $fullMirrorPath"
        $destinationPath = $fullMirrorPath.Substring(0, $fullMirrorPath.Length - $item.Name.Length)
        Write-Host "destinationPath: $destinationPath"
        Rename-Item -Path $oldfullMirrorPath -NewName $destinationPath
        $global:lastNameCopy = $itemName
        $global:millisLast = [System.Math]::Round((Get-Date).Ticks / 10000)
        Write-Host "- $item.Name renamed successfully."
        Write-Host " "
    } 
}

try {
    Write-Host "Script started."
    # Create a FileSystemWatcher to monitor changes in the source directory
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $sourcePath
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true
    
    # Define the event to trigger when a change is detected
    Register-ObjectEvent -InputObject $watcher -EventName "Changed" -Action {   
        $global:eventName = "Changed"
        copyObject -itemPath $Event.SourceEventArgs.FullPath -itemName $Event.SourceEventArgs.Name      
    }
    Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action {   
        $global:eventName = "Created"
        createObject -itemPath $Event.SourceEventArgs.FullPath -itemName $Event.SourceEventArgs.Name     
    }
    Register-ObjectEvent -InputObject $watcher -EventName "Deleted" -Action {  
        $global:eventName = "Deleted"
        deleteObject -itemPath $Event.SourceEventArgs.FullPath -itemName $Event.SourceEventArgs.Name  
    }
    Register-ObjectEvent -InputObject $watcher -EventName "Renamed" -Action {  
        $global:eventName = "Renamed"
        renameObject -itemPath $Event.SourceEventArgs.FullPath -oldPath $Event.SourceEventArgs.OldFullPath-itemName $Event.SourceEventArgs.Name
    }

    Write-Host "Monitoring for changes..."
    while ($true) {
       # Sleep for 0.1 seconds before checking for changes again
       Start-Sleep -Milliseconds 100
        
    }
}
catch [System.IO.DirectoryNotFoundException] {
    Write-Host "Error: The source or destination directory was not found."
}
catch [System.UnauthorizedAccessException] {
    Write-Host "Error: Access to the source or destination directory was denied."
}
catch [System.IO.IOException] {
    Write-Host "Error: The network path was not found. Please check the network connection and destination path."
}
catch {
    Write-Host "An unexpected error occurred: $_"
}
