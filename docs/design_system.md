# HydraClean - Design System

This document outlines the design system for the HydraClean application. It provides a set of guidelines and reusable components to ensure a consistent and high-quality user experience across the platform.

---

## 1. Color Palette

Colors are chosen to evoke feelings of trust, cleanliness, and simplicity.

### Primary Colors

Used for main UI elements, backgrounds, and navigation.

| Color       | Hex       | Usage                               |
| :---------- | :-------- | :---------------------------------- |
| **Blue**    | `#A2D2FF` | Interactive elements, links, highlights |
| **White**   | `#FFFFFF` | Main backgrounds, card backgrounds  |
| **Off-White**| `#F9F9F9` | Screen backgrounds, subtle divisions |

### Accent Color

Used for primary calls-to-action and to draw user attention.

| Color     | Hex       | Usage                               |
| :-------- | :-------- | :---------------------------------- |
| **Coral** | `#FF8A80` | Primary buttons, important alerts   |

### Text Colors

Used for all typography to ensure readability.

| Color         | Hex       | Usage                               |
| :------------ | :-------- | :---------------------------------- |
| **Primary**   | `#333333` | Headings, primary text, body copy   |
| **Secondary** | `#666666` | Sub-headings, secondary information |
| **Placeholder**| `#8E8E93` | Input field placeholders, disabled text |

### Semantic Colors

Used for user feedback and status indicators.

| Color       | Hex       | Usage                               |
| :---------- | :-------- | :---------------------------------- |
| **Success** | `#4CAF50` | Confirmation messages, success states |
| **Warning** | `#FFC107` | Warnings, non-critical alerts     |
| **Error**   | `#F44336` | Error messages, destructive actions |

---

## 2. Typography

The typography is designed to be clean, modern, and highly legible.

-   **Font Family:** Lato (preferred), Nunito, or system default sans-serif.

### Type Scale

| Role                | Font Size | Font Weight | Usage                               |
| :------------------ | :-------- | :---------- | :---------------------------------- |
| **Display Title**   | 34px      | Bold (700)  | Main screen titles (e.g., "Find Your Cleaner") |
| **Heading 1 (H1)**  | 24px      | Bold (700)  | Large section titles, profile names |
| **Heading 2 (H2)**  | 20px      | Semi-Bold (600) | Section titles (e.g., "Top Rated Near You") |
| **Heading 3 (H3)**  | 18px      | Semi-Bold (600) | Card titles, item names             |
| **Body (Regular)**  | 16px      | Regular (400) | Main text, descriptions, inputs     |
| **Body (Small)**    | 14px      | Regular (400) | Secondary text, captions, reviews   |
| **Button Text**     | 18px      | Semi-Bold (600) | Text within primary buttons         |
| **Link Text**       | 14px      | Medium (500)  | Standalone links                    |

---

## 3. Spacing & Layout

A consistent 8px grid system is used for spacing and layout to maintain rhythm and alignment.

-   **Base Unit:** `8px`
-   **xs:** `4px` (half unit)
-   **sm:** `8px` (1 unit)
-   **md:** `16px` (2 units)
-   **lg:** `24px` (3 units)
-   **xl:** `32px` (4 units)
-   **xxl:** `48px` (6 units)

**Standard Gutters:** `16px` or `20px` from screen edges.

---

## 4. UI Components

Core reusable components that form the building blocks of the application.

### Buttons

**Primary Button:**
-   **Use Case:** Main call-to-action (e.g., Login, Request Service).
-   **Style:** Solid fill with Accent Color (`#FF8A80`), white text.
-   **Height:** 55px
-   **Corner Radius:** 27.5px (fully rounded)
-   **Shadow:** Subtle drop shadow on interaction.

**Secondary Button:**
-   **Use Case:** Secondary actions (e.g., Sign up options).
-   **Style:** Outlined with Primary Color (`#A2D2FF`), blue text.
-   **Height:** 50px
-   **Corner Radius:** 25px (fully rounded)
-   **Border:** 2px solid.

### Input Fields

-   **Use Case:** Forms for login, search, messaging.
-   **Style:** Light gray (`#EFEFEF`) filled background, no border.
-   **Height:** 55px
-   **Corner Radius:** 12px
-   **Text Color:** Primary (`#333333`) when active, Placeholder (`#8E8E93`) when empty.

### Cards

-   **Use Case:** Displaying maid profiles, booking requests.
-   **Style:** White (`#FFFFFF`) background.
-   **Corner Radius:** 16px
-   **Shadow:** Soft, diffused drop shadow (`rgba(0,0,0,0.08)`, `10px` blur).
-   **Padding:** `16px` or `20px` internal padding.

### Navigation Bar

-   **Use Case:** App's main navigation.
-   **Style:** Translucent white with a background blur effect.
-   **Height:** 84px (including home indicator area)
-   **Icons:** Outlined, using Secondary text color (`#666666`) for inactive states and Primary Blue (`#A2D2FF`) for the active state.

---

## 5. Iconography

-   **Style:** Simple, outlined icons with a consistent stroke width (2px).
-   **Color:** Use Secondary text color (`#666666`) for most icons. Use Primary Blue (`#A2D2FF`) or Accent Coral (`#FF8A80`) for interactive or highlighted icons.
-   **Examples:** Search loupe, filter sliders, calendar, chat bubble, user profile.
