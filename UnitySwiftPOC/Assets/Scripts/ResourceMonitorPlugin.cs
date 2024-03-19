#if UNITY_IOS
using System;
using System.Runtime.InteropServices;

public class ResourceMonitorPlugin
{
    [DllImport("__Internal")]
    private static extern double cpuUsage();

    [DllImport("__Internal")]
    private static extern double ramUsage();

    
    public double GetCPUUsage() => cpuUsage();

    public double GetRAMUsage() => ramUsage();

}

#endif
