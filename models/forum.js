import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const forumSchema = new Schema(
    {
        title:{
            type: String,
            required: true
        },
        description:{
            type:String,
            required:true
        }, 
        image:{
            type:String
        },
        //make relation with user
        userID: {
            type: mongoose.Types.ObjectId,
            ref:'User'
            
        }



    }

)

export default model('forum', forumSchema);