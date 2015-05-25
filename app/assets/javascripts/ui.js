$(document).ready(function() {
	
	// reply comment
	if($('#comment-form')) {
		var form = $('#comment-form');

		$('.reply').on('click', function(e) {
			e.preventDefault();
			var $this = $(this),
				cancelBtn = '<button type="button" class="btn btn-default pull-right btn-cancel">Cancel</button>',
                commentId = '<input type="hidden" id="parent" name="parent_id" value="'+ $this.attr('id') +'">';

            $(commentId).appendTo(form.find('.form-group'));
			$this.after(form.html());
            console.log(form.html());
			$this.next().append(cancelBtn);
			$this.prop('disabled', true);

			$('.btn-cancel').on('click', function(e) {
				e.preventDefault();
				$(this).parent().remove();
				$this.prop('disabled', false);
			});
		});
	}

});