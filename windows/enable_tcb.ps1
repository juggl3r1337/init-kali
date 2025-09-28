Add-Type @"
using System;
using System.Runtime.InteropServices;
public class TokenManip {
    [DllImport("advapi32.dll", SetLastError=true)]
    public static extern bool OpenProcessToken(IntPtr ProcessHandle, UInt32 DesiredAccess, out IntPtr TokenHandle);
    [DllImport("advapi32.dll", SetLastError=true)]
    public static extern bool LookupPrivilegeValue(string lpSystemName, string lpName, out Int64 lpLuid);
    [DllImport("advapi32.dll", SetLastError=true)]
    public static extern bool AdjustTokenPrivileges(IntPtr TokenHandle, bool DisableAllPrivileges, ref TOKEN_PRIVILEGES NewState, UInt32 BufferLength, IntPtr PreviousState, IntPtr ReturnLength);
    [StructLayout(LayoutKind.Sequential)]
    public struct TOKEN_PRIVILEGES {
        public UInt32 PrivilegeCount;
        public Int64 Luid;
        public UInt32 Attributes;
    }
    public const UInt32 TOKEN_ADJUST_PRIVILEGES = 0x0020;
    public const UInt32 TOKEN_QUERY = 0x0008;
    public const UInt32 SE_PRIVILEGE_ENABLED = 0x00000002;
}
"@
$tokenHandle = [IntPtr]::Zero
$success = [TokenManip]::OpenProcessToken([System.Diagnostics.Process]::GetCurrentProcess().Handle, [TokenManip]::TOKEN_ADJUST_PRIVILEGES -bor [TokenManip]::TOKEN_QUERY, [ref]$tokenHandle)
if (-not $success) { Write-Error "OpenProcessToken failed: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"; return }
$luid = [Int64]0
$success = [TokenManip]::LookupPrivilegeValue($null, "SeTcbPrivilege", [ref]$luid)
if (-not $success) { Write-Error "LookupPrivilegeValue failed: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"; return }
$tp = New-Object TokenManip+TOKEN_PRIVILEGES
$tp.PrivilegeCount = 1
$tp.Luid = $luid
$tp.Attributes = [TokenManip]::SE_PRIVILEGE_ENABLED
$success = [TokenManip]::AdjustTokenPrivileges($tokenHandle, $false, [ref]$tp, [UInt32]0, [IntPtr]::Zero, [IntPtr]::Zero)
if (-not $success) { Write-Error "AdjustTokenPrivileges failed: $([System.Runtime.InteropServices.Marshal]::GetLastWin32Error())"; return }
Write-Output "SeTcbPrivilege enabled successfully"
