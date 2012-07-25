$(function() {
  $('img').click(function() {
    var id = $(this).data('id');
    var iframe = $('<iframe>')
      .attr('src', 'http://www.youtube.com/embed/' + id)
      .attr('width', 459)
      .attr('height', 344)
      .attr('frameborder', 0)
      .attr('allowfullscreen', true);
    $(this).replaceWith(iframe);
  });    
});

  