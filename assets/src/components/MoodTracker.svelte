<script>
  import { onMount } from 'svelte';

  let moodData = [];
  let currentMood = '';
  let errorMessage = '';

  async function fetchMoodData() {
    try {
      const response = await fetch('/api/mood_data');
      const data = await response.json();
      if (data && data.data) {
        moodData = data.data;
      } else {
        throw new Error('Invalid data format');
      }
    } catch (error) {
      errorMessage = 'Failed to fetch mood data: ' + error.message;
    }
  }

  async function logMood() {
    try {
      const response = await fetch('/api/log_mood', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ mood: currentMood })
      });
      const data = await response.json();
      if (data && data.data) {
        moodData.push(data.data);
      } else {
        throw new Error('Invalid data format');
      }
    } catch (error) {
      errorMessage = 'Failed to log mood: ' + error.message;
    }
  }

  function analyzeMoodData() {
    // Logic to analyze user mood data
    // This is a placeholder for the actual implementation
  }

  onMount(() => {
    fetchMoodData();
    analyzeMoodData();
  });
</script>

<main>
  <h2>Mood Tracker</h2>
  {#if errorMessage}
    <p class="error">{errorMessage}</p>
  {/if}
  <label for="mood">How are you feeling?</label>
  <input type="text" id="mood" bind:value={currentMood} placeholder="How are you feeling?" />
  <button on:click={logMood}>Log Mood</button>
  <ul>
    {#each moodData as mood}
      <li>{mood.mood}</li>
    {/each}
  </ul>
</main>
