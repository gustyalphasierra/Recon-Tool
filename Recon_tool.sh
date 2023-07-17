#!/bin/bash
# Function to check if a command-line tool is installed
check_tool_installed() {
 command -v "$1" >/dev/null 2>&1 || { echo >&2 "Error: $1 is not installed. Aborting."; exit 1; }
}
# Function to perform domain or IP reconnaissance
perform_recon() {
 target="$1"
 output_file="recon_output.txt"
 echo "Starting reconnaissance on target: $target"
 echo "### Performing DNS Lookup (using dig) ###" > "$output_file"
 dig "$target" >> "$output_file"
 echo "### Performing Whois Lookup ###" >> "$output_file"
 whois "$target" >> "$output_file"
 echo "### Performing Nmap Scan ###" >> "$output_file"
 nmap -T4 -F "$target" >> "$output_file"
 echo "### Performing Traceroute ###" >> "$output_file"
 traceroute "$target" >> "$output_file"
 echo "### Performing HTTP Headers Check ###" >> "$output_file"
 curl -I "http://$target" >> "$output_file"
 echo "Reconnaissance completed. Results saved in: $output_file"
}
# Check if required tools are installed
check_tool_installed "dig"
check_tool_installed "whois"
check_tool_installed "nmap"
check_tool_installed "traceroute"
2/2
check_tool_installed "curl"
# Check if target is provided as an argument
if [ -z "$1" ]; then
 echo "Usage: $0 <target>"
 exit 1
fi
# Call the function to perform reconnaissance on the target
perform_recon "$1"
