---
hide:
  - toc
---

<style>
.fr-journey-container {
    max-width: 900px;
    margin: 0 auto;
    padding: 24px 16px;
}

.fr-journey-title {
    text-align: center;
    margin-bottom: 24px;
    font-size: 1.6em;
    font-weight: 800;
}

.fr-steps {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    gap: 16px;
}

.fr-step {
    flex: 1;
    min-width: 180px;
    background: var(--md-default-bg-color, white);
    border-radius: 8px;
    border: 1px solid rgba(198, 203, 206, 0.6);
    padding: 16px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    transition: transform 0.2s ease;
}

.fr-step:hover {
    transform: translateY(-3px);
}

.fr-step-number {
    width: 30px;
    height: 30px;
    background: #53AFDA;
    color: white;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 0.95em;
    font-weight: bold;
    margin-bottom: 10px;
}

.fr-step-title {
    font-weight: bold;
    margin-bottom: 6px;
    font-size: 0.95rem;
}

.fr-step-description {
    font-size: 0.75rem;
    margin-bottom: 10px;
    flex-grow: 1;
    color: var(--md-default-fg-color--light);
}

.fr-step-action {
    width: 100%;
}

.fr-btn {
    display: inline-block;
    padding: 0.3rem 0.8rem;
    background-color: #53AFDA;
    color: white !important;
    text-decoration: none;
    border-radius: 4px;
    font-size: 0.75rem;
    font-weight: bold;
    transition: background-color 0.2s;
}

.fr-btn:hover {
    background-color: #3a9bc7;
}

.fr-opspilot {
    background: linear-gradient(135deg, #fff4f0 0%, #ffe0d6 100%);
    border-color: #FF4F00;
}

[data-md-color-scheme="slate"] .fr-opspilot {
    background: linear-gradient(135deg, rgba(255,79,0,0.12) 0%, rgba(255,79,0,0.2) 100%);
}

[data-md-color-scheme="slate"] .fr-opspilot-box {
    background: linear-gradient(135deg, rgba(255,79,0,0.12) 0%, rgba(255,79,0,0.2) 100%) !important;
}

@media (max-width: 600px) {
    .fr-steps { flex-direction: column; }
    .fr-step { width: 100%; }
}
</style>

<div class="fr-journey-container">
  <h1 class="fr-journey-title">Start your FusionReactor journey in 3 easy steps!</h1>
  <div class="fr-steps">

    <div class="fr-step">
      <div class="fr-step-number">1</div>
      <div class="fr-step-title">Create your account</div>
      <div class="fr-step-description">Signing up is easy and only takes a few minutes.</div>
      <div class="fr-step-action">
        <a href="https://app.fusionreactor.io/auth/login" class="fr-btn">Sign up</a>
      </div>
    </div>

    <div class="fr-step">
      <div class="fr-step-number">2</div>
      <div class="fr-step-title">Install FusionReactor</div>
      <div class="fr-step-description">Configure FusionReactor to monitor your stack.</div>
      <div class="fr-step-action">
        <a href="/Getting-started/install-fr/" class="fr-btn">Install</a>
      </div>
    </div>

    <div class="fr-step">
      <div class="fr-step-number">3</div>
      <div class="fr-step-title">Start your FR journey</div>
      <div class="fr-step-description">Familiarize yourself with our monitoring platform.</div>
      <div class="fr-step-action">
        <a href="/Getting-started/intro-to-fr/" class="fr-btn">Learn more</a>
      </div>
    </div>

    <div class="fr-step fr-opspilot">
      <div class="fr-step-title">Want full-stack observability?</div>
      <div class="fr-step-description">OTel, cloud dashboards, alerting, log monitoring, and AI-powered insights. Try OpsPilot, our cloud-native platform.</div>
      <div class="fr-step-action">
        <a href="https://app.opspilot.com" class="fr-btn" style="background-color: #FF4F00;">Explore OpsPilot</a>
      </div>
    </div>

  </div>

  <div style="margin-top: 28px; display: flex; flex-direction: column; gap: 12px;">

    <div style="padding: 20px; border-radius: 8px; border: 1px solid rgba(198,203,206,0.6); background: var(--md-default-bg-color, white);">
      <h3 style="margin-top: 0; font-size: 1rem;">What is FusionReactor?</h3>
      <p style="font-size: 0.82rem; color: var(--md-default-fg-color--light); margin: 0;">FusionReactor is an <strong>on-premise application performance monitoring (APM)</strong> agent for Java and ColdFusion applications. It installs directly on your server and gives you real-time visibility into requests, transactions, JDBC queries, memory, CPU, threads, and more, all without sending data to the cloud. The <strong>FusionReactor Agent</strong> is the core component; everything runs locally on your infrastructure, giving you full control over your data.</p>
    </div>

    <div class="fr-opspilot-box" style="padding: 20px; border-radius: 8px; border: 1px solid #FF4F00; background: linear-gradient(135deg, #fff4f0 0%, #ffe0d6 100%);">
      <h3 style="margin-top: 0; font-size: 1rem;">Need cloud observability?</h3>
      <p style="font-size: 0.82rem; color: var(--md-default-fg-color--light); margin: 0;">For full-stack observability including OpenTelemetry, cloud dashboards, alerting, log monitoring, and AI-powered insights, check out <strong><a href="https://docs.opspilot.com" style="color: #FF4F00;">OpsPilot</a></strong>, our cloud-native observability platform.</p>
    </div>

  </div>

</div>
