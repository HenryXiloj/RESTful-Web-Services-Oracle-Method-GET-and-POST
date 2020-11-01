DECLARE 
    req     utl_http.req; 
    res     utl_http.resp; 
    urlrest VARCHAR2(100) := 'http://jsonplaceholder.typicode.com/posts/1'; 
    name    VARCHAR2(4000); 
    buffer  VARCHAR2(4000); 
BEGIN 
    req := utl_http.Begin_request(urlrest, 'GET', ' HTTP/1.1'); 
    utl_http.Set_header(req, 'user-agent', 'mozilla/4.0'); 
    utl_http.Set_header(req, 'content-type', 'application/json'); 
    res := utl_http.Get_response(req); 

    LOOP 
        utl_http.Read_line(res, buffer); 
        dbms_output.Put_line(buffer); 
    END LOOP; 

    utl_http.End_response(res); 
EXCEPTION 
    WHEN utl_http.end_of_body THEN 
      utl_http.End_response(res); 
END; 

DECLARE 
    req     utl_http.req; 
    res     utl_http.resp; 
    urlrest VARCHAR2(4000) := 'http://jsonplaceholder.typicode.com/posts'; 
    name    VARCHAR2(4000); 
    buffer  VARCHAR2(4000); 
    json    VARCHAR2(4000) := '{"title":"foo","body":"bar","userId":1}'; 
BEGIN 
    req := utl_http.Begin_request(urlrest, 'POST', ' HTTP/1.1'); 
    utl_http.Set_header(req, 'user-agent', 'mozilla/4.0'); 
    utl_http.Set_header(req, 'content-type', 'application/json'); 
    utl_http.Set_header(req, 'Content-Length', Length(json)); 
    utl_http.Write_text(req, json); 
    res := utl_http.Get_response(req); 

    BEGIN 
        LOOP 
            utl_http.Read_line(res, buffer); 

            dbms_output.Put_line(buffer); 
        END LOOP; 

        utl_http.End_response(res); 
    EXCEPTION 
        WHEN utl_http.end_of_body THEN 
          utl_http.End_response(res); 
    END; 
END; 
