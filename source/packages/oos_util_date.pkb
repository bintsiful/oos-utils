create or replace package body oos_util_date
as


  /**
   * Coverts date to Unix Epoch time
   *
   * @issue #18
   *
   * @author Martin Giffy D'Souza
   * @created 30-Dec-2015
   * @param p_date Date to convert to Epoch format
   * @return Unix Epoch time
   */
  function date2epoch(
    p_date in date)
    return number
  as
    $if dbms_db_version.version >= 12 $then
      pragma udf;
    $end
  begin
    return
      round(
        (p_date - to_date ('19700101', 'yyyymmdd')) * 86400
        - (to_number(substr (tz_offset (sessiontimezone), 1, 3))+1) * 3600);

  end date2epoch;


  /**
   * Converts Unix linux time to Oracle date
   *
   * @issue 18
   *
   * @author Martin Giffy D'Souza
   * @created 31-Dec-2015
   * @param p_epoch Epoch Unix date (number)
   * @return date
   */
  function epoch2date(
    p_epoch in number)
    return date
  as

  begin
    return
      to_date ('19700101', 'yyyymmdd')
      + ((p_epoch + ((to_number(substr(tz_offset(sessiontimezone), 1, 3))+1) * 3600)) / 86400);
  end epoch2date;

end oos_util_date;
/
