<!-- src/routes/(protected)/admin/users/+page.svelte -->
<script lang="ts">
  import { supabase } from '$lib/supabase/client';
  import type { PageData } from './$types';
  import ChevronDown from 'lucide-svelte/icons/chevron-down';
  import {
    type ColumnDef,
    type ColumnFiltersState,
    type PaginationState,
    type RowSelectionState,
    type SortingState,
    type VisibilityState,
    getCoreRowModel,
    getFilteredRowModel,
    getPaginationRowModel,
    getSortedRowModel
  } from '@tanstack/table-core';
  import { createRawSnippet } from 'svelte';
  import DataTableCheckbox from '$lib/components/ui/data-table/data-table-checkbox.svelte';
  import DataTableEmailButton from '$lib/components/ui/data-table/data-table-email-button.svelte';
  import DataTableActions from '$lib/components/ui/data-table/data-table-actions.svelte';
  import * as Table from '$lib/components/ui/table/index.js';
  import { Button } from '$lib/components/ui/button/index.js';
  import * as DropdownMenu from '$lib/components/ui/dropdown-menu/index.js';
  import { Input } from '$lib/components/ui/input/index.js';
  import MoreHorizontal from 'lucide-svelte/icons/more-horizontal';
  import {
    FlexRender,
    createSvelteTable,
    renderComponent,
    renderSnippet
  } from '$lib/components/ui/data-table/index.js';
  import * as AlertDialog from '$lib/components/ui/alert-dialog/index.js';

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
  let showDeleteConfirm = $state(false);

  async function handleDeleteUser(userId: string) {
    try {
      // First try to delete from auth.users directly
      const { error: deleteError } = await supabase.rpc('delete_user', {
        input_user_id: userId
      });

      if (deleteError) {
        // Fallback to direct deletion if RPC fails
        const { error: directDeleteError } = await supabase
          .from('user_roles')
          .delete()
          .eq('user_id', userId);

        if (directDeleteError) throw directDeleteError;
      }

      // Update local state after successful deletion
      users = users.filter((user) => user.id !== userId);
    } catch (e: any) {
      error = e.message;
    }
  }

  const columns: ColumnDef<User>[] = [
    {
      id: 'select',
      header: ({ table }) =>
        renderComponent(DataTableCheckbox, {
          checked: table.getIsAllPageRowsSelected(),
          indeterminate: table.getIsSomePageRowsSelected() && !table.getIsAllPageRowsSelected(),
          onCheckedChange: (value) => table.toggleAllPageRowsSelected(!!value),
          'aria-label': 'Select all'
        }),
      cell: ({ row }) =>
        renderComponent(DataTableCheckbox, {
          checked: row.getIsSelected(),
          onCheckedChange: (value) => row.toggleSelected(!!value),
          'aria-label': 'Select row'
        }),
      enableSorting: false,
      enableHiding: false
    },
    {
      accessorKey: 'email',
      header: ({ column }) =>
        renderComponent(DataTableEmailButton, {
          onclick: () => column.toggleSorting(column.getIsSorted() === 'asc')
        }),
      cell: ({ row }) => {
        const emailSnippet = createRawSnippet<[string]>((getEmail) => {
          const email = getEmail();
          return {
            render: () => `<div class="lowercase">${email}</div>`
          };
        });
        return renderSnippet(emailSnippet, row.getValue('email'));
      }
    },
    {
      accessorKey: 'role',
      header: 'Role',
      cell: ({ row }) => {
        const roleSnippet = createRawSnippet<[string]>((getRole) => {
          const role = getRole();
          return {
            render: () => `<div class="capitalize">${role}</div>`
          };
        });
        return renderSnippet(roleSnippet, row.getValue('role'));
      }
    },
    {
      accessorKey: 'last_sign_in_at',
      header: 'Last Sign In',
      cell: ({ row }) => {
        const dateSnippet = createRawSnippet<[string]>((getDate) => {
          const date = new Date(getDate()).toLocaleString();
          return {
            render: () => `<div>${date}</div>`
          };
        });
        return renderSnippet(dateSnippet, row.getValue('last_sign_in_at'));
      }
    },
    {
      id: 'actions',
      cell: ({ row }) => {
        const user = row.original;
        return renderComponent(DataTableActions, {
          id: user.id,
          roles,
          currentRole: user.role,
          onRoleChange: updateUserRole,
          onDelete: handleDeleteUser
        });
      }
    }
  ];

  let pagination = $state<PaginationState>({ pageIndex: 0, pageSize: 10 });
  let sorting = $state<SortingState>([]);
  let columnFilters = $state<ColumnFiltersState>([]);
  let rowSelection = $state<RowSelectionState>({});
  let columnVisibility = $state<VisibilityState>({});

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
      get columnVisibility() {
        return columnVisibility;
      },
      get rowSelection() {
        return rowSelection;
      },
      get columnFilters() {
        return columnFilters;
      }
    },
    getCoreRowModel: getCoreRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    getSortedRowModel: getSortedRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    onPaginationChange: (updater) => {
      if (typeof updater === 'function') {
        pagination = updater(pagination);
      } else {
        pagination = updater;
      }
    },
    onSortingChange: (updater) => {
      if (typeof updater === 'function') {
        sorting = updater(sorting);
      } else {
        sorting = updater;
      }
    },
    onColumnFiltersChange: (updater) => {
      if (typeof updater === 'function') {
        columnFilters = updater(columnFilters);
      } else {
        columnFilters = updater;
      }
    },
    onColumnVisibilityChange: (updater) => {
      if (typeof updater === 'function') {
        columnVisibility = updater(columnVisibility);
      } else {
        columnVisibility = updater;
      }
    },
    onRowSelectionChange: (updater) => {
      if (typeof updater === 'function') {
        rowSelection = updater(rowSelection);
      } else {
        rowSelection = updater;
      }
    }
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
    const selectedRows = table.getFilteredSelectedRowModel().rows;
    showDeleteConfirm = true;
  }

  async function confirmBulkDelete() {
    try {
      loading = true;
      const selectedRows = table.getFilteredSelectedRowModel().rows;
      for (const row of selectedRows) {
        await handleDeleteUser(row.original.id);
      }
      showDeleteConfirm = false;
      rowSelection = {};
    } catch (e: any) {
      error = e.message;
    } finally {
      loading = false;
    }
  }
