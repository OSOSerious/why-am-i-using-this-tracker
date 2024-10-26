<script>
  import { onMount } from 'svelte';

  let userResponses = [];
  let currentQuestion = '';
  let currentResponse = '';
  let errorMessage = '';
  let successMessage = '';

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

  async function promptUser() {
    try {
      const response = await fetch('/api/prompt_user', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json'
        },
        body: JSON.stringify({ question: currentQuestion, response: currentResponse })
      });
      const data = await response.json();
      if (data && data.data) {
        userResponses.push(data.data);
        successMessage = 'Response submitted successfully!';
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
  <h2>User Feedback Prompt</h2>
  {#if errorMessage}
    <p class="error">{errorMessage}</p>
  {/if}
  {#if successMessage}
    <p class="success">{successMessage}</p>
  {/if}
  <label for="question">Enter your question</label>
  <input type="text" id="question" bind:value={currentQuestion} placeholder="Enter your question" aria-label="Enter your question" />
  <label for="response">Enter your response</label>
  <input type="text" id="response" bind:value={currentResponse} placeholder="Enter your response" aria-label="Enter your response" />
  <button on:click={promptUser}>Submit</button>
  <ul>
    {#each userResponses as response}
      <li>{response.question}: {response.response}</li>
    {/each}
  </ul>
</main>
