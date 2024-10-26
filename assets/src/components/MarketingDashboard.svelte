<script>
  import { onMount } from 'svelte';

  let marketingData = [];

  async function fetchMarketingData() {
    const response = await fetch('/api/marketing_data');
    const data = await response.json();
    marketingData = data.data;
  }

  onMount(() => {
    fetchMarketingData();
  });
</script>

<main>
  <h2>Marketing Dashboard</h2>
  <table>
    <thead>
      <tr>
        <th>ID</th>
        <th>Campaign</th>
        <th>Budget</th>
        <th>Spent</th>
        <th>ROI</th>
      </tr>
    </thead>
    <tbody>
      {#each marketingData as data}
        <tr>
          <td>{data.id}</td>
          <td>{data.campaign}</td>
          <td>{data.budget}</td>
          <td>{data.spent}</td>
          <td>{data.roi}</td>
        </tr>
      {/each}
    </tbody>
  </table>
</main>
