namespace DateTime {
    public class Widgets.TimeBreak : Gtk.Grid {

        /* private static Widgets.TimeBreak? _time_break = null;
        public static unowned Widgets.TimeBreak get_default () {
            if (_time_break == null) {
                _time_break = new TimeBreak ();
            }
            return _time_break;
        } */

        public TimeBreak () {
            margin = 5;
            row_spacing = 10;

            var break_lbl = new Gtk.Label ("Break starts in:");
            break_lbl.expand = true;
            break_lbl.halign = Gtk.Align.CENTER;

            var break_reset_button = new Gtk.Button.with_label (_("Reset"));
            break_reset_button.halign = Gtk.Align.CENTER;
            break_reset_button.clicked.connect (() => {
                warning ("reset timer");
            });

            var break_run_button = new Gtk.Button.with_label (_("Run"));
            break_run_button.halign = Gtk.Align.CENTER;
            break_run_button.clicked.connect (() => {
                warning ("run breake");
            });

            attach (break_lbl, 0, 0, 2, 1);
            attach (break_run_button, 0, 1);
            attach (break_reset_button, 1, 1);
        }
    }
}
