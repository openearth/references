\ProvidesClass{deltares_report}
              [2020/01/05 v2.0 Deltares report class]
\DeclareOption{onecolumn}{\OptionNotUsed}
\makeatletter

\newif\if@ddraft% deltares draft
\@ddraftfalse
\DeclareOption{ddraft}{%
    \@ddrafttrue%
}
\newif\if@dutch
\@dutchfalse
\DeclareOption{dutch}{%
    \@dutchtrue%
}
\newif\if@spanish
\@spanishfalse
\DeclareOption{spanish}{%
    \@spanishtrue%
}
\newif\if@signature
\@signaturefalse
\DeclareOption{signature}{%
    \@signaturetrue%
}
\newif\if@dbiblatex%  deltares biblatex
\@dbiblatexfalse
\DeclareOption{biblatex}{%
    \@dbiblatextrue%
}
\newif\if@subfooter
\@subfooterfalse
\DeclareOption{subfooter}{%
    \@subfootertrue%
}
\newif\if@arial
\@arialfalse
\DeclareOption{arial}{%
    \@arialtrue%
}
\newif\if@druler
\@drulerfalse
\DeclareOption{druler}{%
    \@drulertrue%
}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass[11pt,openright,a4paper,titlepage]{report}

%------------------------------------------------------------------------------
%
%\usepackage{hvmaths} % commercial
%
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\if@arial
    \pdfmapfile{+winfonts.map}
    \def\rmdefault{arial}
\else
    \usepackage[scaled=0.92]{helvet}
    \def\rmdefault{phv}
\fi
\DeclareMathSizes{\@xipt}{\@xiipt}{8}{6}
\renewcommand{\ttdefault}{pcr} % courier lettertype, needed for bold face in verbatim environment

%
%------------------------------------------------------------------------------
\usepackage{lipsum}
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage[pdftex]{graphicx}
\usepackage{epstopdf}
\usepackage{color}
\usepackage[table]{xcolor}
\usepackage{frcursive} % needed for 'write' letter (French Cursive), use in processes library
\usepackage{float} % needed to force the location of figures \begin{figure}[H]
\usepackage{textcomp} % needed for the promille sign: \textperthousand
\usepackage{xspace} % needed for spaces behind a macro, but no space before punctuation
\usepackage{xstring} % needed for string handling (GIT repository, branch and hash)
\usepackage{catchfile} % needed for GIT repository, branch and hash
\usepackage[final]{pdfpages} % needed for cover pages
\usepackage[detect-all=true]{siunitx}

\if@dutch
    \usepackage[dutch]{babel}
\else
    \if@spanish
        \usepackage[spanish, es-tabla]{babel}
    \else
        \usepackage[english]{babel}
    \fi
\fi

\usepackage{svn-multi}
\usepackage{tabularx}
\usepackage{longtable}
\usepackage{verbatim}
\usepackage{upquote} % needed for realistic quotes in verbatim
\usepackage{fancyvrb} % needed for framed verbatim environment
\usepackage{calc} % adding, substracting, multiplying of lengths
\usepackage{wrapfig}
\usepackage{caption}
\usepackage{subcaption} % two or more figures in a figure-environment
\usepackage{url}
\urlstyle{same}
\usepackage{moreverb}
\usepackage[smallscripts]{moresize}
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
\usepackage{paralist} % inline enumeration

\usepackage{hyperref}
\hypersetup{pdfborder={0 0 0}, bookmarksnumbered=true, colorlinks=true, linkcolor=dbluelink, citecolor=dbluelink, urlcolor=dbluelink}

% Because the \newif have side effects, use \newtoggle
\usepackage{etoolbox}% http://ctan.org/pkg/etoolbox: needed for conditional list of figures and list of tables

\usepackage{nomencl}
\usepackage[intoc]{deltares_nomentbl}  % adjusted for the table of content
\usepackage{bookmark}
\usepackage{adjustbox}
\usepackage{booktabs}
\usepackage{minitoc}

\usepackage[yyyymmdd]{datetime} % to generate a timestamp
\settimeformat{hhmmsstime}
\renewcommand{\dateseparator}{-}

\newcommand{\topline}{\specialrule{1.0pt}{0pt}{0pt}}
\newcommand{\midline}{\specialrule{0.25pt}{0pt}{0pt}}
\newcommand{\bottomline}{\topline}
\renewcommand{\arraystretch}{1.33}  % 6 mm = 1.33 * 4.5 ( 4.5==\baselineskip)

%------------------------------------------------------------------------------

\hoffset -1in \voffset -1in
\setlength{\baselineskip}{4.5mm}
\linespread{0.941}
\raggedright

\setlength{\topmargin}{0mm}
\headheight 3\baselineskip
\headsep 0\baselineskip
% until text = \topmargin + \headheight + \headsep == 6\baselineskip
\footskip 6\baselineskip
\setlength{\textheight}{297mm-\headsep-\headheight-9\baselineskip}
%foothoogte 2\baselineskip
% 1.5cm remaining

\setlength{\oddsidemargin}{47mm}
\setlength{\evensidemargin}{47mm}
\setlength{\textwidth}{182mm - \oddsidemargin} % 135mm

