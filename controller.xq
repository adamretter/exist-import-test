xquery version "3.1";
declare namespace m="http://menology.obdurodon.org/model";

declare variable $exist:root external;
declare variable $exist:prefix external;
declare variable $exist:controller external;
declare variable $exist:path external;
declare variable $exist:resource external;

declare variable $uri as xs:anyURI := request:get-uri();
declare variable $context as xs:string := request:get-context-path();
declare variable $fqcontroller as xs:string := concat($context, $exist:prefix, $exist:controller, '/');

if ($exist:resource eq '') then
    <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
        <redirect url="index"/>
    </dispatch>
else
    if (not(contains($exist:resource, '.')))
    then
        <dispatch xmlns="http://exist.sourceforge.net/NS/exist">
            <forward url="{concat($exist:controller, '/modules', $exist:path, '.xq')}"/>
            <cache-control cache="no"/>
        </dispatch>
    else
        <ignore xmlns="http://exist.sourceforge.net/NS/exist">
            <cache-control cache="yes"/>
        </ignore>