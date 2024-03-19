using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TestPlugin : MonoBehaviour
{
    [SerializeField] Text cpuUsageText;
    [SerializeField] Text ramUsageText;

    [SerializeField] Button btnStartTracking;
    [SerializeField] Button btnEndTracking;


    bool trackingStarted = false;
    ResourceMonitorPlugin resourceMonitor = null;

    void Start()
    {
        resourceMonitor = new ResourceMonitorPlugin();
        btnStartTracking.onClick.AddListener(() =>
        {
            StartTracking();
        });

        btnEndTracking.onClick.AddListener(() =>
        {
            StopTracking();
        });
    }

    void Update()
    {
        if (trackingStarted)
        {
            // Update CPU and RAM usage data
            double cpuUsage = resourceMonitor.GetCPUUsage();
            double ramUsage = resourceMonitor.GetRAMUsage();

            // Display the data in Unity UI
            cpuUsageText.text = "CPU Usage: " + cpuUsage.ToString("F2") + "%";
            ramUsageText.text = "RAM Usage: " + ramUsage.ToString("F2") + " MB";
        }
    }

    public void StartTracking()
    {
        trackingStarted = true;
    }

    public void StopTracking()
    {
        trackingStarted = false;
    }
}
