// Custom checkbox
function setupLabel() {
    // Checkbox
    var checkBox = ".checkbox";
    var checkBoxInput = checkBox + " input[type='checkbox']";
    var checkBoxChecked = "checked";
    var checkBoxDisabled = "disabled";

    // Checkboxes
    if ($(checkBoxInput).length) {
        $(checkBox).each(function(){
            $(this).removeClass(checkBoxChecked);
        });
        $(checkBoxInput + ":checked").each(function(){
            $(this).parent(checkBox).addClass(checkBoxChecked);
        });
        $(checkBoxInput + ":disabled").each(function(){
            $(this).parent(checkBox).addClass(checkBoxDisabled);
        });
    };
};

$(document).ready(function(){
    $("html").addClass("has-js");

    // First let's prepend icons (needed for effects)
    $(".checkbox").prepend("<span class='icon'></span><span class='icon-to-fade'></span>");

    $(".checkbox").click(function(){
        setupLabel();
    });
    setupLabel();
});

