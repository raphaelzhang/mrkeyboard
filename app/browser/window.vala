using Gtk;

namespace Interface {
    public class Window : Gtk.Window {
        public Gtk.Box box;
        public int tab_id;
        public int window_id;
        public string buffer_id;
        public string buffer_name = "";
        public string mode_name;
        
        public signal void create_app_tab(int app_win_id, string mode_name, int tab_id);
        public signal void close_app_tab(string mode_name, string buffer_id);
        public signal void rename_app_tab(string mode_name, string buffer_id, string buffer_name);
        
        public Window(int width, int height, int tid, string bid) {
            tab_id = tid;
            buffer_id = bid;
            
            set_decorated(false);
            set_default_size(width, height);
            
            box = new Gtk.Box(Gtk.Orientation.VERTICAL, 0);
            add(box);
            
            init();
            
            mode_name = get_mode_name();
            
            realize.connect((w) => {
                    var xid = (int)((Gdk.X11.Window) get_window()).get_xid();
                    window_id = xid;
                    create_app_tab(window_id, mode_name, tab_id);
                });
        }
        
        public virtual string get_mode_name() {
            print("You need implement 'get_mode_name' in your application code.\n");
            
            return "";
        }
        
        public void handle_key_event(uint key_val, int key_state, uint32 key_time, bool press) {
            Gdk.EventKey* event;
            if (press) {
                event = (Gdk.EventKey*) new Gdk.Event(Gdk.EventType.KEY_PRESS);
            } else {
                event = (Gdk.EventKey*) new Gdk.Event(Gdk.EventType.KEY_RELEASE);
            }
            var window = get_event_window();
            event->window = window;
            event->keyval = key_val;
            event->state = (Gdk.ModifierType) key_state;
            event->time = key_time;
            ((Gdk.Event*) event)->put();
        }
        
        public virtual void init() {
            print("You need implement 'init' in your application code.\n");
        }
        
        public virtual Gdk.Window get_event_window() {
            print("You need implement 'get_event_window' in your application code.\n");
            
            return get_window();
        }
    }
}