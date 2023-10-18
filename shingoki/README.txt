INSTRUCCIONES:

python3 encode.py < shingoki1.txt > shingoki1.lp
clingo shingokiKB.lp shingoki1.lp | python3 decode.py > solution1.txt

Si se quiere visualizar con clingraph descomentar el #show number/2 de shingokiKB.lp y ejecutar el siguiente comando:
clingo shingokiKB.lp $1 --outf=2 | clingraph --viz-encoding=viz.lp --out=render --view --prefix=viz\_ --engine=neato --type=graph
