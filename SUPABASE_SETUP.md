# Enable Daybook accounts

Daybook uses Supabase Auth for Google and passwordless email sign-in, with Apple sign-in available after Apple Developer credentials are configured. Private Supabase tables sync each account's Work/Personal choice, starting balance, and transactions.

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

## 3. Configure sign-in providers

Email sign-in uses a passwordless link. In **Authentication → Sign In / Providers**, keep **Email** enabled. Users enter their email in Daybook and receive a secure sign-in/confirmation link. Configure Supabase's email templates and SMTP delivery before inviting other users; the default email service is rate-limited.

To enable Google sign-in, enable Google in the same page and enter the OAuth credentials issued by Google. Supabase shows the callback URL to register in Google's developer console.

Apple sign-in requires access to the Apple Developer Program, an Apple Services ID configured for Sign in with Apple, and a generated Apple client secret. Enable Apple in **Authentication → Sign In / Providers** and enter those credentials. Supabase shows the callback URL to register in Apple Developer. Provider secrets belong in Supabase's provider settings, never in `index.html` or `supabase-config.js`.

In **Authentication → URL Configuration**, set the production website URL and add each local/deployed website URL to the redirect allow list. OAuth will not work from a `file://` URL; run the site on a local web server or deploy it to an HTTPS host.

## 4. Run or deploy the site

Serve this folder over HTTP locally for development, or deploy it as a static site over HTTPS. Open the site and use **Continue with email**, **Continue with Google**, or (once configured) **Continue with Apple**. Email sign-in sends a passwordless link; new users complete account creation by confirming their email.

The GitHub Pages workflow publishes `index.html` and `supabase-config.js` from the repository's `main` branch. After the first successful deployment, set the Supabase Site URL to the Pages URL and add that URL (including its repository path) to the redirect allow list in **Authentication → URL Configuration**.

Transactions are stored in Supabase and are loaded only after sign-in. The dashboard intentionally starts empty and has no bank connection.
