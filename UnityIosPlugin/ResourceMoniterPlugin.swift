import Foundation
import MachO

public class ResourceMoniterPlugin {
    
    // MARK: - RAM Usage
    
    public func ramUsage() -> Double {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size)/4
        let kerr: kern_return_t = withUnsafeMutablePointer(to: &info) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
            }
        }
        if kerr == KERN_SUCCESS {
            let usedBytes = Double(info.resident_size)
            return usedBytes / (1024 * 1024) // Convert to MB
        } else {
            return 0
        }
    }
    
    // MARK: - CPU Usage
    
    public func cpuUsage() -> Double {
        let HOST_CPU_LOAD_INFO_COUNT = MemoryLayout<host_cpu_load_info>.stride/MemoryLayout<integer_t>.stride
        var cpuLoadInfo = host_cpu_load_info()
        var count = mach_msg_type_number_t(HOST_CPU_LOAD_INFO_COUNT)
        let result = withUnsafeMutablePointer(to: &cpuLoadInfo) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, $0, &count)
            }
        }
        if result != KERN_SUCCESS {
            print("Error fetching CPU usage")
            return 0.0
        }
        
        let user = Float(cpuLoadInfo.cpu_ticks.0 - cpuLoadInfo.cpu_ticks.1)
        let system = Float(cpuLoadInfo.cpu_ticks.2 - cpuLoadInfo.cpu_ticks.3)
        let idle = Float(cpuLoadInfo.cpu_ticks.3)
        let total = user + system + idle
        
        let usage = ((user + system) / total) * 100.0
        return Double(usage)
    }
}