\setlength{\marginparwidth}{18mm}
\setlength{\marginparsep}{4.5mm}
\let\oldmarginpar\marginpar
\renewcommand\marginpar[1]{\-\oldmarginpar[\raggedleft\footnotesize #1]%
{\raggedright\footnotesize #1}}

\widowpenalty=3000
\clubpenalty=3000

\renewcommand{\cleardoublepage}{
  \clearpage\if@twoside \ifodd\c@page\else
  \hbox{}
  \vspace*{\fill}
  \begin{center}
%    \textit{This page intentionally left blank}
  \end{center}
  \vspace*{\fill}
  \thispagestyle{empty}
  \newpage
  \if@twocolumn\hbox{}\newpage\fi\fi\fi
}
%------------------------------------------------------------------------------
%
% front- and mainmatter commands as known from book.cls, now extended with
% pagestyle, such that page numbers are: i,ii, and 1 of 10, 2 of 10, etc.
% respectively. front- and mainmatter commands automatically set in
% \reporttitle
\newif\if@mainmatter \@mainmattertrue
\newcommand\frontmatter{%
    \cleardoublepage
    \@mainmatterfalse
    \pagenumbering{arabic}%
    \pagestyle{frontmatterplain}%
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
\newcommand\mainmatter{%
    \cleardoublepage
    \@mainmattertrue
    \pagenumbering{arabic}
    \pagestyle{headings}
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
\newcommand\emptymatter{%  no coloured footer
    \pagestyle{empty}
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
\usepackage{deltares_footer}
\if@druler
    \usepackage{deltares_ruler}
\fi
\usepackage{deltares_backcover}

%------------------------------------------------------------------------------
%
% copy of tweaklist.sty, to adjust itemize, enumerate and description
%
\def\enumhook{}
\def\enumhooki{}
\def\enumhookii{}
\def\enumhookiii{}
\def\enumhookiv{}
\def\itemhook{}
\def\itemhooki{}
\def\itemhookii{}
\def\itemhookiii{}
\def\itemhookiv{}
\def\descripthook{}

\def\enumerate{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
    \expandafter
    \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{##1}%
          \enumhook \csname enumhook\romannumeral\the\@enumdepth\endcsname}%
  \fi}
\def\itemize{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
      \expandafter
      \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{##1}%
        \itemhook \csname itemhook\romannumeral\the\@itemdepth\endcsname}%
  \fi}
\renewenvironment{description}
                 {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                          \let\makelabel\descriptionlabel\descripthook}}
                 {\endlist}

\renewcommand{\itemhook}{%
    \setlength{\topsep}{0pt}%
    \setlength{\itemsep}{0pt}%
    \setlength{\labelwidth}{1em}%
    \setlength{\labelsep}{2.25mm}%
    \setlength{\leftmargin}{1em+2.25mm}%
    \setlength{\parsep}{0pt}%
    \setlength{\parskip}{0pt}%
    \setlength{\partopsep}{0pt}%
}%
\renewcommand{\enumhook}{%
    \setlength{\topsep}{0pt}%
    \setlength{\itemsep}{0pt}%
    \setlength{\labelwidth}{1em}%
    \setlength{\labelsep}{2.25mm}%
    \setlength{\leftmargin}{1em+2.25mm}%
    \setlength{\parsep}{0pt}%
    \setlength{\parskip}{0pt}%
    \setlength{\partopsep}{0pt}%
}%
\renewcommand{\descripthook}{%
    \setlength{\topsep}{0pt}%
    \setlength{\itemsep}{0pt}%
    \setlength{\labelwidth}{4.5mm}%
    \setlength{\labelsep}{4.5mm}%
    \setlength{\leftmargin}{9.0mm}%
    \setlength{\parsep}{0pt}%
    \setlength{\parskip}{0pt}%
    \setlength{\partopsep}{0pt}%
}
%------------------------------------------------------------------------------
%
% newcommand for tableofcontents, listoffigures, listotables; taken from report.sty and macro MakeUppercase removed
% 4 nov 2008 Jan Mooiman
%
\usepackage{tocloft}
\setcounter{tocdepth}{3} % i.e. chapter, section and subsection
\renewcommand{\cfttoctitlefont}{\Large\bfseries\raggedright}
\renewcommand{\@tocrmarg}{9mm plus1fil}
\cftsetindents{part}{-19mm}{45mm}
\cftsetindents{chapter}{-19mm}{19mm}
%\cftsetindents{section}{-19mm}{23.5mm}
%\cftsetindents{subsection}{-19mm}{23.5mm}
%\cftsetindents{subsubsection}{-19mm}{23.5mm}
%\cftsetindents{paragraph}{-19mm}{23.5mm}
%\cftsetindents{subparagraph}{-19mm}{23.5mm}
%\cftnodots{}
\newlength{\mylen}   % a "scratch" length
\setlength{\mylen}{45mm} % extra space
\addtolength{\cftpartnumwidth}{\mylen} % add the extra space
\newlength{\tocindent}  % needed for nomenclature reference in table of contents
\setlength{\tocindent}{19mm}

\renewcommand{\@dotsep}{10000}
%\renewcommand*\l@chapter{\@dottedtocline{0}{-19mm}{23.5mm}}
\renewcommand*\l@section{\@dottedtocline{1}{-19mm}{23.5mm}}
\renewcommand*\l@subsection{\@dottedtocline{2}{-19mm}{28.0mm}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{-19mm}{28.0mm}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{-19mm}{28.0mm}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{-19mm}{28.0mm}}
\renewcommand*\l@figure{\@dottedtocline{1}{-19mm}{19mm}}
\renewcommand*\l@table{\l@figure}

\newcommand{\conditionalToC}{\tableofcontents}

\AtBeginEnvironment{longtable}{\gdef\there@is@a@table{}}%
\AtEndEnvironment{table}{\gdef\there@is@a@table{}}%
\AtEndDocument{\ifdefined\there@is@a@table\label{table:was:used:in:doc}\fi}%
\newcommand{\conditionalLoT}{\@ifundefined{r@table:was:used:in:doc}{}{{\listofTables\adjustmtc}}}%

\AtEndEnvironment{figure}{\gdef\there@is@a@figure{}}%
\AtEndDocument{\ifdefined\there@is@a@figure\label{fig:was:used:in:doc}\fi}%
\newcommand{\conditionalLoF}{\@ifundefined{r@fig:was:used:in:doc}{}{\listofFigures\adjustmtc}}%

\AtEndEnvironment{photo}{\gdef\there@is@a@photo{}}%
\AtEndDocument{\ifdefined\there@is@a@photo\label{photo:was:used:in:doc}\fi}%
\newcommand{\conditionalLoP}{\@ifundefined{r@photo:was:used:in:doc}{}{\listofPhotos\adjustmtc}}%

\AtEndEnvironment{actie}{\gdef\there@is@a@actie{}}%
\AtEndDocument{\ifdefined\there@is@a@actie\label{actie:was:used:in:doc}\fi}%
\newcommand{\conditionalLoToDo}{\@ifundefined{r@actie:was:used:in:doc}{}{\listofActies\adjustmtc}}%

\AtEndDocument{\ifdefined\there@is@a@NomenClature\label{nom:was:used:in:doc}\fi}%
\newcommand{\conditionalNomenclature}{\@ifundefined{r@nom:was:used:in:doc}{}{{\renewcommand{\addvspace}[1]{}\printnomenclature\adjustmtc}}}%

\renewcommand\tableofcontents{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \begingroup
    \chapter*{\contentsname}
        \@mkboth{\contentsname}%
                {\contentsname}%
        \parskip\z@%
    \@starttoc{toc}%
    \if@restonecol\twocolumn\fi
    \endgroup
    }
\newcommand\listofFigures{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \begingroup
    \nonumchapter{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
          \parskip\z@%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    \endgroup
    }
\newcommand\listofTables{%
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \begingroup
    \nonumchapter{\listtablename}%
      \@mkboth{\listtablename}%
              {\listtablename}%
        \parskip\z@%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \endgroup
    }

%=================================
% https://www.cnltx.de/2017/04/define-new-floating-environment/
%
\newcounter{photo}[chapter]% the counter
\renewcommand*\thephoto{\ifnum \c@chapter>\z@ \thechapter.\fi \@arabic\c@photo}% the default format for the counter
\newcommand*\fps@photo{tbp}% default floating options
\newcommand*\ftype@photo{4}% float type number, needs to be a power of 2;
% \ftype@figure=1, \ftype@table=2
\newcommand*\ext@photo{lop}% extension of file for the list of photos
\newcommand*\fnum@photo{\photoname\nobreakspace\thephoto}% used in caption
\if@dutch
    \newcommand*\photoname{Foto}% the name
    \def\@listphotoname{Lijst van foto's}
\else
    \if@spanish
        \newcommand*\photoname{Fotograf\'ia}% the name
        \def\@listphotoname{Lista de fotograf\'ias}
    \else
        \newcommand*\photoname{Photo}% the name
        \def\@listphotoname{List of Photos}
    \fi
\fi
\newenvironment{photo}{\@float{photo}}{\end@float}% the environment
\newenvironment{photo*}{\@dblfloat{photo}}{\end@dblfloat}% the starred
% version for twocolumn documents
\newcommand\listofPhotos{% the list of Photos
    \begingroup
    \nonumchapter{\@listphotoname}
    \@mkboth
        {\@listphotoname}
        {\@listphotoname}
        \parskip\z@%
    \@starttoc{\ext@photo}
    \endgroup
}
\let\l@photo\l@figure % layout of list is the same as for figures
%=================================
\newcounter{actie}[chapter]% the counter
\renewcommand*\theactie{\thechapter.\arabic{actie}}% the default format for the counter
\newcommand*\fps@actie{tbp}% default floating options
\newcommand*\ftype@actie{4}% float type number, needs to be a power of 2;
% \ftype@figure=1, \ftype@table=2
\newcommand*\ext@actie{lod}% extension of file for the list of acties
\newcommand*\fnum@actie{\color{dblue}\actiename\nobreakspace\theactie}% used in caption
\if@dutch
    \newcommand*\actiename{TODO}% the name
    \def\@listactiename{Lijst van acties}
\else
    \if@spanish
        \newcommand*\actiename{TODO}% the name
        \def\@listactiename{Lista de acci\'on}
    \else
        \newcommand*\actiename{TODO}% the name
        \def\@listactiename{List of To Do's}
    \fi
\fi
\newenvironment{actie}{\@float{actie}}{\end@float}% the environment
\newenvironment{actie*}{\@dblfloat{actie}}{\end@dblfloat}% the starred
% version for twocolumn documents
\newcommand\listofActies{% the list of Acties
    \begingroup
    \nonumchapter{\@listactiename}
    \@mkboth
        {\@listactiename}
        {\@listactiename}
        \parskip\z@%
    \@starttoc{\ext@actie}
    \endgroup
}
\let\l@actie\l@figure % layout of list is the same as for figures
%------------------------------------------------------------------------------

\usepackage{lastpage}  % must be behind any macro \AtEndDocument{...}

%------------------------------------------------------------------------------
\def\draftname{}

\def\ds@draft{\overfullrule 5pt \@drafttrue}

\if@dutch
    \def\@Version{Versie: \@version.\svnrev}
\else
    \if@spanish
        \def\@Version{Versi\'on: \@version.\svnrev}
    \else
        \def\@Version{Version: \@version.\svnrev}
    \fi
\fi
\def\svn@revinit{00}
\let\svnrev\svn@revinit\let\@svn@rev\svn@revinit

\if@dutch
    \renewcommand{\monthname}{%
        \ifcase\month\or januari \or februari%
        \or maart\or april \or mei%
        \or juni\or juli \or augustus%
        \or september \or oktober \or november%
        \or december\fi}%
\else
    \if@spanish
        \renewcommand{\monthname}{%
            \ifcase\month\or Enero\or Febrero%
            \or Marzo\or Abril\or Mayo%
            \or Junio\or Julio\or Agosto%
            \or Septiembre\or Octubre\or Noviembre%
            \or Diciembre\fi}%
    \else
        \renewcommand{\monthname}{%
            \ifcase\month\or January\or February%
            \or March\or April\or May%
            \or June\or July\or August%
            \or September\or October\or November%
            \or December\fi}%
    \fi
\fi
%------------------------------------------------------------------------------
\raggedbottom

\newcommand\skipnewline[1]{\let \newline \  {{\let \\ \empty #1}}}

\def\title#1{\gdef\@title{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\version#1{\gdef\@version{#1}}
\def\author#1{\gdef\@author{#1}}
\def\partner#1{\gdef\@partner{#1}}
\def\coverPhoto#1{\gdef\@coverPhoto{#1}}
\def\date#1{\gdef\@date{#1}}
\def\client#1{\gdef\@client{#1}}
\def\contact#1{\gdef\@contact{#1}}
\def\summary#1{\gdef\@summary{#1}}
\def\keywords#1{\gdef\@keywords{#1}}
\def\reference#1{\gdef\@reference{#1}}
\def\reviewer#1{\gdef\@reviewer{#1}}
\def\approval#1{\gdef\@approval{#1}}
%\def\disclaimer#1{\gdef\@disclaimer{#1}}
\def\versioni#1{\gdef\@versioni{#1}}
\def\datei#1{\gdef\@datei{#1}}
\def\authori#1{\gdef\@authori{#1}}
\def\revieweri#1{\gdef\@revieweri{#1}}
\def\approvali#1{\gdef\@approvali{#1}}
\def\publisheri#1{\gdef\@publisheri{#1}}
\def\projectnumber#1{\gdef\@projectnumber{#1}}
\def\documentid#1{\gdef\@documentid{#1}}
\def\classification#1{\gdef\@classification{#1}}

\def\@title{\texttt{$\backslash$title\{\ldots\}}}
\def\@subtitle{\texttt{$\backslash$subtitle\{\ldots\}}}
\def\@version{\texttt{$\backslash$version\{\ldots\}}}
\def\@author{\texttt{$\backslash$author\{\ldots\}}}
\def\@partner{\texttt{$\backslash$partner\{\ldots\}}}
\def\@coverPhoto{\texttt{$\backslash$coverPhoto\{\ldots\}}}
\def\@date{\texttt{$\backslash$date\{\ldots\}}}
\def\@client{\texttt{$\backslash$client\{\ldots\}}}
\def\@contact{\texttt{$\backslash$contact\{\ldots\}}}
\def\@summary{\texttt{$\backslash$summary\{\ldots\}}}
\def\@reference{\texttt{$\backslash$reference\{\ldots\}}}
\def\@keywords{\texttt{$\backslash$keywords\{\ldots\}}}
\def\@reviewer{\texttt{$\backslash$reviewer\{\ldots\}}}
\def\@approval{\texttt{$\backslash$approval\{\ldots\}}}

\newtoggle{b_status}
\toggletrue{b_status}
\def\status#1{%
    \def\tempa{}%
    \def\tempb{#1}%
    \ifx\tempa\tempb
        \togglefalse{b_status}%
    \else
        \toggletrue{b_status}%
        \if@ddraft
            % Default draft text, because option ddraft was given
        \else
            \gdef\@status{#1}
        \fi
    \fi
}
\ifdefined\status
    \toggletrue{b_status}%
\else
\fi

\newtoggle{b_disclaimer}
\toggletrue{b_disclaimer}
\def\disclaimer#1{%
    \def\tempa{}%
    \def\tempb{#1}%
    \ifx\tempa\tempb
        \if@ddraft
            \toggletrue{b_disclaimer}
        \else
            \togglefalse{b_disclaimer}
        \fi
    \else
        \toggletrue{b_disclaimer}%
        \if@ddraft
            % Default draft text, because option ddraft was given
        \else
            \gdef\@disclaimer{#1}
        \fi
    \fi
}


\def\@disclaimer{\texttt{$\backslash$disclaimer\{\ldots\}}}
\def\@status{\texttt{$\backslash$status\{\ldots\}}}
\if@ddraft
    \toggletrue{b_disclaimer}
    \if@dutch
        \def\@status{Voorlopig}
        \def\@disclaimer{Dit document is een concept en uitsluitend bedoeld voor discussiedoeleinden. Aan de inhoud van dit rapport kunnen noch door de opdrachtgever, noch door derden rechten worden ontleend.}
    \else
        \if@spanish
            \def\@status{Borrador}
            \def\@disclaimer{Este documento es un borrador el cual \'unicamente debe utilizarse para la discusi\'on del mismo. Ni el cliente ni terceros puedes derivar derecho alguno del contenido de este borrador.}
        \else
            \def\@status{Draft}
            \def\@disclaimer{This is a draft report, intended for discussion purposes only. No part of this report may be relied upon by either principals or third parties.}
       \fi
    \fi
\fi



\def\@projectnumber{\texttt{$\backslash$projectnumber\{\ldots\}}}
\def\@documentid{\texttt{$\backslash$documentid\{\ldots\}}}
\def\@classification{\texttt{$\backslash$classification\{\ldots\}}}

\def\@versioni{\texttt{$\backslash$versioni\{\ldots\}}}
\def\@datei{\texttt{$\backslash$datei\{\ldots\}}}
\def\@authori{\texttt{$\backslash$authori\{\ldots\}}}
\def\@revieweri{\texttt{$\backslash$revieweri\{\ldots\}}}
\def\@approvali{\texttt{$\backslash$approvali\{\ldots\}}}
\def\@publisheri{\texttt{$\backslash$publisheri\{\ldots\}}}

\newcommand{\thechap}{$\;$\leftmark{}$\;$}
\renewcommand\today{%
    \number\year -\twodigit\month -\twodigit\day%
}
% New column type, to assure parskip in tabular environment (see macro \summary)
\newcolumntype{P}[1]{>{%
    \parskip=1\baselineskip%
    \advance\parskip by 0pt plus 2pt%
    \setlength{\parfillskip}{30pt plus 1fil}}p{#1}%
}
%------------------------------------------------------------------------------

%\def\tiny{\@setsize\tiny{7pt}\vipt\@vipt}
%\def\scriptsize{\@setsize\scriptsize{9.5pt}\viiipt\@viiipt}
%\def\large{\@setsize\large{13pt}\xiipt\@xiipt}
%\def\Large{\@setsize\Large{18pt}\xivpt\@xivpt}
%\def\LARGE{\@setsize\LARGE{22pt}\xviipt\@xviipt}
%\def\huge{\@setsize\huge{25pt}\xxpt\@xxpt}
%\def\Huge{\@setsize\Huge{30pt}\xxvpt\@xxvpt}
%\def\HUGE{\@setsize\Huge{40pt}\xxvpt\@xxvpt}

%\def\tiny{\@setsize\tiny{7.33pt}\vipt\@vipt}
%\def\scriptsize{\@setsize\scriptsize{8.5pt}\viiipt\@viiipt}
%\def\footnotesize{\@setsize\footnotesize{9.25pt}\viiipt\@viiipt}
%\def\small{\@setsize\small{10.00pt}\viiipt\@viiipt}
%%\def\normalsize{\@setsize\normalsize{10.95pt}\viiipt\@viiipt}
%\def\large{\@setsize\large{11.75pt}\xiipt\@xiipt}
%\def\Large{\@setsize\Large{14.10pt}\xivpt\@xivpt}
%\def\LARGE{\@setsize\LARGE{15.85}\xviipt\@xviipt}
%\def\huge{\@setsize\huge{19.02}\xxpt\@xxpt}
%\def\Huge{\@setsize\Huge{22.82}\xxvpt\@xxvpt}
%\def\HUGE{\@setsize\Huge{30pt}\xxvpt\@xxvpt}

\def\program#1{\gdef\@program{\selectfont #1}}
\def\title#1{\gdef\@title{\selectfont #1}}
\def\subtitle#1{\gdef\@subtitle{\selectfont #1}}
\def\author#1{\gdef\@author{\selectfont #1}}
\def\partner#1{\gdef\@partner{\selectfont #1}}
%\def\reporttype#1{\gdef\@reporttype{\selectfont #1}}
%\def\reportdate#1{\gdef\@reportdate{\selectfont #1}}

\long\def\approvali#1{\gdef\@approvali{#1}}
\long\def\approvalii#1{\gdef\@approvalii{#1}}
\long\def\approvaliii#1{\gdef\@approvaliii{#1}}
\long\def\approvaliv#1{\gdef\@approvaliv{#1}}
\long\def\authori#1{\gdef\@authori{#1}}
\long\def\authorii#1{\gdef\@authorii{#1}}
\long\def\authoriii#1{\gdef\@authoriii{#1}}
\long\def\authoriv#1{\gdef\@authoriv{#1}}
\long\def\classification#1{\gdef\@classification{#1}}
\long\def\client#1{\gdef\@client{#1}}
\long\def\contact#1{\gdef\@contact{#1}}
\long\def\datei#1{\gdef\@datei{#1}}
\long\def\dateii#1{\gdef\@dateii{#1}}
\long\def\dateiii#1{\gdef\@dateiii{#1}}
\long\def\dateiv#1{\gdef\@dateiv{#1}}
\long\def\keywords#1{\gdef\@keywords{#1}}
\long\def\projectnumber#1{\gdef\@projectnumber{#1}}
\long\def\organisationi#1{\gdef\@organisationi{#1}}
\long\def\organisationii#1{\gdef\@organisationii{#1}}
\long\def\organisationiii#1{\gdef\@organisationiii{#1}}
\long\def\organisationiv#1{\gdef\@organisationiv{#1}}
\long\def\documentid#1{\gdef\@documentid{#1}}
\long\def\revieweri#1{\gdef\@revieweri{#1}}
\long\def\reviewerii#1{\gdef\@reviewerii{#1}}
\long\def\revieweriii#1{\gdef\@revieweriii{#1}}
\long\def\revieweriv#1{\gdef\@revieweriv{#1}}
\long\def\summary#1{\gdef\@summary{#1}}
\long\def\versioni#1{\gdef\@versioni{#1}}
\long\def\versionii#1{\gdef\@versionii{#1}}
\long\def\versioniii#1{\gdef\@versioniii{#1}}
\long\def\versioniv#1{\gdef\@versioniv{#1}}
\long\def\publisheri#1{\gdef\@publisheri{#1}}
\long\def\publisherii#1{\gdef\@publisherii{#1}}
\long\def\publisheriii#1{\gdef\@publisheriii{#1}}
\long\def\publisheriv#1{\gdef\@publisheriv{#1}}

\long\def\@approvali{\texttt{$\backslash$approvali\{\ldots\}}}
\long\def\@approvalii{}
\long\def\@approvaliii{}
\long\def\@approvaliv{}
\long\def\@authori{\texttt{$\backslash$authori\{\ldots\}}}
\long\def\@authorii{}
\long\def\@authoriii{}
\long\def\@authoriv{}
\long\def\@classification{\texttt{$\backslash$classification\{\ldots\}}}
\long\def\@client{\texttt{$\backslash$client\{\ldots\}}}
\long\def\@contact{\texttt{$\backslash$contact\{\ldots\}}}
\long\def\@datei{\texttt{$\backslash$datei\{\ldots\}}}
\long\def\@dateii{}
\long\def\@dateiii{}
\long\def\@dateiv{}
\long\def\@keywords{\texttt{$\backslash$keywords\{\ldots\}}}
\long\def\@projectnumber{\texttt{$\backslash$projectnumber\{\ldots\}}}
\long\def\@organisationi{\texttt{$\backslash$organisationi\{\ldots\}}}
\long\def\@organisationii{}
\long\def\@organisationiii{}
\long\def\@organisationiv{}
\long\def\@documentid{\texttt{$\backslash$documentid\{\ldots\}}}
\long\def\@revieweri{\texttt{$\backslash$revieweri\{\ldots\}}}
\long\def\@reviewerii{}
\long\def\@revieweriii{}
\long\def\@revieweriv{}
\long\def\@summary{}
\long\def\@versioni{\texttt{$\backslash$versioni\{\ldots\}}}
\long\def\@versionii{}
\long\def\@versioniii{}
\long\def\@versioniv{}
\long\def\@publisheri{\texttt{$\backslash$publisheri\{\ldots\}}}
\long\def\@publisherii{}
\long\def\@publisheriii{}
\long\def\@publisheriv{}
%
%------------------------------------------------------------------------------
%
%  TITLE PAGE
%
%------------------------------------------------------------------------------
%
\RequirePackage{transparent}
\definecolor{dbluelink}{RGB}{000,000,100} % the colour of hyper links in the pdf-document (daaark blue)
\definecolor{dblue}{RGB}{  8,  12,128}  % v5: the colour of deltares-name.pdf
\definecolor{dblue0}{RGB}{ 13, 56,224}  % v5: blue table header color
\definecolor{dblue1}{RGB}{236,239,253}  % v5: alternating blue colour in the blue table (light)
\definecolor{dblue2}{RGB}{217,223,250}  % v5: alternating blue colour in the blue table (dark)
\definecolor{dblue4}{RGB}{  8, 12,128}  % v5: colouring the Over Deltares text. title/subtitle of report
\definecolor{dblue5}{RGB}{240,243,254}  % v5: the backgound colour of footer
\definecolor{dgreen0}{RGB}{0, 204,150}  % v5: green table header color
\definecolor{dgreen1}{RGB}{235, 251, 247}  % v5: alternating green colour in the green table (light)
\definecolor{dgreen2}{RGB}{215, 247, 239}  % v5: alternating green colour in the green table (dark)

\definecolor{dname}{RGB}{  8,  12,128}  % v5: the colour of deltares-name.pdf
\definecolor{dmetallic}{RGB}{128,169,189}
\definecolor{dsand}{RGB}{160,158,141}
\definecolor{dgreen}{RGB}{180,211,0}
\definecolor{dorange}{RGB}{255,114,0}
\definecolor{dcyclaam}{RGB}{235,0,115}
\definecolor{dcyan}{RGB}{0,196,214}
\definecolor{dgrey1}{RGB}{150,150,150}
\definecolor{dgrey2}{RGB}{180,180,180}
\definecolor{dgrey3}{RGB}{210,210,210}
\definecolor{dgrey4}{RGB}{230,230,230}  % v5: color of the word 'concept' on title page

\newif\if@partners
\def\partner#1{%
    \def\tempa{}%
    \def\tempb{#1}%
    \ifx\tempa\tempb
        \@partnersfalse%
    \else
        \@partnerstrue%
        \gdef\@partner{#1}
    \fi
}
\ifdefined\partner
    \@partnerstrue%
\else
\fi

\def\maketitle{
    \newpage
    \thispagestyle{frontmatterplain}
    \setcounter{page}{2}
    \vskip 18mm
    \hangindent 0mm \hspace*{0pt}{\huge \bf \@title\par}
    \hangindent 0mm \hspace*{0pt}{\large \@subtitle \par}
    \vspace{18mm}
    \if@dutch
        \hangindent 0mm \hspace*{0mm}{\textbf{Auteurs}\newline}
    \else
        \if@spanish
            \hangindent 0mm \hspace*{0mm}{\textbf{Autores}\newline}
        \else
            \hangindent 0mm \hspace*{0mm}{\textbf{Authors}\newline}
        \fi
    \fi
    \hangindent 0mm \hspace*{0mm}{\@author \par}
    \vspace{9mm}
    \if@partners
        \if@dutch
            \hangindent 0mm \hspace*{0mm}{\textbf{Partners}\newline}
        \else
            \if@spanish
                \hangindent 0mm \hspace*{0mm}{\textbf{Asociados}\newline}
            \else
                \hangindent 0mm \hspace*{0mm}{\textbf{Partners}\newline}
            \fi
        \fi
        \hangindent 0mm \hspace*{0mm}{\@partner \par}
    \fi
    \vspace*{\fill}
    \begin{flushright}
    \footnotesize\@coverPhoto
    \end{flushright}
    \clearpage
    \let\maketitle\relax
}
%
%------------------------------------------------------------------------------
% Signatures GB
%------------------------------------------------------------------------------
%
\newcommand{\signatureGB}{
    \newlength{\texttab}
    \setlength{\texttab}{\textwidth + 19.75mm + 14mm}%

    \pagestyle{signature}
    \hspace*{-19.75mm} \parbox[t]{\texttab}{{\Large\bfseries\raggedright{\skipnewline{\@title}}}\newline
    \@subtitle}

    \vspace*{0\baselineskip}
    \hspace*{-19.75mm}
    \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
        \footnotesize{\textbf{Client}} & \@client \\
        \midline
        \footnotesize{\textbf{Contact}} & \@contact \\
        \midline
        \footnotesize{\textbf{Reference}} & \@reference  \\
        \midline
        \footnotesize{\textbf{Keywords}} & \@keywords
    \end{tabular}

    \hspace*{-19.75mm}
    \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
        \rowcolor{dblue1} \multicolumn{2}{l}{\textbf{Document control}} \\
        \topline
        \footnotesize{\textbf{Version}} & \@version \\
        \midline
        \footnotesize{\textbf{Date}} & \@date  \\
        \midline
        \footnotesize{\textbf{Project number}} & \@projectnumber  \\
        \midline
        \footnotesize{\textbf{Document ID}} & \@documentid  \\
        \midline
        \footnotesize{\textbf{Pages}} &  \pageref*{LastPage}  \\
        \midline
    \end{tabular}
    \iftoggle{b_disclaimer}{%
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
            \footnotesize{\textbf{Status}} & \@status \newline \@disclaimer
        \end{tabular}
    }{
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
            \footnotesize{\textbf{Status}} & \@status
        \end{tabular}
    }

    \signatureAuthors

    \signatureDocVersion

    \vfill

    \nonumchapter{Summary}
    \@summary
}
%
%------------------------------------------------------------------------------
% Signature NL
%------------------------------------------------------------------------------
%
\newcommand{\signatureNL}{
    \newlength{\texttab}
    \setlength{\texttab}{\textwidth + 19.75mm + 14mm}%

    \pagestyle{signature}
    \hspace*{-19.75mm} \parbox[t]{\texttab}{{\Large\bfseries\raggedright{\skipnewline{\@title}}}\newline
    \@subtitle}

    \vspace*{0\baselineskip}
    \hspace*{-19.75mm}
    \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
        \footnotesize{\textbf{Opdrachtgever}} & \@client \\
        \midline
        \footnotesize{\textbf{Contactpersoon}} & \@contact \\
        \midline
        \footnotesize{\textbf{Referenties}} & \@reference  \\
        \midline
        \footnotesize{\textbf{Trefwoorden}} & \@keywords
    \end{tabular}

    \hspace*{-19.75mm}
    \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
        \rowcolor{dblue1} \multicolumn{2}{l}{\textbf{Document controle}} \\
        \topline
        \footnotesize{\textbf{Versie}} & \@versioni \\
        \midline
        \footnotesize{\textbf{Datum}} & \@datei  \\
        \midline
        \footnotesize{\textbf{Projectnummer}} & \@projectnumber  \\
        \midline
        \footnotesize{\textbf{Document ID}} & \@documentid  \\
        \midline
        \footnotesize{\textbf{Pagina's}} &  \pageref*{LastPage}  \\
        \midline
    \end{tabular}
    \iftoggle{b_disclaimer}{%
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
            \footnotesize{\textbf{Status}} & \@status \newline \@disclaimer
        \end{tabular}
    }{
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
            \footnotesize{\textbf{Status}} & \@status
        \end{tabular}
    }

    \signatureAuthors

    \signatureDocVersion

    \vfill

    \nonumchapter{Samenvatting}
    \@summary
}
%
%------------------------------------------------------------------------------
% Signatures ES
%------------------------------------------------------------------------------
%
\newcommand{\signatureESP}{
    \newlength{\texttab}
    \setlength{\texttab}{\textwidth + 19.75mm + 14mm}%

    \pagestyle{signature}
    \hspace*{-19.75mm} \parbox[t]{\texttab}{{\Large\bfseries\raggedright{\skipnewline{\@title}}}\newline
    \@subtitle}

    \vspace*{0\baselineskip}
    \hspace*{-19.75mm}
    \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
        \footnotesize{\textbf{Cliente}} & \@client \\
        \midline
        \footnotesize{\textbf{Contacto}} & \@contact \\
        \midline
        \footnotesize{\textbf{Referencia}} & \@reference  \\
        \midline
        \footnotesize{\textbf{Palabras clave}} & \@keywords
    \end{tabular}

    \hspace*{-19.75mm}
    \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
        \rowcolor{dblue1} \multicolumn{2}{l}{\textbf{Control de documento}} \\
        \topline
        \footnotesize{\textbf{Versi\'on}} & \@version \\
        \midline
        \footnotesize{\textbf{Fecha}} & \@date  \\
        \midline
        \footnotesize{\textbf{N\'umero del proyecto}} & \@projectnumber  \\
        \midline
        \footnotesize{\textbf{Identificaci\'on del documento}} & \@documentid  \\
        \midline
        \footnotesize{\textbf{P\'aginas}} &  \pageref*{LastPage}  \\
        \midline
    \end{tabular}
    \iftoggle{b_disclaimer}{%
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
            \footnotesize{\textbf{Estatus}} & \@status \newline \@disclaimer
        \end{tabular}
    }{
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab-40.0mm-12pt}}
            \footnotesize{\textbf{Estatus}} & \@status
        \end{tabular}
    }

    \signatureAuthors

    \signatureDocVersion

    \vfill

    \nonumchapter{Resumen ejecutivo}
    \@summary
}
\newcommand{\signatureAuthors}{
    \if@dutch
        \hspace*{-19.75mm}
        \begin{tabular}{p{40mm-12pt}|p{\texttab/2-20mm-12pt}|p{\texttab/2-20mm-12pt}}
            \rowcolor{dblue1} \multicolumn{3}{l}{\textbf{Auteur(s)}} \\
            \topline
            & \@authori & \@organisationi \\
            \midline
            & \@authorii & \@organisationii \\
        \end{tabular}
    \else
        \if@spanish
            \hspace*{-19.75mm}
            \begin{tabular}{p{40mm-12pt}|p{\texttab/2-20mm-12pt}|p{\texttab/2-20mm-12pt}}
                \rowcolor{dblue1} \multicolumn{3}{l}{\textbf{Autor(es)}} \\
                \topline
                & \@authori & \@organisationi \\
                \midline
                & \@authorii & \@organisationii \\
            \end{tabular}
        \else
            \hspace*{-19.75mm}
            \begin{tabular}{p{40mm-12pt}|p{\texttab/2-20mm-12pt}|p{\texttab/2-20mm-12pt}}
                \rowcolor{dblue1} \multicolumn{3}{l}{\textbf{Author(s)}} \\
                \topline
                & \@authori & \@organisationi \\
                \midline
                & \@authorii & \@organisationii \\
            \end{tabular}
        \fi
    \fi
}
\newcommand{\signatureDocVersion}{
    \if@signature
        \vspace{\baselineskip}
        \if@dutch
            \hspace*{-19.75mm+14mm}
            \begin{tabular}{p{\texttab-28mm-12pt}}
                \color{dblue4}\textbf{\textit{Gebruik van deze tabel is voor de controle van juiste uitvoering door Deltares van de opdracht. Ieder ander klantgebruik en externe verspreiding is niet toegestaan.}}
             \end{tabular}

            \hspace*{-19.75mm}
            \begin{tabular}{p{40mm-12pt}|p{\texttab/3-13mm-12pt}|p{\texttab/3-13mm-12pt}|p{\texttab/3-14mm-12pt}}
                \rowcolor{dblue1}  \textbf{Doc.\ Versie} & \textbf{Auteur} & \textbf{Controle} & \textbf{Akkoord}  \\
                \topline
                \@versioni & \@authori  & \@revieweri  & \@approvali  \\
                \midline
                \@versionii & \@authorii & \@reviewerii & \@approvalii  \\
            \end{tabular}
        \else
            \if@spanish
                \hspace*{-19.75mm+14mm}
                \begin{tabular}{p{\texttab-28mm-12pt}}
                    \color{dblue4}\textbf{\textit{El uso de esta tabla se limita al control de la ejecuci\'on del encargo por parte de Deltares. No se permite cualquier otro uso por parte del cliente ni su distribuci\'on a terceros.}}
                \end{tabular}

                \hspace*{-19.75mm}
                \begin{tabular}{p{40mm-12pt}|p{\texttab/3-13mm-12pt}|p{\texttab/3-13mm-12pt}|p{\texttab/3-14mm-12pt}}
                    \rowcolor{dblue1}  \textbf{Versi\'on doc.} & \textbf{Autor} & \textbf{Revisor} & \textbf{Visto bueno} \\
                    \topline
                    \@versioni   & \@authori   & \@revieweri  & \@approvali  \\
                    \midline
                    \@versionii  & \@authorii  & \@reviewerii & \@approvalii  \\
                \end{tabular}
            \else
                \hspace*{-19.75mm+14mm}
                \begin{tabular}{p{\texttab-28mm-12pt}}
                    \color{dblue4}\textbf{\textit{The allowed use of this table is limited to check the correct order-performance by Deltares. Any other client-internal-use and any external distribution is not allowed.}}
                \end{tabular}

                \hspace*{-19.75mm}
                \begin{tabular}{p{40mm-12pt}|p{\texttab/3-13mm-12pt}|p{\texttab/3-13mm-12pt}|p{\texttab/3-14mm-12pt}}
                    \rowcolor{dblue1}  \textbf{Doc.\ version} & \textbf{Author} & \textbf{Reviewer} & \textbf{Approver}  \\
                    \topline
                    \@versioni   & \@authori   & \@revieweri  & \@approvali   \\
                    \midline
                    \@versionii  & \@authorii  & \@reviewerii & \@approvalii  \\
                \end{tabular}
            \fi
        \fi
        \vspace{\baselineskip}
    \else
    \fi% end if@signature
}
%
%------------------------------------------------------------------------------
%
%  STATE PAGE
%
%------------------------------------------------------------------------------
\newcommand{\deltarestitle}{\reporttitleOne}%

\newcommand{\reporttitleOne}{%
    \FrontPage%
    \newpage%
    \phantom{m}%
    \cleardoublepage%
    \reporttitle%
}%
\long\def\FrontPage{%
    \thispagestyle{empty}%
    \setlength{\unitlength}{1cm}%
    \AddToShipoutPicture*{\BackgroundTitle}
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
\newcommand{\FrontCover}{\includegraphics[height=182mm,width=182mm,keepaspectratio]{pictures/01_deltares_rapport_omslag.jpg}}
\newcommand{\FrontCircle}{}
\newcommand{\FrontCircleB}{}
\newcommand{\FrontCoverB}{}  % Shorter cover picture, to make room for the icons of the partners
\newcommand{\FrontCoverC}{}  % Figure with the icons of the project partners
%\renewcommand{\FrontCover}{\includegraphics[height=182mm,width=182mm]{pictures/2011-noorwegen-063-mirrored.jpg}}
%\renewcommand{\FrontCircle}{\includegraphics[height=182mm,width=182mm]{pictures/cover_transparant_circle.png}}
\newcommand\BackgroundTitle{%
    \setlength{\unitlength}{1cm}%
    \if@ddraft
        \put(3.94,25.76){\textcolor{dgrey4}{\Huge\bfseries\MakeUppercase\@status}}%  25.76  = 29.7 - 1.4 - 2.54
    \fi
    \put(2.54,-1.14){%
        \parbox[b]{182mm}{\FrontCover}%
    }%
    \put(2.54,1.46){%
        \parbox[b]{101mm}{\FrontCoverB}%
    }%
    \put(3.94,-1.69){%
        \parbox[b]{22.5mm}{\FrontCoverC}%
    }%
    \put(2.54,-1.14){%
        \parbox[b]{182mm}{\FrontCircle}%
    }%
    \put(2.54,1.46){%
        \parbox[b]{182mm}{\FrontCircleB}%
    }%

    \put(20.74,-2.54){\textcolor{white}{\rule{2.8cm}{19.7cm}}}  % white
    \put(2.54,17.06){\textcolor{white}{\rule{210mm}{8mm}}}
    \put(3.94,19.46){% 3.94 = 2.54 + 1.4; 19.46 = (29.7 - 7.7) - 2.54
        \parbox[b]{168mm}{\color{dblue4}\flushleft\Huge\textbf{\@title}}}
    \put(3.94,19.21){% 3.94 = 2.54 + 1.4; 17.86 = (29.7 - 7.95) - 2.54
        \parbox[t]{168mm}{\color{dblue4}\flushleft\Large\textbf{\@subtitle}}}
    \put(17.0,24.91){\includegraphics[height=18mm]{pictures/Deltares_logo_D-blauw_RGB.pdf}}  % 24.91 = 29.7 - 1.8 - 2.54 - 0.45(=\baselineskip)
}
\AtEndEnvironment{document}{
    \cleardoublepage%
    \pagestyle{empty}%
    \addtocounter{page}{0}%
    \AddToShipoutPicture*{\BackCover}%
}
\long\def\LastPage{}  % empty macro, legacy
%
\newcommand{\reporttitle}{%
    % At this point document title is known for sure.
    % Now measure the width of title in page footers (later used in fancy page styles).
    % When larger than max width, reduce it to max width.
    % Result: parbox in footer has exactly right with, such that alignment and
    % possible line break of title in footer is fully automatic.
    \setlength{\maxfoottitlewidth}{110mm}
    \if@subfooter
        \def\@exttitle{\skipnewline{\@title}\;\;\;---\;\;\;\@subtitle}
    \else
        \def\@exttitle{\skipnewline{\@title}}
    \fi
    \settowidth{\foottitlewidth}{\headerfont \@exttitle}
    \ifthenelse{\lengthtest{\foottitlewidth > \maxfoottitlewidth}}{%
        \setlength{\foottitlewidth}{\maxfoottitlewidth}}

    \frontmatter%
    \pagenumbering{arabic}%
    \maketitle%
    \cleardoublepage%
    \if@dutch
        \signatureNL
    \else
        \if@spanish
            \signatureESP
        \else
            \signatureGB
        \fi
    \fi

    \cleardoublepage%
    \setlength{\cftbeforetoctitleskip}{-\baselineskip}
    \setlength{\cftaftertoctitleskip}{1\baselineskip}
    \conditionalToC% tableofcontents%
    \conditionalLoT% Conditionally insert List of Tables
    \conditionalLoF% Conditionally insert List of Figures
    \conditionalLoP% Conditionally insert List of Photos
    \conditionalNomenclature% Conditionally nomenclature package: nomentbl
    \conditionalLoToDo% Conditionally insert List of To Do's

    \global\let\reporttitle\relax%
}%

%------------------------------------------------------------------------------
%
% Change header and footer
%
\usepackage{fancyhdr}
\newcommand{\headerfont}{\fontsize{8}{10}\selectfont}
%\newcommand{\headerfont}{\fontfamily{phv}\fontsize{8}{10}\selectfont}
%\newcommand{\headerfont}{\selectfont}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\chaptermark}[1]{\markboth{#1}{}}
\def\hfootline{%
    \begingroup\color{black}\rule[0mm]{100pt}{1pt}\endgroup}

% parbox width for title in footer: lengths are set in \reporttitle.
\newlength{\maxfoottitlewidth}
\newlength{\foottitlewidth}

%\lfoot{\mbox{\kern\dimexpr-3.14in+.75in\relax\small The left footer}}
%\cfoot{\mbox{\kern\dimexpr-3.14in+.75in\relax \thepage}}
%\rfoot{\small The right footer}

% Used for title page
\fancypagestyle{empty}{%
    \fancyhead{}%
    \fancyfoot{}%
}

% Used for preface/frontmatter
\fancypagestyle{frontmatterplain}{%
    \AddToShipoutPicture{\BackgroundFooter}
    \fancyfootoffset[RO]{14mm}
    \fancyhead{}%
    \fancyhead[LO]{\headerfont }%
    \fancyhead[CO]{\headerfont }%
    \fancyhead[RO]{\headerfont }
    \fancyfoot{}%
    \if@dutch
        \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ van \pageref*{LastPage}}}%  33mm = 47 - 14mm
        \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                    \@documentid, Versie \@version, \@date, \@status}
        \fancyfoot[RO]{}%
    \else
        \if@spanish
            \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ of \pageref*{LastPage}}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                        \@documentid, Versi\'on \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \else
            \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ of \pageref*{LastPage}}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                        \@documentid, Version \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \fi
    \fi
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
% Used for other pages
\fancypagestyle{headings_janm}{%
    \fancyfootoffset[RO]{14mm}
    \fancyhead{}
    \fancyhead[LO]{\headerfont}
    \fancyhead[CO]{\headerfont}
    \fancyhead[RO]{\headerfont}
    \fancyfoot{}
    \if@dutch
        \fancyfoot[LO]{\hspace{-33mm}\headerfont \thepage\ van \pageref*{LastPage}}%
        \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                \@documentid, Versie \@version, \@date, \@status}
        \fancyfoot[RO]{}%
    \else
        \if@spanish
            \fancyfoot[LO]{\hspace{-33mm}\headerfont \thepage\ de \pageref*{LastPage}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                    \@documentid, Versi\'on \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \else
            \fancyfoot[LO]{\hspace{-33mm}\headerfont \thepage\ of \pageref*{LastPage}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                    \@documentid, Version \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \fi
    \fi
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
% Used for signature pages
\fancypagestyle{signature}{%
    \fancyfootoffset[RO]{14mm}
    \fancyhead{}
    \fancyhead[LO]{}
    \fancyhead[CO]{\headerfont}
    \fancyhead[RO]{\headerfont}
    \fancyfoot{}
    \if@dutch
        \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ van \pageref*{LastPage}}}%  33mm = 47 - 14mm
        \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                    \@documentid, Versie \@version, \@date, \@status}
        \fancyfoot[RO]{}%
    \else
        \if@spanish
            \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ de \pageref*{LastPage}}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                        \@documentid, Versi\'on \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \else
            \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ of \pageref*{LastPage}}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                        \@documentid, Version \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \fi
    \fi
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}

% Used for part page
\fancypagestyle{plain}{%
    \fancyfootoffset[RO]{14mm}
    \fancyhead{}%
    \fancyhead[LO]{\headerfont }%
    \fancyhead[CO]{\headerfont }%
    \fancyhead[RO]{\headerfont }
    \fancyfoot{}%
    \if@dutch
        \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ van \pageref*{LastPage}}}%  33mm = 47 - 14mm
        \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle}\newline
                    \@documentid, Versie \@version, \@date, \@status}
        \fancyfoot[RO]{}%
    \else
        \if@spanish
            \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ de \pageref*{LastPage}}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                        \@documentid, Versi\'on \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \else
            \fancyfoot[LO]{\hspace{-34mm}\parbox[t][15mm]{15mm}{\hfill\headerfont \thepage\ of \pageref*{LastPage}}}%
            \fancyfoot[CO]{\raggedright \headerfont  \parbox[t]{\foottitlewidth}{\@exttitle} \newline
                        \@documentid, Version \@version, \@date, \@status}
            \fancyfoot[RO]{}%
        \fi
    \fi
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}

% Used for first page of part
\fancypagestyle{plainPart}{%
    \AddToShipoutPicture*{\BackgroundPicPart}
    \renewcommand{\headrulewidth}{0pt}
    \fancyhead{}%
    \fancyfoot{}%
}

\addtocounter{secnumdepth}{1}
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}
\setlength{\parsep}{1pt}
\setlength{\partopsep}{1pt}
%\setlength{\rightskip}{0pt plus 2cm} % Niet rechts uitlijnen tekst
%\setlength{\@rightskip}{0pt plus 2cm} % Niet rechts uitlijnen lists

%------------------------------------------------------------------------------
%
% To change the caption of tables and figures and photos.
% Format is defautl or `hang' wich aligns caption to the right of the figure statement
%
\captionsetup{format=default,margin=0cm,font=small,labelsep=space,justification=RaggedRight,singlelinecheck=false}
%
\newlength{\greentablewidth}   % a "scratch" length
\setlength{\greentablewidth}{0mm} % extra space%
%------------------------------------------------------------------------------
%
% Define a more advanced remark environment that writes Remark if there is only
% one item and that writes Remarks if there are multiple items.
%
\usepackage{ifthen}

%
\newcommand{\labellist}{\labelitemi\hss{\!}}
\newcounter{n_sp_blocks}
\newcounter{n_sp_items}
\newenvironment{singleplural}[2]%
  {\addtocounter{n_sp_blocks}{1}%
   \ifthenelse{\equal{a\ref{sp_block\arabic{n_sp_blocks}}}{a1}}%
     {\textbf{#1:}}%
     {\textbf{#2:}}%
    \begin{list}{\labellist}{%
        \setlength{\parskip}{0pt}%
        \setlength{\parsep}{0pt}%
        \setlength{\topsep}{0pt}%
        \setlength{\itemsep}{0pt}%
        \setlength{\labelwidth}{0pt}%
        \setlength{\labelsep}{1em+2.25mm}%
        \setlength{\leftmargin}{\labelwidth+\labelsep}%
        \usecounter{n_sp_items}%
   }}%
  {\label{sp_block\arabic{n_sp_blocks}}\end{list}}
%
\if@dutch
    \newenvironment{Remark}%
      {\begin{singleplural}{Opmerking}{Opmerkingen}}
      {\end{singleplural}}
\else
    \if@spanish
        \newenvironment{Remark}%
          {\begin{singleplural}{Advertencia}{Advertencias}}
          {\end{singleplural}}
    \else
        \newenvironment{Remark}%
          {\begin{singleplural}{Remark}{Remarks}}
          {\end{singleplural}}
    \fi
\fi
%
\if@dutch
    \newenvironment{Restriction}%
      {\begin{singleplural}{Restrictie}{Restricties}}
      {\end{singleplural}}
\else
    \if@spanish
        \newenvironment{Restriction}%
          {\begin{singleplural}{Restricci\'on}{Restricciones}}
          {\end{singleplural}}
    \else
        \newenvironment{Restriction}%
          {\begin{singleplural}{Restriction}{Restrictions}}
          {\end{singleplural}}
    \fi
\fi
%
\if@dutch
    \newenvironment{Warning}%
      {\begin{singleplural}{Waarschuwing}{Waarschuwingen}}
      {\end{singleplural}}
\else
    \if@spanish
        \newenvironment{Warning}%
          {\begin{singleplural}{Advertencia}{Advertencias}}
          {\end{singleplural}}
    \else
        \newenvironment{Warning}%
          {\begin{singleplural}{Warning}{Warnings}}
          {\end{singleplural}}
    \fi
\fi
%
\newcommand{\Note}%
    {\marginpar%
        { {\vspace{-1\baselineskip}\includegraphics[height=1.5\baselineskip]{pictures/margin_note.pdf}} }%
        \if@dutch
            \textbf{Note:\ }
        \else
            \if@spanish
                \textbf{Comprobar:\ }
            \else
                \textbf{Note:\ }
            \fi
        \fi
    }
%
\newcommand{\Tip}%
{%
    \textbf{Tip:\ }%
    \marginnote[ {\includegraphics[height=1.5\baselineskip]{pictures/margin_tip_left.pdf}} ]%
               { {\includegraphics[height=1.5\baselineskip]{pictures/margin_tip_right.pdf}} }[-0.75ex]%
}

% todo macro: usage of package marginnote
\renewcommand*{\raggedleftmarginnote}{\raggedleft}
\renewcommand*{\raggedrightmarginnote}{\raggedright}
\newcommand{\todo}[1]{
    \begin{actie}[H]
        \captionsetup{format=hang,font=small,labelfont={sl,bf},textfont=sl}%
        {\gdef\there@is@a@actie{}}%
        {\caption[#1]{\color{dblue}\slshape #1 \protect\marginnote{\color{dblue}\textbf{TODO}}}}%
    \end{actie}
}
%
\RecustomVerbatimEnvironment
  {Verbatim}{Verbatim}
  {fontsize=\footnotesize}
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

\renewcommand\labelitemi{$\itemdot$}
\renewcommand\labelitemii{--}
\renewcommand\labelitemiii{$\boldsymbol\itemdot$}
\renewcommand\labelitemiv{--}

\renewcommand{\labelenumi}{\arabic{enumi}}
\renewcommand{\labelenumii}{\alph{enumii}}
\renewcommand{\labelenumiii}{\roman{enumiii}}
\renewcommand{\labelenumiv}{\Roman{enumiv}}

%
%------------------------------------------------------------------------------

\newenvironment{guilist}%
  {\begin{list}{}%
    {%
      \renewcommand{\makelabel}[1]%
        {\raisebox{0pt}[1ex][0pt]{\makebox[\labelwidth][l]%
          {\parbox[t]{\labelwidth}{\raggedright\hspace{0pt}##1}}}}%
        \setlength{\parskip}{\baselineskip/2}%
        \setlength{\labelwidth}{3.7cm}%
        \setlength{\leftmargin}{\labelwidth+\labelsep}%
        \setlength{\topsep}{0pt}%
        \setlength{\parsep}{0pt}%
        \setlength{\itemsep}{0pt}%
    }%
  }%
  {\end{list}}

\if@dutch
    \newenvironment{domain} % Added more spacing around the text in the header, 19/11/2008 RMC Spiteri
    {%
        \small\begin{tabular}{|p{4.4cm}|p{2.2cm}|p{2.2cm}|p{2.2cm}|p{\textwidth-63pt-11.0cm}|}
        \multicolumn{5}{@{}l}{\textbf{Domein:}} \\ \hline
           \textbf{Parameter} & \textbf{Onder limiet} & \textbf{Boven limiet} & \textbf{Default} & \textbf{Eenheid} \\ \hline
       }
      {\end{tabular}}
\else
    \if@spanish
        \newenvironment{domain} % Added more spacing around the text in the header, 19/11/2008 RMC Spiteri
        {%
            \small\begin{tabular}{|p{4.4cm}|p{2.2cm}|p{2.2cm}|p{2.2cm}|p{\textwidth-63pt-11.0cm}|}
            \multicolumn{5}{@{}l}{\textbf{Dominio:}} \\ \hline
           \textbf{Par\'ametro} & \textbf{Inferior l\'imite} & \textbf{Superior l\'imite} & \textbf{Predeterminado} & \textbf{Unit} \\ \hline
           }
          {\end{tabular}}
    \else
        \newenvironment{domain} % Added more spacing around the text in the header, 19/11/2008 RMC Spiteri
        {%
            \small\begin{tabular}{|p{4.4cm}|p{2.2cm}|p{2.2cm}|p{2.2cm}|p{\textwidth-63pt-11.0cm}|}
            \multicolumn{5}{@{}l}{\textbf{Domain:}} \\ \hline
            \textbf{Parameter} & \textbf{Lower limit} & \textbf{Upper limit} & \textbf{Default} & \textbf{Unit} \\ \hline
            }
            {\end{tabular}}
    \fi
\fi

\newenvironment{action}%
  {\begin{list}{}{%
    \renewcommand{\makelabel}[1]{\includegraphics[height=0.5\baselineskip]{pictures/action_arrow.pdf}\hfill\varlistcolon}%
    \setlength{\labelwidth}{1em+1pt}% Changed to 3.7cm, 19/11/2008 RMC Spiteri
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\parskip}{\baselineskip/2}%
    \setlength{\topsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{0pt}}}
  {\end{list}}
%
% definition of varlist environment for listing
% variables and their meaning after a formula
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
    \setlength{\parskip}{0pt}%
    \setlength{\topsep}{0pt}%
    \setlength{\parsep}{0pt}%
    \setlength{\itemsep}{0pt}}}
  {\end{list}}

%------------------------------------------------------------------------------

\newenvironment{symbollist}%
  {\begin{list}{}{%
    \renewcommand{\makelabel}[1]{\quad{##1}\hfill\varlistcolon}%
    \setlength{\labelwidth}{2.0cm}
    \setlength{\leftmargin}{\labelwidth+\labelsep}%
    \setlength{\parskip}{0pt}%
    \setlength{\topsep}{0pt}%
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
        \setlength{\parskip}{0pt}%
        \setlength{\topsep}{0pt}%
        \setlength{\parsep}{0pt}%
        \setlength{\itemsep}{0pt}
    }%
  }%
  {\end{list}}

%------------------------------------------------------------------------------

\def\nonumchapter#1{%
    \chapter*{#1}%
    \addcontentsline{toc}{chapter}{\hspace{19mm}#1}%
    \markboth{#1}{}}

%------------------------------------------------------------------------------
\newcommand{\clearemptydoublepage}{\newpage{\pagestyle{empty}\cleardoublepage}}
\newcommand{\STRUT}{\rule{0in}{3ex}}

\newcommand{\Deltares}{Deltares\xspace}
\newcommand{\WL}{{WL\,$|$\,Delft Hydraulics\xspace}}
\newcommand{\degr}{\ensuremath{^\circ}}
\newcommand{\tenlog}{ \ensuremath{\ {}^{10}\!\log} }
\newcommand{\twolog}{ \ensuremath{\ {}^{2}\!\log} }

\newcommand{\window}[1]{\textbf{#1}}
\newcommand{\menu}[1]{\emph{#1}}
\newcommand{\button}[1]{\emph{#1}}
\newcommand{\file}[1]{$<${#1}$>$}
\newcommand{\dir}[1]{$<${#1}$>$}
\newcommand{\ginput}[1]{``#1''}
\newcommand{\command}[1]{{\normalfont\ttfamily #1}}
\newcommand{\block}[1]{\textbf{\rmfamily #1}}
\newcommand{\keyw}[1]{{\normalfont\ttfamily #1}}
\newcommand{\unitbrackets}[1]{[#1]}
\newcommand{\ext}[1]{$<$#1$>$}
\newcommand{\key}[1]{\texttt{#1}}
\newcommand{\function}[1]{\emph{#1}}
% To span multiple lines for one keyword, use \texttt{very\_long\_}\linecont\texttt{keyword}
\newcommand{\linecont}{~$\hookleftarrow$\newline\hspace*{1em}}

\DeclareRobustCommand\dotp{\mathpalette\dotp@{.5}} % bullet for the dot product
\newcommand\dotp@[2]{\mathbin{\vcenter{\hbox{\scalebox{#2}{$\m@th#1\bullet$}}}}}
\newcommand{\ssquare}{\stackrel{\scriptscriptstyle\square}{{}}} % small square for itemize list
\newcommand{\itemdot}{\stackrel{\scriptscriptstyle\bullet}{{}}\!} % bullet for the itemize list

\newcommand{\option}[1]{\vspace{0.5cm}\underline{#1}}  % Emphasize an option, mainly used in WAQ TRM

%% Referencing
\newcommand*\Autoref[1]{% First letter is a capital, also from macro \Autoref; needed at the start of a sentence
    \begingroup
        \if@dutch
            \def\appendixautorefname{Appendix}%
            \def\chapterautorefname{Hoofdstuk}%
            \def\equationautorefname~##1\null{Vergelijking~(##1)\null}%
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
            \if@spanish
                \def\appendixautorefname{Ap\'endice}%
                \def\chapterautorefname{Cap\'itulo}%
                \def\equationautorefname~##1\null{Ecuaci\'on~(##1)\null}%
                \def\figureautorefname{Figura}%
                \def\footnoteautorefname{Nota}%
                \def\itemautorefname{Item}%
                \def\pageautorefname{P\'agina}%
                \def\paragraphautorefname{Secci\'on}%
                \def\partautorefname{Parte}%
                \def\sectionautorefname{Secci\'on}%
                \def\subparagraphautorefname{Secci\'on}%
                \def\subsectionautorefname{Secci\'on}%
                \def\subsubsectionautorefname{Secci\'on}%
                \def\tableautorefname{Tabla}%
                \def\theoremautorefname{Teorema}%
            \else
                \def\appendixautorefname{Appendix}%
                \def\chapterautorefname{Chapter}%
                \def\equationautorefname~##1\null{Equation~(##1)\null}%
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
        \fi
        % ...
        \autoref{#1}%
    \endgroup%
}

\if@dutch % First letter is a lower case, also from macro \autoref
    \addto\extrasdutch{%
        \def\appendixautorefname{appendix}%
        \def\chapterautorefname{hoofdstuk}%
        \def\equationautorefname~#1\null{vergelijking~(#1)\null}%
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
    \if@spanish
        \addto\extrasspanish{%
            \def\appendixautorefname{ap\'endice}%
            \def\chapterautorefname{cap\'itulo}%
            \def\equationautorefname~#1\null{ecuaci\'on~(#1)\null}%
            \def\figureautorefname{figura}%
            \def\footnoteautorefname{nota}%
            \def\itemautorefname{item}%
            \def\pageautorefname{p\'agina}%
            \def\paragraphautorefname{secci\'on}%
            \def\partautorefname{parte}%
            \def\sectionautorefname{secci\'on}%
            \def\subparagraphautorefname{secci\'on}%
            \def\subsectionautorefname{secci\'on}%
            \def\subsubsectionautorefname{secci\'on}%
            \def\tableautorefname{tabla}%
            \def\theoremautorefname{teorema}%
        }
    \else
        \addto\extrasenglish{%
            \def\appendixautorefname{Appendix}%
            \def\chapterautorefname{chapter}%
            \def\equationautorefname~#1\null{Equation~(#1)\null}%
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
\fi

\def\execute{%
    \begingroup%
        \catcode`\%=12%
        \catcode`\\=12%
        \executeaux}%
        \def\executeaux#1{\immediate\write18{#1}%
    \endgroup%
}
%------------------------------------------------------------------------------
%
% PART
%
% Copied from report.cls, but pagestyle now depends on front/mainmatter:
\newcommand\BackgroundPicPart{}
\usepackage{eso-pic}

\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
      \refstepcounter{part}%
      \addcontentsline{toc}{part}{\hspace{19mm}#1}%
    \else
      \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}%
    {\centering
     \interlinepenalty \@M
     \normalfont
     \thispagestyle{plainPart}
     \ifnum \c@secnumdepth >-2\relax
       \leavevmode\HUGE\bfseries\raggedright #2
       \par
       \vskip 20\p@
     \fi
     \par}%
     \renewcommand{\partname}[1]{#1}
    \@endpart}
%------------------------------------------------------------------------------
%
% CHAPTER redefinition Hoofdstuk nummmer en titel staan verschoven onderelkaar maar beginnen op de goed plek
%
%------------------------------------------------------------------------------
\vfuzz2pt % Don't report over-full v-boxes if over-edge is small
\hfuzz2pt % Don't report over-full h-boxes if over-edge is small

\def\@makechapterhead#1{%
  \vspace*{-8.5mm}%
  {\parindent \z@%
        \leavevmode\huge\bfseries\raggedright%
        \color{dblue4}
        \llap{\makebox[19mm][l]{\thechapter \hfill}}%
        #1%
        \nobreak
  }
  \vskip 2\baselineskip\nopagebreak
}
\def\@makeschapterhead#1{%
  \vspace*{-8.5mm}%
  {\parindent \z@
        \leavevmode\huge\bfseries\raggedright%
        \color{dblue4}
        \llap{}#1
        \nobreak
  }
  \vskip 1\baselineskip\nopagebreak
}
% Copied from report.cls, but pagestyle now depends on front/mainmatter:
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi%
                      \if@mainmatter\thispagestyle{plain}\else\thispagestyle{frontmatterplain}\fi%
                    \addtocontents{lod}{\protect\addvspace{10\p@}}%
                    \addtocontents{lop}{\protect\addvspace{10\p@}}%
                    \global\@topnum\z@%
                    \@afterindentfalse%
                    \secdef\@chapter\@schapter%
                    }

%------------------------------------------------------------------------------
%
% SECTION redefinition
%
\def\section{\@ifstar\unnumberedsection\numberedsection}
\def\numberedsection{\@ifnextchar[%]
    \numberedsectionwithtwoarguments\numberedsectionwithoneargument}
\def\unnumberedsection{\@ifnextchar[%]
    \unnumberedsectionwithtwoarguments\unnumberedsectionwithoneargument}
\def\numberedsectionwithoneargument#1{\numberedsectionwithtwoarguments[#1]{#1}}
\def\unnumberedsectionwithoneargument#1{\unnumberedsectionwithtwoarguments[#1]{#1}}

\def\numberedsectionwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip 0\baselineskip\nopagebreak
    \refstepcounter{section}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\Large\bfseries\raggedright
        \color{dblue4}
        \llap{\makebox[19mm][l]{\thesection \hfill}}%
        #2
        %\par
    \endgroup
    \vskip -1\baselineskip\nopagebreak
    \vskip 1.75mm

    \addcontentsline{toc}{section}{%
        \protect\numberline{\thesection}%
        #1}%
}
\def\unnumberedsectionwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip 0\baselineskip\nopagebreak
%    \refstepcounter{section}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \color{dblue4}
        \leavevmode\Large\bfseries\raggedright
        #2
        %\par
    \endgroup
    \vskip -1\baselineskip\nopagebreak
    \vskip 1.75mm
%    \addcontentsline{toc}{section}{%
%        \protect\numberline{\thesection}%
%        #1}%
}
%------------------------------------------------------------------------------
%
% SUBSECTION redefinition
%
\def\subsection{\@ifstar\unnumberedsubsection\numberedsubsection}
\def\numberedsubsection{\@ifnextchar[%]
    \numberedsubsectionwithtwoarguments\numberedsubsectionwithoneargument}
\def\unnumberedsubsection{\@ifnextchar[%]
    \unnumberedsubsectionwithtwoarguments\unnumberedsubsectionwithoneargument}
\def\numberedsubsectionwithoneargument#1{\numberedsubsectionwithtwoarguments[#1]{#1}}
\def\unnumberedsubsectionwithoneargument#1{\unnumberedsubsectionwithtwoarguments[#1]{#1}}

\def\numberedsubsectionwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
  \vskip -1\baselineskip\nopagebreak
    \refstepcounter{subsection}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\large\bfseries\raggedright
        \llap{\makebox[19mm][l]{\thesubsection \hfill}}%
        #2
        %\par
    \endgroup
    \vskip -1\baselineskip\nopagebreak
    %\vskip 1.75mm  % v5: no vertical space behind this title
    \addcontentsline{toc}{subsection}{%
        \protect\numberline{\thesubsection}%
        #1}%
}
\def\unnumberedsubsectionwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
%    \refstepcounter{subsection}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\large\bfseries\raggedright
        #2
        %\par
    \endgroup
    \vskip -1\baselineskip\nopagebreak
    %\vskip 1.75mm  % v5: no vertical space behind this title
%  \addcontentsline{toc}{subsection}{%
%    \protect\numberline{\thesubsection}%
%    #1}%
  }
%------------------------------------------------------------------------------
%
% SUBSUBSECTION redefinition
%
\def\subsubsection{\@ifstar\unnumberedsubsubsection\numberedsubsubsection}
\def\numberedsubsubsection{\@ifnextchar[%]
\numberedsubsubsectionwithtwoarguments\numberedsubsubsectionwithoneargument}
\def\unnumberedsubsubsection{\@ifnextchar[%]
    \unnumberedsubsubsectionwithtwoarguments\unnumberedsubsubsectionwithoneargument}
\def\numberedsubsubsectionwithoneargument#1{\numberedsubsubsectionwithtwoarguments[#1]{#1}}
\def\unnumberedsubsubsectionwithoneargument#1{\unnumberedsubsubsectionwithtwoarguments[#1]{#1}}

\def\numberedsubsubsectionwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
    \refstepcounter{subsubsection}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\normalsize\raggedright
        \llap{\makebox[19mm][l]{\thesubsubsection \hfill}}%
        #2
        %\par
    \endgroup
    \vskip -1\parskip\nobreak
    \addcontentsline{toc}{subsubsection}{%
        \protect\numberline{\thesubsubsection}%
        #1}%
}
\def\unnumberedsubsubsectionwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
%  \refstepcounter{subsubsection}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\normalsize\raggedright
        #2
        %\par
    \endgroup
    \vskip -1\parskip\nobreak
%    \addcontentsline{toc}{subsubsection}{%
%    \protect\numberline{\thesubsubsection}%
%    #1}%
}
%------------------------------------------------------------------------------
%
% PARAGRAPH redefinition
%
\def\paragraph{\@ifstar\unnumberedparagraph\numberedparagraph}
\def\numberedparagraph{\@ifnextchar[%]
    \numberedparagraphwithtwoarguments\numberedparagraphwithoneargument}
\def\unnumberedparagraph{\@ifnextchar[%]
    \unnumberedparagraphwithtwoarguments\unnumberedparagraphwithoneargument}
\def\numberedparagraphwithoneargument#1{\numberedparagraphwithtwoarguments[#1]{#1}}
\def\unnumberedparagraphwithoneargument#1{\unnumberedparagraphwithtwoarguments[#1]{#1}}

\def\numberedparagraphwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
    \refstepcounter{paragraph}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\normalsize\raggedright
        \llap{\makebox[19mm][l]{\theparagraph \hfill}}%
        #2
        %\par
    \endgroup
    \vskip -1\parskip\nobreak
    \addcontentsline{toc}{paragraph}{%
        \protect\numberline{\theparagraph}%
        #1}%
}
\def\unnumberedparagraphwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
    %  \refstepcounter{paragraph}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\normalsize\raggedright
        %  \llap{\theparagraph\hspace{4.5mm}}%
        #2
        %\par
    \endgroup
    \vskip -1\parskip\nobreak
%      \addcontentsline{toc}{paragraph}{%
%        \protect\numberline{\theparagraph}%
%        #1}%
}
%------------------------------------------------------------------------------
%
% SUBPARAGRAPH redefinition
%
\def\subparagraph{\@ifstar\unnumberedsubparagraph\numberedsubparagraph}
\def\numberedsubparagraph{\@ifnextchar[%]
    \numberedsubparagraphwithtwoarguments\numberedsubparagraphwithoneargument}
\def\unnumberedsubparagraph{\@ifnextchar[%]
    \unnumberedsubparagraphwithtwoarguments\unnumberedsubparagraphwithoneargument}
\def\numberedsubparagraphwithoneargument#1{\numberedsubparagraphwithtwoarguments[#1]{#1}}
\def\unnumberedsubparagraphwithoneargument#1{\unnumberedsubparagraphwithtwoarguments[#1]{#1}}

\def\numberedsubparagraphwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
    \refstepcounter{subparagraph}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\normalsize\itshape\raggedright
        \llap{\makebox[19mm][l]{\thesubparagraph \hfill}}%
        #2
        %\par
    \endgroup
    \vskip -1\parskip\nobreak
    \addcontentsline{toc}{subparagraph}{%
    \protect\numberline{\thesubparagraph}%
    #1}%
}
\def\unnumberedsubparagraphwithtwoarguments[#1]#2{%
    \def\@currentlabelname{#1}
    \ifhmode\par\fi
    \removelastskip
    \vskip -1\baselineskip\nopagebreak
    %  \refstepcounter{subparagraph}%
    \noindent
    \begingroup
        % Taken from package needspaces
        \setlength{\dimen@}{3\baselineskip}%
        \vskip\z@\@plus\dimen@
        \penalty -100\vskip\z@\@plus -\dimen@
        \vskip\dimen@
        \penalty 9999%
        \vskip -\dimen@
        \vskip\z@skip % hide the previous \vskip from \addvspace
        % end needspaces
        \leavevmode\normalsize\itshape\raggedright
        #2
        %\par
    \endgroup
    \vskip -1\parskip\nobreak
    %  \addcontentsline{toc}{subparagraph}{%
    %      \protect\numberline{\thesubparagraph}%
    %      #1}%
}

%------------------------------------------------------------------------------
%
% INDEX
%
\usepackage{makeidx}
\usepackage[totoc=true]{idxlayout}
%------------------------------------------------------------------------------
%
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

%% Longtable improvement
% \nobreakhline is a \hline in a longtable that disallows a page break after it.
% From: http://tex.stackexchange.com/questions/6350/how-to-disable-pagebreak-on-hline-in-longtable
\def\nobreakhline{%
  \noalign{\ifnum0=`}\fi
    \penalty\@M
    \futurelet\@let@token\LT@@nobreakhline%
}
\def\LT@@nobreakhline{%
  \ifx\@let@token\hline
    \global\let\@gtempa\@gobble
    \gdef\LT@sep{\penalty\@M\vskip\doublerulesep}% <-- change here
  \else
    \global\let\@gtempa\@empty
    \gdef\LT@sep{\penalty\@M\vskip-\arrayrulewidth}% <-- change here
  \fi
  \ifnum0=`{\fi}%
  \multispan\LT@cols
     \unskip\leaders\hrule\@height\arrayrulewidth\hfill\cr
  \noalign{\LT@sep}%
  \multispan\LT@cols
     \unskip\leaders\hrule\@height\arrayrulewidth\hfill\cr
  \noalign{\penalty\@M}%
  \@gtempa
}
%\setlength{\LTleft}{0pt}
% footnote
%------------------------------------------------------------------------------
\renewcommand\footnoterule{\hrule width 44mm height 1.5pt\kern 1mm}  % v5:
%------------------------------------------------------------------------------
% footnote references
%
\newcommand{\footnoteref}[1]{%
% requires a label to be present in the footnote to be referenced!
\ltx@ifpackageloaded{hyperref}{% hyperref package loaded
  \ifHy@hyperfootnotes% option hyperfootnotes=true
    \hbox{\hyperref[#1]{%
            % once upon a time this was not "#1" but "\footnote@reference",
            % but somewhere something changed at some time
            \@textsuperscript {\normalfont \ref*{#1}}}}%
  \else% option hyperfootnotes=false
    \hbox{\@textsuperscript {\normalfont \ref*{#1}}}%
  \fi%
}{% hyperref package not loaded
    \hbox{\@textsuperscript {\normalfont \ref{#1}}}%
 }%
}
%------------------------------------------------------------------------------

\newcommand{\diff}[3][1]{\ensuremath{\frac{d \ifthenelse{\equal{#1}{1}}{}{^#1} {#2}}{d {#3} \ifthenelse{\equal{#1}{1}}{}{^#1}}}}
\newcommand{\pdiff}[3][1]{\ensuremath{\frac{\partial \ifthenelse{\equal{#1}{1}}{}{^#1} {#2}}{\partial {#3} \ifthenelse{\equal{#1}{1}}{}{^#1}}}}

\newcommand{\perscomm}[1]{\citetext{#1, pers.\ comm.}}

\if@dbiblatex
    \newcommand{\citet}{\textcite}
    \newcommand{\citep}{\parencite}
    \usepackage[backend=bibtex, style=deltares_authoryear, maxcitenames=2, maxbibnames=10]{biblatex}
    \newcommand{\printrefsegment}{\printbibliography[segment=\therefsegment, heading=subbibheading]}
    \newcommand{\printallbibliography}{\printbibliography[heading=bibintoc]}
    \defbibheading{bibliography}[\bibname]{%
        \nonumchapter{#1}%
        \markboth{#1}{#1}
    }
    \if@dutch
        \DefineBibliographyStrings{dutch}{%
            bibliography = {Literatuur}
        }
        \defbibheading{subbibheading}{
            \subparagraph*{Literatuur} % for \Autoref{refsegment:\therefsection\therefsegment}}
        }
        \DeclareFieldFormat{urldate}{%
            (Benaderd %
            \thefield{urlday} \addspace%
            \mkbibmonth{\thefield{urlmonth}}\addspace%
            \thefield{urlyear}\isdot)}
    \else
        \if@spanish
            \DefineBibliographyStrings{spanish}{%
                bibliography = {Referencias}
            }
            \defbibheading{subbibheading}{
                \subparagraph*{Referencias} % for \Autoref{refsegment:\therefsection\therefsegment}}
            }
            \DeclareFieldFormat{urldate}{%
                (Accedido %
                \thefield{urlday} \addspace%
                \mkbibmonth{\thefield{urlmonth}}\addspace%
                \thefield{urlyear}\isdot)}
        \else %  i.e. English
            \DefineBibliographyStrings{english}{%
                bibliography = {References}
            }
            \defbibheading{subbibheading}{
                \subparagraph*{References} % for \Autoref{refsegment:\therefsection\therefsegment}}
            }
            \DeclareFieldFormat{urldate}{%
                (Accessed %
                \thefield{urlday} \addspace%
                \mkbibmonth{\thefield{urlmonth}}\addspace%
                \thefield{urlyear}\isdot)}
        \fi
    \fi
    \setlength\bibitemsep{0.5\baselineskip}
\else
    \usepackage{natbib}
    \bibpunct[, ]{(}{)}{;}{a}{,}{,}
    \renewcommand\bibsection{}
    \if@dutch
        \bibliographystyle{deltares_chicago_like_dutch}
    \else
        \if@spanish
            \bibliographystyle{deltares_chicago_like_spanish}
        \else
            \bibliographystyle{deltares_chicago_like}
        \fi
    \fi
\fi

%
% Nomenclature; run makeindex with appropriate style file
%
%
% Nomenclature table
\if@dutch
    \def\nomname{Lijst van symbolen}
    \def\nomAname{Latijnse letters}%
    \def\nomGname{Griekse letters}%
    \def\nomXname{Superscripts}%
    \def\nomZname{Subscripts}%
\else
    \if@spanish
        \def\nomname{Lista de S\'imbolos}
        \def\nomAname{Caract'eres latinos}%
        \def\nomGname{Caract'eres griegos}%
        \def\nomXname{Super\'indices}%
        \def\nomZname{Sub\'indices}%
    \else
        \def\nomname{List of Symbols}
        \def\nomAname{Latin Letters}%
        \def\nomGname{Greek Letters}%
        \def\nomXname{Superscripts}%
        \def\nomZname{Subscripts}%
    \fi
\fi

\IfFileExists{./\jobname.nlo}{
    \if@dutch
        \execute{makeindex -q \jobname.nlo -s deltares_nomentbl_nl.ist -o \jobname.nls}
    \else
        \if@spanish
            \execute{makeindex -q \jobname.nlo -s deltares_nomentbl_esp.ist -o \jobname.nls}
        \else
            \execute{makeindex -q \jobname.nlo -s deltares_nomentbl.ist -o \jobname.nls}
        \fi
    \fi
}{}

\def\@@nomenclature[#1]#2#3#4{\endgroup\@esphack}
\def\@@@nomenclature[#1]#2#3#4{%
    \def\@tempa{#2}%
    \def\@tempb{#3}%
    \protected@write\@nomenclaturefile{}%
    {\string\nomenclatureentry{#1\nom@verb\@tempa @{\nom@verb\@tempa}&%
    \begingroup\nom@verb\@tempb\endgroup &\begingroup#4\endgroup&%
    \begingroup\protect\nompageref}{0}% nompageref==0, so all entries of the page number are the same, needed to skip double entries
    }%
    \endgroup
    \@esphack%
    \gdef\there@is@a@NomenClature{}
}

\makenomenclature

%------------------------------------------------------------------------------
% retrieving GIT repository, branch and hash
%

\def\@setgitdirectory{-{}-{}-{}-}
\def\setgitdirectory#1{\gdef\@setgitdirectory{#1}\giscontent}
\def\@gitrepository{----}
\def\@branch{-{}-{}-{}-}
\def\@githashlong{-{}-{}-{}-}
\def\@githashshort{-{}-{}-{}-}
%
\def\giscontent{
    \IfFileExists{\@setgitdirectory/HEAD.}{%
    \CatchFileDef{\headfull}{\@setgitdirectory/HEAD.}{}
    \StrGobbleRight{\headfull}{1}[\head]
    \StrBehind[2]{\head}{/}[\@branch]
    \IfFileExists{\@setgitdirectory/refs/heads/\@branch.}{%
        \CatchFileDef{\@githashlong}{\@setgitdirectory/refs/heads/\@branch.}{}
        }{%
        \newcommand{\@githashlong}{\dots~(in \emph{packed-refs})}
        }

    % find the git-repository
    \CatchFileDef{\configfull}{\@setgitdirectory/config.}{}
    \StrBehind{\configfull}{[remote "origin"]}[\gitreposA]  % look for the string "[remote "origin"]"
    \StrBehind{\gitreposA}{=}[\gitreposB]  % then behind the equal-sign
    \StrBefore{\gitreposB}{fetch}[\gitreposC]  % the before the "fetch" string
    \gdef\@gitrepository{\gitreposC}
    \StrLeft{\@githashlong}{7}[\@githashshort]
    }{
    }
}
\newcommand{\gitdirectory}{\@setgitdirectory}
\newcommand{\gitrepository}{\@gitrepository}
\newcommand{\githashlong}{\@githashlong}
\newcommand{\githash}{\@githashshort}
\newcommand{\gitbranch}{\StrSubstitute{\@branch}{_}{\_}}

%------------------------------------------------------------------------------
\makeatother
