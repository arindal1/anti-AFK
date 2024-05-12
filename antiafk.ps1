# Get parameters
param (
    [int]$IdleThreshold,
    [string]$MouseMoveRange,
    [string]$PunchCharacters
)

# Function to simulate mouse movement
function Move-Mouse {
    while ($true) {
        Start-Sleep -Seconds (Get-Random -Minimum 5 -Maximum 16)
        $dx = Get-Random -Minimum ($MouseMoveRange.Split(',')[0]) -Maximum ($MouseMoveRange.Split(',')[1])
        $dy = Get-Random -Minimum ($MouseMoveRange.Split(',')[0]) -Maximum ($MouseMoveRange.Split(',')[1])
        [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point((([System.Windows.Forms.Cursor]::Position).X + $dx), (([System.Windows.Forms.Cursor]::Position).Y + $dy))
    }
}

# Function to punch characters
function Punch-Characters {
    while ($true) {
        Start-Sleep -Seconds 1
        if ($idle_time -ge $IdleThreshold) {
            Add-Type -AssemblyName System.Windows.Forms
            $randomChar = -join ($PunchCharacters.ToCharArray() | Get-Random -Count 1)
            [System.Windows.Forms.SendKeys]::SendWait($randomChar)
            $idle_time = 0
        } else {
            $idle_time++
        }
    }
}

# Trap Ctrl+C to exit script
trap {
    exit
}

# Initialize idle time
$idle_time = 0

# Start mouse movement in background
Start-Job -ScriptBlock { Move-Mouse } | Out-Null

# Start punching characters in background
Start-Job -ScriptBlock { Punch-Characters } | Out-Null

# Wait for Ctrl+C to terminate script
while ($true) {
    Start-Sleep -Seconds 1
}
