# Managing your license key

---

## Finding your license key

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1076024968?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="FusionReactor License Key Retrieval"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

Your license key is required to activate your FusionReactor instance. You can find it in two ways:

- **Email:** Sent shortly after your trial begins or purchase is complete.
- **FusionReactor portal:** Log in at [app.fusionreactor.io](https://app.fusionreactor.io) and navigate to the **On-Premise** tab (may require expanding the menu via three dots).

---

## Moving a license key to another server

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1077534030?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Moving a FusionReactor License Key"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

The steps differ slightly depending on whether your instance was automatically or manually activated.

### Automatically licensed instances

When you uninstall an automatically licensed instance, the seat is freed up shortly after uninstallation. You can then use the same key on your new server.

**Deactivating without uninstalling (no downtime):**

If you cannot uninstall the old instance immediately:

1. Open your browser and navigate to `localhost:8088`.
2. Go to the **About** page and click **Deactivate**.
3. The seat is freed immediately - no server restart required.

### Manually activated instances

1. Open your browser and navigate to `localhost:8088`.
2. Go to the **About** page and click **Manual Activation**.
3. Follow the on-screen instructions to generate a **Deactivation Code**.
4. On an internet-connected machine, go to [https://fusion-reactor.com/manual/](https://fusion-reactor.com/manual/) and complete the deactivation using the code.

### Activating on the new server

Once the license is deactivated, enter your license key during activation on the new server.

### Temporary license for overlapping uptime

If both old and new servers need to run simultaneously during migration, contact the Sales team at [sales@fusion-reactor.com](mailto:sales@fusion-reactor.com) to request a temporary license key.

---

## Checking license seats & usage

<div style="padding:56.25% 0 0 0;position:relative;"><iframe src="https://player.vimeo.com/video/1082588392?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=58479" frameborder="0" allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media" style="position:absolute;top:0;left:0;width:100%;height:100%;" title="Checking license seats &amp; usage (On-Premise)"></iframe></div><script src="https://player.vimeo.com/api/player.js"></script>

If you encounter a **"No seats available"** error, your license has reached its seat limit.

Each FusionReactor license seat allows:

- Up to 4 instances per seat.
- All 4 instances must be on the same server (host).

Activating on a different host, or accidentally launching more than 4 instances on the same server, will exceed your seat count.

### How to check usage

1. Log in at [app.fusionreactor.io](https://app.fusionreactor.io).
2. Click **On Premise** in the top navigation bar.

    ![Screenshot](/Getting-started/Tutorials/Common-issues/licenseseat1.png){ width="350" height="250" }

3. Review your licenses, total seats, and usage across servers.

    ![Screenshot](/Getting-started/Tutorials/Common-issues/licenseseat2.png){ width="350" height="250" }

4. Click **View Activations** next to a license to see which servers are using seats and how many instances are running on each.

    ![Screenshot](/Getting-started/Tutorials/Common-issues/licenseseat3.png){ width="350" height="250" }
