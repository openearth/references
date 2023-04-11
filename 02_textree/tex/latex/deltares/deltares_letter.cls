\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_memo}
              [2011/07/25 v1.0 Deltares memo class]
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
\usepackage{marginnote} % needed to place a margin text in a table environment

\usepackage{amstext} % for \text command in math environment
%

% to align equations left add [fleqn] as option to amsmath
%
\usepackage[fleqn]{amsmath}
\usepackage{amssymb}
\usepackage[amssymb,textstyle]{SIunits}
\usepackage{paralist} % inline enumeration

\usepackage[destlabel, pagebackref,pdfborder={0 0 0}, bookmarksnumbered=true, colorlinks=true, linkcolor=blue, citecolor=blue]{hyperref}
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
\setlength{\textheight}{29.7cm-5cm-\baselineskip-4\baselineskip}
\footskip 1cm
% 1.5cm remaining

\oddsidemargin 3.7cm
\setlength{\textwidth}{21cm-5.8cm}
\marginparsep 0mm
\marginparwidth 0mm
\evensidemargin 2cm

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

\def\letterName#1{\gdef\@letterName{#1}}
\def\letterAddress#1{\gdef\@letterAddress{#1}}
\def\letterCity#1{\gdef\@letterCity{#1}}
\def\letterCountry#1{\gdef\@letterCountry{#1}}
\def\letterDate#1{\gdef\@letterDate{#1}}
\def\letterEmail#1{\gdef\@letterEmail{#1}}
\def\letterSubject#1{\gdef\@letterSubject{#1}}
\def\letterTitular#1{\gdef\@letterTitular{#1}}

\def\@letterName{use \texttt{$\backslash$letterName\{\ldots\}}}
\def\@letterAddress{use \texttt{$\backslash$letterAddress\{\ldots\}}}
\def\@letterCity{use \texttt{$\backslash$letterCity\{\ldots\}}}
\def\@letterCountry{use \texttt{$\backslash$letterCountry\{\ldots\}}}
\def\@letterDate{use \texttt{$\backslash$letterDate\{\ldots\}}}
\def\@letterEmail{use \texttt{$\backslash$letterEmail\{\ldots\}}}
\def\@letterSubject{use \texttt{$\backslash$letterSubject\{\ldots\}}}

% \title{\@program\\\@subtitle\\\@manualtype}
\newcommand{\thechap}{$\;$\leftmark{}$\;$}


%------------------------------------------------------------------------------

\def\HUGE{\@setsize\Huge{40pt}\xxvpt\@xxvpt}
\definecolor{gris}{RGB}{128,128,128} % deltares sand

%------------------------------------------------------------------------------
\newcommand{\helv}{%
\fontfamily{phv}\selectfont}

\if@dutch
    \def\@Name{naam}
    \def\@Address{adres}
    \def\@City{stad}
    \def\@Date{Datum}
    \def\@EMail{E-mail}
    \def\@Subject{Onderwerp}
    \def\@letterTitular{dhr., mevr.}
    \def\@ChamberOfCommerce{Postbus 177, 2600 MH  Delft,   Boussinesqweg 1, 2629 HV  Delft, Nederland,  T +31(0)88\,335\,8273,   F +31(0)88\,335\,8582,   www.deltares.nl. \newline Deltares is ingeschreven in het handelsregister van de Kamer van Koophandel Haaglanden onder nummer 41146461 als Stichting Deltares.
}
\else
    \def\@name{name}
    \def\@address{address}
    \def\@city{city}
    \def\@Date{Date}
    \def\@EMail{E-mail}
    \def\@Subject{Subject}
    \def\@letterTitular{Mr., Ms.}
    \def\@ChamberOfCommerce{P.O.\ Box 177, 2600 MH  Delft,  Boussinesqweg 1, 2629 HV  Delft,  The Netherlands,  T +31(0)88\,335\,8273,  F +31(0)88\,335\,8582,  www.deltares.nl. \newline Deltares is registered with the trade register of the Chamber of Commerce Haaglanden with number 41146461, as Foundation 'Stichting Deltares'.
}
\fi

