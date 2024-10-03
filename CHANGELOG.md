## 7.2.0 (2024-10-03)

### Features

* use Claranet "azurecaf" provider bf9e07b

### Documentation

* update README badge to use OpenTofu registry b3a2550
* update README with `terraform-docs` v0.19.0 8207cfc

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.1 c6675ad
* **deps:** update dependency opentofu to v1.8.2 ca4d48c
* **deps:** update dependency pre-commit to v3.8.0 bb73f69
* **deps:** update dependency terraform-docs to v0.19.0 4c38a29
* **deps:** update dependency trivy to v0.54.1 3b58224
* **deps:** update dependency trivy to v0.55.0 359b4e9
* **deps:** update dependency trivy to v0.55.1 c9b39ae
* **deps:** update dependency trivy to v0.55.2 03a96bb
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 7f66849
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 0f3f694
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 cf54501
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.3 3882e0c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.93.0 33b8f86
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 7c5c86c
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 4ebe663
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 b3c233d
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 9ca9127
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 d5bf1e3
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 3e09a98
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 940a9c1
* **deps:** update tools 516398f
* **deps:** update tools ceb6f3a

## 7.1.1 (2024-07-25)


### Bug Fixes

* **AZ-1440:** fix exclusion_configuration variable c68eb30


### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] a42f0dd
* **AZ-1391:** update semantic-release config [skip ci] 28a4697


### Miscellaneous Chores

* **deps:** add renovate.json 751d038
* **deps:** enable automerge on renovate 638f3c9
* **deps:** update dependency opentofu to v1.7.0 7cc3e7a
* **deps:** update dependency opentofu to v1.7.1 978e382
* **deps:** update dependency opentofu to v1.7.2 f22a904
* **deps:** update dependency opentofu to v1.7.3 9c95d27
* **deps:** update dependency pre-commit to v3.7.1 538bf19
* **deps:** update dependency terraform-docs to v0.18.0 26769ea
* **deps:** update dependency tflint to v0.51.0 22e330a
* **deps:** update dependency tflint to v0.51.1 748b6d8
* **deps:** update dependency tflint to v0.51.2 f9ac898
* **deps:** update dependency tflint to v0.52.0 7c6e743
* **deps:** update dependency trivy to v0.50.2 27d67c2
* **deps:** update dependency trivy to v0.50.4 24c9df7
* **deps:** update dependency trivy to v0.51.0 d752444
* **deps:** update dependency trivy to v0.51.1 21b7121
* **deps:** update dependency trivy to v0.51.2 3d02d27
* **deps:** update dependency trivy to v0.51.4 d6c92a1
* **deps:** update dependency trivy to v0.52.0 75eed4f
* **deps:** update dependency trivy to v0.52.1 6fad441
* **deps:** update dependency trivy to v0.52.2 d91a10b
* **deps:** update dependency trivy to v0.53.0 14d6838
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 41bc1f5
* **deps:** update renovate.json 5369332
* **pre-commit:** update commitlint hook 1247ce9
* **release:** remove legacy `VERSION` file 1da073b

# v7.1.0 - 2023-12-08

Changed
  * AZ-1228: Add `rule` block option under `rule_group_override_configuration` block for `managed_rule_set_configuration` input

# v7.0.0 - 2023-02-24

Breaking
  * AZ-1007: Update to Terraform `v1.3`

# v6.0.0 - 2023-02-20

Added
  * AZ-790: First version - Module Azure WAF policy
