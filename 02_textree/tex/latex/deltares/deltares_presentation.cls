\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_presentation}
              [2023/08/25 v1.0 Standard LaTeX document class]
\makeatletter

\newif\if@academy% deltares academy
\@academyfalse
\DeclareOption{academy}{%
    \@academytrue%
}
\newif\if@wide% deltares wide 16x9
\@widefalse
\DeclareOption{wide}{%
    \@widetrue%
}
\ProcessOptions\relax
\PassOptionsToPackage{fleqn}{amsmath}
\LoadClass{beamer}

% Requirement
\RequirePackage{tikz}
\RequirePackage{transparent}
\usepackage{lipsum}
\usepackage{pgfcomp-version-0-65}
\usepackage{color}
\usepackage[scaled=.92]{helvet}
\def\rmdefault{phv}
\DeclareMathSizes{\@xipt}{\@xiipt}{8}{6}
\usepackage{amstext} % for \text command in math environment
\usepackage{amssymb}
\usepackage{subcaption}

\usepackage[yyyymmdd]{datetime} % to generate a timestamp
\settimeformat{hhmmsstime}
\renewcommand{\dateseparator}{-}


%-------------------------------------------------------------------------------
% beamer color Theme
%-------------------------------------------------------------------------------

%%%%%%%%%%%%%% Jan Mooiman
% Corporate colors
\definecolor{dbluelink}{RGB}{000,000,100} % the colour of hyper links in the pdf-document (daaark blue)
\definecolor{dblue}{RGB}{  8,  12,128}  % v5: the colour of deltares-name.pdf
\definecolor{dblue0}{RGB}{ 13, 56,224}  % v5: blue table header color
\definecolor{dblue1}{RGB}{236,239,253}  % v5: alternating blue colour in the blue table (light)
\definecolor{dblue2}{RGB}{217,223,250}  % v5: alternating blue colour in the blue table (dark)
\definecolor{dblue4}{RGB}{  8, 12,128}  % v5: colouring the title/subtitle of report
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
\if@academy
    \definecolor{dbeamer}{RGB}{255,114,0}
\else
    \definecolor{dbeamer}{RGB}{83,83,76}
\fi

% Settings
\renewcommand{\familydefault}{phv}
\setbeamercolor{date}{fg=dblue}
\setbeamercolor{author}{fg=dmetallic!70!black}
\setbeamercolor{structure}{fg=dblue}
\setbeamercolor{section in head/foot}{fg=white, bg=dblue}
\setbeamercolor{block body}{bg=normal text.bg!97!black}
\setbeamercolor{block title}{bg=dblue, fg=white}
\setbeamercolor{block title example}{use={normal text,example text},fg=white,bg=dgreen}
\setbeamercolor{block title alerted}{bg=red, fg=white}
\setbeamercolor{block body alerted}{bg=normal text.bg!97!black}
\setbeamercolor{frametitle}{fg=dblue4}

% Items
\setbeamertemplate{items}[arrow]
\setbeamertemplate{sections/subsections in toc}[circle]
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{blocks}[rounded][shadow=true]
\pgfdeclareverticalshading[upper.bg,lower.bg]{bmb@transition}{\textwidth+10mm}{%
  color(0pt)=(lower.bg); color(3pt)=(lower.bg); color(3pt)=(upper.bg); color(4pt)=(upper.bg)}

% Fonts
\usepackage[T1]{fontenc}
\renewcommand{\ttdefault}{cmr}
\renewcommand\mathfamilydefault{\ttdefault}

\setbeamerfont{date}{size=\footnotesize}
\setbeamerfont{author}{}

\newcommand{\frontPhoto}{\includegraphics[height=\paperheight]{pictures/tetra_kantoor.png}}
%\newcommand{\frontPhoto}{\includegraphics[height=\paperheight, trim=135mm 0 0 0]{pictures/obernbergersee.jpg}}

