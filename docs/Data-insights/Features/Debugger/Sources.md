title: Sources
# Debugger Sources

Sources a configurable via the top left section of the [Debugger](Overview.md).

The sources section allows you to configure and view the source code
which will be shown when you are stepping through code with the
[Interactive Debugger](Overview.md).

Additionally, you will be able to view files in your configured sources
via the source code viewer in the [Debugger](Overview.md).

If no sources are configured then the FusionReactor Production Debugger,
"Debugger", will work fine, but you will only see decompiled code in the
Thread View. If you configure the source directory where your code is
located then the debugger will show the correct source when stepping
through the code.

## Adding a Source Directory

Initially, with no sources configured, you should click the link in the
sources section to be taken to the **Add Source** window.

![](/Data-insights/Features/Debugger/images/245553061.png)

However, if you already have sources directories configured, you can add
a new source directory by selecting **Configure Sources** to open the
configuration window and then selecting **Add Source** on the bottom
right.

![](/Data-insights/Features/Debugger/images/245553055.png)

In either case, you can now select the root directory where your source
code resides.

You need to ensure that the root is correct.

If you have a project with a file like :

```
/home/username/project1/src/main/java/com/intergral/test/Test.java
```

then the root source directory must be
/home/username/project1/src/main/java/ , because this is the start of
the package declaration.

## Remove a Source Directory

You can remove a source directory from the debugger by pressing the red
X **Delete** button.

## Disabling a Source Directory

You can disable a source directory so that it's no longer used to scan
for source code in the debugger by using the **Enable / Disable**
check-box.

## Ordering

The ordering of the source directories is important as they are checked
in order (top-down). If you have two `index.jsp` files in 2 different
source directories then the top one will be used first (unless its
disabled).

If a single source directory has two copies of the same file then the
file used in the debugger will be the first one found using
[breadth first](https://en.wikipedia.org/wiki/Breadth-first_search) scan. 
