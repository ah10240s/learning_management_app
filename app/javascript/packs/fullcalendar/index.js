
import '../../stylesheets/fullcalendar/index.scss';
//require('moment');
//require('fullcalendar');

import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';

document.addEventListener('turbolinks:load', function() {
    var calendarEl = document.getElementById('calendar');

    var calendar = new Calendar(calendarEl, {
        plugins: [ dayGridPlugin, interactionPlugin ],

        //細かな表示設定
        locale: 'ja',
        timeZone: 'Asia/Tokyo',
        firstDay: 0,
        headerToolbar: {
            start: '',
            center: 'title',
            end: 'today prev,next' 
        },
        expandRows: true,
        stickyHeaderDates: true,
        buttonText: {
            today: '今日'
        }, 
        allDayText: '終日',
        height: "auto",
        navLinks: false,
        themeSystem: 'bootstrap',
        events: '/studyplans.json',
        businessHours: true,
        dayCellContent: function(e) {
            e.dayNumberText = e.dayNumberText.replace('日', '');
        }


    });

    calendar.render();
});
