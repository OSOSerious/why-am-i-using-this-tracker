<script>
  import { onMount } from 'svelte';

  let userResponses = [];
  let currentQuestion = '';
  let currentResponse = '';

  async function fetchUserResponses() {
    const response = await fetch('/api/user_responses');
    const data = await response.json();
    userResponses = data.data;
  }

  async function promptUser() {
    const response = await fetch('/api/prompt_user', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ question: currentQuestion, response: currentResponse })
    });
    const data = await response.json();
    userResponses.push(data.data);
  }

  onMount(() => {
    fetchUserResponses();
  });
</script>

<main>
  <h2>User Feedback Prompt</h2>
  <input type="text" bind:value={currentQuestion} placeholder="Enter your question" />
  <input type="text" bind:value={currentResponse} placeholder="Enter your response" />
  <button on:click={promptUser}>Submit</button>
  <ul>
    {#each userResponses as response}
      <li>{response.question}: {response.response}</li>
    {/each}
  </ul>
</main>
