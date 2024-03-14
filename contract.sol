// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.24;
// importing String.sol from openzeppelin library
import "@openzeppelin/contracts/utils/Strings.sol";

contract Votaciones 
{
    struct Votador
    {
        address ID;
        uint Voto;
    }

    struct Candidato
    {
        uint ID;
        string Nombre;
        uint Votos;
    }
    Votador[5] public Votadores;
    Candidato[5] public Candidatos;
    constructor() 
    {
        for(uint i=0;i<Votadores.length;i++)
        {
            Votadores[i].ID=address(0);
            Votadores[i].Voto=0;
        }
        for(uint i=0;i<Candidatos.length;i++)
        {
            Candidatos[i].ID=0;
            Candidatos[i].Nombre="";
            Candidatos[i].Votos=0;
        }
    }

    function Reset() public 
    {
        for(uint i=0;i<Votadores.length;i++)
        {
            Votadores[i].ID=address(0);
            Votadores[i].Voto=0;
        }
        for(uint i=0;i<Candidatos.length;i++)
        {
            Candidatos[i].ID=0;
            Candidatos[i].Nombre="";
            Candidatos[i].Votos=0;
        }
    }

    function AddVoto(uint CandidatoVotado) public
    {
        for(uint i=0; i<Votadores.length;i++)
        {
            if(Votadores[i].ID == msg.sender)
            {
                return;
            }
            else if(Votadores[i].ID==address(0))
            {
                Votadores[i].ID=msg.sender;
                Votadores[i].Voto=CandidatoVotado;
            for(uint j=0; i<Candidatos.length;i++)
            {
                if(Candidatos[j].ID==CandidatoVotado)
                {
                Candidatos[j].Votos++;
                return;
                }
            }
                return;
            }

        }
    }

    function AddCandidato(uint ID, string memory Nombre) public
    {
        for(uint i=0; i<Candidatos.length;i++)
        {
            if(Candidatos[i].ID==0)
            {
                Candidatos[i].ID=ID;
                Candidatos[i].Nombre=Nombre;
                Candidatos[i].Votos=0;
                return;
            }
        }
    }
    function Ganador() public view
    returns (string memory CandidatoGanador)
    {
       Candidato memory CandGanador;
       CandGanador.ID=0;
       CandGanador.Nombre="";
       CandGanador.Votos=0;
       for(uint i=0;i<Candidatos.length;i++)
       {
        if(Candidatos[i].Votos>CandGanador.Votos)
        {
            CandGanador=Candidatos[i];
        }
       }
    CandidatoGanador=CandGanador.Nombre;
    }
    function GetCandidatos() public view 
    returns (string memory ListaCandidatos)
    {
        for(uint i=0;i<Candidatos.length;i++)
        {
            ListaCandidatos=string.concat(ListaCandidatos," [ID:",Strings.toString(Candidatos[i].ID),", Nombre:",Candidatos[i].Nombre,", Votos:",Strings.toString(Candidatos[i].Votos),"] ");
        }
    }
    function GetVotadores() public view 
    returns (string memory ListaVotadores)
    {
        for(uint i=0;i<Votadores.length;i++)
        {
            ListaVotadores=string.concat(ListaVotadores," [ID:",Strings.toHexString(uint160(Votadores[i].ID), 20),", Voto por:",Strings.toString(Votadores[i].Voto));
        }
    }


}