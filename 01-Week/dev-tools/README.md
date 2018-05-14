# JS Debugging
---

### Objectives
*After this lesson, students will be able to:*

- Identify and resolve common and uncommon "logical errors" that affect the results of your program
- Use logs to troubleshoot errors in an application (console log in Dev Tools)
- Conduct real-time debugging in the browser (start small, triangulation, remove code)
- Access properties of a class using helper methods ( `typeof` for datatypes)
- Use debuggers and breakpoints to identify logical errors in expressions

---

## Debugging Javascript

---

- As applications and websites get more and more complex, we need increasingly powerful tools to help us detect bugs, typos, implementation errors.
- Our goal as a developer is to find problems and fix them quickly and efficiently
- When developing websites, the easiest way to debug any javascript is to use Chrome debugging tools

---

### Debugging in Chrome

You can open the Chrome DevTools with:

```sh
option + command + i
```

---

#### The Sources Panel

- The `Sources` panel helps us visualize what's going on when we load JavaScript code. It provides a way for us to debug our code in an interactive way. Follow the steps below to explore the Sources panel:
- Open the starter code in Chrome and make sure the Chrome DevTools panel is opened. Go to the `Sources` panel.
- If it is not already selected, select **Sources**.

---

#### Debugging with breakpoints

- A breakpoint is an instruction given to a program via a keyword to pause the execution of a script. 
- The Chrome DevTools let you pause execution of a script and see what's going on.
- There are also multiple commands the allow us to streamline this process

---

#### Add and remove breakpoint

- On the left side of the panel, click on a line number where you want to stop the execution of the code. 
- The line number will be highlighted with a blue arrow to show the breakpoint.

---

#### Multiple breakpoints

- You can add several breakpoints in the scripts, and every time a breakpoint is set, the execution will stop. 
- You can enable and disable the breakpoints using the checkboxes on the right sidebar.
- It is possible to access a breakpoint by clicking on it in the source on the left.
- A breakpoint can be removed by clicking on the blue arrow on the left.

---

#### Debugger keyword

- Another way of setting breakpoints in the code is to use the `debugger` keyword. 
- If the console is open and the interpreter is going through a line in the code that contains `debugger`, then the console will highlight this line and the console will be in the context of the `debugger`.

```javascript
debugger

setTimeout(function(){
  alert("Loaded");
}, 0);
```

---

- The DevTools console drawer will allow you to experiment within the scope of where the debugger is currently paused. 
- Hit the **Esc** key to bring the console into view. The Esc key also closes this section.
- Add `debugger` statements

---

### Main Methods
- **Continue**: continues code execution until we encounter another breakpoint.
- **Step over**: step through code line-by-line to get insights into how each line affects the variables being updated. Should your code call another function, the debugger won't jump into its code, instead stepping over so that the focus remains on the current function.
- **Step into**: like Step over, however clicking Step into at the function call will cause the debugger to move its execution to the first line in the functions definition.
- **Step out**: having stepped into a function, clicking this will cause the remainder of the function definition to be run and the debugger will move its execution to the parent function.
- **Toggle breakpoints**: toggles breakpoints on/off while leaving their enabled states intact.

---

#### Hotkeys
There are also several related keyboard shortcuts available in the Sources panel:

| Execution | Shortcut |
|-----------|----------|
| Continue | `F8` or `Command + /` |
| Step over | `F10` or `Command+'` |
| Step into | `F11` or `Command+;`  |
| Step out | `Shift+F11` or `Shift+Command+;` |
| Next call frame | `Ctrl+.` |
| Previous call frame | `Ctrl+,` |

---

#### Interact with paused breakpoints

- Once you have one or more breakpoints set, return to the browser window and interact with your page.
- Spend 5 minutes practicing

---

### Pretty Print option

- In production mode, JavaScript in a website will be minified, meaning that variable names are condensed and spaces and line breaks are removed. This can make the source code unreadable, and difficult to debug.
- You can re-format the code using the "Pretty Print" button of the bottom left side of the panel `{}`. This makes the code more easy to read and debug.

---

## Practice Time (15 mins)

Debug the code using the Chrome development tools. Uncomment:

```js
  <script type="text/javascript" src="./js/debug.js"></script>
```

Get the functions to log out, one after the other.

---

## Conclusion

- Javascript debugging tools have improved significantly over the last few years. 
- Learn how to leverage debugging chrome and the tools available for you. 
- The best resource is google: https://developer.chrome.com/devtools/docs/javascript-debugging
