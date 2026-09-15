# privacy

The short version: **nothing about your reminders ever leaves your Mac.** dwell talks to one
server, about one thing, and this page is the whole of it.

## what the app sends

dwell contacts `trydwell.app` in exactly three situations, and never otherwise:

| when | what it sends |
| --- | --- |
| you activate a key | the key, a random device id dwell made up on first launch, and your Mac's name (the one in System Settings → General → About) |
| once a week, while licensed | the key and the activation id |
| you press *deactivate this mac* | the key and the activation id |

That is the complete list. No reminder titles, notes, dates, lists or counts. No usage, no
crash reports, no analytics, no identifier tied to your Apple ID. If the server cannot be
reached, dwell carries on for thirty days on its last answer and asks again later.

Updates are fetched from GitHub through Sparkle, which requests one small file describing the
latest version, once a day, and the download when there is one. It sends no profile.

## what the license service stores

When you buy, Stripe handles the payment — your card details go to Stripe and never to us.
Stripe tells the service that a purchase happened and the email it was made under, and the
service keeps:

- your **email**, so a key can be sent and a refund matched,
- the **key** it issued, and the checkout it came from,
- up to **three device records** — the device id, the Mac's name, and when it was activated —
  which is how it counts to three.

The record is kept for as long as the key is good, and a refund marks it revoked. It lives in
an Upstash Redis database; the key email is sent through Resend. Both hold only what is listed
here. Nothing is sold, shared, or used for anything but issuing and checking keys.

## on your Mac

The trial start, the device id and the key are stored in your login Keychain, so they survive
reinstalls. Your current focus and desktop anchors are stored in dwell's own preferences.
Reminders are read from and written to Apple's Reminders store through EventKit, with the
permission macOS asks you for on first launch, and dwell keeps no copy of them.

## questions, and deletion

Write to [hello@trydwell.app](mailto:hello@trydwell.app). Deleting your record on request
also revokes the key, so ask for that only when you mean it.
