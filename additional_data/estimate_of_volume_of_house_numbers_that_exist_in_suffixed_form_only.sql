WITH
	unique_house_numbers AS (
		SELECT DISTINCT
			(CASE WHEN paon ~ '^\d+[A-Z]*$' THEN paon ELSE saon END) AS house_number_with_suffix,
			substring((CASE WHEN paon ~ '^\d+[A-Z]*$' THEN paon ELSE saon END) FROM '^(\d+)[A-Z]*$') AS house_number_without_suffix,
			(CASE
				WHEN substring((CASE WHEN paon ~ '^\d+[A-Z]*$' THEN paon ELSE saon END) FROM '^\d+([A-Z]*)$') = ''
				THEN NULL
				ELSE substring((CASE WHEN paon ~ '^\d+[A-Z]*$' THEN paon ELSE saon END) FROM '^\d+([A-Z]*)$')
			 END) AS suffix,
			street
		FROM lr_price_paid
		WHERE (paon ~ '^\d+[A-Z]*$') OR (saon ~ '^\d+[A-Z]*$')
	),
	house_numbers_with_or_without_suffixes AS (
		SELECT
			street,
			house_number_without_suffix,
			SUM(CASE WHEN suffix IS NULL THEN 1 ELSE 0 END) > 0 AS exists_without_suffix,
			SUM(CASE WHEN suffix IS NULL THEN 0 ELSE 1 END) > 0 AS exists_with_suffix
		FROM unique_house_numbers
		GROUP BY street, house_number_without_suffix
	)
SELECT
	SUM(CASE WHEN exists_without_suffix AND NOT exists_with_suffix THEN 1 ELSE 0 END) AS no_that_exist_in_nonsuffixed_form_only,
	SUM(CASE WHEN NOT exists_without_suffix AND exists_with_suffix THEN 1 ELSE 0 END) AS no_that_exist_in_suffixed_form_only,
	SUM(CASE WHEN exists_without_suffix AND exists_with_suffix THEN 1 ELSE 0 END) AS no_that_exist_in_both_forms
FROM house_numbers_with_or_without_suffixes;
