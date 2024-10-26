<script>
  import { onMount } from 'svelte';

  let usageData = [];

  async function fetchUsageData() {
    const response = await fetch('/api/usage_data');
    const data = await response.json();
    usageData = data.data;
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
  <ul>
    {#each usageData as usage}
      <li>{usage.app}: {usage.duration} minutes</li>
    {/each}
  </ul>
</main>