</script>

<div class="min-h-screen bg-white p-6 dark:bg-neutral-900">
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
        <p class="text-sm leading-none text-neutral-900 dark:text-white">{error}</p>
      </div>
    {/if}

    {#if loading}
      <div class="flex items-center justify-center p-8">Loading ...</div>
    {:else if users.length === 0}
      <div class="flex flex-col items-center justify-center p-8">
        <p class="text-neutral-500 dark:text-neutral-400">No users found.</p>
      </div>
    {:else}
      <div>
        <div class="flex items-center justify-between space-x-4 py-4">
          <div class="flex w-full items-center">
            <Input
              placeholder="Filter emails..."
              value={(table.getColumn('email')?.getFilterValue() as string) ?? ''}
              oninput={(e) => table.getColumn('email')?.setFilterValue(e.currentTarget.value)}
              onchange={(e) => {
                table.getColumn('email')?.setFilterValue(e.currentTarget.value);
              }}
              class=""
            />
            {#if table.getFilteredSelectedRowModel().rows.length > 0}
              <AlertDialog.Root bind:open={showDeleteConfirm}>
                <AlertDialog.Trigger>
                  <DropdownMenu.Root>
                    <DropdownMenu.Trigger>
                      <Button variant="outline">
                        Actions <ChevronDown class="ml-2 size-4" />
                      </Button>
                    </DropdownMenu.Trigger>
                    <DropdownMenu.Content align="end">
                      <DropdownMenu.Item onclick={handleBulkDelete}
                        >Delete Selected</DropdownMenu.Item
                      >
                    </DropdownMenu.Content>
                  </DropdownMenu.Root>
                </AlertDialog.Trigger>

                <AlertDialog.Portal>
                  <AlertDialog.Content>
                    <AlertDialog.Header>
                      <AlertDialog.Title>Are you absolutely sure?</AlertDialog.Title>
                      <AlertDialog.Description>
                        This action cannot be undone. This will permanently delete the following
                        user accounts:
                      </AlertDialog.Description>
                    </AlertDialog.Header>
                    <div class="max-h-[200px] overflow-y-auto py-4">
                      <ul class="list-inside list-disc space-y-2">
                        {#each table.getFilteredSelectedRowModel().rows as row}
                          <li>{row.original.email}</li>
                        {/each}
                      </ul>
                    </div>
                    <AlertDialog.Footer>
                      <AlertDialog.Cancel>Cancel</AlertDialog.Cancel>
                      <AlertDialog.Action onclick={confirmBulkDelete}
                        >Delete Users</AlertDialog.Action
                      >
                    </AlertDialog.Footer>
                  </AlertDialog.Content>
                </AlertDialog.Portal>
              </AlertDialog.Root>
            {/if}
          </div>
          <DropdownMenu.Root>
            <DropdownMenu.Trigger>
              <Button variant="outline">
                Columns <ChevronDown class="ml-2 size-4" />
              </Button>
            </DropdownMenu.Trigger>
            <DropdownMenu.Content align="end">
              {#each table.getAllColumns().filter((col) => col.getCanHide()) as column}
                <DropdownMenu.CheckboxItem
                  class="capitalize"
                  checked={column.getIsVisible()}
                  onCheckedChange={(checked) => column.toggleVisibility(!!checked)}
                >
                  {column.id}
                </DropdownMenu.CheckboxItem>
              {/each}
            </DropdownMenu.Content>
          </DropdownMenu.Root>
        </div>
        <div class="rounded-md border">
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
        <div class="flex items-center justify-end space-x-2 pt-4">
          <div class="flex-1 text-sm text-muted-foreground">
            {table.getFilteredSelectedRowModel().rows.length} of
            {table.getFilteredRowModel().rows.length} row(s) selected.
          </div>
          <div class="space-x-2">
            <Button
              variant="outline"
              size="sm"
              onclick={() => table.previousPage()}
              disabled={!table.getCanPreviousPage()}
            >
              Previous
            </Button>
            <Button
              variant="outline"
              size="sm"
              onclick={() => table.nextPage()}
              disabled={!table.getCanNextPage()}
            >
              Next
            </Button>
          </div>
        </div>
      </div>
    {/if}
  </div>
</div>
