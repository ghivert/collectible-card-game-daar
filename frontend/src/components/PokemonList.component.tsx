import { useEffect, useMemo, useRef, useState } from 'react'
 

const PokemonCard = (props:any) => {
    return (
        <div>
            <img src={props.data.imageUrl} alt={props.data.name} />
            <div>{props.data.name}</div>
        </div>
    )    
}


const  PokemonList = (props:any) => {
    const [cartes, setCartes] = useState([]);
    useEffect(() => {
        let listeDeCartes =(props.cartes);
        if (listeDeCartes != null) {
            setCartes(Object.values(listeDeCartes));
        }  
    })
    return (
        <div className="pokeonliste">   
             <ul>
                {cartes.map((data, index) => (
                    <li key={index}>
                        <PokemonCard data={data}/>
                    </li>
                ))}
            </ul>  
        </div>
    )
}

export default PokemonList;