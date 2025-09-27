### **Mockup Set: House Maid Application (MVP)**

**Theme:** Clean, Trustworthy, and Simple
**Primary Colors:** Soft Blue (#A2D2FF), White (#FFFFFF), Dark Gray for text (#333333)
**Accent Color:** Coral (#FF8A80) for calls-to-action.
**Font:** A clean, sans-serif font like Lato or Nunito.

---

### **Screen 1: Landing / Login Page**

**Layout:** Centered, single-column.

```
+-------------------------------------------+
|                                           |
|          [App Logo: "HydraClean"]         |
|                                           |
|      "Your Home, Your Cleaner, Your Way"  |
|                                           |
|      +-------------------------------+    |
|      | Email                         |    |
|      +-------------------------------+    |
|                                           |
|      +-------------------------------+    |
|      | Password                      |    |
|      +-------------------------------+    |
|                                           |
|      +-------------------------------+    |
|      |       [   LOGIN   ]           |    |
|      +-------------------------------+    |
|                                           |
|           Forgot Password?              |
|                                           |
|      ---------------- or ---------------   |
|                                           |
|      Don't have an account?               |
|      [ I'm a Client ]  [ I'm a Maid ]     |
|                                           |
+-------------------------------------------+
```

*   **Components:**
    *   **Logo:** Simple, clean logo with the app name.
    *   **Tagline:** Emphasizes the direct connection model.
    *   **Input Fields:** Standard email and password fields.
    *   **Primary Button (Login):** Solid Coral button.
    *   **Secondary Buttons (Sign Up):** Outlined Soft Blue buttons to differentiate user paths.

---

### **Screen 2: Client - Home & Search**

**Layout:** Top search bar, followed by a list of featured or nearby maids.

```
+-------------------------------------------+
| [Menu Icon]   HydraClean                  |
+-------------------------------------------+
|                                           |
|      +-------------------------------+    |
|      | [Icon] Search by Zip Code...  |    |
|      +-------------------------------+    |
|                                           |
|      --- Nearby Cleaners ---              |
|                                           |
|      +-------------------------------+    |
|      | [Photo]  **Maria G.**         |    |
|      |          [4.9 Stars] [Icon]   |    |
|      |          $35/hr                 |    |
|      |          "Experienced and..." > |    |
|      +-------------------------------+    |
|                                           |
|      +-------------------------------+    |
|      | [Photo]  **John D.**          |    |
|      |          [4.8 Stars] [Icon]   |    |
|      |          $30/hr                 |    |
|      |          "Reliable and..."    > |    |
|      +-------------------------------+    |
|                                           |
|                                           |
+-------------------------------------------+
| [Home] [Bookings] [Messages] [Profile]    |
+-------------------------------------------+
```

*   **Components:**
    *   **Top Bar:** Hamburger menu for secondary options.
    *   **Search Bar:** Prominent and easy to use.
    *   **Maid Card:** A reusable component showing a maid's photo, name, average rating, hourly rate, and a snippet of their bio. Tapping it navigates to their full profile.
    *   **Bottom Navigation Bar:** Standard mobile navigation for key client sections.

---

### **Screen 3: Client - Maid Profile & Booking**

**Layout:** Detailed view of a single maid.

```
+-------------------------------------------+
| [< Back]      Maria G.'s Profile          |
+-------------------------------------------+
|                                           |
|      [Large Profile Photo: Maria G.]      |
|      **Maria Garcia**                     |
|      [4.9 Stars] (125 reviews)            |
|      $35 / hour                           |
|                                           |
|      --- About Me ---                     |
|      "I have been a professional cleaner  |
|      for over 10 years. I am detail..."  |
|                                           |
|      --- Services Offered ---             |
|      [Basic Cleaning] [Deep Cleaning]     |
|                                           |
|      --- Availability ---                 |
|      [ S M T W T F S ]                    |
|      [ 1 2 3 4 5 6 7 ] (Available dates)  |
|                                           |
|      --- Reviews (3 of 125) ---           |
|      **Jane S.** [5 Stars]                |
|      "Maria was fantastic! So thorough."  |
|                                           |
|      +-------------------------------+    |
|      | [  REQUEST SERVICE  ]         |    |
|      +-------------------------------+    |
|                                           |
+-------------------------------------------+
```

*   **Components:**
    *   **Profile Header:** Large photo, name, rating, and price are prominent to build trust.
    *   **Sections:** Clear, collapsible sections for "About Me," "Services," "Availability," and "Reviews."
    *   **Availability:** A simple calendar view showing available dates.
    *   **Call-to-Action:** A sticky or bottom-placed Coral button to initiate the booking process.

---

### **Screen 4: Maid - Dashboard / Home**

**Layout:** A summary view focused on actions the maid needs to take.

```
+-------------------------------------------+
| [Menu Icon]   Welcome, Maria!             |
+-------------------------------------------+
|                                           |
|      --- New Booking Requests (1) ---     |
|                                           |
|      +-------------------------------+    |
|      | **Client:** David L.           |    |
|      | **Date:**   Oct 28, 2:00 PM    |    |
|      | **Service:** Basic Cleaning (3hr)|    |
|      |                               |    |
|      | [ DECLINE ]      [ ACCEPT ]   |    |
|      +-------------------------------+    |
|                                           |
|      --- Upcoming Bookings ---            |
|                                           |
|      +-------------------------------+    |
|      | **Client:** Jane S.            |    |
|      | **Date:**   Oct 26, 10:00 AM   |    |
|      | [ Message ]      [ Details ]  |    |
|      +-------------------------------+    |
|                                           |
+-------------------------------------------+
| [Home] [Schedule] [Messages] [Profile]    |
+-------------------------------------------+
```

*   **Components:**
    *   **Request Card:** Highlights new requests with clear client info, date/time, and service type. Action buttons are prominent.
    *   **Upcoming Bookings Card:** A simpler card for confirmed jobs.
    *   **Bottom Navigation Bar:** Tailored to the maid's needs (e.g., "Schedule" instead of "Bookings").

---

### **Screen 5: Shared - In-App Messaging**

**Layout:** Standard chat interface.

```
+-------------------------------------------+
| [< Back]      Chat with David L.          |
+-------------------------------------------+
|                                           |
|      Booking: Oct 28, 2:00 PM             |
|      ---------------------------------    |
|                                           |
|      [Hi Maria! Just wanted to confirm  ] |
|      [our booking for Friday. We have a  ] |
|      [cat, but he's very friendly.     ] |
|      (David L., 10:32 AM)                 |
|                                           |
|      [ Sounds great, David! Thanks for  ] |
|      [ the heads up. See you Friday!    ] |
|      (You, 10:35 AM)                      |
|                                           |
|                                           |
|                                           |
|      +-------------------------------+    |
|      | Type your message...      [>] |    |
|      +-------------------------------+    |
|                                           |
+-------------------------------------------+
```

*   **Components:**
    *   **Context Header:** Shows who the chat is with and links to the relevant booking for context.
    *   **Chat Bubbles:** Standard left/right alignment for messages.
    *   **Text Input:** Simple, clear input field with a send button.
