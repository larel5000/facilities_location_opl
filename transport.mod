/*********************************************
 * OPL 12.7.0.0 Model
 * Author: DMB
 * Creation Date: 7 sept. 2017 at 12:13:37
 *********************************************/
{string} clients = ...;
{string} entrepots = ...;
int cout_transport[clients][entrepots] = ...;
int cout_installation[entrepots] = ...;
int besoins[clients] = ...;
int qte_dispo = ...;

dvar boolean x[clients][entrepots];
dvar boolean y[entrepots];

minimize sum(j in entrepots)(cout_installation[j]*y[j]) +
		sum(i in clients, j in entrepots)(cout_transport[i][j]*x[i][j]);
		
subject to{
	forall(i in clients)
	  ct_unicite:
	  sum(j in entrepots)x[i][j] == 1;
	  
	forall(j in entrepots)
	  ct_capacite:
	  sum(i in clients)besoins[i]*x[i][j] <= qte_dispo;
	  
	forall(i in clients, j in entrepots)
	  ct_affectation:
	  x[i][j] <= y[j];
}

execute{}

