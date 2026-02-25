# Basic Azure PowerShell and CLI Scripts

This repository is a collection of simple PowerShell &amp; Azure CLI scripts that were
created while learning to automate Azure resource creation. The files are intentionally
very small so you can read them and reuse the pieces that interest you.

**Structure:**

- `01-rg.ps1` through `10-app.ps1` – scripts using the `Az` PowerShell module.
- `11-azcli.ps1` through `18-webapp.ps1` – equivalent tasks executed with the
  `az` command‑line tool from within PowerShell.
- `improved/` – parameterized, documented versions of each script suitable for
  sharing or using in automation pipelines. See the comments at the top of each
  file for usage examples.

## How to use

1. **Authenticate with Azure**

   You must be signed in before the scripts can create resources. There are two
   common methods depending on whether you prefer the PowerShell module or the
   CLI:
   - PowerShell (Az module):
     ```powershell
     Connect-AzAccount
     # If your account has access to multiple subscriptions you can list and
     # select one:
     Get-AzSubscription          # show subscriptions
     Set-AzContext -SubscriptionId <id-or-name>
     ```
   - Azure CLI (works inside PowerShell or any shell):
     ```powershell
     az login
     az account show              # view current subscription
     az account set -s <name-or-id>
     ```

   You can also switch clouds using `Connect-AzAccount -Environment` or
   `az cloud set` if you're targeting Azure Government, China, etc.

2. Change to this directory:

   ```powershell
   cd path\to\sanilcli
   ```

3. Run individual scripts. The original versions simply set a handful of variables
   and call the appropriate cmdlets; you can edit the variables in place. The
   `improved` versions accept parameters, for example:

   ```powershell
   .\improved\01-rg.ps1 -ResourceGroupName "my-rg" -Location "eastus"
   ```

   or, if running the CLI variants:

   ```powershell
   .\improved\12-azcli-vnet.ps1 -ResourceGroupName "my-rg" -VNetName "my-vnet"
   ```

4. The scripts are numbered for convenience but are independent; run the ones
   you need in any order. You can also reuse or copy the commands into your own
   automation.

## Suggestions for improvement

- Parameterize the other files (see `improved` folder for examples).
- Add error checking and idempotency (already done in `improved` versions).
- Consider converting these one‑liners into functions or modules for reuse.
- Add Azure policy or ARM/Bicep templates if you prefer declarative definitions.

Feel free to fork this repo, adapt the scripts, and share back enhancements. The
`improved` directory is a starting point for anyone who wants to make the samples
more production‑ready.
