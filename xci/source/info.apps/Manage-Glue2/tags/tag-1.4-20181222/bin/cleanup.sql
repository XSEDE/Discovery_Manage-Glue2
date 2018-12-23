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
\qecho Purging older than 28 days from glue2.glue2_db_acceleratorenvironment
delete from glue2.glue2_db_acceleratorenvironment
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_acceleratorenvironment;

\qecho Purging older than 28 days from glue2.glue2_db_accesspolicy
delete from glue2.glue2_db_accesspolicy
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_accesspolicy;

\qecho Purging older than 28 days from glue2.glue2_db_admindomain
delete from glue2.glue2_db_admindomain
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_admindomain;

\qecho Purging older than 28 days from glue2.glue2_db_computingactivity
delete from glue2.glue2_db_computingactivity
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingactivity;

\qecho Purging older than 28 days from glue2.glue2_db_computingmanager
delete from glue2.glue2_db_computingmanager
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingmanager;

\qecho Purging older than 28 days from glue2.glue2_db_computingmanageracceleratorinfo
delete from glue2.glue2_db_computingmanageracceleratorinfo
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingmanageracceleratorinfo;

\qecho Purging older than 28 days from glue2.glue2_db_computingqueue
delete from glue2.glue2_db_computingqueue
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingqueue;

\qecho Purging older than 28 days from glue2.glue2_db_computingshare
delete from glue2.glue2_db_computingshare
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingshare;

\qecho Purging older than 28 days from glue2.glue2_db_computingshareacceleratorinfo
delete from glue2.glue2_db_computingshareacceleratorinfo
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_computingshareacceleratorinfo;

\qecho Purging older than 28 days from glue2.glue2_db_contact
delete from glue2.glue2_db_contact
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_contact;

\qecho Purging older than 28 days from glue2.glue2_db_executionenvironment
delete from glue2.glue2_db_executionenvironment
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_executionenvironment;

\qecho Purging older than 28 days from glue2.glue2_db_location
delete from glue2.glue2_db_location
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_location;

\qecho Purging older than 28 days from glue2.glue2_db_userdomain
delete from glue2.glue2_db_userdomain
  where "CreationTime" < current_timestamp - interval '28 days';
vacuum analyze glue2.glue2_db_userdomain;

\qecho Purging older than 28 days from glue2.monitoring_db_testresult
delete from glue2.monitoring_db_testresult
  where "CreationTime" < current_timestamp - interval '28 days';
  vacuum analyze glue2.monitoring_db_testresult;

\qecho Purging older than 56 days from glue2.glue2_db_entityhistory
delete from glue2.glue2_db_entityhistory
  where "ReceivedTime" < current_timestamp - interval '56 days';
-- vacuum analyze glue2.glue2_db_entityhistory;
