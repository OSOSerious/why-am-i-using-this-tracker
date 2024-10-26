<script>
  import UsageTracker from './components/UsageTracker.svelte';
  import UserPrompt from './components/UserPrompt.svelte';
  import Analytics from './components/Analytics.svelte';
  import MoodTracker from './components/MoodTracker.svelte';
  import Gamification from './components/Gamification.svelte';

  let usageData = [];
  let userResponses = [];
  let errorMessage = '';

  async function fetchUsageData() {
    try {
      const response = await fetch('/api/usage_data');
      const data = await response.json();
      if (data && data.data) {
        usageData = data.data;
      } else {
        throw new Error('Invalid data format');
      }
    } catch (error) {
      errorMessage = 'Failed to fetch usage data: ' + error.message;
    }
  }

  async function fetchUserResponses() {
    try {
      const response = await fetch('/api/user_responses');
      const data = await response.json();
      if (data && data.data) {
        userResponses = data.data;
      } else {
        throw new Error('Invalid data format');
      }
    } catch (error) {
      errorMessage = 'Failed to fetch user responses: ' + error.message;
    }
  }

  fetchUsageData();
  fetchUserResponses();
</script>

<main>
  <h1>Why Am I Using This? Tracker</h1>
  {#if errorMessage}
    <p class="error">{errorMessage}</p>
  {/if}
  <UsageTracker {usageData} />
  <UserPrompt {userResponses} />
  <Analytics />
  <MoodTracker />
  <Gamification />
</main>
