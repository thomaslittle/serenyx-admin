<!-- src/routes/(protected)/admin/users/+page.svelte -->
<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import type { PageData } from './$types';
  import {
    type ColumnDef,
    type ColumnFiltersState,
    type PaginationState,
    type SortingState,
    getCoreRowModel,
    getFilteredRowModel,
    getPaginationRowModel,
    getSortedRowModel
  } from '@tanstack/table-core';
  import { createSvelteTable, FlexRender } from '$lib/components/ui/data-table/index.js';
  import * as Table from '$lib/components/ui/table/index.js';
  import { Input } from '$lib/components/ui/input/index.js';
  import { Button } from '$lib/components/ui/button/index.js';
  import * as DropdownMenu from '$lib/components/ui/dropdown-menu/index.js';
  import ChevronDown from 'lucide-svelte/icons/chevron-down';
  import { columns } from './(components)/columns';

  const { data } = $props<{ data: PageData }>();

  type User = {
    id: string;
    email: string;
    role: string;
    last_sign_in_at: string;
  };

  let users = $state(data.users || []);
  let roles = data.availableRoles || [];
  let loading = $state(false);
  let error = $state<string | null>(null);

  let pagination = $state<PaginationState>({ pageIndex: 0, pageSize: 10 });
  let sorting = $state<SortingState>([]);
  let columnFilters = $state<ColumnFiltersState>([]);

  const table = createSvelteTable({
    get data() {
      return users;
    },
    columns,
    state: {
      get pagination() {
        return pagination;
      },
      get sorting() {
        return sorting;
      },
      get columnFilters() {
        return columnFilters;
      }
    },
    onPaginationChange: (updater) => {
      pagination = typeof updater === 'function' ? updater(pagination) : updater;
    },
    onSortingChange: (updater) => {
      sorting = typeof updater === 'function' ? updater(sorting) : updater;
    },
    onColumnFiltersChange: (updater) => {
      columnFilters = typeof updater === 'function' ? updater(columnFilters) : updater;
    },
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel()
  });

  async function updateUserRole(userId: string, newRole: string) {
    try {
      const { error: updateError } = await supabase.rpc('set_role', {
        input_user_id: userId,
        input_role: newRole
      });

      if (updateError) throw updateError;

      users = users.map((user) => (user.id === userId ? { ...user, role: newRole } : user));
    } catch (e: any) {
      error = e.message;
    }
  }

  async function handleBulkDelete() {
    const selectedIds = table.getFilteredSelectedRowModel().rows.map((row) => row.original.id);
    try {
      const { error: deleteError } = await supabase.from('users').delete().in('id', selectedIds);

      if (deleteError) throw deleteError;
      users = users.filter((user) => !selectedIds.includes(user.id));
    } catch (e: any) {
      error = e.message;
    }
  }
</script>

