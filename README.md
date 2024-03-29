# Unity Native Plugin for iOS Resource Monitoring

This repository contains a Unity native plugin implemented in Swift for monitoring CPU and RAM usage on iOS devices.
I am unable to get GPU working.

## Overview

The native plugin consists of two functions:
- `StartTracking`: Starts tracking CPU and RAM usage.
- `StopTracking`: Stops tracking and returns the tracked CPU and RAM usage data.

## Usage

1. Clone this repository to your local machine.
2. Open the Unity project included in the repository.
3. Open Scene Demo_Scene 
6. Build the Unity project for iOS.
7. Open the Xcode project generated by Unity and build it for your iOS device.
8. Run the app on your iOS device to monitor CPU and RAM usage in real-time.

## Native Plugin Implementation

The native plugin is implemented in Swift and uses system APIs to monitor CPU and RAM usage:
- CPU usage is obtained using the `host_statistics` function.
- RAM usage is obtained using the `mach_task_basic_info` struct.
