# InTune Migration Utility (iOS)

This iOS application was developed to streamline the migration of **corporate-owned** and **BYOD** iOS devices from **Workspace ONE (AirWatch)** to **Microsoft Intune**.

The app supports both ownership scenarios with custom logic, using **App Configurations** to dynamically fetch values such as:
- Device serial number
- AirWatch environment (UAT or Prod)
- User authentication account
- Intune tenant ID
- User's first and last name
- Org Group IDs for COPE vs BYOD flows

---

## 🚀 Features

### 🔐 Secure App Configuration Input
- Accepts all config data via MDM app configuration
- No hardcoded environment or OG values

### 🏢 COPE Device Flow (Corporate-Owned Personally Enabled)
- Validates that **Microsoft Company Portal** is installed
- Uses AirWatch API to remove the device (without wiping user data)
- Programmatically launches Company Portal for Intune enrollment

### 👤 BYOD Flow
- Identifies BYOD ownership
- Removes device from AirWatch (graceful unenrollment)
- No wipe, no data loss
- Instructs user to enroll via Intune MAM flow

### 🔄 One-Button Simplicity
- Single-button UI triggers the correct flow based on ownership
- Uses local & remote checks for user and environment awareness

---

## ⚙️ Requirements

- iOS 13+
- Workspace ONE MDM deployed
- Microsoft Intune tenant and Company Portal configured
- App Config pushed from AirWatch with:
  - `serial_number`
  - `auth_account`
  - `tenant_id`
  - `user_first_name`
  - `user_last_name`
  - `byod_og_id`
  - `cope_og_id`

---

## 🔧 Setup

1. Deploy this app via Workspace ONE with managed app configuration.
2. Ensure Company Portal is available in the App Catalog.
3. Map correct OG IDs based on ownership type.
4. Test device flow (COPE vs BYOD) using known S/Ns.

---

## 🧾 License

Internal use only or MIT (based on your deployment preference)

---

Built by Jonathon Poe for enterprise iOS mobility transitions.
