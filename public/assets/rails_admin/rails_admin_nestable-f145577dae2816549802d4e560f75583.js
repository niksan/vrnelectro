(function() {
  jQuery(function() {
    var $tree_nodes, $tree_nodes_max_depth, $tree_nodes_options;
    $tree_nodes = $('#tree_nodes');
    $tree_nodes_options = {};
    $tree_nodes_max_depth = $tree_nodes.data('max-depth');
    if ($tree_nodes_max_depth && $tree_nodes_max_depth !== 'false') {
      $tree_nodes_options['maxDepth'] = $tree_nodes_max_depth;
    }
    return $tree_nodes.nestable($tree_nodes_options).on({
      change: function(event) {
        var serialized_tree;
        serialized_tree = $tree_nodes.nestable('serialize');
        return $.ajax({
          url: $tree_nodes.data('update-path'),
          type: 'POST',
          data: {
            tree_nodes: serialized_tree
          },
          success: function(data) {
            var $flash;
            $flash = $('<div>').addClass('nestable-flash alert').append($('<button>').addClass('close').data('dismiss', 'alert').html('&times;')).append($('<span>').addClass('body').html(data));
            $('#rails_admin_nestable').append($flash);
            return $flash.fadeIn(200).delay(2000).fadeOut(200, function() {
              return $(this).remove();
            });
          }
        });
      }
    });
  });

}).call(this);
