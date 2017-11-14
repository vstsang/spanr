$('#datepicker').datetimepicker({
  daysOfWeekDisabled: [0, 6],
  format: 'DD/MM/YYYY',
  inline: true,
  showTodayButton: true,
  keepOpen: true,
  tooltips: { today: 'Go to today' },
  icons: { today: 'glyphicon glyphicon-calendar' }
});
