\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_memo}
              [2020/01/05 v2.0 Deltares memo class]
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
\newif\if@spanish
\@spanishfalse
\DeclareOption{spanish}{%
    \@spanishtrue%
}
\newif\if@dbiblatex% deltares biblatex
\@dbiblatexfalse
\DeclareOption{biblatex}{%
    \@dbiblatextrue%
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
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[11pt,a4paper,titlepage]{article}

%------------------------------------------------------------------------------

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

%------------------------------------------------------------------------------

%\usepackage{sectsty}  % to set section fonts
%\allsectionsfont{\fontfamily{phv}\selectfont} % helvetica

%------------------------------------------------------------------------------

\usepackage{lipsum}
\usepackage[pdftex]{graphicx}
\usepackage{epstopdf}
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
\usepackage{etoolbox}% http://ctan.org/pkg/etoolbox: needed for conditional list of figures and list of tables
\usepackage{nomencl}
\usepackage[intoc]{nomentbl}
\usepackage{bookmark}
\usepackage{adjustbox}
\usepackage{booktabs}

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

\setlength{\topmargin}{0\baselineskip}
\headheight 3\baselineskip
\headsep 1\baselineskip
% until text = \topmargin + \headheight + \headsep == 6\baselineskip
\footskip 5\baselineskip
\setlength{\textheight}{297mm-\headsep-\headheight-10\baselineskip}

\setlength{\oddsidemargin}{28mm}
\setlength{\evensidemargin}{28mm}
\setlength{\textwidth}{175mm - \oddsidemargin} % 175 - 28 = 147 mm

\setlength{\marginparwidth}{18mm}
\setlength{\marginparsep}{4.5mm}
\let\oldmarginpar\marginpar
\renewcommand\marginpar[1]{\-\oldmarginpar[\raggedleft\footnotesize #1]%
{\raggedright\footnotesize #1}}

\widowpenalty=3000
\clubpenalty=3000

%------------------------------------------------------------------------------

\if@druler
    \usepackage{deltares_memo_ruler}
\fi

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
%\cftsetindents{part}{-19mm}{45mm}
%\cftsetindents{chapter}{-19mm}{19mm}
%\cftsetindents{section}{-19mm}{23.5mm}
%\cftsetindents{subsection}{-19mm}{23.5mm}
%\cftsetindents{subsubsection}{-19mm}{23.5mm}
%\cftsetindents{paragraph}{-19mm}{23.5mm}
%\cftsetindents{subparagraph}{-19mm}{23.5mm}
%\cftnodots{}
\newlength{\mylen}   % a "scratch" length
\setlength{\mylen}{45mm} % extra space
\addtolength{\cftpartnumwidth}{\mylen} % add the extra space

\renewcommand{\@dotsep}{10000}
%\renewcommand*\l@chapter{\@dottedtocline{0}{-14mm}{14mm}}
\renewcommand*\l@section{\@dottedtocline{1}{-14mm}{14mm}}
\renewcommand*\l@subsection{\@dottedtocline{2}{-14mm}{14mm}}
\renewcommand*\l@subsubsection{\@dottedtocline{3}{-14mm}{14mm}}
\renewcommand*\l@paragraph{\@dottedtocline{4}{-14mm}{14mm}}
\renewcommand*\l@subparagraph{\@dottedtocline{5}{-14mm}{14mm}}
\renewcommand*\l@figure{\@dottedtocline{1}{-14mm}{14mm}}
\renewcommand*\l@table{\l@figure}

\AtEndEnvironment{figure}{\gdef\there@is@a@figure{}}%
\AtEndDocument{\ifdefined\there@is@a@figure\label{fig:was:used:in:doc}\fi}%
\newcommand{\conditionalLoF}{\@ifundefined{r@fig:was:used:in:doc}{}{\listofFigures\adjustmtc}}%

\AtBeginEnvironment{longtable}{\gdef\there@is@a@table{}}%
\AtEndEnvironment{table}{\gdef\there@is@a@table{}}%
\AtEndDocument{\ifdefined\there@is@a@table\label{table:was:used:in:doc}\fi}%
\newcommand{\conditionalLoT}{\@ifundefined{r@table:was:used:in:doc}{}{\listofTables\adjustmtc}}%

\renewcommand\tableofcontents{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begingroup
        \section*{\contentsname}
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
    \section*{\listfigurename}%
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
    \section*{\listtablename}%
      \@mkboth{\listtablename}%
              {\listtablename}%
        \parskip\z@%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    \endgroup
    }
\newcommand\listofPhotos{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \begingroup
        \nonumchapter{\listtablename}%
          \@mkboth{%
              \listtablename}%
             {\listtablename}%
          \parskip\z@%
        \@starttoc{lot}%
        \if@restonecol\twocolumn\fi
    \endgroup
    }
%------------------------------------------------------------------------------

\usepackage{lastpage}  % must be behind any macro \AtEndDocument{...}

%------------------------------------------------------------------------------
\def\draftname{}

\def\ds@draft{\overfullrule 5pt \@drafttrue}

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
\newif\if@confidential
\newif\if@memocopy

\def\@memoVersion{\texttt{$\backslash$memoVersion\{\ldots\}}}
\def\@memoTo{\texttt{$\backslash$memoTo\{\ldots\}}}
\def\@memoConfidentialUntil{\texttt{$\backslash$memoConfidentialUntil\{\ldots\}}}
\def\@memoFrom{\texttt{$\backslash$memoFrom\{\ldots\}}}
\def\@memoSubject{\texttt{$\backslash$memoSubject\{\ldots\}}}
\def\@memoDate{\texttt{$\backslash$memoDate\{\ldots\}}}
\def\@memoTelephone{\texttt{$\backslash$memoTelephone\{\ldots\}}}
\def\@memoEmail{\texttt{$\backslash$memoEmail\{\ldots\}}}
\def\@memoCopy{\texttt{$\backslash$memoCopy\{\ldots\}}}
\def\@memoAction{\texttt{$\backslash$memoAction\{\ldots\}}}

\def\program#1{\gdef\@program{#1}}
\def\@program{Memo}
\def\memoVersion#1{\gdef\@memoVersion{#1}}
\def\memoTo#1{\gdef\@memoTo{#1}}

\def\memoConfidentialUntil#1{%
    \def\tempa{}%
    \def\tempb{#1}%
    \ifx\tempa\tempb
        \@confidentialfalse%
    \else
        \@confidentialtrue%
        \gdef\@memoConfidentialUntil{#1}
    \fi
}
\ifdefined\memoConfidentialUntil
    \@confidentialtrue%
\else
\fi

\def\memoFrom#1{\gdef\@memoFrom{#1}}
\def\memoSubject#1{\gdef\@memoSubject{#1}}
\def\memoDate#1{\gdef\@memoDate{#1}}
\def\memoTelephone#1{\gdef\@memoTelephone{#1}}
\def\memoEmail#1{\gdef\@memoEmail{#1}}

\def\memoCopy#1{%
    \def\tempa{}%
    \def\tempb{#1}%
    \ifx\tempa\tempb
        \@memocopyfalse%
    \else
        \@memocopytrue%
        \gdef\@memoCopy{#1}
    \fi
}
\ifdefined\memoCopy
    \@memocopytrue%
\else
\fi

\def\memoAction#1{\gdef\@memoAction{#1}}

%------------------------------------------------------------------------------

%\def\tiny{\@setsize\tiny{7pt}\vipt\@vipt}
%\def\scriptsize{\@setsize\scriptsize{9.5pt}\viiipt\@viiipt}
%\def\large{\@setsize\large{13pt}\xiipt\@xiipt}
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
\newcommand{\helv}{\fontfamily{phv}\selectfont}

\if@dutch
    \def\@CopyTo{Kopie aan}
    \def\@Date{Datum}
    \def\@DirectLine{Doorkiesnummer}
    \def\@EMail{E-mail}
    \def\@From{Contactpersoon}
    \def\@NumberOfPages{Aantal pagina's}
    \def\@Page{Pagina}
    \def\@Reference{Ons kenmerk}
    \def\@Subject{Onderwerp}
    \def\@To{Aan}
\else
    \if@spanish
        \def\@CopyTo{Copia a}
        \def\@Date{Fecha}
        \def\@DirectLine{Tel\'efono}
        \def\@EMail{Correo electr\'onico}
        \def\@From{Contacto}
        \def\@NumberOfPages{N\'umero de p\'aginas}
        \def\@Page{P\'agina}
        \def\@Reference{Referencia}
        \def\@Subject{Asunto}
        \def\@To{Dirigido a}
    \else
        \def\@CopyTo{Copy to}
        \def\@Date{Date}
        \def\@DirectLine{Direct line}
        \def\@EMail{E-mail}
        \def\@From{Contact person}
        \def\@NumberOfPages{Number of pages}
        \def\@Page{Page}
        \def\@Reference{Our reference}
        \def\@Subject{Subject}
        \def\@To{To}
    \fi
\fi

%------------------------------------------------------------------------------
%
% Change header and footer
%
\usepackage{fancyhdr}
\newcommand{\headerfont}{\fontsize{8}{10}\selectfont}
%\newcommand{\headerfont}{\selectfont}
\newlength{\foottitlewidth}
\setlength{\foottitlewidth}{\textwidth + 19mm + 14 mm}

\pagestyle{plain}
\fancyhead{}
\setlength{\headheight}{5\baselineskip}
\fancypagestyle{pagematter}{% used on pages 2 to end
    \setlength{\textheight}{297mm - 11\baselineskip}
    \if@dutch
        \fancyhead[LO]{
            \begingroup
            \renewcommand{\arraystretch}{1.00}
            \headerfont
            \begin{tabular}{@{}p{46mm}@{}p{46mm}@{}p{46mm}@{}p{30mm}}
                \scriptsize{\textbf{\@Date}} & \scriptsize{\textbf{\@Reference}} & & \scriptsize{\textbf{\@Page}} \\
                \@memoDate & \@memoVersion & & \thepage\ van \pageref*{LastPage} \\
            \end{tabular}
            \endgroup
            }
    \else
        \fancyhead[LO]{
            \begingroup
            \renewcommand{\arraystretch}{1.00}
            \headerfont
            \begin{tabular}{@{}p{46mm}@{}p{46mm}@{}p{46mm}@{}p{30mm}}
                \scriptsize{\textbf{\@Date}} & \scriptsize{\textbf{\@Reference}} & & \scriptsize{\textbf{\@Page}} \\
                \@memoDate & \@memoVersion & & \thepage\ of \pageref*{LastPage} \\
            \end{tabular}
            \endgroup
            }
    \fi
    \fancyfoot{}
    %\fancyfoot[LO]{\vspace{0.0mm}\parbox[t][29mm]{29mm}{\includegraphics[height=15mm]{pictures/Deltares_pay-off_D-blauw_RGB.pdf}}}
    \fancyfoot[CO]{\headerfont }
    \fancyhead[RO]{\headerfont }
}

\renewcommand{\headrulewidth}{0pt}

\fancypagestyle{plain}{%
    \fancyhead{}%
    \fancyfoot{}%
    \if@dutch
        \fancyfoot[LO]{
            \hspace{-21mm}\parbox[t][29mm]{29mm}{\includegraphics[height=15mm]{pictures/Deltares_pay-off_D-blauw_RGB.pdf}}\newline
            \vspace{-3.0\baselineskip}
            \begin{tabular}{@{}p{\foottitlewidth}}
                \scriptsize Postbus 177, 2600 MH Delft $|$ Boussinesqweg 1 $|$ 2629 HV Delft $|$ T +31(0)88\,335\,8273 $|$ F +31(0)88\,335\,8582 $|$ www.deltares.nl\newline
                Deltares is ingeschreven in het handelsregister van de Kamer van Koophandel Haaglanden onder nr.\ 41146461 als Stichting Deltares
            \end{tabular}
        }
    \else
        \if@spanish
            \fancyfoot[LO]{
                \hspace{-21mm}\parbox[t][29mm]{29mm}{\includegraphics[height=15mm]{pictures/Deltares_pay-off_D-blauw_RGB.pdf}}\newline
                \vspace{-3.0\baselineskip}
                \begin{tabular}{@{}p{\foottitlewidth}}
                    \scriptsize P.O.\ Box 177, 2600 MH Delft $|$ Boussinesqweg 1, 2629 HV Delft $|$ Pa\'ises Bajos $|$ T +31(0)88\,335\,8273 $|$ F +31(0)88\,335\,8582 $|$ www.deltares.nl\newline
                    Deltares est\'a registrado en la C\'amara de Comercio Haaglanden con n\'umero 41146461, como Fundaci\'on 'Stichting Deltares'
                \end{tabular}
            }
        \else
            \fancyfoot[LO]{
                \hspace{-21mm}\parbox[t][29mm]{29mm}{\includegraphics[height=15mm]{pictures/Deltares_pay-off_D-blauw_RGB.pdf}}\newline
                \vspace{-3.0\baselineskip}
                \begin{tabular}{@{}p{\foottitlewidth}}
                    \scriptsize P.O.\ Box 177, 2600 MH Delft $|$ Boussinesqweg 1, 2629 HV Delft $|$ The Netherlands $|$ T +31(0)88\,335\,8273 $|$ F +31(0)88\,335\,8582 $|$ www.deltares.nl\newline
                    Deltares is registered with the trade register of the Chamber of Commerce Haaglanden with number 41146461, as Foundation 'Stichting Deltares'
                \end{tabular}
            }
        \fi
    \fi
    \fancyfoot[CO]{\headerfont }%
    \fancyfoot[RO]{\headerfont }
}

\addtocounter{secnumdepth}{1}
\setlength{\parskip}{\baselineskip}
\setlength{\parindent}{0pt}
\setlength{\parsep}{1pt}
\setlength{\partopsep}{1pt}

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
%------------------------------------------------------------------------------
%
% MEMO header
%
%------------------------------------------------------------------------------
\newcommand{\deltarestitle}{
    \pagestyle{pagematter}
    \thispagestyle{plain}
    \begingroup
        \renewcommand{\arraystretch}{1.00}
        \makememoHeader
    \endgroup
}
\def\makememoHeader{
    \begin{tabular}{@{}p{90mm-6pt}p{\textwidth-90mm-12pt}}
    \vspace{-2.5\baselineskip}
    \color{dblue4}\huge Memo  &    \vspace{-5.75\baselineskip}  \hfill \parbox[t][28mm]{28mm}{\headerfont \includegraphics[height=18mm]{pictures/Deltares_logo_D-blauw_RGB.pdf}}\\
    \end{tabular}
    \vskip 2\baselineskip
    \begin{tabular}{@{}p{90mm-6pt}}
    \scriptsize{\textbf{\@To}}  \\
    \scriptsize{\@memoTo}
    \end{tabular}
    \vskip 0\parskip
    \if@confidential
        \vskip 0\parskip
        \begin{tabular}{@{}p{90mm-6pt}}
        \if@dutch
            \underline{Vertrouwelijk tot \@memoConfidentialUntil}  \\
        \else
            \if@spanish
                \underline{Confidencial hasta \@memoConfidentialUntil}  \\
            \else
                \underline{Confidential until \@memoConfidentialUntil}  \\
            \fi
        \fi
        \end{tabular}
        \vskip 0\parskip
    \fi
    \begin{tabular}{@{}p{46mm}@{}p{46mm}@{}p{46mm}@{}p{30mm}}
    \scriptsize{\textbf{\@Date}} & \scriptsize{\textbf{\@Reference}} &
    \scriptsize{} & \scriptsize{\textbf{\@NumberOfPages}} \\
    \scriptsize{\@memoDate} &   \scriptsize{\@memoVersion} & & \scriptsize{\pageref*{LastPage}} \\
    \scriptsize{\textbf{\@From}}  &  \scriptsize{\textbf{\@DirectLine}} & \scriptsize{\textbf{\@EMail}} & \\
    \scriptsize{\@memoFrom}         &  \scriptsize{\@memoTelephone}    & \scriptsize{\@memoEmail} &
    \end{tabular}
    \vskip 0\parskip
    \begin{tabular}{@{}p{\textwidth-6pt}}
    \scriptsize{\textbf{\@Subject}}  \\
    \scriptsize{\@memoSubject} \\
    \if@memocopy
        \scriptsize{\textbf{\@CopyTo}}  \\
        \scriptsize{\@memoCopy} \\
    \fi
    \vskip 1\parskip
    \end{tabular}
    \vskip 1\baselineskip
    \let\makememoHeader\relax
    \if@druler
        \AddToShipoutPicture{\BackgroundRuler}
    \fi
}
\long\def\LastPage{%
    \phantom{m}%
}

%------------------------------------------------------------------------------
%
% To change the caption of tables and figures.
% Format is defautl or `hang' wich aligns caption to the right of the figure statement
%
\captionsetup{format=default,margin=0.9cm,font=small,labelfont={sl,bf},textfont=sl,labelsep=colon,justification=RaggedRight,singlelinecheck=false}
%
\newlength{\greentablewidth}   % a "scratch" length
\setlength{\greentablewidth}{0mm} % extra space%
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
    {\color[rgb]{0,0.2,0.5}\textbf{TODO(??):} }%
    \protect\marginnote{\textbf{TODO}}%
    {\color[rgb]{0,0.2,0.5}\slshape #1}%
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
    \setlength{\parskip}{\baselineskip/2}%
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
    \setlength{\parskip}{\baselineskip/2}%
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
        \setlength{\parskip}{\baselineskip/2}%
        \setlength{\topsep}{0pt}%
        \setlength{\parsep}{0pt}%
        \setlength{\itemsep}{0pt}
    }%
  }%
  {\end{list}}

%------------------------------------------------------------------------------

\def\nonumchapter#1{%
    \chapter*{#1}%
    %\addcontentsline{toc}{chapter}{#1}%
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
        \llap{\makebox[14mm][l]{\thesection \hfill}}%
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
        \llap{\makebox[14mm][l]{\thesubsection \hfill}}%
        #2
        %\par
    \endgroup
    \vskip -1\baselineskip\nopagebreak
    \vskip 1.75mm
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
    \vskip 1.75mm
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
        \llap{\makebox[14mm][l]{\thesubsubsection \hfill}}%
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
        \llap{\makebox[14mm][l]{\theparagraph \hfill}}%
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
        \llap{\makebox[14mm][l]{\thesubparagraph \hfill}}%
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
\renewcommand\footnoterule{\hrule width 44mm height 1.5pt\kern 1mm}
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
    \newcommand{\printallbibliography}{\printbibliography[heading=bibintoc,locallabelwidth=true]}

    \if@dutch
        \DefineBibliographyStrings{dutch}{%
            bibliography = {Referenties}
        }
        \defbibheading{subbibheading}{
            \subparagraph*{Referenties} % for \Autoref{refsegment:\therefsection\therefsegment}}
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
        \else  % i.e. English
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
    \setlength\biblabelsep{14mm}
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
    %\usepackage{chapterbib}
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
\def\@gitrepository{-{}-{}-{}-}
\def\@gitbranch{-{}-{}-{}-}
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
    \StrBefore{\gitreposB}{fetch}[\gitreposC]  % then before the "fetch" string
    \StrSubstitute{\gitreposC}{\\}{\textbackslash }[\gitreposD]
    \StrSubstitute{\gitreposD}{_}{\_}[\gitreposE]
    \gdef\@gitrepository{\gitreposE}
    \StrLeft{\@githashlong}{7}[\@githashshort]
    }{
    }
}
\newcommand{\gitdirectory}{\@setgitdirectory}
\newcommand{\gitrepository}{\@gitrepository}
\newcommand{\githashlong}{\@githashlong}
\newcommand{\githash}{\@githashshort}
\newcommand{\gitbranch}{\StrSubstitute{\@gitbranch}{_}{\_}}

%------------------------------------------------------------------------------
\makeatother
