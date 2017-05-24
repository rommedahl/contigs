# contigs -- Marcus Rommedahl

**2017-05-18**
-Started up GitHub repository
-Invited group-members and Lars
-Set up a basic folder structure

64056772 rows/overlaps  
7969739 unika C1 IDs  
9563025 unika C2 IDs  
11393435 C IDs  
41652839 Subset kanter  
29682269 Felmatchande längder

**Illustration av overlap data**
```
id1 :  [~~{S1~~~E1}    |L1|%.f
id2 :     {S2~~~E2}~~] |L2|/Rx
```
I den första raden är id1 identiteten för den första sekvensen. S1 är den första positionen och E2 den sista positionen i den första sekvensen som är gemensam med den andra sekvensen. Positioner räknas från 0. L1 är längden för den första sekvensen.
%.f anger antalet andelen positioner i snittet som överensstämmer mellan sekvenserna.
I den andra raden så är S2, E2 och L2 motsvarande mot den första raden. Rx har värdet R0 om den andra sekvensen har matchats så som den är läst. Om den har lätst baklänges har den värdet R1.

**Tankar kring egenskaper hos data**

I en graf kan ett snitt betraktas som en kant mellan två sekvenser som då utgör hörn, där kanten innebär att de har en relation.

De relativa start och slutpositionerna är intressanta. Dessa kan ses som ett argument till kanten.
Om t.ex. den ena sekvensen har sin början och slut inom den andra sekvensen så är den en delmängd.

```
id1 :  [~~{4~~~~10}~~] |10|%.f
id2 :     {0~~~~~6}    | 6|/Rx
```
I exemplet

Andelen matchande positioner i snittet skulle kunna ses som ett avstånd, eller för att välja snitt när två stycken är i konflikt.
