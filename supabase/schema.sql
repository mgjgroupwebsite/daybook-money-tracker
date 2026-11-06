create table if not exists public.daybook_transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  name text not null check (char_length(name) between 1 and 70),
  note text not null default '',
  category text not null check (char_length(category) between 1 and 50),
  type text not null check (type in ('income', 'expense')),
  amount numeric(12, 2) not null check (amount > 0),
  transaction_date date not null,
  created_at timestamptz not null default now()
);

create index if not exists daybook_transactions_user_date_idx
  on public.daybook_transactions (user_id, transaction_date desc, created_at desc);

alter table public.daybook_transactions enable row level security;

drop policy if exists "Users can read their own transactions" on public.daybook_transactions;
create policy "Users can read their own transactions"
  on public.daybook_transactions for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can add their own transactions" on public.daybook_transactions;
create policy "Users can add their own transactions"
  on public.daybook_transactions for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own transactions" on public.daybook_transactions;
create policy "Users can update their own transactions"
  on public.daybook_transactions for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can delete their own transactions" on public.daybook_transactions;
create policy "Users can delete their own transactions"
  on public.daybook_transactions for delete
  to authenticated
  using ((select auth.uid()) = user_id);

grant select, insert, update, delete on public.daybook_transactions to authenticated;

create table if not exists public.daybook_settings (
  user_id uuid primary key default auth.uid() references auth.users (id) on delete cascade,
  opening_balance numeric(12, 2) not null default 0,
  account_type text check (account_type in ('personal', 'work'))
);

alter table public.daybook_settings
  add column if not exists account_type text check (account_type in ('personal', 'work'));

alter table public.daybook_settings enable row level security;

drop policy if exists "Users can read their own settings" on public.daybook_settings;
create policy "Users can read their own settings"
  on public.daybook_settings for select
  to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "Users can add their own settings" on public.daybook_settings;
create policy "Users can add their own settings"
  on public.daybook_settings for insert
  to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "Users can update their own settings" on public.daybook_settings;
create policy "Users can update their own settings"
  on public.daybook_settings for update
  to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

grant select, insert, update on public.daybook_settings to authenticated;
