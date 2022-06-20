import Foundation
class SingleTon{
  //class for read input and wrap it
  private init(){}
  var studentsRecords=[Student]()
  var teachersRecords=[Teacher]()
  static let objReader=SingleTon()
  func getIntInput()->Int{
    guard let input=readLine(),let itIsNum=Int(input)else{
      print("WARNING : Enter only number")
  return self.getIntInput()
  }
  return itIsNum
  }
  func getStringInput()->String{
    guard let input=readLine(),let strInput=(input.contains(where:{$0.isNumber})) ? nil : input,let noBlank=(strInput.trimmingCharacters(in: .whitespacesAndNewlines).count==0 ?nil:strInput.trimmingCharacters(in: .whitespacesAndNewlines)) else{
  print("WARNING : Enter a valid string")
  return self.getStringInput()
}
    return noBlank
  }
  func getAlphaNumeric()->String{
    guard let input=readLine(),let noBlank=(input.trimmingCharacters(in: .whitespacesAndNewlines).count==0 ?nil:input.trimmingCharacters(in: .whitespacesAndNewlines))else{
      print("Warning : Enter the string")
      return self.getAlphaNumeric()
    }
    return noBlank
  }
  func getPercentage()->Float{
    guard let input=readLine(),let itIsNum=Float(input),let itIsPer=(itIsNum<=100&&itIsNum>=0) ? itIsNum:nil else{
      print("WARNING : Enter only float from 0-100")
      return self.getPercentage()
    }
    return itIsPer
  }
  func getBool()->Bool{
    guard let input=readLine(),let noBlank=(input.trimmingCharacters(in: .whitespacesAndNewlines).count==0 ?nil:input.trimmingCharacters(in: .whitespacesAndNewlines)),let bool=Bool(noBlank.lowercased())else{
      print("WARNING : Enter true or false")
      return self.getBool()
    }
    return bool
  }
  func getAmount()->Int{
    guard let input=readLine(),let toInt=Int(input),let minAmt=(toInt>=5000 ? toInt :nil)else{
      print("WARNING : the minimun amount is 5000")
      return self.getAmount()
    }
    return minAmt
  }
}

//Student
class Student{//class for add or remove students
  var name:String
  let singleTon=SingleTon.objReader
  var registrationNumber:String
  var isFiratGraduate:Bool
  private var percentage10:Float
  private var percentage12:Float
  var fees:Int
  init(){
    print("Enter the Name  of the student")
    self.name=singleTon.getStringInput()
    print("Enter the Register number of the student")
    self.registrationNumber=singleTon.getAlphaNumeric()
    print("Student First graduate ?(true/false)")
    self.isFiratGraduate=singleTon.getBool()
    print("Enter the sslc percentage of the student")
    self.percentage10=singleTon.getPercentage()
    print("Enter the hsc percentage of the student")
    self.percentage12=singleTon.getPercentage()
    print("Enter the fee of the student ")
    self.fees=singleTon.getAmount()
  }
  func getmark10()->Float{
    return self.percentage10
  }
  func getmark12()->Float{
    return self.percentage12
  }
}
  
//Teacher
class Teacher{//class for add or remove 
  private var name:String
  let singleTon=SingleTon.objReader
  var idNumber:String
  var salary:Int
  var experience:Int
  init(){
    print("Enter Name of the Teacher")
    self.name=singleTon.getStringInput()
    print("Enter the Id number of the student")
    self.idNumber=singleTon.getAlphaNumeric()
    print("Enter the Salary of the teacher")
    self.salary=singleTon.getAmount()
    print("Enter the experience of teacher in years")
    self.experience=singleTon.getIntInput()
    
  }
  func teacherMain(){
    print("Enter your choice : \n\n1 . MANAGE TEACHERS 2 . MANAGE SALARY \n")
  }
  
}

//Admin
class Admin{
  let singleTon=SingleTon.objReader

  func updateSalary(){
    print("\nEnter the Id of the teacher to update salary\n")
    let id=singleTon.getAlphaNumeric()
    if let row = singleTon.teachersRecords.firstIndex(where: {$0.idNumber == id}),let exp=((singleTon.teachersRecords[row].experience)==0 ?nil:singleTon.teachersRecords[row].experience) {
       singleTon.teachersRecords[row].salary = singleTon.teachersRecords[row].salary+exp*1000
      print("\nSalary updated sucessfully\n")
}
    else{
      print("\nWARNING:No such id found\n")
    }
  }
  func manageTeachers(choice:Int){
    switch(choice){
      case 1:
      let addTeacher=Teacher()
      singleTon.teachersRecords.append(addTeacher)
      print("\nTEACHER ADDED SUCESSFULLY\n")
      case 2:
      self.removeTeachers()
      default:
      print("WARNING : Enter \"1\" or \"2\" to continue\n")
      self.switchChoice(choice:1)
    }
  }
  func removeTeachers(){
    print("Enter the ID number of the teacher to remove")
      let removeId=singleTon.getAlphaNumeric()
      if let index=singleTon.teachersRecords.firstIndex(where:{$0.idNumber == removeId}){
  singleTon.teachersRecords.remove(at:index)
  print("\nTEACHER REMOVED SUCESSFULLY\n")
}else{
    print("\nWARNING:no such teacher found\n")
}
  }
  func adminMain(){
    print("Enter your choice : \n\n1 . MANAGE TEACHERS 2 . MANAGE SALARY \n")
    let choiceType=singleTon.getIntInput()
    self.switchChoice(choice:choiceType)
  }
  func switchChoice(choice:Int){
    switch(choice){
      case 1:
      print("1 . ADD TEACHER 2 . REMOVE TEACHER\n")
      let type=singleTon.getIntInput()
      self.manageTeachers(choice:type)
      case 2:
      self.updateSalary()
      default:
      print("WARNING : Enter \"1\" or \"2\" to continue\n")
      self.adminMain()
    }
  }
}

