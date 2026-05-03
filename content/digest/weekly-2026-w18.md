---
title: "Weekly Kubernetes digest · 2026 · week 18"
date: 2026-05-02T23:31:59+00:00
description: "What landed across the Kubernetes-and-cloud blogs I follow this week — synthesized into themes, every claim linked back to the source."
tags: ["digest", "kubernetes", "weekly"]
draft: false
---

> *This is an automated weekly digest. Themes and synthesis are written
> by Claude from the headlines + summaries in the source RSS feeds —
> full articles are not reproduced. Every claim links back to the
> original. See the sources block at the bottom for everything
> considered this week.*

## Resource Management and Scheduling

Kubernetes 1.36 ships three interrelated beta- and alpha-stage features that redefine how workloads consume cluster resources. [In-Place Pod-Level Resources Vertical Scaling graduates to beta](https://kubernetes.io/blog/2026/04/30/kubernetes-v1-36-inplace-pod-level-resources-beta/), building on v1.35's general availability of in-place vertical scaling and v1.34's pod-level resource model. This allows runtime adjustment of CPU and memory without restarting containers. Separately, [Pod-Level Resource Managers enter alpha](https://kubernetes.io/blog/2026/05/01/kubernetes-v1-36-feature-pod-level-resource-managers-alpha/), extending the kubelet's topology, CPU, and memory managers to treat entire pods—not just individual containers—as scheduling units for performance-critical scenarios. A third update [refines Memory QoS to support tiered memory protection](https://kubernetes.io/blog/2026/04/29/kubernetes-v1-36-memory-qos-tiered-protection/) via cgroup v2, giving the kernel finer-grained guidance on how to evict or protect container memory under pressure.

For batch workloads, [mutable pod resources for suspended Jobs](https://kubernetes.io/blog/2026/04/27/kubernetes-v1-36-mutable-pod-resources-for-suspended-jobs/) reach beta. Queue controllers or cluster operators can now change CPU, memory, or GPU requests in a suspended Job's pod template before resumption—useful for preemption-based scheduling or right-sizing before actual execution.

Finally, [a new API surface addresses controller staleness](https://kubernetes.io/blog/2026/04/28/kubernetes-v1-36-staleness-mitigation-for-controllers/), exposing cache lag and missed updates that can cause incorrect reconciliation decisions at scale.

## Supply Chain Security and Credential Theft

Three separate attacks this week exploited package-registry trust models. A [malicious release of the elementary-data PyPI CLI (v0.23.3)](https://snyk.io/blog/malicious-release-of-elementary-data-pypi-package-steals-cloud-credentials-from-data-engineers/) was published via a GitHub Actions script injection vulnerability, harvesting dbt profiles, cloud keys, and SSH credentials from data engineering pipelines. The [lightning PyPI package was similarly compromised](https://snyk.io/blog/lightning-pypi-compromise-bun-based-credential-stealer/), shipping a Bun-based stealer that executes on import. On npm, attackers calling themselves "Mini Shai-Hulud" [compromised four SAP-ecosystem packages](https://snyk.io/blog/bun-based-stealer-hits-sap-cap-js-mbt-npm-packages/)—@cap-js/cds, @cap-js/cds-dk, @sap/cds, and @sap/mbt—on April 29, injecting the same Bun-based payload. All three campaigns share infrastructure and operational patterns. Snyk has published live advisories.

In vulnerability news, [CVE-2026-31431 ("Copy Fail")](https://webflow.sysdig.com/blog/cve-2026-31431-copy-fail-linux-kernel-flaw-lets-local-users-gain-root-in-seconds) is a Linux kernel flaw enabling local privilege escalation to root in seconds. [CVE-2026-40478](https://snyk.io/blog/thymeleaf-injection/) is a Thymeleaf template injection (CVSS 9.1) exploitable only when applications dynamically construct view or template expressions; developers should update to 3.1.4+ and audit callsites. Finally, [CVE-2026-42208](https://webflow.sysdig.com/blog/cve-2026-42208-targeted-sql-injection-against-litellms-authentication-path-discovered-36-hours-following-vulnerability-disclosure) is a SQL injection in LiteLLM's authentication path that was exploited within 36 hours of disclosure.

## Identity and Secrets Management

HashiCorp published three complementary pieces on non-human identity and secrets hygiene. [SPIFFE auth support in Vault Enterprise](https://www.hashicorp.com/blog/spiffe-securing-the-identity-of-agentic-ai-and-non-human-actors) now covers agentic AI and other workloads, while [local account password rotation via SSH](https://www.hashicorp.com/blog/securing-the-last-mile-with-local-account-password-rotation) replaces shared passwords with unique, audited credentials. A third post explains [how to operationalize Vault Radar's secret detection](https://www.hashicorp.com/blog/turning-secret-detection-into-measurable-risk-reduction) by coordinating remediation workflows and measuring risk reduction. For SSH access at enterprise scale, HashiCorp also outlined [an updated architecture using Vault SSH certificates and Boundary](https://www.hashicorp.com/blog/secure-ssh-access-at-scale-with-hashicorp-vault-and-boundary) for hybrid and multi-cloud environments.

**Also worth reading:** [Snyk and Atlassian integrate to surface Snyk Studio AI fixes directly in Jira tickets](https://snyk.io/blog/atlassian-integration-intelligent-remediation-jira/); [The AI Kubernetes Show becomes a biweekly podcast](https://www.buoyant.io/blog/the-ai-kubernetes-show-is-back).

## Sources considered this week

- [Kubernetes v1.36: Pod-Level Resource Managers (Alpha)](https://kubernetes.io/blog/2026/05/01/kubernetes-v1-36-feature-pod-level-resource-managers-alpha/) · *Kubernetes Blog*
- [Kubernetes v1.36: In-Place Vertical Scaling for Pod-Level Resources Graduates to Beta](https://kubernetes.io/blog/2026/04/30/kubernetes-v1-36-inplace-pod-level-resources-beta/) · *Kubernetes Blog*
- [SPIFFE: Securing the identity of agentic AI and non-human actors](https://www.hashicorp.com/blog/spiffe-securing-the-identity-of-agentic-ai-and-non-human-actors) · *HashiCorp Blog*
- [Announcing the new Partner Premier tier for the Terraform Registry](https://www.hashicorp.com/blog/announcing-the-new-partner-premier-tier-for-the-terraform-registry) · *HashiCorp Blog*
- [Securing the last mile with local account password rotation](https://www.hashicorp.com/blog/securing-the-last-mile-with-local-account-password-rotation) · *HashiCorp Blog*
- [CVE-2026-31431: “Copy Fail” Linux kernel flaw lets local users gain root in seconds](https://webflow.sysdig.com/blog/cve-2026-31431-copy-fail-linux-kernel-flaw-lets-local-users-gain-root-in-seconds) · *Sysdig Blog*
- [AI is the present of security](https://webflow.sysdig.com/blog/ai-is-the-present-of-security) · *Sysdig Blog*
- [PCI DSS v4.0.1 Compliance in the cloud and Kubernetes with Sysdig](https://webflow.sysdig.com/blog/pci-dss-v4-0-1-compliance-in-the-cloud-and-kubernetes-with-sysdig) · *Sysdig Blog*
- [lightning PyPI Compromise: A Bun-Based Credential Stealer in Python](https://snyk.io/blog/lightning-pypi-compromise-bun-based-credential-stealer/) · *Snyk Blog*
- [Secure SSH access at scale with HashiCorp Vault and Boundary](https://www.hashicorp.com/blog/secure-ssh-access-at-scale-with-hashicorp-vault-and-boundary) · *HashiCorp Blog*
- [Kubernetes v1.36: Tiered Memory Protection with Memory QoS](https://kubernetes.io/blog/2026/04/29/kubernetes-v1-36-memory-qos-tiered-protection/) · *Kubernetes Blog*
- [How to secure workloads, containers, and Kubernetes the right way](https://webflow.sysdig.com/blog/how-to-secure-workloads-containers-and-kubernetes-the-right-way) · *Sysdig Blog*
- [Don't Panic: The Thymeleaf Template Injection That Only Hurts If You Let It (CVE-2026-40478)](https://snyk.io/blog/thymeleaf-injection/) · *Snyk Blog*
- ["A Mini Shai-Hulud Has Appeared": Bun-Based Stealer Hits SAP @cap-js and mbt npm Packages](https://snyk.io/blog/bun-based-stealer-hits-sap-cap-js-mbt-npm-packages/) · *Snyk Blog*
- [Bridging the Gap to Autonomous Fixes: Snyk and Atlassian Unveil Intelligent Remediation for Jira](https://snyk.io/blog/atlassian-integration-intelligent-remediation-jira/) · *Snyk Blog*
- [The AI Kubernetes Show is Back: Now a Regular Biweekly Podcast!](https://www.buoyant.io/blog/the-ai-kubernetes-show-is-back) · *Buoyant (Linkerd)*
- [Kubernetes v1.36: Staleness Mitigation and Observability for Controllers](https://kubernetes.io/blog/2026/04/28/kubernetes-v1-36-staleness-mitigation-for-controllers/) · *Kubernetes Blog*
- [Turning secret detection into measurable risk reduction](https://www.hashicorp.com/blog/turning-secret-detection-into-measurable-risk-reduction) · *HashiCorp Blog*
- [Malicious Release of elementary-data PyPI Package Steals Cloud Credentials from Data Engineers](https://snyk.io/blog/malicious-release-of-elementary-data-pypi-package-steals-cloud-credentials-from-data-engineers/) · *Snyk Blog*
- [Kubernetes v1.36: Mutable Pod Resources for Suspended Jobs (beta)](https://kubernetes.io/blog/2026/04/27/kubernetes-v1-36-mutable-pod-resources-for-suspended-jobs/) · *Kubernetes Blog*
- [CVE-2026-42208: Targeted SQL injection against LiteLLM's authentication path discovered 36 hours following vulnerability disclosure](https://webflow.sysdig.com/blog/cve-2026-42208-targeted-sql-injection-against-litellms-authentication-path-discovered-36-hours-following-vulnerability-disclosure) · *Sysdig Blog*
