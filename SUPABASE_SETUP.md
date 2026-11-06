# Enable Daybook accounts

Daybook uses Supabase Auth for Google and Apple sign-in, and private Supabase tables to sync each account's Work/Personal choice, starting balance, and transactions. The project is not connected until the steps below are completed.

## 1. Create a Supabase project

Create a project at [supabase.com/dashboard](https://supabase.com/dashboard). In **Project Settings → API**, copy the Project URL and the publishable key (`sb_publishable_...`). These are public client values; never put a `service_role` or secret key in this website.

Edit `supabase-config.js`:

```js
window.DAYBOOK_CONFIG = {
  url: "https://YOUR_PROJECT_ID.supabase.co",
  publishableKey: "sb_publishable_YOUR_KEY"
};
```

## 2. Create the private transaction table

In the Supabase SQL Editor, run `supabase/schema.sql`. Row-level security policies restrict every read and write to the authenticated user's own rows. If you already ran an earlier version of this schema, run the updated file again to add the Work/Personal setting.

## 3. Configure Google and Apple

In **Authentication → Sign In / Providers**, enable Google and Apple and enter the OAuth credentials issued by each provider. Supabase shows the callback URL to register in each provider's developer console. Register that exact callback URL there.

In **Authentication → URL Configuration**, set the production website URL and add each local/deployed website URL to the redirect allow list. OAuth will not work from a `file://` URL; run the site on a local web server or deploy it to an HTTPS host.

Apple sign-in requires an Apple Developer account and an Apple Services ID configured for Sign in with Apple. Provider secrets belong in Supabase's provider settings, never in `index.html` or `supabase-config.js`.

## 4. Run or deploy the site

Serve this folder over HTTP locally for development, or deploy it as a static site over HTTPS. Open the site and use **Continue with Google** or **Continue with Apple**. New users are created by the provider flow; returning users sign in through the same buttons.

The GitHub Pages workflow publishes `index.html` and `supabase-config.js` from the repository's `main` branch. After the first successful deployment, set the Supabase Site URL to the Pages URL and add that URL (including its repository path) to the redirect allow list in **Authentication → URL Configuration**.

Transactions are stored in Supabase and are loaded only after sign-in. The dashboard intentionally starts empty and has no bank connection.
