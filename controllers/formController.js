import Forum from '../models/forum.js';

export function addForum(req, res) {
    
        // Invoquer la méthode create directement sur le modèle
        Forum
        .create({
            title: req.body.title,
            description: req.body.description,
            // Récupérer l'URL de l'image pour l'insérer dans la BD
            image: `${req.file.filename}`,
            userID: req.body.userID

        })
        .then(newGame => {
            res.status(200).json(newGame);
        })
        .catch(err => {
            res.status(500).json({ error: err });
        });
    
}


export async function getAll(_,res){

    try{
        const forums = await Forum.find();
        if(!forums || forums.length === 0){
            return res.status(404).json({message : "No forum found"});
        }
        res.status(200).json(forums);
    }catch(error){
        return res.status(500).json({message:"Internal Error"})
    }
}

