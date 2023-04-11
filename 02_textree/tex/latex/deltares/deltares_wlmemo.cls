\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_wlmemo}
              [2007/10/31 v1.0 Standard LaTeX document class]
\DeclareOption{onecolumn}{\OptionNotUsed}
\makeatletter
\newif\if@ddraft
\@ddraftfalse
\DeclareOption{ddraft}{%
    \@ddrafttrue%
}
\newif\if@dutch
\@dutchfalse
\DeclareOption{dutch}{%
    \@dutchtrue%
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,twoside,openright,a4paper,titlepage]{article}

%------------------------------------------------------------------------------

\usepackage[scaled=.92]{helvet}
\def\rmdefault{phv}
\DeclareMathSizes{\@xipt}{\@xipt}{8}{6}
\renewcommand{\ttdefault}{pcr} % courier lettertype, needed for bold face in verbatim environment

%------------------------------------------------------------------------------

\usepackage{sectsty}  % to set section fonts
\allsectionsfont{\fontfamily{phv}\selectfont} % helvetica

%------------------------------------------------------------------------------

\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[pdftex]{graphicx}
\usepackage{epstopdf}
\usepackage{color}
\usepackage{frcursive} % needed for 'write' letter (French Cursive), use in processes library
\usepackage{float} % needed to force the location of figures \begin{figure}[H]
\usepackage{textcomp} % needed for the promille sign: \textperthousand
\usepackage[final]{pdfpages} % needed for cover pages

\if@dutch
    \usepackage[dutch]{babel}
\else
    \usepackage[english]{babel}
\fi

\usepackage{svn-multi}
\usepackage{tabularx}
\usepackage{longtable}
\usepackage{verbatim}
\usepackage{upquote} % needed for realistic quotes in verbatim
\usepackage{fancyvrb} % needed for framed verbatim environment
\usepackage{calc}
\usepackage{wrapfig}
\usepackage{caption}
\usepackage{subcaption} % two or more figures in a figure-environment
\usepackage{url}
\usepackage{moreverb}
\usepackage{rotating} % needed for rotating text in tables
\usepackage{nameref}
\usepackage{import} % needed for nested \input{...} -> \import{...}{...}
\usepackage{marginnote} % needed to place the word TODO in the margin, also when it is used in tables

\usepackage{amstext} % for \text command in math environment
%
% to align equations left add [fleqn] as option to amsmath
%
\usepackage[fleqn]{amsmath}
\usepackage{amssymb}
\usepackage[detect-all=true]{siunitx}
\usepackage{paralist} % inline enumeration

\RequirePackage{transparent}
\definecolor{dbluelink}{RGB}{000,000,100} % the colour of hyper links in the pdf-document (daaark blue)
\usepackage{hyperref}
\hypersetup{pdfborder={0 0 0}, bookmarksnumbered=true, colorlinks=true, linkcolor=dbluelink, citecolor=dbluelink, urlcolor=dbluelink}
\usepackage{lastpage}

\usepackage{datetime} % to generate a timestamp
\settimeformat{hhmmsstime}
\renewcommand{\dateseparator}{-}
\yyyymmdddate

%------------------------------------------------------------------------------

\hoffset -1in \voffset -1in
\setlength{\baselineskip}{4.5mm}

\topmargin 1.5cm
\headheight 1cm
\headsep \baselineskip
\setlength{\textheight}{29.7cm-5cm-\baselineskip-2\baselineskip}
\footskip 1cm
% 1.5cm remaining

\oddsidemargin 3.5cm
\setlength{\textwidth}{21cm-5.5cm}
\marginparsep 0mm
\marginparwidth 0mm
\evensidemargin 2cm

%C5 paper format (formaat van envelope voor dubbel gevouwen A4; en user manaul MSheet)

%\setlength\paperheight{229mm}
%\setlength\paperwidth{162mm}
%\setlength{\textheight}{229mm-5cm-\baselineskip}
%\setlength{\textwidth}{162mm-5.5cm}


