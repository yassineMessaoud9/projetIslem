import book from '../models/book.js';

export async function  AddBook(req,res){
    try{
        const newBook = await book.create({...req.body});
        res.status(201).json(newBook);
    }catch(e){
        console.log("Error in Adding Book: ", e)
        res.status(400).send('Something went wrong!')
    }
}

//get all
export async function GetAllBooks(req,res){
   try{
    //findall
    let books=await book.find();
    if(!books||books.length==0){
        return res.status(404).json({msg:"No Books Found!"})
    }
    res.status(200).json(books);

   } catch(e){
    console.log("Error in Getting All Books :",e)
    res.status(500).json({error:e});
   }
}
//update clicked to 1
export async function ClickedBook(req,res){
    const id= req.params.id;
    try {
       // change clicked to 1
       let updated_at = await book.findByIdAndUpdate(id ,{$set:{clicked:1}},{new:true});
        res.status(200).json(updated_at);
    }
    catch (err) {
        console.log("Error in Marking the Book as Clicked : ", err);
        res.status(400).json({ error: "Error in updating" });
    }
}

// get number of book clicked and not clicked by the total of books in one response
export async function NumberofClickedNotClicked(req,res){
    let books=await book.find().sort([['createdAt', -1]]);
    var clickCount=[];
    for(let i=0 ;i<books.length ; i++){
        if(books[i].clicked===1)
        clickCount.push(1);
    else
    clickCount.push(0);
}
var sumOfClicked=clickCount.reduce((a, b)=> a + b, 0);
var sumOfNotClicked=books.length-sumOfClicked;
var totalBooks=books.length;
if(isNaN(sumOfClicked) || isNaN(sumOfNotClicked)){
    throw new Error ("Invalid Value");
    }
    else{
        return res.status(200).json({TotalBooks:totalBooks,Clicked:sumOfClicked, NotClicked:sumOfNotClicked});   
        }
        
}
// statistic by date
// Controller method to get book creation statistics
export async function getBookCreationStatistics(req, res) {
    try {
      const timeFrame = req.query.timeframe ; // Default to 'monthly' if no query param provided
      let groupByFormat = "%Y-%m"; // Default grouping by year and month
  
      if (timeFrame === 'yearly') {
        groupByFormat = "%Y"; // Change grouping to by year
      }
  
      // Now build up the aggregation pipeline
      const stats = await Book.aggregate([
        {
          $project: {
            year: { $year: "$createdAt" },
            month: { $month: "$createdAt" }, // Include month in the project stage if needed
          }
        },
        {
          $group: {
            _id: timeFrame === 'monthly' ? { year: "$year", month: "$month" } : { year: "$year" },
            count: { $sum: 1 }
          }
        },
        { $sort: { '_id.year': 1, '_id.month': 1 } } // Sort by year and then by month if monthly
      ]);
  
      // Send back the stats as JSON
      res.status(200).json(stats);
    } catch (error) {
      console.error('Error getting book creation statistics:', error);
      res.status(500).send(error.message);
    }
  }  

