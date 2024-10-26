<script>
  import { onMount } from 'svelte';

  let gamificationData = [];
  let errorMessage = '';

  async function fetchGamificationData() {
    try {
      const response = await fetch('/api/gamification_data');
      const data = await response.json();
      if (data && data.data) {
        gamificationData = data.data;
      } else {
        throw new Error('Invalid data format');
      }
    } catch (error) {
      errorMessage = 'Failed to fetch gamification data: ' + error.message;
    }
  }

  onMount(() => {
    fetchGamificationData();
  });

  function manageRewards() {
    // Logic to manage rewards
    // This is a placeholder for the actual implementation
  }

  function manageChallenges() {
    // Logic to manage challenges
    // This is a placeholder for the actual implementation
  }

  function manageLeaderboards() {
    // Logic to manage leaderboards
    // This is a placeholder for the actual implementation
  }

  manageRewards();
  manageChallenges();
  manageLeaderboards();
</script>

<main>
  <h2>Gamification</h2>
  {#if errorMessage}
    <p class="error">{errorMessage}</p>
  {/if}
  <ul>
    {#each gamificationData as data}
      <li>User {data.user_id}: {data.reward_points} points, {data.challenges_completed} challenges completed, Position {data.leaderboard_position}</li>
    {/each}
  </ul>
</main>
