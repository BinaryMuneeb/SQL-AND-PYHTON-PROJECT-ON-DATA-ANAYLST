select * from layoofs_staging2;


select MAX(total_laid_off),max(percentage_laid_off) 
from 
layoofs_staging2;

select  *
from layoofs_staging2
where percentage_laid_off =1
order by total_laid_off desc;

select  *
from layoofs_staging2
where percentage_laid_off =1
order by funds_raised_millions desc;

select  company ,sum(total_laid_off)
from layoofs_staging2
group by company
order by 2 desc;

SELECT MIN(`date`),MAX(`date`)
FROM 
layoofs_staging2;


select  INDUSTRY ,sum(total_laid_off)
from layoofs_staging2
group by  industry
order by 2 desc;

select  COUNTRY ,sum(total_laid_off)
from layoofs_staging2
group by COUNTRY
order by 2 desc;

select  year(`date`) ,sum(total_laid_off)
from layoofs_staging2
group by year(`date`)
order by 1 desc;

select STAGE ,sum(total_laid_off)
from layoofs_staging2
group by STAGE
order by 1 desc;

SELECT substring(`date`,1,7) AS 'MONTH',
SUM(TOTAL_LAID_OFF)
FROM layoofs_staging2
group by substring(`date`,1,7) 
order by 1 ASC;


WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoOfs_staging2
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, total_laid_off,SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoOfs
FROM DATE_CTE
ORDER BY dates ASC;

SELECT company,YEAR(`date`), sum(total_laid_off)
from layoofs_staging2
group by company, year(`date`)
order by 3 asc;


with Company_Year (company,years,total_laid_off) as(
SELECT company,YEAR(`date`), sum(total_laid_off)
from layoofs_staging2
group by company, year(`date`)
),
company_year_ranking as
(select *,dense_rank() over(partition by years order by total_laid_off desc
) as ranking
from Company_year)
select * from company_year_ranking
where ranking <=5;