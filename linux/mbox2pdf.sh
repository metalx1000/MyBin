#!/bin/bash

dir="attachments"
pw="password"

echo "Reading Mailbox File..."
csplit --digits=2  --quiet -k --prefix=outfile Gmail.mbox "/--/+1" "{*}"

echo "Creating Attachment Folder..."
mkdir $dir

echo "Finding all pdf files..."
grep -l 'application/pdf; name="11OCCHIPI' out*|\
  while read file
  do 
    mv $file $dir
  done

echo "Removing Temp files..."
rm outfile*
cd $dir

echo "Converting Files..."
for i in outfile*
do 
  echo "$i"
  awk -v nr="$(wc -l < $i)" 'NR>8 && NR<(nr-1)' $i > $i.b64
  dos2unix $i.b64
  base64 -d $i.b64 > $i.pdf
  pdftops -upw $pw $i.pdf
  ps2pdf $i.ps
  pdftotext $i.pdf
  name=$(grep '/20' $i.txt|head -n 1|tr '/' '_')
  mv $i.pdf $name.pdf
  echo $name.pdf
  rm $i.ps
  rm $i.b64
  rm $i
done
