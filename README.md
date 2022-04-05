
The goal of this series is to make it easier to share evolving data and
other R objects across projects and with your colleagues.

Compared to a previous meetup about pins, this one presents pins 1.0.0,
which includes a new more explicit API and greater support for
versioning.

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

### Share data as pins with Dropbox

This meetup covers how to share data as pins with Dropbox.

Objectives:

-   Read the latest version of a pin.
-   List all pins.
-   Explore the available versions of one specific dataset.
-   Explore the metadata for a version of a pin.
-   Read a specific version.

### Next (tentative)

-   Managing pins: Create boards, and read/write/delete/prune versioned
    pins.
-   Using pins to save computations and downloads.

## Resources

-   YouTube [playlist](https://bit.ly/ds-incubator-videos).
-   The
    [ds-incubator](https://github.com/2DegreesInvesting/ds-incubator#ds-incubator)
    project.
-   [Ideas](https://bit.ly/dsi-ideas) for future meetups.
-   The [pins](https://pins.rstudio.com/) package.
-   Materials
    ([ds.pins/releases](https://github.com/2DegreesInvesting/ds.pins/releases)).
