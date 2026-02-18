# a_and_i_admin_web_serivce

Admin web service built with Flutter Web.

## Firebase Hosting Deployment

This repository is configured to deploy to Firebase Hosting when a tag in the
format `vX.Y.Z` is pushed.

- Workflow file: `.github/workflows/firebase-hosting-deploy.yml`
- Hosting config: `firebase.json`

### Required GitHub Settings

Add the following in your GitHub repository settings:

- Secret: `FIREBASE_SERVICE_ACCOUNT`
  - Firebase service account JSON (for deploy permission)
- Secret: `API_BASE_URL` (optional)
  - Example: `https://api.aandiclub.com`
  - If omitted, workflow defaults to `https://api.aandiclub.com`
- Firebase project ID is fixed to `admin-aandi-web` in workflow.

### Trigger Deployment

```bash
git tag v1.0.0
git push origin v1.0.0
```
