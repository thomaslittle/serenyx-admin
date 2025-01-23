<script lang="ts">
  import { Table } from '@bits-ui/table';
  import { createEventDispatcher } from 'svelte';
  import { fade } from 'svelte/transition';
  
  export let data: any[] = [];
  export let columns: {key: string, title: string, render?: (row: any) => string}[] = [];
  export let sortKey: string | null = null;
  export let sortDir: 'asc' | 'desc' = 'asc';
  
  const dispatch = createEventDispatcher();
</script>

<div class="rounded-md border">
  <Table.Root>
    <Table.Header>
      <Table.Row>
        {#each columns as column}
          <Table.Head 
            class="h-12 px-4 text-left align-middle font-medium text-muted-foreground hover:text-foreground cursor-pointer"
            on:click={() => dispatch('sort', { key: column.key })}
          >
            <div class="flex items-center gap-2">
              {column.title}
              {#if sortKey === column.key}
                <span class="text-xs opacity-50">
                  {sortDir === 'asc' ? '↑' : '↓'}
                </span>
              {/if}
            </div>
          </Table.Head>
        {/each}
      </Table.Row>
    </Table.Header>
    
    <Table.Body>
      {#each data as row (row.id)}
        <Table.Row class="border-t hover:bg-muted/50" in:fade|local>
          {#each columns as column}
            <Table.Cell class="p-4">
              {#if column.render}
                {@html column.render(row)}
              {:else}
                {row[column.key]}
              {/if}
            </Table.Cell>
          {/each}
        </Table.Row>
      {/each}
    </Table.Body>
  </Table.Root>
</div>