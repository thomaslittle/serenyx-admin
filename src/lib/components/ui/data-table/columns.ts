import type { ColumnDef } from "@tanstack/table-core";
import { renderComponent } from "$lib/components/ui/data-table/index.js";
import { Checkbox } from "$lib/components/ui/checkbox/index.js";
 
export const columns: ColumnDef<Payment>[] = [
 // ...
 {
  id: "select",
  header: ({ table }) =>
   renderComponent(Checkbox, {
    checked: table.getIsAllPageRowsSelected(),
    indeterminate:
     table.getIsSomePageRowsSelected() &&
     !table.getIsAllPageRowsSelected(),
    onCheckedChange: (value) => table.toggleAllPageRowsSelected(!!value),
    "aria-label": "Select all",
   }),
  cell: ({ row }) =>
   renderComponent(Checkbox, {
    checked: row.getIsSelected(),
    onCheckedChange: (value) => row.toggleSelected(!!value),
    "aria-label": "Select row",
   }),
  enableSorting: false,
  enableHiding: false,
 },
];