%-------------------------------------------------------------------------------
% beamer innner Theme
%-------------------------------------------------------------------------------
\DeclareOptionBeamer{shadow}[true]{\def\beamer@themerounded@shadow{#1}}
\ExecuteOptionsBeamer{shadow=false}
\ProcessOptionsBeamer
\if@wide
\setlength\paperwidth{160mm}%
\setlength\paperheight{90mm}%
\textwidth=130mm
\else
\setlength\paperwidth{160mm}%
\setlength\paperheight{45mm}%
\fi

\mode<presentation>

% Title page
%\defbeamertemplate{title page}{Deltares}%
%{
%}
\setbeamertemplate{title page}{\titleframe}
\newcommand{\titleframe}{%
\begin{frame}[plain]
\textwidth=90mm
    \vspace*{90mm}
    \hspace*{-11mm}{
        \begin{pgfpicture}
            \frontPhoto
        \end{pgfpicture}
    }
    \raisebox{80mm}[0pt][0pt]{
        \hspace{110mm}\includegraphics[height=10mm]{Deltares_logo_D-blauw_RGB.pdf}
    }
    \raisebox{10mm}[0pt][0pt]{
    \hspace*{60mm}
    \hbox{%
        \begin{beamercolorbox}[wd=\textwidth,sep=8pt]{title page header}
            \if@academy
                \color{dblue}
            \else
                \color{dblue}
            \fi
            \usebeamerfont{title}{\color{dblue4}\bfseries\inserttitle}%
            \vskip0.75cm%
            \usebeamerfont{subtitle}{\color{dblue4}\small\insertsubtitle}%
            \vskip0.50cm%
            \usebeamerfont{author}{\insertauthor}%
            \vskip0.50cm%
            \usebeamerfont{date}{\color{dblue4}\insertdate}%
        \end{beamercolorbox}
        }
    }
\end{frame}
}

%-------------------------------------------------------------------------------
% beamer outer Theme
%-------------------------------------------------------------------------------

\setbeamertemplate{headline}{\SlideHeader}
\setbeamertemplate{footline}{\SlideFooter}

\setbeamertemplate{frametitle}{\LARGE\bfseries\vspace*{7mm}\hspace*{0mm}\insertframetitle}

\newcommand{\SlideRightRibbon}{%
}
\newcommand{\SlideHeader}{% Now it is the ribbon at right side of slide
    % Draw ribbon at right side
    \raisebox{-45mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{90mm+5mm}
        \color{dblue5}
        \pgfline{\pgfpoint{155mm}{1mm}}{\pgfpoint{150mm+10mm}{1mm}}
    \end{pgfpicture}}
    % Draw small line in the ribbon
    \raisebox{-85mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{0.25pt}
        \color{black}
        \pgfline{\pgfpoint{155mm+0.25pt}{1mm}}{\pgfpoint{155mm+4mm}{1mm}}
    \end{pgfpicture}}
}

\newcommand{\SlideFooter}{% Footer with Delatres-logo, section, date and page numbers
{
    \leavevmode%
    \hbox{%
    \begin{beamercolorbox}[wd=\paperwidth,dp=1ex]{}
        \vspace{0mm}
        \hspace{7.75mm}\includegraphics[height=8mm,keepaspectratio]{pictures/Deltares_logo_D-blauw_RGB.pdf}%
    \end{beamercolorbox}%
    }
    \hbox{%
    \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,left]{date in head/foot}%
        \hspace*{4mm} \usebeamerfont{date in head/foot}\thesection.~\insertsection~~\beamer@ifempty{\insertshortinstitute}{}{}
    \end{beamercolorbox}%
    \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{date in head/foot}%
        \usebeamerfont{date in head/foot}\insertshortdate{}
    \end{beamercolorbox}%
    \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,right]{date in head/foot}%
        \usebeamerfont{date in head/foot}\insertpagenumber{} \hspace*{1.0mm}
    \end{beamercolorbox}}%
    \vskip3pt%
}}



\defbeamertemplate{background}{special frames}{%
      \begin{tikzpicture}
      \fill[white,opacity=1] (0,0) rectangle(\the\paperwidth,\the\paperheight);
      \useasboundingbox (0,0) rectangle(\the\paperwidth,\the\paperheight);
      \end{tikzpicture}
}

\setbeamertemplate{background}{
  \begin{tikzpicture}
   \fill[white,opacity=1] (0,0) rectangle(\the\paperwidth,\the\paperheight);
  \end{tikzpicture}
}

\newcommand{\insertendpage}{%
    \setbeamertemplate{background}[special frames]
    \begin{frame}[plain]
    \frametitle{Contact}
    \renewcommand{\tabcolsep}{0pt}
    \renewcommand{\arraystretch}{0.75}
    \raisebox{14mm}[0mm][0mm]{
        \begin{tabular}{{p{0.25\paperwidth}p{0.0\paperwidth}p{0.25\paperwidth}}}
            \color{dblue4} www.deltares.nl & \color{dblue4}  & \color{dblue4} \\ 
            \color{dblue4} info@deltares.nl & \color{dblue4}  & \color{dblue4} \\ 
        \end{tabular}
    }
    \newline
    \newline
    \hspace*{-12mm}
    \raisebox{-43mm}[0mm][5mm]{
      \begin{tikzpicture}
        \includegraphics[width=\paperwidth, trim=0 0 0 0, scale=1]{pictures/deltagoot.png}
      \end{tikzpicture}
    }
    \end{frame}
}


%-------------------------------------------------------------------------------

\mode<all>
\AtBeginEnvironment{proof}{\let\@addpunct\@gobble}
%-------------------------------------------------------------------------------

\makeatother

