BBEdit LassoScript Codeless Language Module
###########################################

Read the article `BBEdit LassoScript Codeless Language Module
<http://www.stevepiercy.com/articles/bbedit-lassoscript-codeless-language-module/>`_.

Introduction
============

This article contains instructions on how to enable LassoScript syntax
coloring in BBEdit 8.5.5 and later with standard and your custom tags and
types. It can also be used to include and Lasso how to use AppleScript to
switch language modes between LassoScript, HTML and JavaScript.

This codeless language module is designed to work with both the LassoScript
``<?lassoscript ?>`` and square-bracket ``[]`` syntaxes for Lasso Professional
8.5.x and later.

Filenames must end with ``.lasso``, ``.las``, or ``.inc``. You can modify the
file ``LassoScript.plist`` to include other file suffixes.

The ``BBLMKeywordList`` is current as of Lasso Professional 8.6.3. To update
the BBLMKeywordList, edit ``LassoScript.plist`` as specified in the message
on LassoTalk `Subject: List of all LDML tags and keywords
<http://lasso.2283332.n4.nabble.com/List-of-all-LDML-tags-and-keywords-tp3097270p3097274.html>`_.

I modified the SQL statement from the above message as shown below.

Update the BBLMKeywordList
--------------------------

Step 1: Export tags, parameter names and parameter values
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Begin by going to the LassoAdmin database browser, under the SQL tab:
`http://localhost/DatabaseBrowser.0.LassoApp?tab1=sql
<http://localhost/DatabaseBrowser.0.LassoApp?tab1=sql>`_

Use the following search parameters.

Click `SQL Statement` heading.

==========  ==============
SQL Statement parameters
==========================
Datasource  Lasso Internal
Host        Internal
Database    LDML8_Reference
Table       Tags
==========  ==============

Click `Export` heading.

============    =============
Export parameters
=============================
Format          Tab Delimited
Field Names     No
Line Endings    UNIX/Mac OS X
============    =============

Click `Options` heading.

================    =============
Options parameters
=================================
Show Fields         All Fields
Max Records         All Records
Max Field Lines     All Lines
Submit on Return    No
================    =============

Enter the following in the SQL Statement field.

code-block:: sql

    SELECT tag_name FROM tags
    UNION
    SELECT DISTINCT param_name FROM parameters WHERE param_name LIKE '-%'
    UNION
    SELECT DISTINCT param_value FROM parameters WHERE param_value LIKE '-%'
    ORDER BY tag_name;

Click `Issue SQL Statement` button.

Click `Export Results` button.

Step 2: Clean up export in BBEdit
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Manually remove any symbols and other Types from the records (``!`` Not
Logical ... ``->`` Member).

After you have done that, you can either use the following process manually,
or you can use the AppleScript ``LDML_Prep.scpt`` which is included in the
repository. ``LDML_Prep.scpt`` executes the following steps in order.

Strip ``" ... "`` (spaces before and after) for matching container tags, then
a stray ``"..."`` (no spaces), then account for parameter values that are
comma-separated, then strip square brackets, then format for the plist.

===========     ========================================
Find            Replace
===========     ========================================
``" ... "``     ``\r``
``...``         (blank)
``-\r``         ``\r``
``", "``        ``\r``
``[``           (blank)
``]``           (blank)
``(.*)\r``      ``\t\t<string>\1</string>\r`` (use grep)
===========     ========================================

Step 3: Modify plist
^^^^^^^^^^^^^^^^^^^^

Paste results into my plist at the top of the BBLMKeywordList, select the
array of keywords, and use BBEdit's Text > Process Duplicate Lines command to
remove duplicate keywords.

Complete information on writing Codeless Language Modules can be found in the
BBEdit User Manual.

Installation Instructions
-------------------------

#. clone the GitHub repository `BBEdit_LassoScript_CLM
   <https://github.com/stevepiercy/BBEdit_LassoScript_CLM>`_ or download the
   ``.zip`` file
#. Backup and remove all other LDML Language Modules from
   ``~/Library/Application Support/BBEdit/Language Modules``. This avoids
   possible conflicts.
#. Move the file ``BBEditLDML/Language Modules/LassoScript.plist`` to
   ``~/Library/Application Support/BBEdit/Language Modules``.
#. Move the folder ``BBEditLDML/Scripts/06)Set Language to/`` and its contents
   to ``~/Library/Application Support/BBEdit/Scripts/``.
#. Restart BBEdit. This will load the new ``.plist`` and AppleScripts.  Next
   you configure BBEdit to use these items.
#. In BBEdit, select `BBEdit > Preferences > Languages > Lasso Script >
   Options... > General`.

   #. For adding multiline comments, enter ``/*`` and ``*/`` for `Comment start`
      and `Comment end`, respectively.
   #. For looking up selections in the local reference, for `Reference URL
      template` enter ``http://localhost/Reference.LassoApp?__SYMBOLNAME__``.
      Ctrl-click on a selection, and select Find in Reference. The local copy
      of your language reference should appear in a web browser and search for
      the selected text.
#. In BBEdit, select `BBEdit > Preferences > Languages > Suffix Mappings`. Map
   the file suffixes that you want to have lasso syntax highlighting to the
   appropriate language module.  You might need to `Add...` or `Change...`
   file suffixes. I recommend mapping ``.lasso``, ``.las``, and ``.inc``. For
   each suffix, set the name of the suffix, set the language to `Lasso
   Script`, and select the radio button for `Source File`.
#. Under the `Scripts` menu (the funny scroll icon shaped like an ``S``),
   select `Set Language to > LDML`.
#. You can set keyboard shortcuts for these scripts to easily switch language
   modes.  Select `Window > Palettes > Scripts`. Expand `Set Language to`.
   Select `HTML`. Click `Set Key...`. I use ``^H`` (CTRL-H) for HTML, and
   ``^L`` for LDML.
#. Create a new file, name it ``test.lasso``, set the language to `LDML`, and
   syntax coloring should work.

Use at your own risk!

Thanks to Johan Sölve, Adam Randall, Greg Willits and Chris Corwin for
contributions (with or without their knowledge).

Updates, suggestions and comments regarding this article may be sent to Steve
Piercy, `web@stevepiercy.com <web@stevepiercy.com>`_ or comment using Disqus.
