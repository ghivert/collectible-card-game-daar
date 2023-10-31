import { Router } from 'express';

export const collection = Router();

collection.get('/:id', (req, res) => {
    let collectionId = req.params.id
    return res.json({ data: [], message: "Success"});
});
