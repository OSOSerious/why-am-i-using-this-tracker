<script>
  import { onMount } from 'svelte';

  let userResponses = [];
  let errorMessage = '';

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

  async function promptUser(question, response) {
    try {
      const response = await fetch('/api/prompt_user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ question, response })
      });
      const data = await response.json();
      if (data && data.data) {
        userResponses.push(data.data);
      } else {
        throw new Error('Invalid data format');
      }
    } catch (error) {
      errorMessage = 'Failed to prompt user: ' + error.message;
    }
  }

  onMount(() => {
    fetchUserResponses();
  });
</script>

<main>
  <h2>User Prompts</h2>
  {#if errorMessage}
    <p class="error">{errorMessage}</p>
  {/if}
  <ul>
    {#each userResponses as response}
      <li>{response.question}: {response.response}</li>
    {/each}
  </ul>
</main>
