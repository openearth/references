d = []
with open('references.bib','r', encoding='utf-8') as refs: 
    for line in refs:
        #print(line)
        if line[0] == '@': 
            t = line[:-1].split('{')
            idx = t[1].find(',')
            d.append(t[1][:idx]) 
            print(t[1][:idx])
            t[0][1:].lower()
#d.sort()

header = [
    '\\documentclass[10pt]{article}\n',
    '\\usepackage[margin=2cm,landscape,a3paper]{geometry}\n',
    '\\usepackage{natbib}\n',
    '\\usepackage{hyperref}\n',
    '\\usepackage{pifont}\n',
    '\\DeclareRobustCommand{\\van}[3]{#2}\n',
    '\\begin{document}\n',
    '\\input{abbreviations}\n'
    '\\section{Useless}\n',
]

footer = [
'\\DeclareRobustCommand{\\van}[3]{#3}\n',
'\\bibliographystyle{agufull08_mod}\n',
'% \\bibliographystyle{unsrtnat}\n'
'\\texttt{\\bibliography{references}}\n',
'\\end{document}'
]

with open('print_references.tex','w') as pr: 
    pr.writelines(header)
    pr.writelines('\citet{'+ entry + '}\n' for entry in d)
    pr.writelines(footer)

