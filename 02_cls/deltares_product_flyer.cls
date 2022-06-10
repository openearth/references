% This class file aims to reproduce the productblad that can be found in WhiteOffice.
% Author: Bernhard Becker (bernhard.becker@deltares.nl)
% The requirements of the Deltares huisstijl are met as good as possible under the constraints of the limited technical  knowledge of the Author.
% Basically let the AVD department make your product summaries,
% use this only if there is a special reason (for example: requirement of svn version control).

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{deltares_product_flyer}
              [2007/10/31 v1.0 Standard LaTeX document class]
\LoadClass[10pt,twoside,a4paper,titlepage]{article}

\RequirePackage{color}
\RequirePackage{transparent}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage{eso-pic}
\RequirePackage[a4paper,portrait]{geometry}
\RequirePackage{xwatermark}
\RequirePackage{ifthen}

\usepackage{sectsty}  % to set section fonts
\usepackage{xspace}
\usepackage[font=scriptsize]{caption}
\usepackage{textcomp}
\usepackage[final]{pdfpages} % needed for cover pages
\usepackage[destlabel, pagebackref, pdfborder={0 0 0}, bookmarksnumbered=true, colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue]{hyperref}

\definecolor{dblue}{RGB}{000,139,191}
\definecolor{dmetallic}{RGB}{128,169,189}
\definecolor{dgreen}{RGB}{180,211,0}

\renewcommand{\familydefault}{\sfdefault}
\newcommand{\subtitle}[1]{\def\@subtitle{#1}}
\newcommand{\Version}[1]{\def\@Version{#1}}
\newcommand{\ContactEmail}[1]{\def\@ContactEmail{#1}}
\newcommand{\ContactURL}[1]{\def\@ContactURL{#1}}

\geometry{lmargin=6cm,rmargin=1.5cm,tmargin=0cm,bmargin=2.5cm}
\allsectionsfont{\color{dblue}\fontfamily{phv}\selectfont}
\sectionfont{\color{dblue}\large}

\long\def\maketitle{
    \thispagestyle{empty}
    \setlength{\unitlength}{1cm}
    \AddToShipoutPicture*{\BackgroundTitle}
    \vspace*{10cm}
}

\long\def\EndTitlePage{
    \newpage
    \newgeometry{lmargin=1.5cm,rmargin=1.5cm, tmargin= 2cm, bmargin =2.5cm}
    \twocolumn
    \AddToShipoutPicture{\BackgroundPage}
}

\long\def\LastPage{
    \newpage
    \newgeometry{lmargin=1.5cm,rmargin=1.5cm, tmargin= 2cm, bmargin =6.5cm}
    \twocolumn
    \thispagestyle{empty}
    \AddToShipoutPicture*{\BottomLastPage}
}


\newcommand\BackgroundTitle{%
\setlength{\unitlength}{1cm}
\put(0,22.8){{\textcolor{dblue}{\rule{4.4cm}{1.3cm}}}}
\put(0,21.5){\transparent{0.65}{\textcolor{dblue}{\rule{4.4cm}{1.3cm}}}}
\put(0,20.2){\transparent{0.50}{\textcolor{dblue}{\rule{4.4cm}{1.3cm}}}}
\put(0,0){\textcolor{dgreen}{\rule{4.4cm}{20.2cm}}}
%
\put(0.0,22.8){\textcolor{white}{\line(1,0){4.4}}}
\put(4.4,22.8){\textcolor{dblue}{\line(1,0){16}}}
\put(0.0,21.5){\textcolor{white}{\line(1,0){4.4}}}
\put(4.4,21.5){\textcolor{dblue}{\line(1,0){16}}}
\put(0.0,20.2){\textcolor{white}{\line(1,0){4.4}}}
\put(4.4,20.2){\textcolor{dblue}{\line(1,0){16}}}
%
\put(12.45,24.45){\includegraphics{pictures/deltares_merk.pdf}}
\put(6,22.806){\textcolor{dblue}{{\LARGE \fontfamily{phv}\textbf{\@title}}}}
\put(6,21.505){\textcolor{dblue}{{\Large \fontfamily{phv}\textit{\@subtitle}}}}
%
\put(4.5,0.3){\rotatebox{90}{{\textcolor{dblue}{\tiny \fontfamily{phv}\@Version}}}}
}

\newcommand\BackgroundPage{
    \ifthenelse{\isodd{\thepage}}{
        \setlength{\unitlength}{1cm}
        \put(16.6,28.4){\textcolor{dgreen}{\rule{4.4cm}{1.3cm}}}
        \put(13.1,28.6){\includegraphics[width=3cm]{pictures/deltares_name.pdf}}
    }{
        \setlength{\unitlength}{1cm}
        \put(0,28.4){\textcolor{dgreen}{\rule{4.4cm}{1.3cm}}}
        \put(4.9,28.6){\includegraphics[width=3cm]{pictures/deltares_name.pdf}}
    }
}

\newcommand\BottomLastPage{
    \setlength{\unitlength}{1cm}
    \put(11,0){\textcolor{dgreen}{\rule{10cm}{3.2cm}}}
    \put(14.6,3.2){\textcolor{dgreen}{\rule{6.4cm}{0.9cm}}}
    \put(13.7,3.2){\transparent{0.65}{\textcolor{dgreen}{\rule{0.9cm}{0.9cm}}}}
    \put(12.8,3.2){\transparent{0.50}{\textcolor{dgreen}{\rule{0.9cm}{0.9cm}}}}
    \put(11.9,3.2){\transparent{0.35}{\textcolor{dgreen}{\rule{0.9cm}{0.9cm}}}}
    \put(11.6,0.9){\textcolor{white}{\parbox[b]{8.1cm}{\small \fontfamily{phv}{\textsl{Deltares is a leading, independent, Dutch-based research institute and specialist consultancy for matters relating to water, soil and the subsurface. We apply our advanced expertise worldwide, to help people live safely and sustainably in delta areas, coastal zones and riverbasins.}}}}}
    \put(1.6,0.5){\includegraphics[width=5.5cm]{pictures/deltares_name.pdf}}
    \put(11.0,4.4){
        \textcolor{dblue}{
            \parbox[b]{8.6cm}{
                \small \fontfamily{phv}
                \textbf{More information:}\newline
                \url{\@ContactURL}\\
                \@ContactEmail
            }
        }
    }
}