%------------------------------------------------------------------------------
%
% Change header and footer
%
\usepackage{fancyhdr}
\newcommand{\headerfont}{\fontfamily{phv}\selectfont}
\newcommand{\letterOnset}{\@letterTitular}
%\newcommand{\headerfont}{\selectfont}
\def\footersize{\@setsize\scriptsize{9pt}\viipt\@viipt}
\pagestyle{fancy}
\fancyhead{}
\setlength{\headheight}{6\baselineskip}
\fancyhead[LO,LE]{
    \headerfont
    \begin{tabular}[b]{@{}p{50mm}p{\textwidth-50mm-19pt}}
        \scriptsize{\textbf{\@Date}}  \\
    \end{tabular}
    }
\fancyhead[CO,CE]{ \headerfont }
\fancyhead[RO,RE]{ \headerfont \includegraphics[height=6\baselineskip]{pictures/deltares_namelogo.pdf}}
\fancyfoot{}
\fancyfoot[LO,RE]{\headerfont }
\fancyfoot[CO,CE]{\headerfont }
\fancyfoot[RO,LE]{\headerfont }

\renewcommand{\headrulewidth}{0pt}

\fancypagestyle{plain}{%
    \fancyhead{}%
    \fancyhead[LO,RE]{\headerfont }%
    \fancyhead[CO,CE]{\headerfont }%
    \fancyhead[RO,LE]{\headerfont }%
    \fancyfoot{}%
    \fancyfoot[LO,RE]{\headerfont \footersize \@ChamberOfCommerce}%
    \fancyfoot[CO,CE]{\headerfont }%
    \fancyfoot[RO,LE]{\headerfont }
}

\addtocounter{secnumdepth}{1}
\setlength{\parskip}{\baselineskip/2}
\setlength{\parindent}{0pt}
\setlength{\parsep}{1pt}
\setlength{\partopsep}{1pt}

%------------------------------------------------------------------------------
%
% MEMO header
%
%------------------------------------------------------------------------------
\def\deltarestitle{
    \vspace*{0mm}% needed to get adress on the right place (behind the envelop window)
    \begin{tabular}{@{}p{\textwidth}}
    {{\@letterName}}  \\
    {{\@letterAddress}}  \\
    {{\@letterCity}}  \\
    {{\@letterCountry}}
    \end{tabular}
%
    \vskip 6\baselineskip
    {%\color{gris}
    \begin{tabular}{@{}p{45mm}p{\textwidth-45mm-19pt}}
    \footnotesize{\textbf{\@Date}} &  \footnotesize{\textbf{\@EMail}} \\
     \@letterDate & \@letterEmail
    \end{tabular}
    }
    \vskip 1\baselineskip
    {%\color{gris}
    \begin{tabular}{@{}p{\textwidth}}
    \footnotesize{\textbf{\@Subject}}  \\
    \@letterSubject      \\
    \end{tabular}
    }
%
    \vskip 2\baselineskip
    \let\deltarestitle\relax
    \thispagestyle{plain}
}


%------------------------------------------------------------------------------
%
% To change the caption of tables and figures.
% Format is defautl or `hang' wich aligns caption to the right of the figure statement
\captionsetup{format=default,margin=0.9cm,font=small,labelfont=sl,textfont=sl}
%
%------------------------------------------------------------------------------
%
% Define a more advanced remark environment that writes Remark if there is only
% one item and that writes Remarks if there are multiple items.
%
\usepackage{ifthen}
%
%
\RecustomVerbatimEnvironment
  {Verbatim}{Verbatim}
  {fontsize=\footnotesize}
%


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

\newcommand{\Cref}[1]{Chapter~\ref{#1}}
\newcommand{\Sref}[1]{Section~\ref{#1}}
\newcommand{\Fref}[1]{Figure~\ref{#1}}
\if@dutch
    \newcommand{\Frefs}[2]{Figuren~\ref{#1} en \ref{#2}}
    \newcommand{\Freft}[2]{Figuren~\ref{#1} tot \ref{#2}}
\else
    \newcommand{\Frefs}[2]{Figures~\ref{#1} and \ref{#2}}
    \newcommand{\Freft}[2]{Figures~\ref{#1} to \ref{#2}}
\fi
\newcommand{\Aref}[1]{Algorithm~\ref{#1}}
\newcommand{\Apref}[1]{Appendix~\ref{#1}}
\newcommand{\Tref}[1]{Table~\ref{#1}}
\newcommand{\Eref}[1]{Equation~\ref{#1}}


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
\usepackage{natbib}
\bibpunct[, ]{(}{)}{;}{a}{,}{,}
\renewcommand\bibsection{}
\bibliographystyle{deltares_chicago_like}
%\usepackage{chapterbib}
\makeatother

