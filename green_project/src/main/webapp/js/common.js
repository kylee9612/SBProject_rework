/*
	jQuery 연결 이후 이용
 */

$('title').append($('h3.title_name').html());

/* top button */
$(window).scroll(function() {
	if ($(window).scrollTop() > 100) {
		$('.topBtn').css('display', 'block')
	} else {
		$('.topBtn').css('display', 'none')
	}
});

$('.topBtn').click(function() {
	$('html, body').animate({scrollTop:0}, 500);
});