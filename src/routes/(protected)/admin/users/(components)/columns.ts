import type { ColumnDef } from '@tanstack/table-core';
import { renderComponent } from '$lib/components/ui/data-table';
import { Button } from '$lib/components/ui/button';
import { Checkbox } from '$lib/components/ui/checkbox';
import ArrowUpDown from 'lucide-svelte/icons/arrow-up-down';
import type { User } from '../types';

export const columns: ColumnDef<User>[] = [
  {
    id: 'select',
    header: ({ table }) => 
      renderComponent(Checkbox, {
        checked: table.getIsAllPageRowsSelected(),
        onchange: (e) => table.toggleAllPageRowsSelected(!!e.currentTarget.checked),
        ariaLabel: 'Select all'
      }),
    cell: ({ row }) => 
      renderComponent(Checkbox, {
        checked: row.getIsSelected(),
        onchange: (e) => row.toggleSelected(!!e.currentTarget.checked),
        ariaLabel: 'Select row'
      }),
    enableSorting: false,
    enableHiding: false
  },
  {
    accessorKey: 'email',
    header: ({ column }) =>
      renderComponent(Button, {
        variant: 'ghost',
        onclick: () => column.toggleSorting(column.getIsSorted() === 'asc'),
        children: ['Email', renderComponent(ArrowUpDown, { class: 'ml-2 h-4 w-4' })]
      }),
    cell: ({ row }) =>
      renderComponent('div', {
        class: 'font-medium',
        children: [row.getValue('email')]
      }),
    enableColumnFilter: true,
    filterFn: 'includesString'
  },
  {
    accessorKey: 'role',
    header: 'Role',
    cell: ({ row }) => {
      const user = row.original;
      if (!roles || roles.length === 0) return '';

      return renderComponent('select', {
        class: 'rounded-md bg-neutral-200 px-2 py-1 text-sm text-neutral-900 dark:bg-neutral-700 dark:text-white',
        value: user.role,
        onchange: (e) => updateUserRole(user.id, e.currentTarget.value),
        children: [
          renderComponent('option', { value: '', children: ['Select Role'] }),
          ...roles.map((role) =>
            renderComponent('option', {
              value: role,
              children: [role.replace(/_/g, ' ').replace(/\b\w/g, (l) => l.toUpperCase())]
            })
          )
        ]
      });
    }
  },
  {
    accessorKey: 'last_sign_in_at',
    header: 'Last Sign In',
    cell: ({ row }) =>
      renderComponent('div', {
        class: 'text-neutral-500 dark:text-neutral-400',
        children: [new Date(row.getValue('last_sign_in_at')).toLocaleString()]
      })
  }
]; 