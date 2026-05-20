import os
from dotenv import load_dotenv

load_dotenv()

# UDIDs dos dispositivos — definidos no .env
CIELO_DX8000_UDID = os.getenv("CIELO_DX8000_UDID", "emulator-5554")
REDE_L400_UDID = os.getenv("REDE_L400_UDID", "emulator-5554")
REDE_N960K_UDID = os.getenv("REDE_N960K_UDID", "emulator-5554")
GETNET_DX8000_UDID = os.getenv("GETNET_DX8000_UDID", "emulator-5554")
GETNET_P2_UDID = os.getenv("GETNET_P2_UDID", "emulator-5554")
GETNET_P3_UDID = os.getenv("GETNET_P3_UDID", "emulator-5554")
STONE_UDID = os.getenv("STONE_UDID", "emulator-5554")
PAGBANK_A7_1_UDID = os.getenv("PAGBANK_A7_1_UDID", "emulator-5554")
PAGBANK_A11_UDID = os.getenv("PAGBANK_A11_UDID", "emulator-5554")
FISERV_UDID = os.getenv("FISERV_UDID", "emulator-5554")
SIPAG_P2_UDID = os.getenv("SIPAG_P2_UDID", "emulator-5554")
SIPAG_X990_UDID = os.getenv("SIPAG_X990_UDID", "emulator-5554")
SIPAG_DX8000_UDID = os.getenv("SIPAG_DX8000_UDID", "emulator-5554")
SAFRA_UDID = os.getenv("SAFRA_UDID", "emulator-5554")
MERCADOPAGO_UDID = os.getenv("MERCADOPAGO_UDID", "emulator-5554")
QUICKPAY_A910_UDID = os.getenv("QUICKPAY_A910_UDID", "emulator-5554")
CLOVER_UDID = os.getenv("CLOVER_UDID", "emulator-5554")

CLIENT_ID = os.getenv("CLIENT_ID", "")
CLIENT_SECRET = os.getenv("CLIENT_SECRET", "")
