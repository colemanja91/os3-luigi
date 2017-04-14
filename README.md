# Luigi Central Scheduler running on Openshift 3

Demo repo demonstrating Luigi running on Openshift 3 / Openshift Origin.

For more context on running Luigi jobs themselves in Openshift, please see this doc: https://github.com/rh-marketingops/rh-mo-scc-luigi

- Luigi (Spotify): https://github.com/spotify/luigi
- Openshift Origin: https://www.openshift.org/
- Openshift Enterprise: https://www.openshift.com

# Requirements

- Some knowledge of Luigi and how you will be using it (the Luigi project has great documentation and examples)
- At least developer access to a running Openshift cluster
  + A cluster administrated by your organization
  + Openshift Dedicated
  + Openshift Online preview
  + You can run an Openshift cluster on your local machine for dev purposes
- If you want to use the experimental Luigi task history, you'll need to use an ephemeral DB image (no long-term storage), or make sure your Openshift admin has enabled persistent storage volumes

# Setup

1. Create a new Openshift project (examples here refer to the project as `scc` or `scc-dev`)
2. If using a task history DB, add to project using available Openshift DB image
  - This example built using the PostgreSQL 9.5 image (persistent)
  - DB app name here is listed as `scc-luigi-db`
  - If not using task history DB, you'll need to clone this repo and remove the task history config from `luigi.cfg`
2. Add to project using Source-to-Image (S2I)
  - This example was built using the Python 3.5 base image
  - App name here is listed as `scc-luigi`
3. For the source repo, use https://github.com/colemanja91/os3-luigi.git
4. Set your deployment and routing options as desired
  - See *Open Issues* below
5. Finish configuration and allow to build/deploy

# Open Issues

One of the great advantages of Openshift 3 and Kubernetes is automatic deployments of your applications; the cluster can run and scale deployments depending on traffic. Sadly, Luigi does not yet support a scalability for the central scheduler (due to the app state being pickled, which can't be shared across pods).
If running on OS3, I recommend running only a single pod at once, to avoid scheduling issues. With smaller loads, we have not experienced any load problems on the scheduler itself, but have seen occasional availability issues when a lone pod must be rebuilt. 