<div class="min-h-screen bg-white p-8 dark:bg-neutral-900">
  <div class="mx-auto max-w-7xl">
    <div class="md:flex md:items-center md:justify-between">
      <div class="min-w-0 flex-1">
        <h2
          class="font-heading text-2xl font-bold uppercase text-neutral-900 dark:text-white sm:text-3xl"
        >
          Users
        </h2>
      </div>
    </div>

    {#if error}
      <div class="mt-4 flex items-center gap-2 rounded-md border border-primary/40 p-2">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width="24"
          height="24"
          viewBox="0 0 24 24"
          class="stroke-primary"
        >
          <g fill="none" stroke-linecap="round" stroke-linejoin="round" stroke-width="1.5">
            <path d="M20 16v2m0 4.01l.01-.011M4 6v6s0 3 7 3s7-3 7-3V6" />
            <path d="M11 3c7 0 7 3 7 3s0 3-7 3s-7-3-7-3s0-3 7-3m0 18c-7 0-7-3-7-3v-6" />
          </g>
        </svg>
        <p class="text-sm capitalize leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    {#if loading}
      <div class="flex items-center justify-center p-8">Loading ...</div>
    {:else if users.length === 0}
      <div class="flex flex-col items-center justify-center p-8">
        <p class="text-neutral-500 dark:text-neutral-400">No users found.</p>
      </div>
    {:else}
      <div class="mt-8">
        <div class="flex items-center py-4">
          <Input
            placeholder="Filter emails..."
            value={(table.getColumn('email')?.getFilterValue() as string) ?? ''}
            on:input={(e) => table.getColumn('email')?.setFilterValue(e.currentTarget.value)}
            class="max-w-sm"
          />
          {#if table.getFilteredSelectedRowModel().rows.length > 0}
            <DropdownMenu.Root>
              <DropdownMenu.Trigger>
                <Button variant="outline" class="ml-2">
                  Actions <ChevronDown class="ml-2 size-4" />
                </Button>
              </DropdownMenu.Trigger>
              <DropdownMenu.Content align="end">
                <DropdownMenu.Item on:click={handleBulkDelete}>Delete Selected</DropdownMenu.Item>
              </DropdownMenu.Content>
            </DropdownMenu.Root>
          {/if}
          <DropdownMenu.Root>
            <DropdownMenu.Trigger>
              <Button variant="outline" class="ml-auto">
                Columns <ChevronDown class="ml-2 size-4" />
              </Button>
            </DropdownMenu.Trigger>
            <DropdownMenu.Content align="end">
              {#each table.getAllColumns().filter((col) => col.getCanHide()) as column}
                <DropdownMenu.CheckboxItem
                  class="capitalize"
                  checked={column.getIsVisible()}
                  on:click={() => column.toggleVisibility()}
                >
                  {column.id}
                </DropdownMenu.CheckboxItem>
              {/each}
            </DropdownMenu.Content>
          </DropdownMenu.Root>
        </div>

        <div class="overflow-hidden rounded-lg bg-neutral-100 shadow dark:bg-neutral-800">
          <Table.Root>
            <Table.Header>
              {#each table.getHeaderGroups() as headerGroup (headerGroup.id)}
                <Table.Row>
                  {#each headerGroup.headers as header (header.id)}
                    <Table.Head class="[&:has([role=checkbox])]:pl-3">
                      {#if !header.isPlaceholder}
                        <FlexRender
                          content={header.column.columnDef.header}
                          context={header.getContext()}
                        />
                      {/if}
                    </Table.Head>
                  {/each}
                </Table.Row>
              {/each}
            </Table.Header>
            <Table.Body>
              {#each table.getRowModel().rows as row (row.id)}
                <Table.Row data-state={row.getIsSelected() && 'selected'}>
                  {#each row.getVisibleCells() as cell (cell.id)}
                    <Table.Cell class="[&:has([role=checkbox])]:pl-3">
                      <FlexRender
                        content={cell.column.columnDef.cell}
                        context={cell.getContext()}
                      />
                    </Table.Cell>
                  {/each}
                </Table.Row>
              {:else}
                <Table.Row>
                  <Table.Cell colspan={columns.length} class="h-24 text-center">
                    No results.
                  </Table.Cell>
                </Table.Row>
              {/each}
            </Table.Body>
          </Table.Root>
        </div>

        <div class="flex items-center justify-end space-x-2 py-4">
          <div class="flex-1 text-sm text-muted-foreground">
            {table.getFilteredSelectedRowModel().rows.length} of
            {table.getFilteredRowModel().rows.length} row(s) selected.
          </div>
          <div class="flex items-center space-x-2">
            <Button
              variant="outline"
              size="sm"
              on:click={() => table.previousPage()}
              disabled={!table.getCanPreviousPage()}
            >
              Previous
            </Button>
            <Button
              variant="outline"
              size="sm"
              on:click={() => table.nextPage()}
              disabled={!table.getCanNextPage()}
            >
              Next
            </Button>
            <select
              value={table.getState().pagination.pageSize}
              on:change={(e) => table.setPageSize(Number(e.currentTarget.value))}
              class="rounded-md border p-1 text-sm"
            >
              {#each [10, 20, 30, 40, 50] as size}
                <option value={size}>Show {size}</option>
              {/each}
            </select>
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
