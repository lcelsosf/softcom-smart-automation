import subprocess

from robot.libraries.BuiltIn import BuiltIn


class logcatlibrary:
    def clear_logcat(self):
        """Clears the Android logcat buffer for the current device."""
        udid = BuiltIn().get_variable_value("${DEVICE_UDID}", "emulator-5554")
        try:
            subprocess.run(
                ["adb", "-s", udid, "logcat", "-c"],
                check=True,
                capture_output=True,
                timeout=15,
            )
        except subprocess.TimeoutExpired:
            BuiltIn().log(f"adb logcat -c timed out for device {udid}, skipping.", level="WARN")