//MAIN
class Main{
  var singleTon=SingleTon.objReader
  func switchUser(choice:Int){
    switch(choice){
      case 1:
      print("\t\t\tUSERMODE: ADMIN\t\t\t\n")
       let adminMode=Admin()
       adminMode.adminMain()
      case 2:
      switchModeTeacher()
      case 3:
      studentMode()
      case 4:
      visitorView()
      default:
      print("WARNING:\"Enter 1 to 4 numbers to login\"\n")
      self.main()
    }
  }
  func visitorView(){
    print("\nTotal no of students in the college-\t\(singleTon.studentsRecords.count)\n")
      print("\nTotal no of teachers in the college-\t\(singleTon.teachersRecords.count)\n")
      print("\nTotal no of FirstGraduate students in college-\t\(singleTon.studentsRecords.filter({$0.isFiratGraduate}).count)\n")
      print("\nTotal no of experienced teachers-\t\(singleTon.teachersRecords.filter({$0.experience>0}).count)\n")
      print("\nTotal Earnings of college-\t\(singleTon.studentsRecords.map{$0.fees}.reduce(0,+))\n")
      print("\nTotal Expenditure of college-\t\(singleTon.teachersRecords.map{$0.salary}.reduce(0,+))\n")
      let turnOver=(singleTon.studentsRecords.map{$0.fees}.reduce(0,+))-(singleTon.teachersRecords.map{$0.salary}.reduce(0,+))
      if(turnOver>0){
        print("\nMonthly profit -\t\(turnOver)\n")
      }
      else{
        print("\nMonthly loss -\t\(abs(turnOver))\n")
      }
  }
  func studentMode(){
    if(singleTon.studentsRecords.count<=0){
      print("No students to search")
    }else{
      print("Enter your registration number")
      let id=singleTon.getAlphaNumeric()
      if let searchId=singleTon.studentsRecords.firstIndex(where: {$0.registrationNumber == id}){
        let details=singleTon.studentsRecords[searchId]
  print("\nName:\(details.name)\n\nRegisterNumber:\(details.registrationNumber)\n\nFirstGraduate:\(details.isFiratGraduate ? "yes":"N0")\n\nSSLC:\(details.getmark10())%\n\nHSC:\(details.getmark12())%\n\nFees:\(details.fees)\n")
    }
    }
  }
  func removeStudent(){
    print("Enter the ID number of the student to remove")
      let removeId=singleTon.getAlphaNumeric()
      if let index=singleTon.studentsRecords.firstIndex(where:{$0.registrationNumber == removeId}){
  singleTon.studentsRecords.remove(at:index)
  print("\nSTUDENT REMOVED SUCESSFULLY\n")
}else{
    print("\nWARNING : no such student found\n")
}
  }
  func switchManage(){
    print("1 . ADD STUDENT 2 . REMOVE STUDENT\n")
    let choice=singleTon.getIntInput()
    switch(choice){
      case 1:
      let addStudent=Student()
      singleTon.studentsRecords.append(addStudent)
      print("\nSTUDENT ADDED SUCESSFULLY\n")
      case 2:
      self.removeStudent()
      default:
      print("WARNING : Enter \"1\" or \"2\" to continue\n")
      self.switchManage()
    }
  }
  func applyScholarShip(){
    print("Enter the student registration to apply scholarship")
    let searchId=singleTon.getAlphaNumeric()
    if let row=singleTon.studentsRecords.firstIndex(where:{$0.registrationNumber==searchId}),let check=(((singleTon.studentsRecords[row].isFiratGraduate)&&singleTon.studentsRecords[row].getmark10()>=80&&singleTon.studentsRecords[row].getmark12()>=80) ?singleTon.studentsRecords[row].fees/4:nil){
      singleTon.studentsRecords[row].fees=singleTon.studentsRecords[row].fees-check
      print("SCHOLARSHIP SUCESSFULLY APPLIED")
    }
    else{
      print("WARNING :The student has'nt met the requirement for scholarship")
    }
  }
  func switchModeTeacher(){
    print("Enter your choice : \n\n1 . MANAGE STUDENTS 2 . APPLY SCHOLARSHIP \n")
    let choice=singleTon.getIntInput()
    switch(choice){
        case 1:
        self.switchManage()
        case 2:
      applyScholarShip()
        default:
         print("WARNING : Enter \"1\" or \"2\" to continue\n")
      self.switchModeTeacher()
      }
  }
  func main(){
    print("\t|=====Enter your user type=====|  \n\n 1 . ADMIN  2 . TEACHER  3 . STUDENT  4 . VISITOR \n")
    let choice=singleTon.getIntInput()
    self.switchUser(choice:choice)
  }
}
while(true){
  let start=Main()
  start.main()
}
