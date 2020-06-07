import $ from 'jquery';

function jsRoar(name) {
  alert(`I am ${name}. Hear me roar!`)
}

$(document).ready(function() {
  $('a#roar').on(
    'click',
    function() {
      jsRoar('JavaScript');
    }
  );
});