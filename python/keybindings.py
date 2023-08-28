from IPython import get_ipython
from prompt_toolkit.enums import DEFAULT_BUFFER
from prompt_toolkit.keys import Keys
from prompt_toolkit.filters import HasFocus, HasSelection, ViInsertMode, EmacsInsertMode


ip = get_ipython()
insert_mode = ViInsertMode() | EmacsInsertMode()


def complete(event):
    buf = event.current_buffer
    suggestion = buf.suggestion
    if suggestion:
        buf.insert_text(suggestion.text)


# Register the shortcut if IPython is using prompt_toolkit
if getattr(ip, "pt_app", None):
    registry = ip.pt_app.key_bindings
    registry.add_binding(
        Keys.ControlSpace,
        filter=(HasFocus(DEFAULT_BUFFER) & ~HasSelection() & insert_mode),
    )(complete)
