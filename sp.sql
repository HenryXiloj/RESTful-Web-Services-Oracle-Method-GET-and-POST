create or replace PROCEDURE ws_restful
( urlRest in varchar2,
  json in varchar2
)
IS
  req utl_http.req;
  res utl_http.resp;
  url varchar2(4000) := urlRest;
  name varchar2(4000);
  buffer varchar2(4000);
  content varchar2(4000) := json;

BEGIN
  req := utl_http.begin_request(url, 'POST',' HTTP/1.1');
  utl_http.set_header(req, 'user-agent', 'mozilla/4.0');
  utl_http.set_header(req, 'content-type', 'application/json');
  utl_http.set_header(req, 'Content-Length', length(content));

  utl_http.write_text(req, content);
  res := utl_http.get_response(req);
  -- process the response from the HTTP call
  BEGIN
    loop
      utl_http.read_line(res, buffer);
      dbms_output.put_line(buffer);
    end loop;
    utl_http.end_response(res);
  exception
    when utl_http.end_of_body
    then
      utl_http.end_response(res);
  END;
END;