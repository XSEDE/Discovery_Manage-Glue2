\t on

/* Children before parents */
\qecho Purging older than 28 days from glue2.glue2_db_endpoint
delete from glue2.glue2_db_endpoint
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_endpoint;

\qecho Purging older than 28 days from glue2.glue2_db_abstractservice
delete from glue2.glue2_db_abstractservice
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_abstractservice;

/* Children before parents */
\qecho Purging older than 28 days from glue2.glue2_db_applicationhandle
delete from glue2.glue2_db_applicationhandle
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_applicationhandle;

\qecho Purging older than 28 days from glue2.glue2_db_applicationenvironment
delete from glue2.glue2_db_applicationenvironment
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_applicationenvironment;

/* These don't have children/parents */
\qecho Purging older than 28 days from glue2.glue2_db_computingactivity
delete from glue2.glue2_db_computingactivity
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingactivity;

\qecho Purging older than 28 days from glue2.glue2_db_computingmanager
delete from glue2.glue2_db_computingmanager
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingmanager;

\qecho Purging older than 28 days from glue2.glue2_db_computingshare
delete from glue2.glue2_db_computingshare
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingshare;

\qecho Purging older than 28 days from glue2.glue2_db_executionenvironment
delete from glue2.glue2_db_executionenvironment
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_executionenvironment;

\qecho Purging older than 28 days from glue2.glue2_db_location
delete from glue2.glue2_db_location
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_location;

\qecho Purging older than 90 days from glue2.glue2_db_entityhistory
delete from glue2.glue2_db_entityhistory
  where "ReceivedTime" < current_timestamp - interval '90 days';
-- vacuum analyze glue2.glue2_db_entityhistory;
