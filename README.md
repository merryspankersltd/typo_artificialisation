# Une typologie simple de l'artificialisation

L'objet de cette typologie est de produire une carte qui classe les communes de l'emprise du MOS selon deux axes:
- l'intensité de l'artificialisation
- la dominante habitat/activités de cette artificialisation

# Méthode de classification

A l'inverse d'une ACP, les axes de classification sont ici choisis par hypothèse (intensité de l'artificialisation, rapport habitat/activités) et l'exercice revient à effectuer des traitements de normalisatrion sur les distributions des deux variables, puis de choisir des seuils de classification.

## normalisation des variables

On met en oeuvre la librairie bestNormalize qui choisit automatiquement la meilleure méthode de normalisation pour une distribution donnée. Dans tous les cas bestNormalize choisira une méthode orderNorm (https://www.rdocumentation.org/packages/bestNormalize/versions/1.8.2/topics/orderNorm) qui fonctionne selon un principe simple de classement par rang.

### La variable intensité de l'artificialisation et sa normalisation

L'intensité de l'artificialisation est définie comme l'évolution en valeur absolue (ha) de la tache urbaine (composantes urbaines, activité et espaces en mutation) entre 2010 et 2020, rapportée à la surface totale de la commune. On peut donc aussi la définir comme la consommation d'espaces agricoles et naturels rapportée à la surface communale dans l'intervalle de 10 ans.

![image](https://user-images.githubusercontent.com/11749671/170271290-5f070c2c-da0d-4851-af38-d4551e591bdd.png)

La distribution contient des valeurs négatives, sa forme générale est celle d'une loi de puissance avec une longue queue dans les grandes valeurs. BestNormalize permet d'obtenir une distribution normale autour de zéro.

### La variable rapport habitat/activités et sa normalisation

Pour estimer un rapport habitat/activités, on commence par normaliser les variables "taux d'évolution de l'habitat" (tx_U) et "taux d'évolution des activités" (tx_A).

![image](https://user-images.githubusercontent.com/11749671/170272928-c4723d31-ad0e-496a-a6fd-01d2e9d985ba.png)

Tx_U contient des valeurs négatives et forme une longue queue. Sa normalisation (orderNorm) conduit à une distribuiton proche de la normale

![image](https://user-images.githubusercontent.com/11749671/170273288-2e83c3c3-d503-4c90-8807-146bbb6459e5.png)

Tx_A ne permet pas d'obtenir une distribution complètement normale, on remarque un gap dans les valeurs précédant la médiane.

Pour obtenir un rapport U/A cohérent, il faut déplacer les deux distribution normalisées dans le domaine positif (ajout de la valeur absolue du minimum). Après normalisation (orderNorm), on obtient une distribution normale.

![image](https://user-images.githubusercontent.com/11749671/170274714-b27efa87-0c11-4380-8363-004a955c93a9.png)

Le placement des communes sur les deux axes (x = rapport habitat / activités, y = intensité de l'artificialisation) permet d'obtenir un nuage de points étalé dans les deux dimensions.

![image](https://user-images.githubusercontent.com/11749671/170277302-d57a2354-a778-4290-95ee-923a464dbe72.png)

# Typologie

La méthode de classification aboutit naturellement à une partition de l'ensemble en 4 groupes selon les axes x et y:
- x < 0 et y < 0: artificialisation faible, dominante activités
- x > 0 et y < 0: artificialisation faible, dominante habitat
- x < 0 et y > 0: artificialisation forte, dominante activités
- x > 0 et y > 0: artificialisatopn forte, dominante habitat

![typo_finale](https://user-images.githubusercontent.com/11749671/170288599-ace1acf5-e39a-49d0-9e34-476de3523b14.png)
