import mongoose, { Schema, Document } from 'mongoose';
import UserModel from './user';
interface Post extends Document {
    title: string;
    content:string;
    image:string;
    createdAt:Date;
    user:typeof UserModel;
}

const postSchema = new Schema({
    title:{ type : String , required: true },
    content: {type : String ,required:true},
    image:{
        type:String,
        default:""
    },
    user: { type: Schema.Types.ObjectId, ref: 'User', required: true },
    createdAt: { type: Date, default: Date.now },

})

const PostModel = mongoose.model<Post>('Post', postSchema);

export default PostModel;
