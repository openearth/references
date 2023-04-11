\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_casedoc}
              [2011/07/26 v0.1 Deltares Validation Case Document]
% This small package is intended for the 'wrapper' LaTeX document
% to produce a memo for a single validation test case.

\LoadClass{deltares_memo}
\makeatletter
\RequirePackage[nofancy]{svninfo}

% Set memo date to current SVN revision's date.
\svnInfo $Id: deltares_casedoc.cls 19332 2011-11-10 19:48:59Z mooiman $
\memoDate{\svnInfoLongDate}

%
\newcommand{\casesection}[1]{%
\section*{#1}
}
