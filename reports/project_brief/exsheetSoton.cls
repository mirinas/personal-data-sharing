%%
%% This is file `exsheetSoton.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% exsheetSoton.dtx  (with options: `exsheetSoton')
%% 
%% This is a generated file.
%% 
%% Copyright (C) 2018 by Thai Son Hoang
%% <T dot S dot Hoang at ecs dot soton dot ac dot uk>
%% 
%% This file may be distributed and/or modified under the conditions of
%% the LaTeX Project Public License, either version 1.3c of this license
%% or (at your option) any later version. The latest version of this
%% license is in:
%% 
%%    http://www.latex-project.org/lppl.txt
%% 
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008/05/04 or later.
%% 
%% This work has the LPPL maintenance status "author-maintained".
%% 
%% The Current Maintainer of this work is T. S. Hoang
%% 
%%%%%% BEGIN Identification part %%%%%
\NeedsTeXFormat{LaTeX2e}\relax
\ProvidesClass{exsheetSoton}
    [2019/02/02 v0.1.1 Class for University of Southampton exercise sheet]
%%%%%% END Identification part %%%%%

%%%%% BEGIN Internal Helper Macros %%%%%

%   A wrapper for \ifstrequal to make sure that the first argument is properly expanded
\newcommand{\exsheetSoton@ifstrequal}{%
  \expandafter\ifstrequal\expandafter%
}%
\newcommand{\exsheetSoton@ifnotempty}[2]{%
  \exsheetSoton@ifstrequal{#1}{}{}{#2}%
}%
%%%%% END Internal Helper Macros %%%%%
\newcommand{\exsheetSoton@Module}{Module Name}
\newcommand{\module}[1]{%
  \renewcommand{\exsheetSoton@Module}{#1}%
}%
\newcommand{\exsheetSoton@Authors}{Authors}
\newcommand{\authors}[1]{%
  \renewcommand{\exsheetSoton@Authors}{#1}%
}%
\newcommand{\exsheetSoton@Period}{Current semester}
\newcommand{\period}[1]{%
  \renewcommand{\exsheetSoton@Period}{#1}%
}%
\newcommand{\exsheetSoton@exType}{Problem Class}
\newcommand{\exType}[1]{%
  \renewcommand{\exsheetSoton@exType}{#1}%
}%
\newcommand{\exsheetSoton@groupNumber}{}
\newcommand{\groupNumber}[1]{%
  \renewcommand{\exsheetSoton@groupNumber}{#1}%
}%
\newcommand{\exsheetSoton@exTitle}{Exercise Title}
\newcommand{\exTitle}[1]{%
  \renewcommand{\exsheetSoton@exTitle}{#1}%
}%
\newcommand{\exsheetSoton@IssueDate}{Issue Date}
\newcommand{\issueDate}[1]{%
  \renewcommand{\exsheetSoton@IssueDate}{#1}%
}%
\newcommand{\exsheetSoton@SubmissionDate}{}
\newcommand{\submissionDate}[1]{%
  \renewcommand{\exsheetSoton@SubmissionDate}{#1}%
}%

%%%%% BEGIN Declaration of options %%%%%
\PassOptionsToClass{a4paper,11pt,DIV12}{scrartcl}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\newcommand{\exsheet@submissiondate}{subm. date}
\newcommand{\submissiondate}[1]{\renewcommand{\exsheet@submissiondate}{#1}}
\newcommand{\exsheet@postdate}{}
\newcommand{\postdiscussiondate}[1]{\renewcommand{\exsheet@postdate}{#1}}

%%%%% Exclude solution for exercise sheet %%%%%
\newenvironment{solution}{\comment}{\endcomment}
\newenvironment{assignmentonly}{}{}

\DeclareOption{solution}{

  %%%%% Redefine the type as solution sheet %%%%%
  \exType{Solution Sheet}

  %%%%% Include the solution %%%%%
  \renewenvironment{solution}{
    \bigskip

\noindent
    \textbf{Solution:}% \marginline{\textbf{Solution}}
\\
  }{}

\renewenvironment{assignmentonly}{\comment}{\endcomment}
}

%%%%% END Declaration of options %%%%%

%%%%% BEGIN Execution of options %%%%%
\ProcessOptions\relax
%%%%% END Execution of options %%%%%

%%%%% BEGIN Special class file commands %%%%%
\LoadClass{scrartcl}
%%%%% END Special class file commands %%%%%

%%%%% BEGIN Packages loading %%%%%
\RequirePackage{etoolbox}
\RequirePackage[T1]{fontenc}

\RequirePackage{ifthen}

\RequirePackage{latexsym}
\RequirePackage{textcomp}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsbsy}

\RequirePackage{graphicx}
%%%% Use verbatim package for commenting out the solution in the exercise sheet
\RequirePackage{verbatim}

%%%%% END Packages loading %%%%%

\renewcommand{\maketitle}
{
  \begin{minipage}[t]{0.4\textwidth}
    \vspace{-8ex}
    \hspace{-4em}
  \end{minipage}
  \hfill
  \begin{minipage}[t]{0.5\textwidth}
    \vspace{0pt}
    \flushright%
    \exsheetSoton@Authors%
  \end{minipage}
  \begin{center}
    \vspace{40pt}
    {\huge \exsheetSoton@Module}\\
    \vspace{20pt}
    {\LARGE
      \exsheetSoton@exTitle}\\
    \vspace{20pt}
    {%
      \begin{tabular}{ll}
        \exsheetSoton@ifnotempty{\exsheetSoton@SubmissionDate}
        {Submission date: & \exsheetSoton@SubmissionDate} \\
      \end{tabular}
    }
    \vspace{5pt}
  \end{center}
}

\AtBeginDocument{\maketitle}
\endinput
%%
%% End of file `exsheetSoton.cls'.
