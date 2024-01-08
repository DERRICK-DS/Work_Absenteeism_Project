--Creating Left Join.

Select *
From dbo.Absenteeism_at_work abse
left join dbo.compensation comp
on abse.ID = comp.ID
left join Reasons rea
on abse.Reason_for_absence = rea.Number

--Finding the Healthiest individuals with Low absenteeism for the bonus.

Select *
From dbo.Absenteeism_at_work 
where  Social_drinker = 0 and Social_smoker = 0 and Body_mass_index between 18.9 and 24.9
and Absenteeism_time_in_hours < (Select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

--Compensation rate increase for non-smokers/budget $983221 /each $1433 per year / $ 0.65 per hour- them working 2080 hrs per Year.

Select count (*) as NonSmokersCount
From dbo.Absenteeism_at_work 
where Social_smoker = 0

--Optimize the Query for Power BI

Select abse.ID, rea.Reason, abse.Month_of_absence, abse.Body_mass_index,
case when Body_mass_index < 18.9 then 'Underweight'
     when Body_mass_index > 24.9 then 'Overweight'
     when Body_mass_index  between 18.9 and 24.9 then 'Healthy'
	 else 'uknown' end as BMI_category,
case when Month_of_absence in (12,1,2) then 'Winter'
     when Month_of_absence in (3,4,5) then 'Spring'
	 when Month_of_absence in (6,7,8) then 'Summer'
	 when Month_of_absence in (9,10,11) then 'Fall'
	 Else 'Unknown' END as Season_Names,
Day_of_the_week,
Seasons,
Transportation_expense,
Distance_from_Residence_to_Work,
Service_time,
age,
Work_load_Average_day,Hit_target,Disciplinary_failure,Education,son,Social_smoker,Social_drinker,Pet,Weight,Height,Absenteeism_time_in_hours
From dbo.Absenteeism_at_work abse
left join dbo.compensation comp
on abse.ID = comp.ID
left join Reasons rea
on abse.Reason_for_absence = rea.Number




