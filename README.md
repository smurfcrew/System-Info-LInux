# SysInfo.sh


The provided Bash script, sysinfo.sh, is designed to display system information based on a user-provided parameter. It accepts one of three arguments (`sys`, `mem`, or `disk`) and outputs corresponding system details.

## **1. Purpose**
- Provides system information such as hardware details, memory usage, CPU usage, and disk usage.
- It is invoked with a single argument to specify the type of information to display.

## **2. Input**
- The script expects one of the following arguments:
  - `sys`: Displays general system information.
  - `mem`: Displays memory and CPU usage statistics.
  - `disk`: Displays disk usage information.

## **3. Output**
- Based on the input argument, the script outputs:
  - **System Information (`sys`)**:
    - Hostname
    - Uptime
    - Manufacturer, product name, and version
    - Machine type (physical or virtual)
    - Operating system, kernel version, and architecture
    - Processor name
    - Active user
    - Main system IP address
  - **Memory and CPU Usage (`mem`)**:
    - Memory usage percentage
    - Swap usage percentage
    - CPU usage percentage
  - **Disk Usage (`disk`)**:
    - Disk usage percentage for the root filesystem
    - Detailed disk usage for all mounted filesystems

## **4. Key Components**
- **System Information Variables**:
  - Uses commands like `hostname`, `uptime`, `cat`, `lscpu`, and `hostnamectl` to gather system details.
- **Memory and CPU Usage**:
  - Uses the `free` command to calculate memory and swap usage percentages.
  - Uses stat and `top` to calculate CPU usage.
- **Disk Usage**:
  - Uses the `df` command to calculate disk usage for the root filesystem and other mounted filesystems.
- **Functions**:
  - `print_sys_info`: Prints system information.
  - `print_mem_info`: Prints memory and CPU usage.
  - `print_disk_info`: Prints disk usage.
  - `usage`: Displays usage instructions if the script is run incorrectly.
- **Main Script Logic**:
  - Checks if exactly one argument is provided.
  - Uses a `case` statement to call the appropriate function based on the argument (`sys`, `mem`, or `disk`).
  - Displays an error message if an invalid argument is provided.

## **5. Example Usage**
- To display system information:
  ```bash
  ./sysinfo.sh sys
  ```
- To display memory and CPU usage:
  ```bash
  ./sysinfo.sh mem
  ```
- To display disk usage:
  ```bash
  ./sysinfo.sh disk
  ```

## **6. Notes**
- The script assumes the presence of certain files and commands (e.g., `/sys/class/dmi/id/*`, `free`, `df`, `top`), which may not be available on all systems.