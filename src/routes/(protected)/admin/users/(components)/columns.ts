import type { ColumnDef } from '@tanstack/table-core';
import type { User } from '../types';
import CheckboxCell from './data-table-checkbox-cell.svelte';
import EmailHeader from './data-table-email-header.svelte';
import RoleSelect from './data-table-role-select.svelte';

export function createColumns(roles: string[], updateUserRole: (userId: string, role: string) => void): ColumnDef<User>[] {
  return [
    {
      id: 'select',
      header: ({ table }) => ({
        component: CheckboxCell,
        props: {
          checked: table.getIsAllPageRowsSelected(),
          onCheckedChange: table.toggleAllPageRowsSelected
        }
      }),
      cell: ({ row }) => ({
        component: CheckboxCell,
        props: {
          checked: row.getIsSelected(),
          onCheckedChange: row.toggleSelected
        }
      })
    },
    {
      accessorKey: 'email',
      header: ({ column }) => ({
        component: EmailHeader,
        props: {
          onClick: () => column.toggleSorting(column.getIsSorted() === 'asc')
        }
      }),
      cell: ({ row }) => ({
        component: 'div',
        props: {
          class: 'font-medium',
          children: row.getValue('email')
        }
      })
    },
    {
      accessorKey: 'role',
      header: 'Role',
      cell: ({ row }) => ({
        component: RoleSelect,
        props: {
          value: row.getValue('role'),
          onChange: (value) => updateUserRole(row.original.id, value),
          options: [
            { value: '', label: 'Select Role' },
            ...roles.map(role => ({
              value: role,
              label: role.replace(/_/g, ' ').replace(/\b\w/g, (l) => l.toUpperCase())
            }))
          ]
        }
      })
    },
    {
      accessorKey: 'last_sign_in_at',
      header: 'Last Sign In',
      cell: ({ row }) => ({
        component: 'div',
        props: {
          class: 'text-neutral-500 dark:text-neutral-400',
          children: new Date(row.getValue('last_sign_in_at')).toLocaleString()
        }
      })
    }
  ];
} 