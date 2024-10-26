<script>
  import { onMount } from 'svelte';

  let userResponses = [];

  async function fetchUserResponses() {
    const response = await fetch('/api/user_responses');
    const data = await response.json();
    userResponses = data.data;
  }

  async function promptUser(question, response) {
    const response = await fetch('/api/prompt_user', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ question, response })
    });
    const data = await response.json();
    userResponses.push(data.data);
  }

  onMount(() => {
    fetchUserResponses();
  });
</script>

<main>
  <h2>User Prompts</h2>
  <ul>
    {#each userResponses as response}
      <li>{response.question}: {response.response}</li>
    {/each}
  </ul>
</main>
