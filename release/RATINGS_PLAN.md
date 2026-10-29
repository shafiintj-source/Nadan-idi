# Ratings and feedback — implementation pending

These are release requirements, not features already included in the APK.

- Use Google's official in-app review interface after enough completed play sessions, outside an active match.
- Apply the same eligibility to winners and losers. Never ask whether the user is happy before routing to reviews.
- Use a conservative local cooldown, such as 90 days between attempts. Google can suppress the dialog.
- Never offer coins, unlocks, rewards or discounts for a rating.
- Never ask for five stars or make a rating necessary to continue.
- Add an always-available “Rate on Google Play” menu link to the actual listing once it exists. Do not use that button to trigger a potentially invisible review API call.
- Keep a separate Help/Feedback entry available to everyone.
- Improve first-session controls, readable text, reconnect handling and crashes before adding prompts.
- Reply constructively to real reviews and test fixes before release.
- Measure genuine feedback. No ratings, rankings or downloads are guaranteed.

Policy reference: https://developer.android.com/guide/playcore/in-app-review
