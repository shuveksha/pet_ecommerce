Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()
$window = New-Object System.Windows.Forms.Form
$window.Text = "Server Reboot"
$window.Size = New-Object System.Drawing.Size(275, 175)
$window.StartPosition = "CenterScreen"
$window.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("C:\Users\Dell\Desktop\purfect tester - Copy\favicon.ico")

$information = New-Object System.Windows.Forms.Label
$information.Location = New-Object System.Drawing.Point(10, 20)
$information.Size = New-Object System.Drawing.Size(280, 20)
$information.Text = "The server rebooted at 2:14 PM on 16/10/2021."
$window.Controls.Add($information)

$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(85, 75)
$button.Size = New-Object System.Drawing.Size(75, 25)
$button.Text = "OK"
$button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$window.Controls.Add($button)
$button.Add_Click({
	Set-Content .\popup.txt $button.DialogResult
})

$window.Topmost = $true
$result = $window.ShowDialog()