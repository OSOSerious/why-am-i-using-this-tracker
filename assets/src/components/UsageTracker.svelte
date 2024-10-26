<script>
  import { onMount } from 'svelte';

  let usageData = [];
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

  onMount(() => {
    fetchUsageData();
  });

  function monitorAppUsage() {
    // Logic to monitor app usage in the background
    // This is a placeholder for the actual implementation
  }

  monitorAppUsage();
</script>

<main>
  <h2>App Usage Tracker</h2>
  {#if errorMessage}
    <p class="error">{errorMessage}</p>
  {/if}
  <ul>
    {#each usageData as usage}
      <li>{usage.app}: {usage.duration} minutes</li>
    {/each}
  </ul>
</main>
