@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS de Projeção de animais'
@Metadata.allowExtensions: true 
define root view entity ZC_ANIMAL_LETICIA as projection on ZI_ANIMAL_LETICIA as Animal
{
    key Id, 
    Nome, 
    Idade, 
    Especie, 
    Sexo
}