%------------------------------------------------------------------------------
%
% Automatically add label LastPage at end of document, not needed in template
% anymore (\label{LastPage} followed by \end{document} does not work).
%
\AtEndDocument{\clearpage
\addtocounter{page}{-1}%
\immediate\write\@auxout{%
\string\newlabel{LastPage}%
{{}{\thepage}}}%
\addtocounter{page}{1}%
}

%------------------------------------------------------------------------------
%
% newcommand for tableofcontents, listoffigures, listotables; taken from report.sty and macro MakeUppercase removed
% 4 nov 2008 Jan Mooiman
%
\renewcommand*\l@section{\@dottedtocline{1}{1.5em}{2.7em}}
\renewcommand*\l@subsection{\@dottedtocline{2}{4.2em}{3.6em}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{7.8em}{4.5em}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{12.3em}{5.4em}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{17.7em}{6.3em}}
\renewcommand*\l@figure{\l@section}
\renewcommand*\l@table{\l@figure}

\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begingroup
        \section*{\contentsname
        \@mkboth{%
           \contentsname}{\contentsname}}%
                \parskip\z@%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \endgroup
    }
\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \section*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \section*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
%------------------------------------------------------------------------------
\if@ddraft
    \def\draftname{}%
    \AtBeginDocument{%
    \RequirePackage{draftwatermark}%
    \SetWatermarkAngle{54.7}%
    \SetWatermarkScale{5}%
    \SetWatermarkFontSize{1cm}%
    \SetWatermarkLightness{0.92}%
    \SetWatermarkText{DRAFT}%

    \newcommand\sc@watermark{%
        \setlength{\@tempdimb}{.63\paperwidth}%
        \setlength{\@tempdimc}{-.58\paperheight}%
        \put(\strip@pt\@tempdimb,\strip@pt\@tempdimc){%
        \makebox(0,0){\rotatebox{\sc@wm@angle}{%
        \scalebox{\sc@wm@scale}{%
        \expandafter\expandafter\expandafter\textcolor
        \expandafter\sc@wm@colormodel\expandafter{\sc@wm@colorspecs}{%
        \fontsize{\sc@wm@fontsize}{10.0\sc@wm@fontsize}
        \selectfont
        \sc@wm@text}}}}}}
    }
\else
    \def\draftname{}
\fi
%------------------------------------------------------------------------------
\raggedbottom

\def\program#1{\gdef\@program{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\manualtype#1{\gdef\@manualtype{#1}}
\def\version#1{\gdef\@version{#1}}
\def\author#1{\gdef\@author{#1}}
\def\@subtitle{Subtitle}
\def\@manualtype{Manual}
\def\@version{X}

% \title{\@program\\\@subtitle\\\@manualtype}
\newcommand{\thechap}{$\;$\leftmark{}$\;$}

% MEMO header

\def\program#1{\gdef\@program{#1}}
\def\@program{Memo}
\def\memoVersion#1{\gdef\@memoVersion{#1}}
\def\memoTo#1{\gdef\@memoTo{#1}}
\def\memoFrom#1{\gdef\@memoFrom{#1}}
\def\memoSubject#1{\gdef\@memoSubject{#1}}
\def\memoDate#1{\gdef\@memoDate{#1}}
\def\memoTelephone#1{\gdef\@memoTelephone{#1}}
\def\memoEmail#1{\gdef\@memoEmail{#1}}
\def\memoCopy#1{\gdef\@memoCopy{#1}}
\def\memoAction#1{\gdef\@memoAction{#1}}

\def\@memoVersion{use \texttt{$\backslash$memoVersion\{\ldots\}}}
\def\@memoTo{use \texttt{$\backslash$memoTo\{\ldots\}}}
\def\@memoFrom{use \texttt{$\backslash$memoFrom\{\ldots\}}}
\def\@memoSubject{use \texttt{$\backslash$memoSubject\{\ldots\}}}
\def\@memoDate{use \texttt{$\backslash$memoDate\{\ldots\}}}
\def\@memoTelephone{use \texttt{$\backslash$memoTelephone\{\ldots\}}}
\def\@memoEmail{use \texttt{$\backslash$memoEmail\{\ldots\}}}
\def\@memoCopy{use \texttt{$\backslash$memoCopy\{\ldots\}}}
\def\@memoAction{use \texttt{$\backslash$memoAction\{\ldots\}}}

%------------------------------------------------------------------------------

%\def\tiny{\@setsize\tiny{7pt}\vipt\@vipt}
%\def\scriptsize{\@setsize\scriptsize{9.5pt}\viiipt\@viiipt}
%\def\large{\@setsize\large{14pt}\xiipt\@xiipt}
%\def\Large{\@setsize\Large{18pt}\xivpt\@xivpt}
%\def\LARGE{\@setsize\LARGE{22pt}\xviipt\@xviipt}
%\def\huge{\@setsize\huge{25pt}\xxpt\@xxpt}
%\def\Huge{\@setsize\Huge{30pt}\xxvpt\@xxvpt}
\def\HUGE{\@setsize\Huge{40pt}\xxvpt\@xxvpt}

\def\program#1{\gdef\@program{\selectfont #1}}
\def\title#1{\gdef\@title{\selectfont #1}}
\def\subtitle#1{\gdef\@subtitle{\selectfont #1}}
\def\author#1{\gdef\@author{\selectfont #1}}
%\def\reporttype#1{\gdef\@reporttype{\selectfont #1}}
%\def\reportdate#1{\gdef\@reportdate{\selectfont #1}}

%------------------------------------------------------------------------------
\newcommand{\helv}{%
\fontfamily{phv}\selectfont}

\if@dutch
    \def\@CopyTo{Kopie aan}
    \def\@Date{Datum}
    \def\@DirectLine{Doorkiesnummer}
    \def\@EMail{E-mail}
    \def\@From{Van}
    \def\@NumberOfPages{Aantal pagina's}
    \def\@Page{Bladzijde}
    \def\@Reference{Kenmerk}
    \def\@Subject{Onderwerp}
    \def\@To{Aan}
    \def\@Action{Actie}
\else
    \def\@CopyTo{Copy to}
    \def\@Date{Date}
    \def\@DirectLine{Direct line}
    \def\@EMail{E-mail}
    \def\@From{From}
    \def\@NumberOfPages{Number of pages}
    \def\@Page{Page}
    \def\@Reference{Reference}
    \def\@Subject{Subject}
    \def\@To{To}
    \def\@Action{Action}
\fi
%------------------------------------------------------------------------------
%
% Change header and footer
%
\usepackage{fancyhdr}
\newcommand{\headerfont}{\fontfamily{phv}\selectfont}

\pagestyle{fancy}
\fancyhead{}
\fancyhead[LO,RE]{\headerfont \@program: \@memoVersion}
\fancyhead[CO,CE]{\headerfont }
\fancyhead[RO,LE]{\headerfont \@memoDate \\Page \thepage}
\fancyfoot{}
\fancyfoot[LO,RE]{\headerfont }
\fancyfoot[CO,CE]{}
\fancyfoot[RO,LE]{\headerfont }

\fancypagestyle{plain}{%
    \fancyhead{}%
    \fancyhead[LO,RE]{\headerfont \@memoDate \\Page \thepage}%
    \fancyhead[CO,CE]{\headerfont }%
    \fancyhead[RO,LE]{\headerfont \@program: \@version}%
    \fancyfoot{}%
    \fancyfoot[LO,RE]{\headerfont }%
    \fancyfoot[CO,CE]{}%
    \fancyfoot[RO,LE]{\headerfont }
}
\fancypagestyle{frontmatterplain}{%
    \fancyhead{}
    \fancyhead[LO,RE]{\headerfont }
    \fancyhead[CO,CE]{\headerfont }
    \fancyhead[RO,LE]{\headerfont \@program: \@memoVersion}
    \fancyfoot{}
    \fancyfoot[LO,RE]{\headerfont }
    \fancyfoot[CO,CE]{}
    \fancyfoot[RO,LE]{\headerfont }
}

\addtocounter{secnumdepth}{1}
\setlength{\parskip}{\baselineskip/2}
\setlength{\parindent}{0pt}
\setlength{\parsep}{1pt}
\setlength{\partopsep}{1pt}

\def\itemhook{}
%------------------------------------------------------------------------------
%
% MEMO header
%
%------------------------------------------------------------------------------
\def\makememoHeader{
    \pagestyle{frontmatterplain}
    \begin{tabular}{@{}p{17mm}p{0mm}p{\textwidth-17mm-30pt}}
    \textbf{\@To}      & : & \@memoTo \\
    \textbf{\@From}    & : & \@memoFrom \\
    \textbf{\@Subject} & : & \@memoSubject \\
    \textbf{\@Date}    & : & \@memoDate \\
    %\textbf{\@CopyTo}  & : & \@memoCopy \\
    %\textbf{\@Action}  & : & \@memoAction \\
    [1ex]  \hline
    \end{tabular}
    \let\makememoHeader\relax
    \pagestyle{frontmatterplain}
}


%------------------------------------------------------------------------------
%
% To change the caption of tables and figures.
% Format is defautl or `hang' wich aligns caption to the right of the figure statement
\captionsetup{format=default,margin=0.9cm,font=small,labelfont=sl,textfont=sl}
%
%------------------------------------------------------------------------------
%
% Simple remark environment that always writes Remarks.
%
%\newenvironment{remark}%
%  {{\bf Remarks:}\setlength{\parskip}{0pt}%
%  \begin{itemize}{}{}}
%  {\end{itemize}}
%
%------------------------------------------------------------------------------
%
% Define a more advanced remark environment that writes Remark if there is only
% one item and that writes Remarks if there are multiple items.
%
\usepackage{ifthen}
%
\newcounter{n_sp_blocks}
\newcounter{n_sp_items}
\newenvironment{singleplural}[2]%
  {\addtocounter{n_sp_blocks}{1}%
   \ifthenelse{\equal{a\ref{sp_block\arabic{n_sp_blocks}}}{a1}}%
     {\textbf{#1:}}%
     {\textbf{#2:}}%
   \setlength{\parskip}{0pt}%
   \begin{list}{\labelitemi}{\usecounter{n_sp_items}}}
  {\label{sp_block\arabic{n_sp_blocks}}\end{list}}
%
\newenvironment{Remark}%
  {\begin{singleplural}{Remark}{Remarks}}
  {\end{singleplural}}
%
\newenvironment{Restriction}%
  {\begin{singleplural}{Restriction}{Restrictions}}
  {\end{singleplural}}
%
\newenvironment{Warning}%
%  {\color{red}\begin{singleplural}{Warning}{Warnings}}
  {\begin{singleplural}{Warning}{Warnings}}
  {\end{singleplural}}
%
\RecustomVerbatimEnvironment
  {Verbatim}{Verbatim}
  {fontsize=\footnotesize}
%
%------------------------------------------------------------------------------

\newenvironment{guilist}%
  {\begin{list}{}%
    {%
      \renewcommand{\makelabel}[1]%
        {\raisebox{0pt}[1ex][0pt]{\makebox[\labelwidth][l]%
          {\parbox[t]{\labelwidth}{\raggedright\hspace{0pt}##1}}}}%
      \setlength{\labelwidth}{3.7cm}%
      \setlength{\leftmargin}{\labelwidth+\labelsep}%
    }%
  }%
  {\end{list}}

%
%------------------------------------------------------------------------------
% Bring items closer together in list environments
%
\let\orig@Itemize =\itemize
\let\orig@Enumerate =\enumerate
\let\orig@Description =\description
% Zero the vertical spacing parameters
\def\Nospacing{\itemsep=0pt\topsep=0pt\partopsep=0pt\parskip=0pt\parsep=0pt}
\renewenvironment{itemize}{\orig@Itemize\Nospacing}{\endlist}
\renewenvironment{enumerate}{\orig@Enumerate\Nospacing}{\endlist}
\renewenvironment{description}{\orig@Description\Nospacing}{\endlist}

%\renewcommand\labelitemi{$\diamond$}
%\renewcommand\labelitemii{$\triangleright$}
%\renewcommand\labelitemiii{-}

\renewcommand{\labelenumi}{\arabic{enumi}}
\renewcommand{\labelenumii}{\arabic{enumi}.\arabic{enumii}}
\renewcommand{\labelenumiii}{\arabic{enumi}.\arabic{enumii}.\arabic{enumiii}}

\newenvironment{domain} % Added more spacing around the text in the header, 19/11/2008 RMC Spiteri
  {\textbf{Domain:}

   \small\begin{tabular}{|p{4.8cm}|p{2.4cm}|p{2.4cm}|p{2.4cm}|p{\textwidth-60pt-12cm}|} \hline  \STRUT
   \textbf{Parameter} & \textbf{Lower limit} & \textbf{Upper limit} & \textbf{Default} & \textbf{Unit} \\[1ex] \hline
   }
  {\end{tabular}}

\newenvironment{action}%
%  {\color{green}\begin{itemize}}%
  {\begin{itemize}}%
  {\end{itemize}}
%
%                             definition of varlist environment for listing
%                               variables and their meaning after a formula
%
%  X   : description
%  Y_n : description
%
\newcommand{\varlistcolon}{} % originally :
\newenvironment{varlist}%
  {\begin{list}{}{%
    \renewcommand{\makelabel}[1]{\quad{##1}\hfill\varlistcolon}%
    \setlength{\labelwidth}{3.7cm}% Changed to 3.7cm, 19/11/2008 RMC Spiteri
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{0pt}}}
  {\end{list}}

\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{\hss\llap{##1}}%
        \itemhook \csname itemhook\romannumeral\the\@itemdepth\endcsname}%
  \fi}
\renewenvironment{description}
                 {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                          \let\makelabel\descriptionlabel\descripthook}}
                 {\endlist}

\renewcommand{\itemhook}{%
  \setlength{\topsep}{\baselineskip/2}%
  \setlength{\itemsep}{0pt}%
  \setlength{\labelwidth}{1em}%
  \setlength{\labelsep}{2.25mm}%
  \setlength{\leftmargin}{1em+2.25mm}%
  \setlength{\parskip}{0pt}%
}%

%------------------------------------------------------------------------------

\newenvironment{symbollist}%
  {\begin{list}{}{%
    \renewcommand{\makelabel}[1]{\quad{##1}\hfill\varlistcolon}%
    \setlength{\labelwidth}{2.0cm}
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{0pt}}}
  {\end{list}}

%------------------------------------------------------------------------------

\newenvironment{options}%
  {\underline{Options:}
  \begin{list}{}%
    {%
      \renewcommand{\makelabel}[1]%
        {\raisebox{0pt}[1ex][0pt]{\makebox[\labelwidth][l]%
        {\parbox[t]{\labelwidth}{\raggedright\hspace{0pt}##1}}}}%
      \setlength{\labelwidth}{3.7cm}%
      \setlength{\leftmargin}{\labelwidth+\labelsep}%
    }%
  }%
  {\end{list}}

%------------------------------------------------------------------------------

\def\nonumchapter#1{%
    \chapter*{#1}%
    \addcontentsline{toc}{chapter}{#1}%
    \markboth{#1}{}}

%------------------------------------------------------------------------------

\newcommand{\clearemptydoublepage}{\newpage{\pagestyle{empty}\cleardoublepage}}
\newcommand{\STRUT}{\rule{0in}{3ex}}

\newcommand{\Deltares}{Deltares}
\newcommand{\WL}{{WL\,$|$\,Delft Hydraulics}}
\newcommand{\degr}{\ensuremath{^\circ}}
\newcommand{\tenlog}{ \ensuremath{\ {}^{10}\!\log} }

\newcommand{\window}[1]{\textbf{#1}}
\newcommand{\menu}[1]{\textit{#1}}
\newcommand{\button}[1]{\textit{#1}}
\newcommand{\file}[1]{$<${#1}$>$} 
\newcommand{\dir}[1]{$<${#1}$>$}  
\newcommand{\ginput}[1]{``#1''}
\newcommand{\command}[1]{{\normalfont\ttfamily #1}}
\newcommand{\block}[1]{\textbf{\rmfamily #1}}
\newcommand{\keyw}[1]{{\normalfont\ttfamily #1}}
\newcommand{\unitbrackets}[1]{[#1]}
\newcommand{\ext}[1]{$<$#1$>$}
\newcommand{\key}[1]{\texttt{#1}}
\newcommand{\function}[1]{\textit{#1}}

\DeclareRobustCommand\dotp{\mathpalette\dotp@{.5}} % bullet for the dot product
\newcommand\dotp@[2]{\mathbin{\vcenter{\hbox{\scalebox{#2}{$\m@th#1\bullet$}}}}}
\newcommand{\ssquare}{\stackrel{\scriptscriptstyle\square}{{}}} % small square for itemize list

\newcommand{\option}[1]{\vspace{0.5cm}\underline{#1}}  % Geeft een optie aan, vooral gebruikt in WAQ TRM
% todo macro: usage of package marginnote
\renewcommand*{\raggedleftmarginnote}{\raggedleft}
\renewcommand*{\raggedrightmarginnote}{\raggedright}
\newcommand{\todo}[1]{
    {\color[rgb]{0,0.2,0.5}\textbf{TODO(??):} }%
    \protect\marginnote{\textbf{TODO}}%
    {\color[rgb]{0,0.2,0.5}\slshape #1}%
}

%% Referencing
\newcommand*\Autoref[1]{% First letter is a capital, also from macro \Autoref
    \begingroup
        \if@dutch
            \def\appendixautorefname{Appendix}%
            \def\chapterautorefname{Hoofdstuk}%
            \def\equationautorefname~##1\null{Vergelijking~(##1)\null}
            \def\figureautorefname{Figuur}%
            \def\footnoteautorefname{Voetnoot}%
            \def\itemautorefname{Item}%
            \def\pageautorefname{Bladzijde}%
            \def\paragraphautorefname{Paragraaf}%
            \def\partautorefname{Deel}%
            \def\sectionautorefname{Paragraaf}%
            \def\subparagraphautorefname{Paragraaf}%
            \def\subsectionautorefname{Paragraaf}%
            \def\subsubsectionautorefname{Paragraaf}%
            \def\tableautorefname{Tabel}%
            \def\theoremautorefname{Theorema}%
        \else
            \def\appendixautorefname{Appendix}%
            \def\chapterautorefname{Chapter}%
            \def\equationautorefname~##1\null{Equation~(##1)\null}
            \def\figureautorefname{Figure}%
            \def\footnoteautorefname{Footnote}%
            \def\itemautorefname{Item}%
            \def\pageautorefname{Page}%
            \def\paragraphautorefname{Section}%
            \def\partautorefname{Part}%
            \def\sectionautorefname{Section}%
            \def\subparagraphautorefname{Section}%
            \def\subsectionautorefname{Section}%
            \def\subsubsectionautorefname{Section}%
            \def\tableautorefname{Table}%
            \def\theoremautorefname{Theorem}%
        \fi
        % ...
        \autoref{#1}%
    \endgroup%
}

\if@dutch % First letter is a lower case, also from macro \autoref
    \addto\extrasdutch{
        \def\appendixautorefname{appendix}%
        \def\chapterautorefname{hoofdstuk}%
        \def\equationautorefname~#1\null{vergelijking~(#1)\null}
        \def\figureautorefname{figuur}%
        \def\footnoteautorefname{voetnoot}%
        \def\itemautorefname{item}%
        \def\pageautorefname{bladzijde}%
        \def\paragraphautorefname{paragraaf}%
        \def\partautorefname{deel}%
        \def\sectionautorefname{paragraaf}%
        \def\subparagraphautorefname{paragraaf}%
        \def\subsectionautorefname{paragraaf}%
        \def\subsubsectionautorefname{paragraaf}%
        \def\tableautorefname{tabel}%
        \def\theoremautorefname{theorema}%
    }
\else
    \addto\extrasenglish{
        \def\appendixautorefname{Appendix}%
        \def\chapterautorefname{chapter}%
        \def\equationautorefname~#1\null{Equation~(#1)\null}
        \def\figureautorefname{Figure}%
        \def\footnoteautorefname{footnote}%
        \def\itemautorefname{item}%
        \def\pageautorefname{page}%
        \def\paragraphautorefname{section}%
        \def\partautorefname{Part}%
        \def\sectionautorefname{section}%
        \def\subparagraphautorefname{section}%
        \def\subsectionautorefname{section}%
        \def\subsubsectionautorefname{section}%
        \def\tableautorefname{Table}%
        \def\theoremautorefname{Theorem}%
    }
\fi

\newcommand{\Cref}[1]{\autoref{#1}}
\newcommand{\Sref}[1]{\autoref{#1}}
\newcommand{\Fref}[1]{\autoref{#1}}
\if@dutch
    \newcommand{\Frefs}[2]{Figuren~\ref{#1} en \ref{#2}}
    \newcommand{\Freft}[2]{Figuren~\ref{#1} tot \ref{#2}}
\else
    \newcommand{\Frefs}[2]{Figures~\ref{#1} and \ref{#2}}
    \newcommand{\Freft}[2]{Figures~\ref{#1} to \ref{#2}}
\fi
\newcommand{\Aref}[1]{\autoref{#1}}
\newcommand{\Apref}[1]{\autoref{#1}}
\newcommand{\Tref}[1]{\autoref{#1}}
\newcommand{\Eref}[1]{\autoref{#1}}


\hyphenation{bathy-metry fa-vour-able}

\def\execute{%
    \begingroup%
        \catcode`\%=12%
        \catcode`\\=12%
        \executeaux}%
        \def\executeaux#1{\immediate\write18{#1}%
    \endgroup%
}

\renewcommand\paragraph{\looseness-1%
                        \@startsection{paragraph}{4}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1pt}%
                                     {\fontfamily{phv}\normalsize\bfseries}}

%\def\promille{\leavevmode\kern-.05em
%\raise.5ex\hbox{\the\scriptfont0 0}\kern-.15em/\kern-.15em
%\lower.25ex\hbox{\the\scriptfont0 00}}

\newcommand{\promille}{%
  \relax\ifmmode\promillezeichen
        \else\leavevmode\(\mathsurround=0pt\promillezeichen\)\fi}
\newcommand{\promillezeichen}{%
  \kern-.05em%
  \raise.5ex\hbox{\the\scriptfont0 0}%
  \kern-.15em/\kern-.15em%
  \lower.25ex\hbox{\the\scriptfont0 00}}


%------------------------------------------------------------------------------

\newcommand{\diff}[3][1]{\ensuremath{\frac{d \ifthenelse{\equal{#1}{1}}{}{^#1} {#2}}{d {#3} \ifthenelse{\equal{#1}{1}}{}{^#1}}}}
\newcommand{\pdiff}[3][1]{\ensuremath{\frac{\partial \ifthenelse{\equal{#1}{1}}{}{^#1} {#2}}{\partial {#3} \ifthenelse{\equal{#1}{1}}{}{^#1}}}}

\newcommand{\perscomm}[1]{\citetext{#1, pers.\ comm.}}
\newcommand{\deltarestitle}{\makememoHeader}
\usepackage{natbib}
\bibpunct[, ]{(}{)}{;}{a}{,}{,}
\renewcommand\bibsection{}
\bibliographystyle{deltares_chicago_like}
%\usepackage{chapterbib}
\makeatother

