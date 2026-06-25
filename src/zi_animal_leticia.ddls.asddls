@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'CDS de interface de animais'

define root view entity ZI_ANIMAL_LETICIA as select from ztanimal_leticia
{
    @EndUserText.label: 'ID' 
    key id as Id, 
    @EndUserText.label: 'Nome' 
    nome as Nome, 
    @EndUserText.label: 'Idade' 
    idade as Idade, 
    @EndUserText.label: 'Espécie' 
    especie as Especie, 
    @EndUserText.label: 'Sexo' 
    sexo as Sexo 
}
