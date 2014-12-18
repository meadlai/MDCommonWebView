/*!
 * common.js v0.0.1, 2014/12/03
 * By meadlai,
 * ref::: http://amsul.ca/pickadate.js/date.htm
 * 
 */

var isOnPc=!(/Android|webOS|iPhone|iPad|iPod|BlackBerry/i.test(navigator.userAgent));


document.write([
                    '<link rel="stylesheet" href="lib/themes/default.css" id="theme_base">'
                    ,'<link rel="stylesheet" href="lib/themes/default.date.css" id="theme_date">'
                    ,'<link rel="stylesheet" href="lib/themes/default.time.css" id="theme_time">'
                    ,'<script src="lib/picker.js"></script>'
                    ,'<script src="lib/picker.date.js"></script>'
                    ,'<script src="lib/picker.time.js"></script>'
                ].join(""));
$(document).ready(function(){
    if(isOnPc){
        $('.datepicker').pickadate({formatSubmit: 'yyyy-mm-dd',format: 'yyyy-mm-dd 00:00:00'});
        $('.timepicker').pickadate();
    }
});



