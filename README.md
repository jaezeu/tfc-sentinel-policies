# Terraform Cloud Sentinel Policies

This repository contains Sentinel policies for Terraform Cloud/Enterprise runs.

## Policies included

### 1) `required-tags.sentinel`
Ensures managed resources being created or updated include the required tags:

- `env`
- `app`
- `costcenter`

How it works:
- Reads plan changes from `tfplan/v2`.
- Selects managed resources with `create` or `update` actions.
- Checks only resources that expose a `tags` attribute.
- Fails if any required tag is missing.
- Prints detailed violations to help with remediation.

Current behavior:
- Enforcement intent: **strict** (policy must pass).
- In `sentinel.hcl`, this policy is configured as `hard-mandatory`.

---

### 2) `cost-limits.sentinel`
Limits monthly cost increase per run.

How it works:
- Reads `delta_monthly_cost` from `tfrun.cost_estimate`.
- Defaults missing estimates to `0`.
- Converts the value to a number and compares it to a threshold.

Configured threshold:
- `max_monthly_increase = 10`

Interpretation:
- Passes when monthly increase is less than or equal to **$10**.

Current behavior:
- In `sentinel.hcl`, this policy is configured as `advisory`.
- Advisory policies do not block applies, but they report violations.

## Policy set configuration

`sentinel.hcl` defines enforcement levels:

- `required-tags` → `hard-mandatory`
- `cost-limits` → `advisory`

## Repository structure

- `required-tags.sentinel` — required tag validation
- `cost-limits.sentinel` — cost delta threshold check
- `sentinel.hcl` — policy registration and enforcement levels

## Usage in Terraform Cloud / Terraform Enterprise

1. Create or open a Policy Set in your organization.
2. Connect this repository (VCS-backed policy set) or upload policy files.
3. Ensure all three files are included:
	- `required-tags.sentinel`
	- `cost-limits.sentinel`
	- `sentinel.hcl`
4. Attach the policy set to target workspaces.
5. Run a plan and review policy check results.

## Expected outcomes

- A run with missing required tags fails policy checks due to `required-tags` (hard-mandatory).
- A run increasing monthly cost by more than $10 triggers `cost-limits` as advisory.

## Customization

- To change required tags, edit `required_tags` in `required-tags.sentinel`.
- To change the monthly cost threshold, edit `max_monthly_increase` in `cost-limits.sentinel`.
- To change blocking behavior, update `enforcement_level` values in `sentinel.hcl`.