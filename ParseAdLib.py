#!/usr/bin/env python
# coding: utf-8

# In[ ]:


from html.parser import HTMLParser

class MyAdlibHTMLParser(HTMLParser):
    def update(self):
        self.foundContent = False
        self.getLabel = False
        self.getValue = False
        self.getListFirst  = False
        self.getList = False
        self.currentLabel = ''
        self.currentValue = ''
        self.d = {}

    def handle_starttag(self, tag, attrs):
        dir(self)
        if tag == 'ul': 
            self.foundContent = True
        if self.foundContent: 
            if tag == 'div':
                #print("Encountered a start tag:", tag, attrs)
                if attrs[-1][-1] == 'label': 
                    self.getLabel = True
                    self.getValue = False
                    self.getListFirst  = False
                    self.getList  = False
                if attrs[-1][-1] == 'value': 
                    self.getLabel = False
                    self.getValue = True
                    self.getListFirst  = False
                    self.getList  = False
                if attrs[-1][-1] == 'separateline-first':                     
                    self.getLabel = False
                    self.getValue = False
                    self.getListFirst = True
                    self.getList  = False
                if attrs[-1][-1] == 'separateline':                     
                    self.getLabel = False
                    self.getValue = False
                    self.getListFirst = False
                    self.getList  = True
            if tag == 'a':  
                if attrs[0][1] == 'ais-pdf': 
                    self.d['hyperref'] = attrs[1][1]
    def handle_endtag(self, tag):
        if self.foundContent: 
            #print("Encountered an end tag :", tag)
            if tag == 'ul': 
                self.foundContent = False

    def handle_data(self, data):
        if self.foundContent: 
            #print("Encountered some data  :", data)
            if self.getLabel: 
                self.currentLabel = data
                self.getLabel = False
            if self.getValue: 
                self.currentValue = data
                self.getValue = False
                self.d[self.currentLabel] = self.currentValue
            if self.getListFirst: 
                self.currentValue = data
                self.getListFirst = False
                self.d[self.currentLabel] = [self.currentValue]
            if self.getList: 
                self.currentValue = data
                self.getValue = False
                self.d[self.currentLabel].append(self.currentValue)

def parse_adlib_catalog_entry(html_file):
    parser = MyAdlibHTMLParser()
    parser.update()
    
    with open(html_file,'r', encoding="utf8") as f: 
        text = f.read()
        parser.feed(text)
    entry = parser.d
    authors = [author[::-1].strip()[::-1].split(' ') for author in entry['Author']]
    authorslistbib = []

    for author in authors: 
        if len(author) > 2: 
            inbetween = ' '.join(author[1:-1])
            authorbib = f"{'{'}\\van{'{'+author[-1]+'}{'+inbetween.capitalize()+'}{'+inbetween+'}'}{'}'} {author[-1]}, {author[0]}"
        else:
            authorbib = f"{author[1]}, {author[0]}"
        authorslistbib.append(authorbib)

    entry['Author'] = '{' + ' and '.join(authorslistbib) + '}'

    entry['Citekey'] = ''.join(authors[0][1:]) +entry['Year of publication'][2:4]        
    return entry

def save_file(entry):
    import shutil, os, subprocess
    os.getcwd()
    if not os.path.exists('adlib'):
        os.mkdir('adlib')
    path, filename = os.path.split(entry['hyperref'])
    _, ext = os.path.splitext(filename)
    dfilename = os.path.split(entry['hyperref'])[-1]
    if not os.path.exists(dfilename):
        subprocess.run(r"curl -O " + entry['hyperref'])
    fullfilename = os.path.join('adlib',entry['Citekey']+ext)
    if not os.path.exists(fullfilename):
        shutil.copyfile(dfilename, fullfilename)
        print(f"Digital document saved to: {fullfilename}")
    else:
        if os.path.getsize(dfilename) == os.path.getsize(fullfilename): 
            print(f"Digital document {fullfilename} already exists")
            return 1
        return 0
    return 1
        
def bibtex(entry):
    bibtex_entry = ( 
    f"@techreport{'{'+entry['Citekey']}, \n"
    f"  author      = {entry['Author']},\n"
    f"  title       = {'{{'+entry['Title']+'}}'},\n"
    f"  institution = {'{'+entry['Publisher']}, {entry['Place of publication']+'}'},\n"
    f"  year        = {'{'+entry['Year of publication'][0:4]+'}'},\n"
    f"  type        = {'{'+entry['Material']+'}'},\n"
    )
    if 'Pagination' in entry.keys(): 
        bibtex_entry += f"  pages      = {'{'+entry['Pagination']+'}'},\n" 
    bibtex_entry += (
    f"  address     = {'{'+'}'},\n"
    f"  month       = {'{'+entry['Year of publication'][4:]+'}'},\n"
    f"  note        = {'{'+'}'},\n"
    f"  annote      = {'{'+'}'},\n"
      )

    for key in list(set(entry.keys()) - set(['Citekey','Title','Author','Publisher','Place of publication','Year of publication','Material','Pagination'])):
        print(key)
        bibtex_entry += f"  {key.replace(' ','').lower():<10} = {'{'+str(entry[key])+'}'},\n"


    bibtex_entry += "}\n"
    
    return bibtex_entry

def generate_bib(filename): 
    import os
    entry = parse_adlib_catalog_entry(filename)
    print(entry)
    base, ext = os.path.splitext(filename)
    save_file(entry)
    bibentry = bibtex(entry)
    print(bibentry)
    bibfile = os.path.join('adlib',entry['Citekey']+'.bib')
    if not os.path.exists(bibfile): 
        with open(bibfile, 'w') as f:
            f.writelines(bibentry)
            print(f"Bibliography document saved to: {bibfile}")
    else: 
        print(f"Bibliography document {bibfile} already exists")                


# In[ ]:


import glob
for file in glob.glob('fullCatalogue*.html'):
    generate_bib(file)


# In[ ]:




