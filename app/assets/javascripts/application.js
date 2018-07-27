// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require uikit
//= require_tree .



$(document).on('turbolinks:load', function () {
    // Show and hide alert on login
    if ($('.alert').html() == "") {
      $('.uk-alert-danger').hide()
    } else {
      $('.uk-alert-danger').show()
    }
    // Show modal on add listing
    $('#js-modal-prompt').click(function () {
      $('.uk-modal').show();
      details();
    });
    // Hide modal
    $('.uk-modal-close-default').click(function () {
      $('.uk-modal').hide();
    });
  
    if ($('div.edit-form').html !=""){
      details();
    }
    // Details tab
    function details() {
      $('.uk-switcher li').hide();
      $('li#details').show();
      $('.uk-tab li').removeClass('uk-active');
      $('.uk-tab li:nth-child(1)').addClass('uk-active');
    }
  
    $('a#tab-details').click(function () {
      details();
    });
      
    // Location tab
    function location() {
      $('.uk-switcher li').hide();
      $('li#location').show();
      $('.uk-tab li').removeClass('uk-active');
      $('.uk-tab li:nth-child(2)').addClass('uk-active');
    }
    
    $('a#tab-location').click(function () {
      location();
    });
    
    // Features tab
    function features() {
      $('.uk-switcher li').hide();
      $('li#features').show();
      $('.uk-tab li').removeClass('uk-active');
      $('.uk-tab li:nth-child(3)').addClass('uk-active');
    }
  
    $('a#tab-features').click(function () {
      features();
    });
  
    // Capitalize words
    function keyUp(e) {
      $(e).keyup(function () {
        var str = $(e).val();
        var spart = str.split(" ");
        for (var i = 0; i < spart.length; i++) {
          var j = spart[i].charAt(0).toUpperCase();
          spart[i] = j + spart[i].substr(1);
        }
        $(e).val(spart.join(" "));
      });
    }
  
    // add feature
    keyUp('#listing_temp');
    let tagsCount = 0;
    function addTag(tag){
      tagsCount += 1;
      let span_count = $('span.uk-badge').size();
      let uniqueTag = 0;
      if (span_count < 5) {
        if (span_count == 0 ){
          $('#tags-overflow').append(`<span class="uk-badge" id="${tagsCount}">${tag}<a id="${tagsCount}"> x</a></span>`);
          $('#listing_temp').val('');
        }else {
          for(x=1; x<= span_count; x++ ){
            let spanTag = $(`div span.uk-badge:nth-child(${x})`).text().replace(' x','');
            if (tag == spanTag ) {
              uniqueTag += 1;
            }
          }
          if (uniqueTag == 0){
            $('#tags-overflow').append(`<span class="uk-badge" id="${tagsCount}">${tag}<a id="${tagsCount}"> x</a></span>`);
            $('#listing_temp').val('');
          }
        }
      }
      $('span.uk-badge a').click(function () {
        let a_id = $(this).attr('id');
        $(`span#${a_id}`).remove();
      });
    }
  
    // Feature button
    $('div.feature-dropdown').hide();
    $('#listing_temp').click(function(){
      $('div#feature-dropdown-one').toggle();
    });
  
    $('#listing_temp').keypress(function(){
      $('div#feature-dropdown-one').hide();
    });
    
     // add tag by select
    $('a.dropdown-tags').click(function(){
      $('#listing_temp').val("");
      let span_count = $('span.uk-badge').size();
      if (span_count < 5){
        $(this).attr('background', '#a3c117')
      }
      addTag($(this).text());
    });
  
    // add tag by text
    $('#add-feature-tag').click(function () {
      let tag = $('#listing_temp').val();
      if (tag != "") {
        addTag(tag);
      }
    });
  
    // disable/enable edit
    if ($('select.status-select').val() == 'inactive'){
      $('div.uk-modal-header').addClass('disabledbutton');
      $('div.uk-modal-body').addClass('disabledbutton');
    }
  
    $('select.status-select').change(function(){
      if ($(this).val() == 'inactive'){
        $('div.uk-modal-header').addClass('disabledbutton');
        $('div.uk-modal-body').addClass('disabledbutton');
      }
      if ($(this).val() == 'active'){
        $('div.uk-modal-header').removeClass('disabledbutton');
        $('div.uk-modal-body').removeClass('disabledbutton');     
      }
    });
  
    $("#listing_property_type option:nth-child(1)").attr({disabled:true});
    $("#listing_contract_type option:nth-child(1)").attr({disabled:true});
    $("#listing_bedroom_type option:nth-child(1)").attr({disabled:true});
  
  });
  