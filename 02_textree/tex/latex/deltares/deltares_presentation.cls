\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_beamer}
              [2007/10/31 v1.0 Standard LaTeX document class]
\makeatletter

\newif\if@academy% deltares academy
\@academyfalse
\DeclareOption{academy}{%
    \@academytrue%
}
\ProcessOptions\relax
\LoadClass{beamer}

% Requirement
\RequirePackage{tikz}
\RequirePackage{transparent}
\usepackage{pgfcomp-version-0-65}
\usepackage{color}

%-------------------------------------------------------------------------------
% beamer color Theme
%-------------------------------------------------------------------------------

%%%%%%%%%%%%%% Jan Mooiman
% Corporate colors
\definecolor{dblue}{RGB}{000,139,191} %hex= #008bbf
\definecolor{dmetallic}{RGB}{128,169,189} %hex = #80a8bd
\definecolor{dsand}{RGB}{160, 158, 141}
% Secundary colors
\definecolor{dgreen}{RGB}{180,211,0} %hex = #b4d300
\definecolor{dorange}{RGB}{255,114,0}
\definecolor{dcyclaam}{RGB}{235,0,115}
\definecolor{dcyaan}{RGB}{0,196,214}
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
\setbeamercolor{frametitle}{fg=white}

% Items
\setbeamertemplate{items}[arrow]
\setbeamertemplate{sections/subsections in toc}[circle]
\setbeamertemplate{navigation symbols}{}
\setbeamertemplate{blocks}[rounded][shadow=true]  
\pgfdeclareverticalshading[upper.bg,lower.bg]{bmb@transition}{130mm}{%
  color(0pt)=(lower.bg); color(3pt)=(lower.bg); color(3pt)=(upper.bg); color(4pt)=(upper.bg)}

% Fonts
\setbeamerfont{date}{size=\footnotesize}
\setbeamerfont{author}{}

