# search_locality
Search locality problem

This program searches for "context".  For this project, context is defined as
having two search terms occurring within N words of each other irrespective of
sentence, paragraph, or page boundary.  

This program iterates over all the plain text documents in a directory and
returns the set of documents where two search terms occur within N words of
each other.  

In addition to allowing two search terms, the user may specify phrases instead
of terms.  

## how to run

```
git clone https://github.com/lindyslewis/search_locality.git  
cd search_locality
ruby init.rb 3 'test_data' 'Cattleya and Logan' 'best kitties'
```
