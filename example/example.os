#Использовать ".."

Процедура ЗаписатьТаблицу(ТаблицаСтатистики, ИмяФайла)

	МассивСтрок = Новый Массив;
	МассивОписанияКолонок = Новый Массив;
	Для каждого Колонка Из ТаблицаСтатистики.Колонки Цикл
		МассивОписанияКолонок.Добавить(Колонка.Имя);	
	КонецЦикла;

	МассивСтрок.Добавить(СтрСоединить(МассивОписанияКолонок, ";"));

	Для Каждого Строка Из ТаблицаСтатистики Цикл

		ОписаниеСтроки = Новый Массив;
		Для каждого Колонка Из ТаблицаСтатистики.Колонки Цикл
			ОписаниеСтроки.Добавить(Строка[Колонка.Имя]);	
		КонецЦикла;
		МассивСтрок.Добавить(СтрСоединить(ОписаниеСтроки, ";"));

	КонецЦикла;

	ИтоговыйТекст = СтрСоединить(МассивСтрок, Символы.ПС);

	ЗаписьТекста = Новый ЗаписьТекста(ИмяФайла);
	ЗаписьТекста.Записать(ИтоговыйТекст);
	ЗаписьТекста.Закрыть();

КонецПроцедуры

Процедура СообщитьСтатусЗахватаКорня(ЧтениеХрана)

	ДанныеОЗахватеКорня = ЧтениеХрана.КореньЗахвачен();
	Если ДанныеОЗахватеКорня.Захвачен Тогда
		ТекстСообщения = СтрШаблон("Корень захвачен %1 часов назад пользователем %2", 
									Окр(ДанныеОЗахватеКорня.Длительность / 3600), 
									ДанныеОЗахватеКорня.Пользователь);
	Иначе
		ТекстСообщения = "Корень не захвачен";
	КонецЕсли;

	Сообщить(ТекстСообщения);

КонецПроцедуры

КаталогСДанными = ОбъединитьПути(ТекущийСценарий().Каталог, "..\tests",  "fixtures");
ПутьКХранилищу1 = ОбъединитьПути(КаталогСДанными, "storage1");
ПутьКХранилищу2 = ОбъединитьПути(КаталогСДанными, "storage2");
ПутьКВыгрузкеКонфигурации = ОбъединитьПути(КаталогСДанными, "src");

ЧтениеХрана = Новый ЧтениеХранилища(ПутьКХранилищу1);
ЧтениеХрана.ПрочитатьХранилище();
ЗаписатьТаблицу(ЧтениеХрана.ТаблицаЗахватов(), "Таблица захватов.csv");
СообщитьСтатусЗахватаКорня(ЧтениеХрана);

ЧтениеХрана = Новый ЧтениеХранилища(ПутьКХранилищу2, ПутьКВыгрузкеКонфигурации);
ЧтениеХрана.ПрочитатьХранилище();
ЗаписатьТаблицу(ЧтениеХрана.ТаблицаЗахватов(), "Таблица захватов с выгрузкой в файлы.csv");
СообщитьСтатусЗахватаКорня(ЧтениеХрана);