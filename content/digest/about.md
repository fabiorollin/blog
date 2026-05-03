---
title: "About this digest"
date: 2026-05-02T00:00:00-04:00
description: "How the weekly Kubernetes digest is built, what's in it, and what it deliberately leaves out."
---

This page is a contact + transparency note for any publisher whose feed gets pulled into the weekly digest.

## What the pipeline does

Every Monday, a Python job reads the past week of items from a curated list of ~20 Kubernetes-and-cloud-platform RSS feeds. It passes only the **titles and the short summaries the publishers themselves chose to put in the feed** — never the full article body, never anything scraped from the source HTML page.

Those titles + summaries go to Claude with a strict prompt:

- Group items by theme, not by source.
- Drop pure marketing, sales pitches, and version-bump-only announcements.
- Never quote more than 10 words verbatim from any single source.
- Every concrete claim must link back to the original article.

The model produces a ~400-word roundup, which gets committed to this site as a markdown post. The post ends with a *Sources considered this week* block linking every item that was passed in — whether it ended up cited in the body or not.

## What it deliberately doesn't do

- It does not scrape source HTML pages — RSS feeds only.
- It does not reproduce full article bodies, code blocks, diagrams, or screenshots from sources.
- It does not republish under my byline anything that would substitute for the original.
- The synthesized post is *about themes that emerged across multiple sources* — the job of a roundup, not a mirror.

## Reach me

If you're a publisher and would like your feed removed (or added), email me at fabiorollin@gmail.com or open an issue on the [GitHub repo](https://github.com/fabiorollin). I'll act within a day.

The bot identifies itself in fetches with the `User-Agent` string `fabiorollin-weekly-digest/1.0 (+https://blog.fabiorollin.com/digest/about/)` and respects `robots.txt`.
