import Foundation

struct Company {
    let name: String
    let activity: String
    let description: String
    let vacancies: [Vacancy]
    let contacts: String
    
    struct Vacancy {
        let profession: String
        let level: String
        let salary: Int
    }
    
    func interviewMethod1(candidate: Candidate) -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    func interviewMethod2(candidate: Candidate) -> Bool {
        return arc4random_uniform(2) == 0
    }
    
    func interview(candidate: Candidate) -> Bool {
        let randomIndex = Int(arc4random_uniform(2))
        if randomIndex == 0 {
            return interviewMethod1(candidate: candidate)
        } else {
            return interviewMethod2(candidate: candidate)
        }
    }
}

class Candidate {
    let name: String
    let activity: String
    let profession: String
    let level: String
    let salary: Int
    let skills: [String]
    
    init(name: String, activity: String, profession: String, level: String, salary: Int, skills: [String]) {
        self.name = name
        self.activity = activity
        self.profession = profession
        self.level = level
        self.salary = salary
        self.skills = skills
    }
    
    func parseSalary() -> String {
        switch salary {
            case 0...99999:
                return "0 - 99999"
            case 100000..<150000:
                return "100000 - 149999"
            case 150000...Int.max:
                return "150000"
            default:
                return "Error/ Incorrect salary!"
        }
    }
    
    func parseSalaryToID() -> [Int] {
        switch salary {
            case 0...99999:
                return [0, 99999]
            case 100000...149999:
                return [100000, 149999]
            default:
                return [150000, 999999999]
        }
    }
}

let companies = [
    Company(name: "SuperPay", activity: "Banking", description: "A bank that makes payments super easy", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Senior", salary: 200000),
        Company.Vacancy(profession: "Analyst", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "Designer", level: "Middle", salary: 150000),
    ], contacts: "info@superpay.com"),
    Company(name: "MMM", activity: "IT", description: "A software company that does everything", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Middle", salary: 150000),
        Company.Vacancy(profession: "QA", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "Project Manager", level: "Senior", salary: 250000),
    ], contacts: "info@mmm.com"),
    Company(name: "CryptoSuperGo", activity: "IT", description: "CryptoSuperGo is a cutting-edge technology company that specializes in blockchain solutions for businesses.", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Senior", salary: 200000),
        Company.Vacancy(profession: "QA", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "Project Manager", level: "Senior", salary: 180000),
        Company.Vacancy(profession: "Analyst", level: "Junior", salary: 110000),
        Company.Vacancy(profession: "Designer", level: "Middle", salary: 140000)
    ], contacts: "info@mmm.com"),
    Company(name: "CryptoSuperGo", activity: "Public Services", description: "CryptoSuperGo is a cutting-edge technology company that specializes in blockchain solutions for businesses.", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Senior", salary: 200000),
        Company.Vacancy(profession: "QA", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "Analyst", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "Designer", level: "Middle", salary: 140000)
    ], contacts: "info@cryptosupergo.com"),
    Company(name: "InnovateTech", activity: "IT", description: "InnovateTech is a fast-growing technology company that specializes in software development.", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "QA", level: "Middle", salary: 120000),
        Company.Vacancy(profession: "Project Manager", level: "Senior", salary: 180000),
        Company.Vacancy(profession: "Analyst", level: "Junior", salary: 130000),
        Company.Vacancy(profession: "Designer", level: "Middle", salary: 130000)
    ], contacts: "info@innovatetech.com"),
    Company(name: "InnovateTech", activity: "IT", description: "InnovateTech is a fast-growing technology company that specializes in software development.", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Middle", salary: 110000),
        Company.Vacancy(profession: "QA", level: "Middle", salary: 120000),
        Company.Vacancy(profession: "Project Manager", level: "Senior", salary: 180000),
        Company.Vacancy(profession: "Analyst", level: "Junior", salary: 130000),
        Company.Vacancy(profession: "Developer", level: "Middle", salary: 10000)
    ], contacts: "info@innovatetech.com"),
    Company(name: "E-Commerce Solutions", activity: "Public Services", description: "E-Commerce Solutions is a company that specializes in providing e-commerce solutions to businesses.", vacancies: [
        Company.Vacancy(profession: "Developer", level: "Junior", salary: 100000),
        Company.Vacancy(profession: "QA", level: "Middle", salary: 120000),
        Company.Vacancy(profession: "Project Manager", level: "Senior", salary: 180000),
        Company.Vacancy(profession: "Analyst", level: "Middle", salary: 120000),
        Company.Vacancy(profession: "Designer", level: "Middle", salary: 130000)
    ], contacts: "info@ecommercesolutions.com")
]

let candidate = Candidate(name: "Ivan", activity: "IT", profession: "Developer", level: "Middle", salary: 50000, skills: ["python", "matlab"])

print("Candidate:")
print("- Name: \(candidate.name)")
print("- Activity: \(candidate.activity)")
print("- Profession: \(candidate.profession)")
print("- Level: \(candidate.level)")
print("- Salary: \(candidate.salary)")
print("- Skills: \(candidate.skills)\n")

print("\(candidate.activity). \(candidate.profession). \(candidate.level). > \(candidate.parseSalary())")
print("The list of suitable vacancies:\n")

var index = 1
for company in companies {
    if company.activity == candidate.activity {
        for vacancy in company.vacancies {
            if vacancy.profession == candidate.profession && vacancy.level == candidate.level && vacancy.salary >= candidate.parseSalaryToID()[0] && vacancy.salary <= candidate.parseSalaryToID()[1] {
                print("\(index).")
                print("\(vacancy.level) \(vacancy.profession)     ---      from \(vacancy.salary)")
                print("  \(company.name)")
                print("  \(company.activity)")
                print("---------------------------------------\n")
                index += 1
            }
        }
    }
}

if index > 1 {
    let company = companies.first { company in
        company.vacancies.contains { vacancy in
            vacancy.profession == candidate.profession &&
            vacancy.level == candidate.level &&
            vacancy.salary >= candidate.salary
        }
    }!
    let result = company.interview(candidate: candidate)
    print("\(index - 1)")
    print("Proccessing Interview...")
    if result {
        print("Success, candidate was applied.")
    } else {
        print("Sorry, candidate was not applied.")
    }
} else {
    print("Proccessing Interview...")
    print("Sorry, candidate was not applied.")
}
