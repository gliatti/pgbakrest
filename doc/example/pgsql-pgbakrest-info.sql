-- An example of monitoring pgBakRest from within PostgreSQL
--
-- Use copy to export data from the pgBakRest info command into the jsonb
-- type so it can be queried directly by PostgreSQL.

-- Create monitor schema
create schema monitor;

-- Get pgBakRest info in JSON format
create function monitor.pgbakrest_info()
    returns jsonb AS $$
declare
    data jsonb;
begin
    -- Create a temp table to hold the JSON data
    create temp table temp_pgbakrest_data (data text);

    -- Copy data into the table directly from the pgBakRest info command
    copy temp_pgbakrest_data (data)
        from program
            'pgbakrest --output=json info' (format text);

    select replace(temp_pgbakrest_data.data, E'\n', '\n')::jsonb
      into data
      from temp_pgbakrest_data;

    drop table temp_pgbakrest_data;

    return data;
end $$ language plpgsql;
