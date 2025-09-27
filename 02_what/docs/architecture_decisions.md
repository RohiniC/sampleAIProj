---
decision_id: "mvp-platform-choice-2025"
date: "2025-09-26"
context: "Determine the core technology for the user-facing application of the HydraClean MVP, balancing speed to market, user experience, and future scalability."
urgency: "high"
options:
  - name: "Responsive Web App"
    effort: "2 weeks"
    risk: "low"
    pros: ["fastest to market", "single codebase for all devices", "no app store approval process", "maximum accessibility via any browser"]
    cons: ["less integrated user experience", "no push notifications for booking alerts", "limited access to native device features (e.g., advanced camera, contacts)"]
  - name: "Cross-Platform Mobile App (React Native/Flutter)"
    effort: "4 weeks"
    risk: "medium"
    pros: ["superior, native-like user experience", "push notifications for critical engagement (booking alerts, messages)", "app store presence builds credibility and trust", "better access to device hardware"]
    cons: ["longer initial development time for MVP", "complexity of app store approval process can cause delays", "requires more specialized development skills"]
decision: "Cross-Platform Mobile App (React Native/Flutter)"
rationale: "The core user interactions (booking requests, acceptances, and messaging) are time-sensitive and rely heavily on push notifications for a good user experience. An installable app from a trusted app store is also a key factor in building the initial trust that the platform desperately needs to succeed."
success_criteria: ["MVP is successfully deployed to both Apple App Store and Google Play Store", "Push notification open rate exceeds 50%", "User feedback praises the app's responsiveness and ease of use"]
rollback_plan: "If native development proves too slow or hits significant roadblocks, we will pivot to building a Progressive Web App (PWA). This will allow us to reuse the web-based components while still offering an installable, app-like experience with some push notification capabilities, avoiding app store dependencies."
---

# Architecture Decision Record: MVP Platform Choice

This document records the decision regarding the core platform for the HydraClean MVP. The details are captured in the front matter above.