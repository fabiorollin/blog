---
title: "Weekly Kubernetes digest · 2026 · week 28"
date: 2026-07-06T13:00:34+00:00
description: "What landed across the Kubernetes-and-cloud blogs I follow this week — synthesized into themes, every claim linked back to the source."
tags: ["digest", "kubernetes", "weekly"]
draft: false
---

> *This is an automated weekly digest. Themes and synthesis are written
> by Claude from the headlines + summaries in the source RSS feeds —
> full articles are not reproduced. Every claim links back to the
> original. See the sources block at the bottom for everything
> considered this week.*

## Observability and monitoring frameworks

Two articles this week explored how teams measure and respond to production issues. [Buoyant published a guide](https://www.buoyant.io/blog/the-sre-guide-to-kubernetes-observability-red-vs-use-methods) comparing RED (rate, errors, duration) and USE (utilization, saturation, errors) metrics in Kubernetes. RED tracks request-level signals and works well for service-level monitoring—Linkerd emits these automatically with no application changes. The post includes a case study where [p99 latency jumped 47%](https://www.buoyant.io/blog/the-sre-guide-to-kubernetes-observability-red-vs-use-methods) during an incident, illustrating how latency percentiles surface problems that averages mask. USE focuses on resource consumption—CPU, memory, disk—and helps diagnose capacity or saturation issues. The frameworks overlap but target different questions: RED answers "is the service working?", USE answers "does it have enough resources?"

## Infrastructure state and drift management

HashiCorp announced two releases addressing infrastructure visibility. [HCP Terraform powered by Infragraph entered limited availability](https://www.hashicorp.com/blog/hcp-terraform-powered-by-infragraph-limited-availability-launch), positioning itself as a single source of truth across hybrid and multi-cloud estates where resource data typically lives in silos. A separate post described [how Terraform helps discover unmanaged Azure resources](https://www.hashicorp.com/blog/discover-govern-and-scale-azure-infrastructure-in-the-ai-era) and reduce drift as teams scale cloud and AI workloads. Both pieces emphasize governance in environments where infrastructure grows faster than centralized control.

## Kubernetes API mechanics

[Learnk8s published a deep dive on server-side apply](https://learnkube.com/server-side-apply-kubernetes), the mechanism that replaced client-side apply's silent-overwrite behavior. Client-side apply merges the entire object, so two tools editing the same resource will clobber each other. [Server-side apply moves field ownership to the API server](https://learnkube.com/server-side-apply-kubernetes), tracking which manager owns which fields and surfacing conflicts explicitly. The change matters for GitOps workflows and any environment where multiple controllers or operators touch the same objects.

## Also worth reading

Container Solutions asked ["Is open source dead?"](https://blog.container-solutions.com/is-open-source-dead) in a reflection on shifting incentives around code reuse. Sysdig [documented JADEPUFFER](https://webflow.sysdig.com/blog/jadepuffer-agentic-ransomware-for-automated-database-extortion), agentic ransomware targeting databases for automated extortion.

## Sources considered this week

- [The SRE Guide to Kubernetes Observability: RED vs. USE Methods](https://www.buoyant.io/blog/the-sre-guide-to-kubernetes-observability-red-vs-use-methods) · *Buoyant (Linkerd)*
- [Is Open Source Dead?](https://blog.container-solutions.com/is-open-source-dead) · *Container Solutions*
- [JADEPUFFER: Agentic ransomware for automated database extortion](https://webflow.sysdig.com/blog/jadepuffer-agentic-ransomware-for-automated-database-extortion) · *Sysdig Blog*
- [Discover, govern, and scale Azure infrastructure in the AI era](https://www.hashicorp.com/blog/discover-govern-and-scale-azure-infrastructure-in-the-ai-era) · *HashiCorp Blog*
- [HCP Terraform Powered by Infragraph is Now in Limited Availability](https://www.hashicorp.com/blog/hcp-terraform-powered-by-infragraph-limited-availability-launch) · *HashiCorp Blog*
- [Server-side apply: what happens when you run kubectl apply](https://learnkube.com/server-side-apply-kubernetes) · *Learnk8s*
