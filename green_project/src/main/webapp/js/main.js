
$(function() {
	$('.date').daterangepicker({
		"locale": {
			"format": "YYYY-MM-DD",
			"separator": " ~ ",
			"applyLabel": "확인",
			"cancelLabel": "취소",
			"fromLabel": "From",
			"toLabel": "To",
			"customRangeLabel": "Custom",
			"weekLabel": "W",
			"daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
			"monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		},
		"startDate": new Date(),
		"endDate": new Date(),
		"drops": "auto"
	}, function(start, end, label) {
		console.log('New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')');
	});
});

$('.pre_btn').css('display', 'none');
$('.next_btn').click(function() {
	$('.next_btn').css('display', 'none');
	let wid = $('.recommend_item_wrap').width();
	$('.recommend_item_wrap ul li').css('transform', `translateX(-${wid}px)`);
	$('.pre_btn').css('display', 'block');
});
$('.pre_btn').click(function() {
	$('.pre_btn').css('display', 'none');
	let wid = $('.recommend_item_wrap').width();
	$('.recommend_item_wrap ul li').css('transform', `translateX(0)`);
	$('.next_btn').css('display', 'block');
});

$(document).scroll(function() {
	if ($(document).scrollTop() >= $('header').innerHeight()) {
		$('.top_box').addClass('normal_top')
	} else {
		$('.top_box').removeClass('normal_top')
	}
});