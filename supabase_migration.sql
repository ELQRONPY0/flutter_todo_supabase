-- Migration file for Supabase
-- Copy and paste this into the SQL Editor in your Supabase dashboard

-- 1. Create the 'tasks' table
CREATE TABLE public.tasks (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  title text NOT NULL,
  description text,
  is_done boolean NOT NULL DEFAULT false,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.tasks ENABLE ROW LEVEL SECURITY;

-- 3. Create Policy: Authenticated users can select their own tasks
CREATE POLICY "Select own tasks" ON public.tasks
  FOR SELECT
  USING (user_id = auth.uid());

-- 4. Create Policy: Authenticated users can insert their own tasks
-- We check that the user_id being inserted matches the authenticated user's ID.
CREATE POLICY "Insert tasks" ON public.tasks
  FOR INSERT
  WITH CHECK (user_id = auth.uid());

-- 5. Create Policy: Authenticated users can update their own tasks
CREATE POLICY "Update own tasks" ON public.tasks
  FOR UPDATE
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());

-- 6. Create Policy: Authenticated users can delete their own tasks
CREATE POLICY "Delete own tasks" ON public.tasks
  FOR DELETE
  USING (user_id = auth.uid());

-- 7. (Optional) Set up Realtime for the tasks table
-- You usually need to enable this in the Supabase Dashboard:
-- Go to Database -> Replication -> Click "0 tables" (or source) -> Toggle "tasks" -> Save.
-- But you can also try to enable it via SQL for the publication:
alter publication supabase_realtime add table public.tasks;
