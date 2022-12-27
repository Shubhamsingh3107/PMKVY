use pmkvy

select * from pmkvy_table;
select * from gender_wise_salary;
select * from gender_wise_enrolled_placed;


select scheme,count(scheme) from pmkvy_table group by scheme;


select scheme,count(Component) from pmkvy_table group by Component;


select TrainingType,count(TrainingType) from pmkvy_table group by TrainingType;


select TCState,avg(Enrolled),avg(Trained),avg(Assessed),avg(Certified),avg(ReportedPlaced) from pmkvy_table 
group by TCState order by ReportedPlaced desc;



select TCState,count(distinct(TCDistrict)) as district_count from pmkvy_table group by TCState order by district_count desc



select distinct(TCDistrict),TCState,(sum(Trained)/sum(Enrolled)*100) as Trained_Enrolled_perc_dist  from pmkvy_table group by TCDistrict order by Trained_Enrolled_perc_dist desc



select TCState,(sum(Trained)/sum(Enrolled)*100) as Trained_Enrolled_perc_state  from pmkvy_table group by TCState order by Trained_Enrolled_perc_state desc



select distinct(TCDistrict),TCState,(sum(Assessed)/sum(Enrolled)*100) as Assessed_Enrolled_perc_dist  from pmkvy_table group by TCDistrict order by Assessed_Enrolled_perc_dist desc



select TCState,(sum(Assessed)/sum(Enrolled)*100) as Assessed_Enrolled_perc_state from pmkvy_table group by TCState order by Assessed_Enrolled_perc_state desc



select distinct(TCDistrict),TCState,COALESCE(sum(Certified)/sum(Trained)*100, 0) as Certified_Trained_perc_dist from pmkvy_table group by TCDistrict order by Certified_Trained_perc_dist desc




select TCState,COALESCE(sum(Certified)/sum(Trained)*100, 0) as Certified_Trained_perc_state from pmkvy_table group by TCState order by Certified_Trained_perc_state desc




select distinct(TCDistrict),TCState,COALESCE(sum(ReportedPlaced)/sum(Certified)*100, 0) as ReportedPlaced_Certified_perc_dist from pmkvy_table group by TCDistrict order by ReportedPlaced_Certified_perc_dist desc




select TCState,COALESCE(sum(ReportedPlaced)/sum(Certified)*100, 0) as ReportedPlaced_Certified_perc_state from pmkvy_table group by TCState order by ReportedPlaced_Certified_perc_state desc




select distinct(TCDistrict),TCState,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_dist from pmkvy_table group by TCDistrict order by Trained_ReportedPlaced_perc_dist desc




select TCState,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by TCState order by Trained_ReportedPlaced_perc_state desc




select TrainingType,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by TrainingType




select TCState,TrainingType,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by TCState,TrainingType




select Component,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by Component




select TCState,Component,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by TCState,Component




select Scheme,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by Scheme;




select TCState,Scheme,COALESCE(sum(ReportedPlaced)/sum(Trained)*100, 0) as Trained_ReportedPlaced_perc_state from pmkvy_table group by TCState,Scheme;





select TCState,(EnrolledFemale/TotalEnrolled)*100 as female_enrol_perc,(EnrolledMale/TotalEnrolled)*100 as male_enrol_perc, (EnrolledTransgender/TotalEnrolled)*100 as trans_enrol_perc from gender_wise_enrolled_placed;





select TCState,(ReportedPlaced_Female/TotalEnrolled)*100 as female_placed_perc,(ReportedPlaced_Male/TotalEnrolled)*100 as male_placed_perc,(ReportedPlaced_Transgender/TotalEnrolled)*100 as trans_placed_perc from gender_wise_enrolled_placed;




select TCState,Female_Salary,Male_Salary,Transgender_Salary from gender_wise_salary




select TCState,avg(Female_Salary) as avg_female_salary,avg(Male_Salary) as avg_male_salary,avg(Transgender_Salary) as avg_transgender_salary from gender_wise_salary




select a.TCState,sum(a.Enrolled) as total_enrolled,c.EnrolledFemale,c.EnrolledMale,c.EnrolledTransgender,
case
when  sum(a.Enrolled)= c.EnrolledFemale + c.EnrolledMale + c.EnrolledTransgender then 'Data Matched'
else 'ERROR'
end as Data_match_confirmation
from pmkvy_table as a join gender_wise_enrolled_placed as c on a.TCState = c.TCState group by a.TCState
