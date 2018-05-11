"""
Author: RedFantom
License: GNU GPLv3
Copyright (c) 2017-2018 RedFantom
"""
import ctypes
import inspect
from queue import Queue
import threading as td
from unittest import TestCase
from ttkthemes import ThemedTk
from ttkthemes._utils import is_python_3
if is_python_3():
    import tkinter as tk
    from tkinter import ttk
else:
    import Tkinter as tk
    import ttk


class ExceptionThread(td.Thread):
    """
    Thread that supports raising Exceptions from other Threads

    Based on code from an excellent StackOverflow answer by Philippe F:
    <https://stackoverflow.com/questions/323972>

    Allows raising an Exception using the raise_exc instance function.
    """
    def _get_thread_id(self):
        """
        Return the Thread ID of *this* Thread instance

        Determines the Thread ID of this Thread instance from another
        Thread.
        """
        if not self.is_alive():
            raise td.ThreadError("Thread is not active")
        if hasattr(self, "_thread_id"):  # Cached ID
            return self._thread_id
        for thread_id, thread_obj in td._active.items():
            if thread_obj is not self:
                continue
            return thread_id
        raise ValueError("Could not determine Thread ID")

    def raise_exception(self, exception: Exception):
        """
        Raise an Exception in the running Thread context

        Only exception types can be raised, not instances. Uses the
        ctypes Python API interface to raise the error in the Thread
        context.
        """
        if not inspect.isclass(exception):
            raise TypeError("Only types can be raised (not instances)")
        thread_id = ctypes.c_long(self._get_thread_id())
        exception = ctypes.py_object(exception)
        result = ctypes.pythonapi.PyThreadState_SetAsyncExc(thread_id, exception)
        if result == 0:
            raise ValueError("Invalid Thread ID")  # Should not occur
        elif result == 1:
            return True  # Success
        else:  # Failure
            ctypes.pythonapi.PyThreadState_SetAsyncExc(thread_id, 0)
            raise SystemError("SetAsyncExc failed with return code {}".format(result))


class TestThread(ExceptionThread):
    """
    Try to pack a single widget into a newly created MainWindow

    Returns the result of the attempt in a Queue instance that is passed
    at initialization. If the attempt fails
    """
    def __init__(self, theme: str, widget: tk.Widget, result_q: Queue):
        """
        :param theme: Theme to apply to ThemedTk instance
        :param widget: Widget to create and pack into window
        :param result_q: Queue to put the result in
        """
        if not inspect.isclass(widget):
            raise TypeError
        ExceptionThread.__init__(self)
        self.theme, self.widget, self.queue = theme, widget, result_q

    def run(self):
        """
        Create the main Window and then pack the Widget into it

        Runs a separate Timer Thread in order to raise the
        exception in the context if the creation of the widget fails
        """
        window = ThemedTk(theme=self.theme)
        # Create Exception Timer
        timer = td.Timer(5, self.raise_exception, args=[TimeoutError])
        timer.start()
        # Perform the operation
        self.widget(window).pack()
        window.update()
        window.update()
        window.destroy()
        # Cancel the timer (only on success)
        timer.cancel()
        # Put the result in the queue
        self.queue.put(True)

    def raise_exception(self, exception: Exception):
        """Raise the exception in Thread context and put False in queue"""
        self.queue.put(False)
        ExceptionThread.raise_exception(self, exception)


class TestThemedWidgets(TestCase):
    """
    Tkinter may crash if widgets are not configured properly in a theme.
    Therefore, in addition to checking if all files for a theme exist
    by loading it, this Test also tests every core ttk widget to see
    if the widget can be successfully created with the theme data.
    """
    WIDGETS = [
        "Label",
        "Treeview",
        "Button",
        "Frame",
        "Notebook",
        "Progressbar",
        "Scrollbar",
        "Scale",
        "Entry",
        "Combobox"
    ]

    def setUp(self):
        self.window = ThemedTk()

    def test_widget_creation(self):
        failed = 0
        for theme in self.window.themes:
            self.window.set_theme(theme)
            for widget in self.WIDGETS:
                widget_class = getattr(ttk, widget)
                queue = Queue()
                thread = TestThread(theme, widget_class, queue)
                thread.start()
                while queue.empty():
                    continue
                result = queue.get()
                if result is False:
                    print("[FAILURE] {}, {}".format(theme, widget))
                    failed += 1
        self.assertEqual(failed, 0)

    def tearDown(self):
        self.window.destroy()
