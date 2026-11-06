# Daybook design system

## Surface

Daybook is a personal money-tracking dashboard for quick, repeated check-ins. It starts with a blank ledger, then shows only transactions entered by the signed-in person. Google OAuth and passwordless email sign-in are provided by Supabase; the transaction table is account-scoped with row-level security.

## Visual direction

- **Mode:** Operate.
- **World:** A cool, precise work surface with deep violet navigation, lilac data marks, white panels, and a single acid-mint signature.
- **Palette:** Ink `#17192f`, navy `#20224d`, action blue `#4647db`, mint `#d7fb6e`, ground `#f5f6fa`, paper `#ffffff`; green and red communicate income and expense.
- **Typography:** Native system UI sans-serif stack, tabular figures for amounts, compact labels, and strong size/weight contrast.
- **Components:** A Google/email account gate leads to a fixed desktop navigation rail, responsive top navigation on small screens, a broad balance ledger with a user-entered opening balance, recorded cash-flow and spending-category views, and compact transaction rows. Borders and spacing provide structure; decoration stays restrained.
- **Interaction:** Google OAuth and passwordless email sign-in, first-run Work/Personal choice, account-scoped cloud transactions and starting balance, amount privacy toggle, month navigation, transaction search and type filtering, CSV export, inline transaction entry, keyboard focus rings, and reduced-motion support.
- **Responsive behavior:** The sidebar collapses to an icon rail at tablet widths and becomes a compact horizontal header on mobile. Financial summaries, chart, budgets, transactions, and accounts reflow to one column on narrow screens.

## Data boundary

The dashboard contains no synthetic balances or transactions and has no bank connection. Transactions sync through Supabase after account and provider setup; the publishable client key is public, while provider secrets remain in Supabase.
