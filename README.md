# blog.fabiorollin.com

Personal technical blog. Hugo static site, served by nginx, deployed to the existing EKS cluster, fronted by the same shared ALB as `fabiorollin.com` and `contacts.fabiorollin.com`.

Palette and typography matched to the main portfolio landing page.

## Local development

Requires [Hugo extended](https://gohugo.io/installation/) (v0.139+) installed locally.

```powershell
# Install Hugo on Windows via winget
winget install Hugo.Hugo.Extended

# Live preview at http://localhost:1313
hugo server -D
```

`-D` includes drafts. Drop it for production preview.

## Add a new post

```powershell
hugo new posts/my-new-post.md
```

Edit the front matter and content. Set `draft: false` when ready to publish.

## Build the static site

```powershell
hugo --minify --gc
```

Output goes to `./public`. Don't commit it — built fresh in Docker.

## Deploy

### One-time setup

**1. Create the ECR repository:**

```powershell
aws ecr create-repository --repository-name blog --region us-east-1
```

**2. Add the DNS record.** In Route 53, create an `A` ALIAS record for `blog.fabiorollin.com` pointing at the same ALB used by the rest of `fabiorollin.com`. The wildcard ACM cert (`*.fabiorollin.com`) already covers it.

```powershell
# Get the ALB DNS name
kubectl get ingress -A -o json | ConvertFrom-Json | `
  Select-Object -ExpandProperty items | `
  Where-Object { $_.metadata.namespace -eq "web-demo" } | `
  Select-Object -ExpandProperty status
```

Use that hostname as the ALIAS target in Route 53.

### Per-deploy

```powershell
$ECR = "807291695385.dkr.ecr.us-east-1.amazonaws.com/blog"
$TAG = (Get-Date -Format "yyyyMMdd-HHmm")

# Build
docker build -t blog:latest .

# Auth + push
aws ecr get-login-password --region us-east-1 | `
  docker login --username AWS --password-stdin "807291695385.dkr.ecr.us-east-1.amazonaws.com"

docker tag blog:latest "${ECR}:${TAG}"
docker tag blog:latest "${ECR}:latest"
docker push "${ECR}:${TAG}"
docker push "${ECR}:latest"

# Apply manifests (first deploy only)
kubectl apply -f k8s/blog.yaml

# Subsequent deploys: just bump the image
kubectl set image deploy/blog "blog=${ECR}:${TAG}" -n blog
kubectl rollout status deploy/blog -n blog
```

Hard-refresh `https://blog.fabiorollin.com` after rollout.

## Cost

- 1 pod, 25m CPU / 32Mi memory request — fits inside existing EKS Auto Mode capacity, no new node
- Shared ALB (no new ELB charge — the `alb.ingress.kubernetes.io/group.name: fabiorollin-shared` annotation joins the existing ALB)
- Static files served by nginx — no DB, no API
- ECR: ~$0.10/month for the image storage

**Net: ~$0.20/month** added to the AWS bill on top of what you're already paying for the cluster.

## File layout

```
blog/
├── hugo.toml                 # Hugo configuration
├── content/
│   ├── _index.md             # Homepage description
│   └── posts/                # Blog posts (Markdown + front matter)
├── layouts/                  # Inline custom theme
│   ├── _default/
│   │   ├── baseof.html       # Outer HTML shell
│   │   ├── single.html       # Individual post template
│   │   └── list.html         # Tag/category list templates
│   ├── index.html            # Homepage post-list layout
│   └── partials/
│       ├── header.html       # Sticky nav with brand + links
│       └── footer.html       # Site footer
├── assets/css/
│   └── main.css              # Single CSS file, palette matches fabiorollin.com
├── static/
│   └── favicon.svg           # Tiny SVG favicon (FR monogram)
├── Dockerfile                # Multi-stage: hugomods/hugo → nginx:alpine
├── nginx.conf                # gzip, cache headers, security headers, SPA fallback
├── k8s/blog.yaml             # Namespace + Deployment + Service + Ingress
└── README.md                 # This file
```

## Why no separate theme repo

Custom inline theme. ~200 lines of HTML across `layouts/` plus ~250 lines of CSS in `assets/css/main.css`. Easier to modify than a community theme with its own configuration system, and matches the landing-page palette out of the box.

If you outgrow it: replace `layouts/` with a Hugo theme submodule (e.g., `themes/PaperMod`) and add `theme = "PaperMod"` to `hugo.toml`. The content and config carry over unchanged.

## Adding a new post — 90-second checklist

1. `hugo new posts/<slug>.md`
2. Set `title`, `description`, `tags`, `draft: false`
3. Write the post in Markdown
4. `hugo server -D` to preview at `http://localhost:1313`
5. `git add . && git commit -m "post: <title>"` (if you've got a git remote set up)
6. Run the per-deploy commands above
7. Hard-refresh the live URL

Repeat as you publish.
