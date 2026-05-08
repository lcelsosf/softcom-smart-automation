import os
import re
from dataclasses import dataclass

import yaml
from dotenv import load_dotenv


@dataclass
class DeviceConfig:
    system_port: int
    appium_server: str
    app_package: str


class devicesconfig:
    def __init__(self):
        load_dotenv()
        devices_yaml = os.path.join(os.path.dirname(__file__), "..", "data", "devices.yaml")
        with open(os.path.normpath(devices_yaml), "r", encoding="utf-8") as f:
            self._data = yaml.safe_load(f)
        self._default_package = self._data.get("default_app_package", "softcom.mobile.smart2")
        self._devices = self._data.get("devices", {})

    def _expand_env_vars(self, raw: str) -> str:
        """Expande ${VAR} usando os.getenv — retorna vazio se variável não definida."""
        def replace(match):
            return os.getenv(match.group(1), "")
        return re.sub(r"\$\{([^}]+)\}", replace, raw)

    def get_device_udid(self, tag: str, default: str = "emulator-5554") -> str:
        device = self._devices.get(tag, {})
        raw = device.get("udid", "")
        udid = self._expand_env_vars(raw)
        return udid if udid else default

    def get_device_config(self, tag: str) -> DeviceConfig:
        device = self._devices.get(tag, {})
        return DeviceConfig(
            system_port=device.get("system_port", 8200),
            appium_server=self._expand_env_vars(device.get("appium_server", os.getenv("APPIUM_SERVER_URL", "http://localhost:4723"))),
            app_package=device.get("app_package", self._default_package),
        )

    def get_keyboard_close_method(self, tag: str) -> str:
        device = self._devices.get(tag, {})
        return device.get("keyboard_close", "hide")

    def get_tag_from_udid(self, udid: str) -> str:
        for tag, device in self._devices.items():
            expanded = self._expand_env_vars(device.get("udid", ""))
            if expanded and expanded == udid:
                return tag
        return "default"
