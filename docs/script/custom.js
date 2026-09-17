// https://stackoverflow.com/questions/4425198/can-i-create-links-with-target-blank-in-markdown
// Make all none docs links open in a new tab
$(document.links).filter(function() {
    return this.hostname != window.location.hostname;
}).attr('target', '_blank');