%-------------------------------------------------------------------------------
% beamer innner Theme
%-------------------------------------------------------------------------------
\DeclareOptionBeamer{shadow}[true]{\def\beamer@themerounded@shadow{#1}}
\ExecuteOptionsBeamer{shadow=false}
\ProcessOptionsBeamer

\mode<presentation>
% Title page
%\defbeamertemplate{title page}{Deltares}%
%{
%}
\setbeamertemplate{title page}{\titleframe}
\newcommand{\titleframe}{%
\begin{frame}[plain]
    \raisebox{15.5mm}[0pt][0pt]{
    \hspace{80mm}\includegraphics[height=15mm]{deltares_merk}
    }
    \if@academy
        \hbox{
            \raisebox{6.20mm}[0pt][0pt]{
                \hspace*{-1.5cm}   
                \begin{pgfpicture}{0mm}{-9mm}{0mm}{0mm}
                    \pgfsetlinewidth{27.5mm}
                    \color{dbeamer}
                    \pgfline{\pgfpoint{0mm}{0mm}}{\pgfpoint{65mm}{0mm}}
                \end{pgfpicture}
            }
        }
        \hbox{
            \raisebox{13.65mm}[0pt][0pt]{
            \hspace*{-10.5mm}
            \textcolor{dorange!90}{\fontsize{15.5mm}{1em}\selectfont\bfseries Academy}
            \raisebox{11.5mm}[0pt][0pt]{
            \hspace{-30mm}{\fontsize{3mm}{1em}\selectfont\bfseries\textcolor{white}{Academy}}
            }
            }
        }
        \hspace*{-1.0cm}
    \else
        \raisebox{6.20mm}[0pt][0pt]{
        \hspace*{-1.5cm}{    
        \begin{pgfpicture}
            \includegraphics[height=35mm]{pictures/landschap.jpg}    
        \end{pgfpicture}
        }}
    \fi
    %
    \raisebox{8.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{4mm}
        \transparent{0.90}
        \color{dmetallic!75}
        \pgfline{\pgfpoint{-10mm}{0mm}}{\pgfpoint{129mm}{0mm}}
    \end{pgfpicture}}
    \raisebox{12.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{4mm}
        \transparent{0.7}
        \color{dmetallic!50}
        \pgfline{\pgfpoint{-10mm}{0mm}}{\pgfpoint{129mm}{0mm}}
    \end{pgfpicture}}
    \raisebox{16.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{4mm}
        \transparent{0.5}
        \color{dmetallic!25}
        \pgfline{\pgfpoint{-10mm}{0mm}}{\pgfpoint{129mm}{0mm}}
    \end{pgfpicture}}
    %    
    \raisebox{18.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-15mm}{0mm}}{\pgfpoint{128mm}{0mm}}
    \end{pgfpicture}}
    \raisebox{14.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-15mm}{0mm}}{\pgfpoint{128mm}{0mm}}
    \end{pgfpicture}}
    \raisebox{10.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-15mm}{0mm}}{\pgfpoint{128mm}{0mm}}
    \end{pgfpicture}}
    \raisebox{6.20mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-15mm}{0mm}}{\pgfpoint{125mm}{0mm}}
    \end{pgfpicture}}
    %
    \raisebox{-40mm}[0pt][0pt]{%
    \hbox{%
    \begin{beamercolorbox}[wd=12cm,center,sep=8pt]{title page header}
        \color{dblue}
        \usebeamerfont{title}{\bfseries\inserttitle}%
        \vskip0.75cm%
        \usebeamerfont{author}{\color{dblue}\insertauthor}%
        \vskip0.75cm%
        \usebeamerfont{date}{\color{dblue}\insertdate}%
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

\setbeamertemplate{frametitle}{\bfseries\vspace*{3mm}\hspace*{0mm}\insertframetitle}

\newcommand{\SlideHeader}{%
    \raisebox{-3mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{4mm}
        \color{dbeamer!100}
        \pgfline{\pgfpoint{0mm}{1mm}}{\pgfpoint{128mm}{1mm}}
    \end{pgfpicture}}
    \raisebox{-7mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{4mm}
        \color{dbeamer!85}
        \pgfline{\pgfpoint{-2mm}{1mm}}{\pgfpoint{128mm}{1mm}}
    \end{pgfpicture}}
    \raisebox{-11mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \pgfsetlinewidth{4mm}
        \color{dbeamer!70}
        \pgfline{\pgfpoint{-2mm}{1mm}}{\pgfpoint{128mm}{1mm}}
    \end{pgfpicture}}

        \hspace*{87.75mm}\raisebox{-12mm}[0mm][0mm]{%
            {\includegraphics[height=12mm]{pictures/trein.jpg}}
            \hspace*{3mm}
            {\includegraphics[height=12mm]{pictures/landschap.jpg}}
        }

%    \raisebox{-3pt}[0pt][0pt]{%
%    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
%        \color{white}
%        \pgfline{\pgfpoint{0mm}{1mm}}{\pgfpoint{129mm}{1mm}}
%    \end{pgfpicture}}
    \raisebox{-5mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-5mm}{1mm}}{\pgfpoint{129mm}{1mm}}
    \end{pgfpicture}}
    \raisebox{-9mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-5mm}{1mm}}{\pgfpoint{129mm}{1mm}}
    \end{pgfpicture}}
    \raisebox{-13mm}[0pt][0pt]{%
    \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
        \color{white}
        \pgfline{\pgfpoint{-5mm}{1mm}}{\pgfpoint{129mm}{1mm}}
    \end{pgfpicture}}
}

\newcommand{\SlideFooter}{%
{
    \leavevmode%
    \hbox{%
    \begin{beamercolorbox}[wd=\paperwidth,dp=1ex]{}
        \begin{pgfpicture}{0mm}{0mm}{0mm}{0mm}
            \color{dblue!75}
            \pgfline{\pgfpoint{0mm}{0.20cm}}{\pgfpoint{97.5mm}{0.20cm}}
        \end{pgfpicture}
        \vspace{-1mm}
        \hspace{100mm}\includegraphics[height=0.5cm,keepaspectratio]{pictures/deltares_name}%
    \end{beamercolorbox}%
    }
    \hbox{%
    \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{date in head/foot}%
        \usebeamerfont{date in head/foot}\thesection.~\insertsection~~\beamer@ifempty{\insertshortinstitute}{}{}
    \end{beamercolorbox}%
    \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,center]{date in head/foot}%
        \usebeamerfont{date in head/foot}\insertshortdate{}
    \end{beamercolorbox}%
    \begin{beamercolorbox}[wd=.333333\paperwidth,ht=2.25ex,dp=1ex,right]{date in head/foot}%
        \usebeamerfont{date in head/foot}\insertframenumber{} / \inserttotalframenumber\hspace*{2ex} 
    \end{beamercolorbox}}%
    \vskip0pt%
}}




%-------------------------------------------------------------------------------

\mode<all>

%-------------------------------------------------------------------------------

\makeatother

