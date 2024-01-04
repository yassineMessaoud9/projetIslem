import mongoose from 'mongoose';
const { Schema, model } = mongoose;

const bookSchema = new Schema(
    {
        title:{
            type: String,
            required: true
        },
        description:{
            type:String,
            required:true
        }, 
        link:{
            type:String
        },
        createdAt:{
            //type date
            type:String,
        },
        clicked:{
            type:Number,
            default:0
        }

    }

)

export default model('book', bookSchema);