<script>
  import UsageTracker from './components/UsageTracker.svelte';
  import UserPrompt from './components/UserPrompt.svelte';
  import Analytics from './components/Analytics.svelte';
  import MoodTracker from './components/MoodTracker.svelte';
  import Gamification from './components/Gamification.svelte';

  let usageData = [];
  let userResponses = [];

  async function fetchUsageData() {
    const response = await fetch('/api/usage_data');
    const data = await response.json();
    usageData = data.data;
  }

  async function fetchUserResponses() {
    const response = await fetch('/api/user_responses');
    const data = await response.json();
    userResponses = data.data;
  }

  fetchUsageData();
  fetchUserResponses();
</script>

<main>
  <h1>Why Am I Using This? Tracker</h1>
  <UsageTracker {usageData} />
  <UserPrompt {userResponses} />
  <Analytics />
  <MoodTracker />
  <Gamification />
</main>
