
The goal of this series is to make it easier to share evolving data and
other R objects across projects and with your colleagues.

At the end of this series you will be able to do things like these:

-   Read and write data from a shared folder on Dropbox.
-   Use different versions of an evolving, dataset.
-   Download files but only if they haven’t changed since last time you
    did it.

## Who is the audience?

Analysts and developers at 2DII and beyond.

## Why is this important?

At 2DII we often need to share data across different processes,
projects, and colleagues.

For example:

-   You want to reuse one slow intermediate process into another process
    of the same analysis.

-   You want to use the same input dataset in different projects.

-   You want to share a problematic dataset with a colleague so you can
    debug it together.

> The pins package makes it easy to share R objects across projects and
> with your colleagues. You can pin objects to a variety of pin boards,
> including … Dropbox. Pins can be automatically versioned, making it
> straightforward to track changes, re-run analyses on historical data,
> and undo mistakes.

– <https://pins.rstudio.com/articles/pins.html>

## Syllabus

### Get started with a use case

-   Create a pins board in a local folder under \~/Dropbox/.
-   Write a dataset to a pin board.
-   Read a dataset from a pin board.
-   Overwrite a dataset in a pin board.
-   Write a new version of a dataset to a pin board.
-   Read a specific version of a dataset from a pin board.

### Read and write pins from and to a folder in your computer and Dropbox.

-   Read and write different versions of a pin.
-   Avoid computations by reusing previous results stored in a pins
    board.
-   Avoid re-downloading files from the internet unless they have
    changed.

## Resources

-   YouTube [playlist](https://bit.ly/ds-incubator-videos).
-   The
    [ds-incubator](https://github.com/2DegreesInvesting/ds-incubator#ds-incubator)
    project.
-   [Ideas](https://bit.ly/dsi-ideas) for future meetups.
-   The [pins](https://pins.rstudio.com/) package.
-   Materials
    ([ds.pins/releases](https://github.com/2DegreesInvesting/ds.pins/releases)).
