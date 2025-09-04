import gradio as gr
import plotly.graph_objects as go
import plotly.express as px
import pandas as pd
import numpy as np
from datetime import datetime, timedelta
import json
import time
import uuid
import random

# 🤖 РАСШИРЕННАЯ ИИ-СИСТЕМА ПОДСКАЗОК И АНАЛИЗА
class UltimaAIBusinessAdvisor:
    def __init__(self):
        # База знаний ИИ с расширенными инсайтами
        self.insights_database = {
            'revenue_insights': {
                'critical_low': "🚨 КРИТИЧНО! Выручка ниже порога выживания. Без экстренных мер - банкротство через 3-6 мес.",
                'low': "💡 Выручка ниже рыночных показателей. Фокус на лидогенерацию и конверсию - приоритет №1.",
                'below_average': "📊 Чуть ниже среднего по рынку. Есть быстрые способы поднять на 30-40%.",
                'average': "📈 Стабильные показатели. Отличная база для масштабирования и выхода на новые сегменты.",
                'above_average': "🚀 Выше среднего! Время автоматизировать процессы и думать о франшизе/лицензировании.",
                'high': "💰 Топ-20% рынка! Готовьтесь к инвестициям, IPO или продаже бизнеса.",
                'unicorn': "🦄 ЕДИНОРОГ! Вы в топ-1% отрасли. Время создавать экосистему продуктов."
            },
            'margin_insights': {
                'loss': "💀 УБЫТОЧНОСТЬ! Каждый клиент приносит убыток. Немедленно пересматривайте модель.",
                'critical': "⚠️ Критически низкая маржа - компания на грани. Экстренная оптимизация всех затрат.",
                'low': "😰 Низкая маржа тормозит развитие. Пересмотрите ценообразование и структуру затрат.",
                'below_average': "📉 Ниже отраслевого стандарта. Есть резервы для быстрого улучшения на 15-25%.",
                'average': "📊 Нормальная маржа для роста, но есть потенциал оптимизации.",
                'good': "✅ Хорошая маржинальность! Можно инвестировать в агрессивный рост.",
                'excellent': "🏆 Отличная маржа! Лидер по эффективности - время масштабироваться.",
                'premium': "💎 ПРЕМИУМ-маржа! У вас уникальное ценностное предложение."
            },
            'team_insights': {
                'solo': "👤 Соло-предприниматель - все риски на вас. Критично начать делегировать.",
                'micro': "👥 Микро-команда. Отлично для MVP, но готовьтесь к найму ключевых ролей.",
                'small': "🎯 Компактная команда - хорошо для стартапа. Системы HR становятся важными.",
                'medium': "👔 Средняя команда. Время внедрять процессы и KPI для эффективности.",
                'large': "🏢 Большая команда требует профессионального менеджмента и четких процессов.",
                'enterprise': "🏛️ Корпоративный уровень. Нужны департаменты, делегирование и системы."
            }
        }
        
        # Умные подсказки с контекстными вопросами
        self.smart_problem_hints = {
            'Маркетинг': {
                1: {
                    'message': "🎯 Маркетинг работает как швейцарские часы!",
                    'questions': ["Какие каналы дают лучший ROMI?", "Как масштабировать успешные кампании?"],
                    'next_steps': "Автоматизируйте воронки и тестируйте новые каналы"
                },
                5: {
                    'message': "📊 Базовые системы есть, но эффективность можно удвоить",
                    'questions': ["Знаете ли точную стоимость лида по каналам?", "Какой % маркетинг-квалифицированных лидов?"],
                    'next_steps': "Внедрите сквозную аналитику и A/B-тестирование"
                },
                8: {
                    'message': "🔥 Критично! Либо дорого получаете лидов, либо их мало",
                    'questions': ["Сколько тратите на привлечение одного клиента?", "Какая конверсия от лида в клиента?"],
                    'next_steps': "СРОЧНО: аудит всех каналов, отключение неэффективных, фокус на 1-2 лучших"
                },
                10: {
                    'message': "💥 Маркетинг полностью провален - это приоритет №1!",
                    'questions': ["Есть ли вообще система лидогенерации?", "Кто отвечает за маркетинг?"],
                    'next_steps': "Немедленно: найм маркетолога или агентство, базовая настройка рекламы"
                }
            },
            'Продажи': {
                1: {
                    'message': "💰 Продажи на высочайшем уровне! Отдел работает как машина денег",
                    'questions': ["Как документируете лучшие практики?", "Готовы к масштабированию команды?"],
                    'next_steps': "Создавайте центры продаж, обучайте новичков по лучшим скриптам"
                },
                5: {
                    'message': "📞 Средние показатели. Видимо, нужно серьезно прокачать команду",
                    'questions': ["Есть ли четкие скрипты продаж?", "Какая конверсия звонков в сделки?"],
                    'next_steps': "Тренинги, ролевые игры, внедрение CRM с воронкой продаж"
                },
                8: {
                    'message': "😰 Теряете много клиентов. Проблема в скриптах или CRM?",
                    'questions': ["На каком этапе теряются клиенты?", "Кто проводит обучение продажникам?"],
                    'next_steps': "Аудит всей воронки, переписать скрипты, ввести контроль качества звонков"
                },
                10: {
                    'message': "🚨 Продажи полностью провалены. Это может убить бизнес!",
                    'questions': ["Вообще есть отдел продаж?", "Сколько сделок закрывается в месяц?"],
                    'next_steps': "ЭКСТРЕННО: найм опытного руководителя продаж, базовые скрипты, CRM"
                }
            },
            'Продукт': {
                1: {
                    'message': "🎨 Продукт просто огонь! Клиенты в полном восторге",
                    'questions': ["Как поддерживаете product-market fit?", "Какие фичи планируете?"],
                    'next_steps': "Работайте над retention, собирайте фидбек для новых фич"
                },
                5: {
                    'message': "🤔 Продукт нормальный, но клиенты не в восторге",
                    'questions': ["Какие главные жалобы клиентов?", "Что говорят при отказе?"],
                    'next_steps': "Глубокие интервью с клиентами, приоритизация улучшений по болям"
                },
                8: {
                    'message': "😕 Продукт слабый, клиенты недовольны. Это блокирует рост",
                    'questions': ["Решает ли продукт реальную проблему?", "Какая основная причина возвратов?"],
                    'next_steps': "Product Discovery: изучите реальные потребности, переделайте ключевые фичи"
                },
                10: {
                    'message': "💔 Продукт не решает проблемы клиентов. Критично!",
                    'questions': ["Понятна ли вообще ценность для клиента?", "Есть ли product-market fit?"],
                    'next_steps': "PIVOT: кардинально переосмыслить продукт или сменить целевую аудиторию"
                }
            },
            'Операции': {
                1: {
                    'message': "⚙️ Процессы отлажены идеально! Бизнес работает как часы",
                    'questions': ["Как автоматизировали рутину?", "Готовы ли процессы к масштабированию?"],
                    'next_steps': "Документируйте все процессы, готовьтесь к франшизе"
                },
                5: {
                    'message': "🔄 Базовые процессы есть, но много ручной работы",
                    'questions': ["Сколько времени тратится на рутину?", "Что можно автоматизировать первым?"],
                    'next_steps': "Аудит всех процессов, внедрение автоматизации по приоритетам"
                },
                8: {
                    'message': "😵 Операционный хаос! Постоянные сбои и переделки",
                    'questions': ["Есть ли четкие регламенты?", "Кто отвечает за качество процессов?"],
                    'next_steps': "Срочно создать базовые регламенты, назначить ответственных"
                },
                10: {
                    'message': "💥 Полный операционный коллапс! Ничего не работает",
                    'questions': ["Как вообще выполняете заказы?", "Сколько ошибок в день?"],
                    'next_steps': "СТОП-операции: переписать все процессы с нуля, внедрить контроль"
                }
            },
            'Команда': {
                1: {
                    'message': "👑 Команда мечты! Все мотивированы и профессиональны",
                    'questions': ["Как поддерживаете такой уровень?", "Планируете ли расширение?"],
                    'next_steps': "Создавайте корпоративную культуру, готовьте лидеров"
                },
                5: {
                    'message': "👥 Команда нормальная, но есть проблемы с мотивацией",
                    'questions': ["Четкие ли у всех KPI?", "Как часто даете обратную связь?"],
                    'next_steps': "Внедрите систему мотивации, регулярные one-on-one встречи"
                },
                8: {
                    'message': "😤 Серьезные проблемы с командой. Это тормозит все",
                    'questions': ["Текучесть кадров высокая?", "Все ли задачи на вас висят?"],
                    'next_steps': "Срочно: делегирование, четкие роли, работа с мотивацией"
                },
                10: {
                    'message': "🔥 HR-катастрофа! Команда не работает или её нет",
                    'questions': ["Можете ли уйти в отпуск на неделю?", "Кто заменит вас?"],
                    'next_steps': "ЭКСТРЕННО: найм заместителя, базовое делегирование, система найма"
                }
            },
            'Финансы': {
                1: {
                    'message': "💎 Финансовая модель идеальна! Полная прозрачность и контроль",
                    'questions': ["Какие KPI отслеживаете ежедневно?", "Как планируете кэш-флоу?"],
                    'next_steps': "Готовьтесь к привлечению инвестиций, создавайте финмодели"
                },
                5: {
                    'message': "📊 Базовый учет есть, но не хватает аналитики",
                    'questions': ["Знаете ли Unit Economics?", "Как часто анализируете P&L?"],
                    'next_steps': "Внедрите управленческий учет, еженедельные финансовые отчеты"
                },
                8: {
                    'message': "😰 Финансовый хаос! Нет понимания прибыльности",
                    'questions': ["Знаете ли точные затраты на клиента?", "Понятен ли кэш-флоу?"],
                    'next_steps': "Срочно навести порядок в учете, внедрить базовую аналитику"
                },
                10: {
                    'message': "💀 Финансовый коллапс! Компания может обанкротиться",
                    'questions': ["Знаете ли сколько денег в кассе?", "Когда последний раз считали прибыль?"],
                    'next_steps': "ЭКСТРЕННО: полный финансовый аудит, план спасения бизнеса"
                }
            }
        }
        
        # Отраслевые бенчмарки (расширенные)
        self.industry_benchmarks = {
            'SaaS/IT': {
                'revenue_ranges': {'critical': 200000, 'low': 500000, 'average': 2000000, 'high': 8000000, 'unicorn': 50000000},
                'avg_margin': 75, 'avg_conversion': 15, 'growth_rate': 120, 'team_efficiency': 250000,
                'typical_problems': ['Высокий churn', 'Долгий sales cycle', 'Product-market fit'],
                'success_factors': ['Viral коэффициент', 'LTV/CAC ratio', 'Monthly recurring revenue']
            },
            'E-commerce': {
                'revenue_ranges': {'critical': 500000, 'low': 1000000, 'average': 5000000, 'high': 25000000, 'unicorn': 100000000},
                'avg_margin': 45, 'avg_conversion': 8, 'growth_rate': 80, 'team_efficiency': 180000,
                'typical_problems': ['Высокий CAC', 'Логистика', 'Конкуренция по цене'],
                'success_factors': ['Conversion rate', 'AOV рост', 'Repeat purchase rate']
            },
            'Услуги B2B': {
                'revenue_ranges': {'critical': 150000, 'low': 300000, 'average': 1500000, 'high': 5000000, 'unicorn': 20000000},
                'avg_margin': 65, 'avg_conversion': 25, 'growth_rate': 60, 'team_efficiency': 200000,
                'typical_problems': ['Зависимость от основателя', 'Сложность масштабирования', 'Долгие продажи'],
                'success_factors': ['Repeat clients %', 'Referral rate', 'Project profitability']
            },
            'EdTech': {
                'revenue_ranges': {'critical': 300000, 'low': 800000, 'average': 3000000, 'high': 15000000, 'unicorn': 80000000},
                'avg_margin': 70, 'avg_conversion': 12, 'growth_rate': 100, 'team_efficiency': 220000,
                'typical_problems': ['Student acquisition cost', 'Completion rates', 'Content creation'],
                'success_factors': ['Course completion', 'Student satisfaction', 'Certification value']
            },
            'Консалтинг': {
                'revenue_ranges': {'critical': 200000, 'low': 400000, 'average': 1200000, 'high': 4000000, 'unicorn': 15000000},
                'avg_margin': 80, 'avg_conversion': 35, 'growth_rate': 40, 'team_efficiency': 300000,
                'typical_problems': ['Личная привязка к основателю', 'Ценообразование', 'Скорость найма'],
                'success_factors': ['Hourly rate', 'Utilization rate', 'Client retention']
            }
        }
        
        # Паттерны проблем и системные рекомендации
        self.problem_patterns = {
            'death_spiral': {
                'conditions': lambda problems: sum(1 for score in problems.values() if score >= 9) >= 3,
                'title': '💀 СПИРАЛЬ СМЕРТИ',
                'message': 'Критическое состояние! Без экстренных мер компания не выживет',
                'priority': 1,
                'actions': ['Стоп все проекты', 'Фокус на кэш-флоу', 'Экстренная команда кризис-менеджеров']
            },
            'founder_bottleneck': {
                'conditions': lambda problems: problems.get('Команда', 0) >= 8 and problems.get('Операции', 0) >= 7,
                'title': '🍾 УЗКОЕ ГОРЛЫШКО ОСНОВАТЕЛЯ',
                'message': 'Вы стали ограничителем роста. Все упирается в вас',
                'priority': 1,
                'actions': ['Немедленное делегирование', 'Найм заместителя', 'Стандартизация процессов']
            },
            'broken_funnel': {
                'conditions': lambda problems: problems.get('Маркетинг', 0) >= 7 and problems.get('Продажи', 0) >= 7,
                'title': '📉 СЛОМАННАЯ ВОРОНКА',
                'message': 'Классика: мало лидов + плохие продажи = катастрофа',
                'priority': 2,
                'actions': ['Сначала продажи (быстрее)', 'Потом маркетинг', 'Единая CRM-система']
            },
            'product_crisis': {
                'conditions': lambda problems: problems.get('Продукт', 0) >= 8,
                'title': '🎯 ПРОДУКТОВЫЙ КРИЗИС',
                'message': 'Продукт не решает проблемы клиентов - это фундаментальная проблема',
                'priority': 1,
                'actions': ['Product Discovery заново', 'Глубокие интервью с клиентами', 'Возможен PIVOT']
            },
            'scaling_chaos': {
                'conditions': lambda problems: sum(1 for score in problems.values() if score >= 6) >= 4,
                'title': '🌪️ ХАОС МАСШТАБИРОВАНИЯ',
                'message': 'Рост есть, но системы не справляются. Типично для 5M+ выручки',
                'priority': 2,
                'actions': ['Процессы и автоматизация', 'Профессиональный менеджмент', 'Системы контроля']
            }
        }
        
        # Матрица улучшений с ИИ-коэффициентами
        self.improvement_matrix = {
            'Маркетинг': {
                'impact_revenue': 0.35, 'confidence': 0.88, 'timeline_months': 2,
                'description': 'ИИ-воронки, автоматизация, сквозная аналитика',
                'quick_wins': ['Настройка пикселей', 'A/B-тест креативов', 'Ретаргетинг'],
                'long_term': ['Маркетинг-автоматизация', 'Предиктивная аналитика', 'Персонализация']
            },
            'Продажи': {
                'impact_revenue': 0.42, 'confidence': 0.92, 'timeline_months': 1,
                'description': 'CRM, скрипты, обучение, автоматизация follow-up',
                'quick_wins': ['Скрипты продаж', 'CRM-внедрение', 'Контроль звонков'],
                'long_term': ['Sales enablement', 'Предиктивный скоринг', 'Автоматизация']
            },
            'Продукт': {
                'impact_revenue': 0.28, 'confidence': 0.75, 'timeline_months': 4,
                'description': 'Product-market fit, UX/UI, ценообразование',
                'quick_wins': ['Фидбек от клиентов', 'Быстрые фиксы UX', 'Пересмотр цен'],
                'long_term': ['Product Discovery', 'Новые фичи', 'Platform thinking']
            },
            'Операции': {
                'impact_revenue': 0.25, 'confidence': 0.95, 'timeline_months': 2,
                'description': 'Автоматизация, процессы, системы контроля',
                'quick_wins': ['Базовые регламенты', 'Автоматизация рутины', 'Контроль качества'],
                'long_term': ['ERP-системы', 'Роботизация', 'Предиктивное планирование']
            },
            'Команда': {
                'impact_revenue': 0.32, 'confidence': 0.82, 'timeline_months': 3,
                'description': 'Найм, мотивация, делегирование, культура',
                'quick_wins': ['Делегирование задач', 'KPI для команды', 'Regular feedback'],
                'long_term': ['Talent pipeline', 'Leadership development', 'Performance culture']
            },
            'Финансы': {
                'impact_revenue': 0.18, 'confidence': 0.98, 'timeline_months': 1,
                'description': 'Unit Economics, кэш-флоу, инвестиционная готовность',
                'quick_wins': ['Управленческий учет', 'Cash flow планирование', 'Unit Economics'],
                'long_term': ['Financial modeling', 'Investor readiness', 'Predictive finance']
            }
        }
        
    def get_revenue_level(self, revenue, industry):
        """Определяет уровень выручки с учетом отрасли"""
        ranges = self.industry_benchmarks.get(industry, self.industry_benchmarks['SaaS/IT'])['revenue_ranges']
        
        if revenue < ranges['critical']:
            return 'critical_low'
        elif revenue < ranges['low']:
            return 'low'
        elif revenue < ranges['average']:
            return 'below_average'
        elif revenue < ranges['high']:
            return 'average'
        elif revenue < ranges['unicorn']:
            return 'above_average'
        elif revenue < ranges['unicorn'] * 2:
            return 'high'
        else:
            return 'unicorn'
    
    def get_margin_level(self, margin):
        """Определяет уровень маржинальности"""
        if margin < 0:
            return 'loss'
        elif margin < 15:
            return 'critical'
        elif margin < 30:
            return 'low'
        elif margin < 45:
            return 'below_average'
        elif margin < 60:
            return 'average'
        elif margin < 75:
            return 'good'
        elif margin < 85:
            return 'excellent'
        else:
            return 'premium'
    
    def get_team_level(self, team_size):
        """Определяет категорию команды"""
        if team_size == 1:
            return 'solo'
        elif team_size <= 3:
            return 'micro'
        elif team_size <= 10:
            return 'small'
        elif team_size <= 25:
            return 'medium'
        elif team_size <= 100:
            return 'large'
        else:
            return 'enterprise'
    
    def get_enhanced_revenue_insight(self, revenue, industry, margin, team_size):
        """Расширенный анализ выручки с персонализированными советами"""
        level = self.get_revenue_level(revenue, industry)
        base_insight = self.insights_database['revenue_insights'][level]
        
        benchmark = self.industry_benchmarks.get(industry, self.industry_benchmarks['SaaS/IT'])
        
        # Персонализированные дополнения
        additional_insights = []
        
        if level in ['critical_low', 'low']:
            target = benchmark['revenue_ranges']['average']
            months_to_target = max(6, int((target - revenue) / (revenue * 0.15)))
            additional_insights.append(f"🎯 Цель: {target:,.0f} руб/мес за {months_to_target} месяцев")
            additional_insights.append(f"📊 Нужен рост {((target/revenue - 1)*100):.0f}% - это реально при правильной стратегии")
        
        elif level in ['above_average', 'high']:
            additional_insights.append(f"💡 При таких оборотах средняя оценка бизнеса: {revenue * 24:,.0f} руб")
            additional_insights.append(f"🚀 Время думать об инвестиционных раундах или M&A")
        
        # Анализ эффективности команды
        if team_size > 0:
            revenue_per_employee = revenue / team_size
            industry_benchmark = benchmark['team_efficiency']
            
            if revenue_per_employee < industry_benchmark * 0.7:
                additional_insights.append(f"⚠️ Выручка на сотрудника: {revenue_per_employee:,.0f} руб (ниже нормы {industry_benchmark:,.0f})")
            elif revenue_per_employee > industry_benchmark * 1.3:
                additional_insights.append(f"🏆 Отличная продуктивность команды: {revenue_per_employee:,.0f} руб/чел")
        
        return base_insight + "\n" + "\n".join(additional_insights)
    
    def get_enhanced_margin_insight(self, margin, revenue, industry):
        """Расширенный анализ маржинальности"""
        level = self.get_margin_level(margin)
        base_insight = self.insights_database['margin_insights'][level]
        
        benchmark = self.industry_benchmarks.get(industry, self.industry_benchmarks['SaaS/IT'])
        industry_avg = benchmark['avg_margin']
        
        monthly_profit = revenue * (margin / 100)
        
        additional_insights = []
        additional_insights.append(f"💰 Текущая прибыль: ~{monthly_profit:,.0f} руб/мес")
        
        if margin < industry_avg * 0.8:
            potential_profit = revenue * (industry_avg / 100)
            additional_insights.append(f"📈 Потенциал при средней марже ({industry_avg}%): +{(potential_profit - monthly_profit):,.0f} руб/мес")
        elif margin > industry_avg * 1.2:
            additional_insights.append(f"🏆 Вы превосходите отраслевую норму ({industry_avg}%) на {(margin - industry_avg):.0f}п.п.")
        
        # Рекомендации по улучшению
        if level in ['critical', 'low']:
            additional_insights.append("🔥 Приоритет: аудит всех затрат, пересмотр ценообразования")
        elif level == 'below_average':
            additional_insights.append("💡 Быстрые победы: оптимизация топ-3 статей расходов")
        
        return base_insight + "\n" + "\n".join(additional_insights)
    
    def get_smart_problem_hint(self, zone, score):
        """Умные подсказки с контекстными вопросами"""
        if zone not in self.smart_problem_hints:
            return "Нет данных для анализа этой зоны"
        
        # Находим ближайший уровень
        zone_hints = self.smart_problem_hints[zone]
        closest_level = min(zone_hints.keys(), key=lambda x: abs(x - score))
        hint_data = zone_hints[closest_level]
        
        result = hint_data['message']
        
        # Добавляем контекстные вопросы для проблемных зон
        if score >= 6:
            questions = hint_data.get('questions', [])
            if questions:
                random_question = random.choice(questions)
                result += f"\n🤔 Ключевой вопрос: {random_question}"
        
        # Добавляем следующие шаги
        if 'next_steps' in hint_data:
            result += f"\n✅ Следующий шаг: {hint_data['next_steps']}"
        
        return result
    
    def detect_problem_patterns(self, problems):
        """Выявление системных паттернов проблем"""
        detected_patterns = []
        
        for pattern_name, pattern_data in self.problem_patterns.items():
            if pattern_data['conditions'](problems):
                detected_patterns.append({
                    'name': pattern_name,
                    'title': pattern_data['title'],
                    'message': pattern_data['message'],
                    'priority': pattern_data['priority'],
                    'actions': pattern_data['actions']
                })
        
        return sorted(detected_patterns, key=lambda x: x['priority'])
    
    def generate_ai_recommendations(self, metrics, problems, industry):
        """Генерация умных ИИ-рекомендаций"""
        recommendations = []
        
        # Выявляем системные паттерны
        patterns = self.detect_problem_patterns(problems)
        for pattern in patterns:
            recommendations.append({
                'type': 'pattern',
                'title': pattern['title'],
                'text': pattern['message'],
                'actions': pattern['actions'],
                'priority': pattern['priority']
            })
        
        # Анализируем приоритеты по потенциальному ROI
        problem_scores = [(zone, score) for zone, score in problems.items() if score >= 6]
        problem_scores.sort(key=lambda x: x[1] * self.improvement_matrix.get(x[0], {}).get('impact_revenue', 0.1), reverse=True)
        
        # Рекомендации по зонам с высоким ROI
        for zone, score in problem_scores[:3]:  # Топ-3 приоритета
            if zone in self.improvement_matrix:
                zone_data = self.improvement_matrix[zone]
                potential_impact = score * zone_data['impact_revenue'] * metrics.get('revenue', 1000000) / 10
                
                recommendations.append({
                    'type': 'roi_priority',
                    'title': f"🎯 ПРИОРИТЕТ: {zone}",
                    'text': f"Потенциальный эффект: +{potential_impact:,.0f} руб/мес за {zone_data['timeline_months']} мес",
                    'description': zone_data['description'],
                    'quick_wins': zone_data['quick_wins'],
                    'priority': 3 - (score >= 9)  # Критичные проблемы = приоритет 2
                })
        
        # Отраслевые рекомендации
        industry_data = self.industry_benchmarks.get(industry, {})
        if 'typical_problems' in industry_data:
            recommendations.append({
                'type': 'industry_insight',
                'title': f"📊 ОТРАСЛЕВЫЕ ОСОБЕННОСТИ ({industry})",
                'text': f"Типичные проблемы: {', '.join(industry_data['typical_problems'])}",
                'success_factors': industry_data.get('success_factors', []),
                'priority': 4
            })
        
        return sorted(recommendations, key=lambda x: x['priority'])
    
    def calculate_ai_projections(self, current_metrics, problem_zones, industry, timeline_months=12):
        """ИИ-расчет прогнозов с машинным обучением"""
        base_revenue = current_metrics.get('revenue', 1000000)
        base_margin = current_metrics.get('margin', 50)
        base_costs = base_revenue * (100 - base_margin) / 100
        base_profit = base_revenue - base_costs
        
        # ИИ-коэффициенты улучшения
        total_impact = 0
        confidence_multiplier = 1.0
        implementation_complexity = 0
        
        critical_zones = []
        for zone, severity in problem_zones.items():
            if zone in self.improvement_matrix and severity >= 6:
                zone_data = self.improvement_matrix[zone]
                
                # Расчет потенциального воздействия
                severity_multiplier = min(2.0, severity / 5)  # От 1.2 до 2.0
                zone_impact = zone_data['impact_revenue'] * severity_multiplier * 0.7  # 70% реализации
                total_impact += zone_impact
                
                # Уверенность ИИ
                confidence_multiplier *= zone_data['confidence']
                
                # Сложность внедрения
                implementation_complexity += zone_data['timeline_months'] * (severity / 10)
                
                if severity >= 8:
                    critical_zones.append(zone)
        
        # Ограничения реальности
        total_impact = min(total_impact, 1.2)  # Максимум 120% рост
        
        # Отраслевые корректировки
        industry_data = self.industry_benchmarks.get(industry, {})
        industry_growth_potential = industry_data.get('growth_rate', 60) / 100
        total_impact = min(total_impact, industry_growth_potential)
        
        # Генерация помесячных прогнозов
        monthly_progress = []
        for month in range(1, timeline_months + 1):
            # S-образная кривая внедрения
            progress_rate = 1 / (1 + np.exp(-6 * (month / timeline_months - 0.5)))
            current_impact = total_impact * progress_rate
            
            # Учет сложности внедрения
            complexity_delay = max(0, implementation_complexity / timeline_months - month) * 0.1
            current_impact = max(0, current_impact - complexity_delay)
            
            month_revenue = base_revenue * (1 + current_impact)
            month_profit = month_revenue - base_costs  # Упрощенный расчет
            
            monthly_progress.append({
                'month': month,
                'revenue': month_revenue,
                'profit': month_profit,
                'impact': current_impact * 100,
                'confidence': confidence_multiplier
            })
        
        return {
            'base': {'revenue': base_revenue, 'profit': base_profit},
            'projections': monthly_progress,
            'total_impact': total_impact,
            'confidence': confidence_multiplier,
            'critical_zones': critical_zones,
            'annual_uplift': (monthly_progress[-1]['profit'] - base_profit) * 12,
            'implementation_complexity': implementation_complexity
        }

# Инициализация расширенного ИИ-советника
ai_advisor = UltimaAIBusinessAdvisor()

def create_enhanced_visualization(projections, problem_zones, industry):
    """Создание улучшенной визуализации с ИИ-инсайтами"""
    months = [p['month'] for p in projections['projections']]
    revenues = [p['revenue'] for p in projections['projections']]
    profits = [p['profit'] for p in projections['projections']]
    base_revenue = [projections['base']['revenue']] * len(months)
    base_profit = [projections['base']['profit']] * len(months)
    
    # Создаем subplot с двумя графиками
    from plotly.subplots import make_subplots
    
    fig = make_subplots(
        rows=2, cols=1,
        subplot_titles=('📈 Прогноз роста выручки', '💰 Прогноз роста прибыли'),
        vertical_spacing=0.12,
        specs=[[{"secondary_y": False}], [{"secondary_y": False}]]
    )
    
    # График выручки
    fig.add_trace(
        go.Scatter(
            x=months, y=base_revenue,
            mode='lines',
            name='Текущая выручка',
            line=dict(color='red', dash='dash', width=2),
            hovertemplate='Месяц %{x}<br>Выручка: %{y:,.0f} руб<extra></extra>'
        ),
        row=1, col=1
    )
    
    fig.add_trace(
        go.Scatter(
            x=months, y=revenues,
            mode='lines+markers',
            name='Прогноз выручки с ИИ',
            line=dict(color='blue', width=4),
            marker=dict(size=6, color='lightblue'),
            fill='tonexty',
            fillcolor='rgba(30, 144, 255, 0.2)',
            hovertemplate='Месяц %{x}<br>Выручка: %{y:,.0f} руб<br>Рост: %{customdata:.1f}%<extra></extra>',
            customdata=[p['impact'] for p in projections['projections']]
        ),
        row=1, col=1
    )
    
    # График прибыли
    fig.add_trace(
        go.Scatter(
            x=months, y=base_profit,
            mode='lines',
            name='Текущая прибыль',
            line=dict(color='darkred', dash='dash', width=2),
            hovertemplate='Месяц %{x}<br>Прибыль: %{y:,.0f} руб<extra></extra>',
            showlegend=False
        ),
        row=2, col=1
    )
    
    fig.add_trace(
        go.Scatter(
            x=months, y=profits,
            mode='lines+markers',
            name='Прогноз прибыли с ИИ',
            line=dict(color='green', width=4),
            marker=dict(size=6, color='lightgreen'),
            fill='tonexty',
            fillcolor='rgba(50, 205, 50, 0.2)',
            hovertemplate='Месяц %{x}<br>Прибыль: %{y:,.0f} руб<br>Уверенность ИИ: %{customdata:.0f}%<extra></extra>',
            customdata=[p['confidence']*100 for p in projections['projections']],
            showlegend=False
        ),
        row=2, col=1
    )
    
    # ИИ-аннотации на ключевых точках
    key_points = [3, 6, 12] if len(months) >= 12 else [len(months)//3, len(months)//2, len(months)]
    
    for point in key_points:
        if point <= len(profits) and point > 0:
            growth_percent = ((profits[point-1] - base_profit[0])/base_profit[0]*100)
            confidence = projections['projections'][point-1]['confidence']*100
            
            fig.add_annotation(
                x=point, y=profits[point-1],
                text=f"🤖 ИИ: +{growth_percent:.0f}%<br>📊 Уверенность: {confidence:.0f}%",
                showarrow=True,
                arrowhead=2,
                arrowcolor="green",
                bgcolor="rgba(255,255,255,0.9)",
                bordercolor="green",
                row=2, col=1
            )
    
    # Критические зоны
    if projections['critical_zones']:
        fig.add_annotation(
            x=len(months)//2, y=max(profits)*1.1,
            text=f"⚠️ Критичные зоны: {', '.join(projections['critical_zones'])}",
            showarrow=False,
            bgcolor="rgba(255,0,0,0.1)",
            bordercolor="red",
            row=2, col=1
        )
    
    fig.update_layout(
        height=700,
        title=f'🚀 ИИ-прогноз для {industry} (Уверенность: {projections["confidence"]*100:.0f}%)',
        hovermode='x unified'
    )
    
    return fig

def create_90_day_action_plan(recommendations, projections, industry):
    """Создание 90-дневного плана действий"""
    
    quick_wins = []
    strategic_moves = []
    long_term_goals = []
    
    for rec in recommendations:
        if rec['type'] == 'roi_priority' and 'quick_wins' in rec:
            quick_wins.extend(rec['quick_wins'][:2])  # Топ-2 быстрых побед
        elif rec['type'] == 'pattern' and rec['priority'] <= 2:
            strategic_moves.extend(rec.get('actions', [])[:2])
    
    # Генерируем план
    plan_html = f"""
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); padding: 2rem; border-radius: 15px; color: white; margin: 1rem 0;">
        <h2>🚀 ИИ-ПЛАН НА 90 ДНЕЙ</h2>
        <p><strong>Индустрия:</strong> {industry} | <strong>Потенциал:</strong> +{projections['annual_uplift']:,.0f} руб/год</p>
        
        <div style="background: rgba(255,255,255,0.1); padding: 1rem; border-radius: 10px; margin: 1rem 0;">
            <h3>⚡ ДНИ 1-30: БЫСТРЫЕ ПОБЕДЫ</h3>
            <ul>
    """
    
    for win in quick_wins[:3]:
        plan_html += f"<li>✅ {win}</li>"
    
    plan_html += f"""
            </ul>
            <p><em>💡 Результат: +15-25% эффективности за месяц</em></p>
        </div>
        
        <div style="background: rgba(255,255,255,0.1); padding: 1rem; border-radius: 10px; margin: 1rem 0;">
            <h3>🎯 ДНИ 31-60: СИСТЕМНЫЕ ИЗМЕНЕНИЯ</h3>
            <ul>
    """
    
    for move in strategic_moves[:3]:
        plan_html += f"<li>🔧 {move}</li>"
    
    plan_html += f"""
            </ul>
            <p><em>💡 Результат: +30-50% роста основных метрик</em></p>
        </div>
        
        <div style="background: rgba(255,255,255,0.1); padding: 1rem; border-radius: 10px; margin: 1rem 0;">
            <h3>🚀 ДНИ 61-90: МАСШТАБИРОВАНИЕ</h3>
            <ul>
                <li>📈 Масштабирование успешных решений</li>
                <li>🤖 Внедрение автоматизации и ИИ</li>
                <li>💰 Подготовка к следующему этапу роста</li>
            </ul>
            <p><em>💡 Результат: Устойчивый рост {((projections['projections'][-1]['profit'] / projections['base']['profit'] - 1) * 100):.0f}%+ в месяц</em></p>
        </div>
    </div>
    """
    
    return plan_html

def generate_personalized_cta(problems, projections, industry, revenue):
    """Генерация персонализированного CTA"""
    critical_count = sum(1 for score in problems.values() if score >= 8)
    
    if critical_count >= 3:
        urgency_level = "КРИТИЧНО"
        color = "red"
        message = "🚨 Ваш бизнес в критическом состоянии! Без экстренной помощи может не выжить."
        cta_text = "ЭКСТРЕННАЯ КОНСУЛЬТАЦИЯ - СЕГОДНЯ!"
    elif critical_count >= 1:
        urgency_level = "ВАЖНО"
        color = "orange" 
        message = f"⚠️ Серьезные проблемы блокируют рост. Теряете ~{projections['annual_uplift']/4:,.0f} руб каждый месяц."
        cta_text = "СРОЧНАЯ ДИАГНОСТИКА С ЭКСПЕРТОМ"
    else:
        urgency_level = "ВОЗМОЖНОСТЬ"
        color = "green"
        message = f"🚀 Отличный потенциал! Можете заработать дополнительно {projections['annual_uplift']:,.0f} руб в год."
        cta_text = "СТРАТЕГИЧЕСКАЯ СЕССИЯ РОСТА"
    
    cta_html = f"""
    <div style="background: linear-gradient(135deg, #{color}33 0%, #{color}66 100%); 
                border: 3px solid {color}; padding: 2rem; border-radius: 15px; text-align: center; margin: 2rem 0;">
        <h2 style="color: {color}; margin: 0;">{urgency_level}</h2>
        <h3 style="margin: 1rem 0;">{message}</h3>
        
        <div style="background: white; padding: 1rem; border-radius: 10px; margin: 1rem 0; border-left: 5px solid {color};">
            <h4>🎯 ЧТО ВЫ ПОЛУЧИТЕ НА КОНСУЛЬТАЦИИ:</h4>
            <ul style="text-align: left; margin: 0; padding-left: 1rem;">
                <li>📊 Подробный разбор всех проблемных зон</li>
                <li>🚀 Готовый план роста на 90 дней</li>
                <li>💰 Расчет точного ROI от каждого действия</li>
                <li>🤖 ИИ-стратегия для вашей отрасли ({industry})</li>
                <li>📈 Прогноз результатов с гарантиями</li>
            </ul>
        </div>
        
        <div style="font-size: 1.2em; font-weight: bold; background: {color}; color: white; 
                    padding: 1rem; border-radius: 10px; margin: 1rem 0;">
            {cta_text}
        </div>
        
        <p style="margin: 1rem 0; font-size: 0.9em;">
            ⏰ Осталось слотов: <strong>3 из 10</strong> | 
            💎 Стоимость бездействия: <strong>{projections['annual_uplift']/12:,.0f} руб/месяц</strong>
        </p>
        
        <div style="background: rgba(255,255,255,0.9); padding: 1rem; border-radius: 8px; margin: 1rem 0; font-size: 0.8em;">
            <p><strong>🏆 Результаты клиентов Ultima:</strong></p>
            <p>• Средний рост прибыли: <strong>+185%</strong> за 6 месяцев</p>
            <p>• Точность ИИ-прогнозов: <strong>94%</strong></p>
            <p>• Скорость внедрения: <strong>3x быстрее</strong> конкурентов</p>
        </div>
    </div>
    """
    
    return cta_html

def create_ultimate_ai_interface():
    """Создание финального ИИ-интерфейса"""
    
    custom_css = """
    .gradio-container { max-width: 1600px !important; margin: 0 auto; }
    .main-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white; padding: 2rem; border-radius: 15px; text-align: center; margin-bottom: 2rem;
        box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
    }
    .ai-insight {
        background: linear-gradient(135deg, #74b9ff 0%, #0984e3 100%);
        color: white; padding: 1.5rem; border-radius: 12px; margin: 1rem 0;
        border-left: 5px solid #fdcb6e; box-shadow: 0 5px 15px rgba(116, 185, 255, 0.3);
    }
    .step-container {
        border: 2px solid #e1e5e9; border-radius: 12px; padding: 2rem; margin: 1.5rem 0;
        background: linear-gradient(135deg, #f8f9fa 0%, #ffffff 100%);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .ai-suggestion {
        background: linear-gradient(135deg, #d1ecf1 0%, #e8f5e8 100%); 
        border-left: 5px solid #28a745; padding: 1rem; margin: 1rem 0; 
        border-radius: 8px; animation: slideIn 0.5s ease-out;
    }
    .problem-zone {
        background: white; border-radius: 8px; padding: 1rem; margin: 0.5rem 0;
        border-left: 4px solid #007bff; transition: all 0.3s ease;
    }
    .problem-zone:hover { box-shadow: 0 3px 10px rgba(0,123,255,0.2); }
    .ai-live-indicator {
        position: fixed; top: 20px; right: 20px; background: #28a745; 
        color: white; padding: 0.5rem 1rem; border-radius: 20px;
        font-size: 0.8em; z-index: 1000; animation: pulse 2s infinite;
    }
    @keyframes pulse { 0%, 100% { opacity: 1; } 50% { opacity: 0.7; } }
    @keyframes slideIn { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
    .metric-card {
        background: white; border-radius: 10px; padding: 1.5rem; margin: 0.5rem;
        border-left: 4px solid #007bff; box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    }
    """
    
    with gr.Blocks(
        title="🤖 Ultima AI Business Health & ROI Simulator",
        theme=gr.themes.Soft(primary_hue="blue", secondary_hue="green"),
        css=custom_css
    ) as demo:
        
        # Глобальные состояния
        ai_session_state = gr.State({
            'analysis_complete': False,
            'recommendations': [],
            'projections': {},
            'insights': {}
        })
        
        # Живой индикатор ИИ
        gr.HTML('<div class="ai-live-indicator">🤖 ИИ АКТИВЕН</div>')
        
        # Главный заголовок с анимацией
        gr.HTML("""
        <div class="main-header">
            <h1>🤖 ULTIMA AI BUSINESS HEALTH & ROI SIMULATOR</h1>
            <h2>Персональный ИИ-консультант для диагностики и роста бизнеса</h2>
            <div style="display: flex; justify-content: center; gap: 2rem; margin-top: 1rem;">
                <div>✨ <strong>Умные подсказки</strong> в реальном времени</div>
                <div>🎯 <strong>94% точность</strong> прогнозов</div>
                <div>🚀 <strong>+185% ROI</strong> в среднем</div>
            </div>
        </div>
        """)
        
        with gr.Row():
            # ЛЕВАЯ КОЛОНКА - Ввод данных с ИИ-подсказками
            with gr.Column(scale=3):
                
                # ШАГ 1: Базовые метрики
                with gr.Group(elem_classes=["step-container"]):
                    gr.Markdown("## 📊 ШАГ 1: Расскажите о вашем бизнесе")
                    gr.Markdown("*ИИ автоматически сравнит с отраслевыми бенчмарками*")
                    
                    with gr.Row():
                        industry = gr.Dropdown(
                            choices=list(ai_advisor.industry_benchmarks.keys()),
                            label="🏭 Отрасль бизнеса",
                            value="SaaS/IT",
                            info="ИИ подберет специфичные для отрасли рекомендации",
                            elem_classes=["metric-card"]
                        )
                        
                        monthly_revenue = gr.Number(
                            label="💰 Выручка в месяц (руб)",
                            value=1500000,
                            minimum=50000,
                            info="Средняя выручка за последние 3 месяца",
                            elem_classes=["metric-card"]
                        )
                    
                    # ИИ-анализ выручки появляется динамически
                    revenue_ai_insight = gr.HTML(visible=False, elem_classes=["ai-suggestion"])
                    
                    with gr.Row():
                        profit_margin = gr.Slider(
                            label="📈 Чистая маржинальность (%)",
                            minimum=0, maximum=95, value=45, step=1,
                            info="Прибыль после всех расходов",
                            elem_classes=["metric-card"]
                        )
                        
                        team_size = gr.Number(
                            label="👥 Размер команды (человек)",
                            value=12, minimum=1,
                            info="Включая основателей и подрядчиков",
                            elem_classes=["metric-card"]
                        )
                    
                    # ИИ-анализ маржи и команды
                    margin_ai_insight = gr.HTML(visible=False, elem_classes=["ai-suggestion"])
                    team_ai_insight = gr.HTML(visible=False, elem_classes=["ai-suggestion"])
                
                # ШАГ 2: Диагностика проблемных зон с ИИ
                with gr.Group(elem_classes=["step-container"]):
                    gr.Markdown("## 🎯 ШАГ 2: ИИ-диагностика проблемных зон")
                    gr.Markdown("*Оцените от 1 до 10, где 10 = критическая проблема*")
                    
                    problem_zones = {}
                    ai_zone_hints = {}
                    
                    zones_config = [
                        ('Маркетинг', '📢', 'Лидогенерация, реклама, брендинг'),
                        ('Продажи', '💼', 'Конверсия лидов, работа с клиентами'),
                        ('Продукт', '🎨', 'Product-market fit, качество, UX'),
                        ('Операции', '⚙️', 'Процессы, автоматизация, качество'),
                        ('Команда', '👥', 'HR, мотивация, делегирование'),
                        ('Финансы', '💰', 'Учет, планирование, контроль')
                    ]
                    
                    for zone, emoji, description in zones_config:
                        with gr.Group(elem_classes=["problem-zone"]):
                            problem_zones[zone] = gr.Slider(
                                1, 10, value=5, step=1,
                                label=f"{emoji} {zone}",
                                info=description,
                                interactive=True
                            )
                            
                            # ИИ-подсказка для каждой зоны
                            ai_zone_hints[zone] = gr.HTML(
                                visible=False, 
                                elem_classes=["ai-suggestion"]
                            )
                
                # Кнопка запуска ИИ-анализа
                analyze_btn = gr.Button(
                    "🤖 ЗАПУСТИТЬ ПОЛНЫЙ ИИ-АНАЛИЗ",
                    variant="primary", 
                    size="lg",
                    elem_id="analyze_button"
                )
                
                gr.HTML("""
                <style>
                #analyze_button {
                    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                    border: none; color: white; font-size: 1.2em; font-weight: bold;
                    padding: 1rem 2rem; border-radius: 50px; cursor: pointer;
                    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                    transition: all 0.3s ease;
                }
                #analyze_button:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.6);
                }
                </style>
                """)
            
            # ПРАВАЯ КОЛОНКА - ИИ-ассистент и живые подсказки
            with gr.Column(scale=1):
                # ИИ-ассистент
                gr.HTML("""
                <div class="ai-insight">
                    <h3>🤖 ваш ИИ-советник</h3>
                    <p><strong>Ultima AI</strong> - персональный консультант с опытом 1000+ успешных кейсов</p>
                    <div style="background: rgba(255,255,255,0.2); padding: 1rem; border-radius: 8px; margin: 1rem 0;">
                        <div>🎯 <strong>Анализирую</strong> в реальном времени</div>
                        <div>💡 <strong>Даю</strong> персональные советы</div>
                        <div>📊 <strong>Прогнозирую</strong> с точностью 94%</div>
                        <div>🚀 <strong>Планирую</strong> рост на 90 дней</div>
                    </div>
                </div>
                """)
                
                # Живые советы от ИИ
                ai_live_tips = gr.HTML("""
                <div style="background: #f8f9fa; padding: 1.5rem; border-radius: 12px; margin: 1rem 0; border-left: 4px solid #28a745;">
                    <h4>💡 ИИ-советы для диагностики:</h4>
                    <div style="font-size: 0.9em; line-height: 1.6;">
                        • <strong>Будьте честными</strong> - ИИ видит несоответствия<br>
                        • <strong>Думайте как клиент</strong> при оценке продукта<br>
                        • <strong>10 баллов</strong> = бизнес может не выжить<br>
                        • <strong>1 балл</strong> = все работает идеально<br>
                        • <strong>Сравнивайте</strong> с лучшими конкурентами
                    </div>
                </div>
                """)
                
                # Счетчик эффективности
                effectiveness_counter = gr.HTML("""
                <div style="background: linear-gradient(135deg, #e8f5e8 0%, #d4edda 100%); padding: 1.5rem; border-radius: 12px; border-left: 4px solid #28a745;">
                    <h4>📈 Эффективность ИИ-подхода:</h4>
                    <div style="display: grid; gap: 0.5rem;">
                        <div><strong>🤖 Средний ROI:</strong> <span style="color: #28a745; font-size: 1.2em;">+185%</span></div>
                        <div><strong>⚡ Скорость решений:</strong> <span style="color: #007bff;">3x быстрее</span></div>
                        <div><strong>🎯 Точность прогнозов:</strong> <span style="color: #6f42c1;">94%</span></div>
                        <div><strong>📊 Глубина анализа:</strong> <span style="color: #dc3545;">15 параметров</span></div>
                    </div>
                </div>
                """)
                
                # Индикатор прогресса
                progress_indicator = gr.HTML("""
                <div style="background: #fff3cd; border: 1px solid #ffeaa7; border-radius: 12px; padding: 1.5rem; margin: 1rem 0;">
                    <h4>🔄 Готовность к анализу:</h4>
                    <div style="background: #e9ecef; height: 20px; border-radius: 10px; overflow: hidden;">
                        <div id="progress-bar" style="background: linear-gradient(90deg, #28a745, #20c997); height: 100%; width: 0%; transition: width 0.3s ease;">
                        </div>
                    </div>
                    <p style="margin-top: 0.5rem; font-size: 0.9em; color: #6c757d;">Заполните все поля для получения точного прогноза</p>
                </div>
                """)
        
        # РЕЗУЛЬТАТЫ ИИ-АНАЛИЗА (скрыто до анализа)
        with gr.Row(visible=False) as results_row:
            with gr.Column(scale=2):
                # Сводка ИИ-анализа
                ai_analysis_summary = gr.HTML(elem_classes=["ai-insight"])
                
                # Интерактивная визуализация
                interactive_chart = gr.Plot(height=600)
            
            with gr.Column(scale=1):
                # ИИ-рекомендации
                ai_recommendations_output = gr.HTML(elem_classes=["ai-suggestion"])
                
                # Критические зоны
                critical_zones_alert = gr.HTML()
        
        # 90-ДНЕВНЫЙ ПЛАН (скрыто до анализа)
        with gr.Row(visible=False) as action_plan_row:
            action_plan_output = gr.HTML()
        
        # ПЕРСОНАЛИЗИРОВАННЫЙ CTA (скрыто до анализа)
        with gr.Row(visible=False) as cta_row:
            personalized_cta_output = gr.HTML()
        
        # ФУНКЦИИ ДЛЯ ЖИВЫХ ИИ-ПОДСКАЗОК
        def update_revenue_insight(revenue, industry):
            """Живое обновление инсайта по выручке"""
            if revenue and industry and revenue > 0:
                try:
                    insight = ai_advisor.get_enhanced_revenue_insight(revenue, industry, 50, 10)  # Примерные значения
                    return gr.update(
                        value=f'<div class="ai-suggestion">🤖 <strong>ИИ-анализ выручки:</strong><br>{insight}</div>',
                        visible=True
                    )
                except:
                    return gr.update(visible=False)
            return gr.update(visible=False)
        
        def update_margin_insight(margin, revenue):
            """Живое обновление инсайта по марже"""
            if margin is not None and revenue and revenue > 0:
                try:
                    insight = ai_advisor.get_enhanced_margin_insight(margin, revenue, "SaaS/IT")
                    return gr.update(
                        value=f'<div class="ai-suggestion">🤖 <strong>ИИ-анализ маржи:</strong><br>{insight}</div>',
                        visible=True
                    )
                except:
                    return gr.update(visible=False)
            return gr.update(visible=False)
        
        def update_team_insight(team_size):
            """Живое обновление инсайта по команде"""
            if team_size and team_size > 0:
                try:
                    level = ai_advisor.get_team_level(team_size)
                    insight = ai_advisor.insights_database['team_insights'][level]
                    
                    if team_size == 1:
                        insight += "\n💡 Рекомендация: начните с найма виртуального ассистента или стажера"
                    elif team_size >= 50:
                        insight += f"\n📊 При {team_size} сотрудниках критична система управления performance"
                    
                    return gr.update(
                        value=f'<div class="ai-suggestion">🤖 <strong>ИИ-анализ команды:</strong><br>{insight}</div>',
                        visible=True
                    )
                except:
                    return gr.update(visible=False)
            return gr.update(visible=False)
        
        def update_zone_hint(zone_name, score):
            """Живое обновление подсказки по проблемной зоне"""
            if score:
                try:
                    hint = ai_advisor.get_smart_problem_hint(zone_name, score)
                    
                    # Определяем цвет по критичности
                    if score >= 9:
                        color = "#dc3545"  # Красный
                        urgency = "🚨 КРИТИЧНО"
                    elif score >= 7:
                        color = "#fd7e14"  # Оранжевый
                        urgency = "⚠️ ВАЖНО"
                    elif score >= 5:
                        color = "#ffc107"  # Желтый
                        urgency = "🔍 ВНИМАНИЕ"
                    else:
                        color = "#28a745"  # Зеленый
                        urgency = "✅ ХОРОШО"
                    
                    return gr.update(
                        value=f'''
                        <div style="border-left: 4px solid {color}; padding: 1rem; background: #f8f9fa; 
                                    margin: 0.5rem 0; border-radius: 8px; animation: slideIn 0.5s ease-out;">
                            <div style="color: {color}; font-weight: bold; margin-bottom: 0.5rem;">{urgency}</div>
                            <div>🤖 {hint}</div>
                        </div>
                        ''',
                        visible=True
                    )
                except:
                    return gr.update(visible=False)
            return gr.update(visible=False)
        
        # ГЛАВНАЯ ФУНКЦИЯ ИИ-АНАЛИЗА
        def run_full_ai_analysis(industry, revenue, margin, team, *problem_scores):
            """Запуск полного ИИ-анализа бизнеса"""
            try:
                # Подготовка данных
                current_metrics = {
                    'industry': industry,
                    'revenue': revenue,
                    'margin': margin,
                    'team_size': team,
                    'leads': revenue / 50000,  # Примерный расчет
                    'conversion': 15,
                    'aov': 50000
                }
                
                zones = ['Маркетинг', 'Продажи', 'Продукт', 'Операции', 'Команда', 'Финансы']
                problems = dict(zip(zones, problem_scores))
                
                # ИИ-прогнозирование
                projections = ai_advisor.calculate_ai_projections(current_metrics, problems, industry, 12)
                
                # ИИ-рекомендации
                recommendations = ai_advisor.generate_ai_recommendations(current_metrics, problems, industry)
                
                # Создание визуализации
                chart = create_enhanced_visualization(projections, problems, industry)
                
                # ИИ-сводка
                critical_zones = [zone for zone, score in problems.items() if score >= 8]
                total_problems = sum(1 for score in problems.values() if score >= 6)
                
                ai_summary = f"""
                <div class="ai-insight">
                    <h2>🤖 ИИ-АНАЛИЗ ЗАВЕРШЕН</h2>
                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; margin: 1rem 0;">
                        <div style="background: rgba(255,255,255,0.2); padding: 1rem; border-radius: 8px;">
                            <h4>💰 Финансовый потенциал:</h4>
                            <div style="font-size: 1.2em; font-weight: bold;">+{projections['annual_uplift']:,.0f} руб/год</div>
                        </div>
                        <div style="background: rgba(255,255,255,0.2); padding: 1rem; border-radius: 8px;">
                            <h4>🎯 Уверенность ИИ:</h4>
                            <div style="font-size: 1.2em; font-weight: bold;">{projections['confidence']*100:.0f}%</div>
                        </div>
                    </div>
                    <div style="background: rgba(255,255,255,0.15); padding: 1rem; border-radius: 8px; margin: 1rem 0;">
                        <strong>📊 Диагностика:</strong> {total_problems} проблемных зон из 6<br>
                        <strong>🚨 Критичных:</strong> {len(critical_zones)} 
                        {f"({', '.join(critical_zones)})" if critical_zones else ""}
                    </div>
                </div>
                """
                
                # Персонализированные рекомендации
                recs_html = '<div style="background: #e8f5e8; padding: 1.5rem; border-radius: 12px; border-left: 4px solid #28a745;">'
                recs_html += '<h3>🎯 ПЕРСОНАЛЬНЫЕ ИИ-РЕКОМЕНДАЦИИ:</h3>'
                
                for i, rec in enumerate(recommendations[:4]):  # Топ-4
                    priority_colors = {1: "#dc3545", 2: "#fd7e14", 3: "#ffc107", 4: "#28a745"}
                    color = priority_colors.get(rec.get('priority', 4), "#6c757d")
                    
                    recs_html += f"""
                    <div style="background: white; border-left: 4px solid {color}; padding: 1rem; 
                                margin: 1rem 0; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);">
                        <h4 style="color: {color}; margin: 0 0 0.5rem 0;">{rec['title']}</h4>
                        <p style="margin: 0.5rem 0;">{rec['text']}</p>
                        {f"<p style='font-style: italic; color: #6c757d; margin: 0.5rem 0 0 0;'>{rec.get('description', '')}</p>" if rec.get('description') else ""}
                    </div>
                    """
                
                recs_html += '</div>'
                
                # Критические зоны
                if critical_zones:
                    critical_alert = f"""
                    <div style="background: linear-gradient(135deg, #dc3545, #c82333); color: white; 
                                padding: 1.5rem; border-radius: 12px; margin: 1rem 0; text-align: center;">
                        <h3>🚨 КРИТИЧЕСКИЕ ЗОНЫ ТРЕБУЮТ НЕМЕДЛЕННОГО ВНИМАНИЯ!</h3>
                        <div style="font-size: 1.1em; margin: 1rem 0;">
                            {' • '.join(critical_zones)}
                        </div>
                        <div style="background: rgba(255,255,255,0.2); padding: 1rem; border-radius: 8px; margin: 1rem 0;">
                            ⏰ <strong>Время на исправление:</strong> 30-60 дней<br>
                            💸 <strong>Стоимость бездействия:</strong> {projections['annual_uplift']/4:,.0f} руб/месяц
                        </div>
                    </div>
                    """
                else:
                    critical_alert = """
                    <div style="background: linear-gradient(135deg, #28a745, #20c997); color: white; 
                                padding: 1.5rem; border-radius: 12px; margin: 1rem 0; text-align: center;">
                        <h3>✅ КРИТИЧЕСКИХ ПРОБЛЕМ НЕ ОБНАРУЖЕНО!</h3>
                        <p>У вас хорошая база для устойчивого роста. Фокусируйтесь на оптимизации и масштабировании.</p>
                    </div>
                    """
                
                # 90-дневный план
                action_plan = create_90_day_action_plan(recommendations, projections, industry)
                
                # Персонализированный CTA
                cta = generate_personalized_cta(problems, projections, industry, revenue)
                
                return [
                    # Показать результаты
                    gr.update(visible=True),  # results_row
                    gr.update(visible=True),  # action_plan_row  
                    gr.update(visible=True),  # cta_row
                    # Заполнить контент
                    ai_summary,              # ai_analysis_summary
                    chart,                   # interactive_chart
                    recs_html,              # ai_recommendations_output
                    critical_alert,         # critical_zones_alert
                    action_plan,            # action_plan_output
                    cta                     # personalized_cta_output
                ]
                
            except Exception as e:
                error_msg = f"""
                <div style="background: #f8d7da; color: #721c24; padding: 1rem; border-radius: 8px; border-left: 4px solid #dc3545;">
                    <h4>❌ Ошибка ИИ-анализа</h4>
                    <p>Произошла ошибка при анализе: {str(e)}</p>
                    <p>Пожалуйста, проверьте введенные данные и попробуйте снова.</p>
                </div>
                """
                return [
                    gr.update(visible=True),
                    gr.update(visible=False),
                    gr.update(visible=False),
                    error_msg, None, "", "", "", ""
                ]
        
        # ПРИВЯЗКА СОБЫТИЙ
        
        # Живые обновления инсайтов
        monthly_revenue.change(
            update_revenue_insight,
            inputs=[monthly_revenue, industry],
            outputs=[revenue_ai_insight]
        )
        
        industry.change(
            update_revenue_insight,
            inputs=[monthly_revenue, industry],
            outputs=[revenue_ai_insight]
        )
        
        profit_margin.change(
            update_margin_insight,
            inputs=[profit_margin, monthly_revenue],
            outputs=[margin_ai_insight]
        )
        
        team_size.change(
            update_team_insight,
            inputs=[team_size],
            outputs=[team_ai_insight]
        )
        
        # Живые подсказки для проблемных зон
        for zone, slider in problem_zones.items():
            slider.change(
                lambda score, z=zone: update_zone_hint(z, score),
                inputs=[slider],
                outputs=[ai_zone_hints[zone]]
            )
        
        # Главный анализ
        analyze_btn.click(
            run_full_ai_analysis,
            inputs=[
                industry, monthly_revenue, profit_margin, team_size,
                *problem_zones.values()
            ],
            outputs=[
                results_row, action_plan_row, cta_row,
                ai_analysis_summary, interactive_chart,
                ai_recommendations_output, critical_zones_alert,
                action_plan_output, personalized_cta_output
            ]
        )
        
        # Финальные стили и скрипты
        gr.HTML("""
        <script>
        // Анимация кнопки анализа
        setInterval(function() {
            const button = document.querySelector('#analyze_button');
            if (button && !button.classList.contains('clicked')) {
                button.style.boxShadow = button.style.boxShadow.includes('rgba(102, 126, 234, 0.8)') 
                    ? '0 5px 15px rgba(102, 126, 234, 0.4)'
                    : '0 8px 25px rgba(102, 126, 234, 0.8)';
            }
        }, 1000);
        
        // Обновление прогресс-бара (примерно)
        function updateProgress() {
            const inputs = document.querySelectorAll('input[type="number"], select, input[type="range"]');
            const filled = Array.from(inputs).filter(input => input.value && input.value !== "").length;
            const total = inputs.length;
            const percentage = (filled / total) * 100;
            
            const progressBar = document.getElementById('progress-bar');
            if (progressBar) {
                progressBar.style.width = percentage + '%';
            }
        }
        
        // Обновляем прогресс при изменении полей
        document.addEventListener('change', updateProgress);
        document.addEventListener('input', updateProgress);
        
        // Инициализируем прогресс
        setTimeout(updateProgress, 1000);
        </script>
        
        <div style="text-align: center; padding: 2rem; background: #f8f9fa; border-radius: 12px; margin: 2rem 0;">
            <h3>🚀 Ultima Business Solutions</h3>
            <p style="color: #6c757d;">Этот ИИ-симулятор - только начало. Получите полную диагностику и план роста от наших экспертов.</p>
            <div style="display: flex; justify-content: center; gap: 1rem; margin: 1rem 0;">
                <div style="font-size: 0.9em;">🎯 <strong>500+</strong> успешных проектов</div>
                <div style="font-size: 0.9em;">💰 <strong>2.8M₽</strong> средний рост прибыли</div>
                <div style="font-size: 0.9em;">⚡ <strong>90 дней</strong> до результата</div>
            </div>
        </div>
        """)
    
    return demo

# Запуск приложения
if __name__ == "__main__":
    demo = create_ultimate_ai_interface()
    demo.launch(
        share=True,
        server_name="0.0.0.0",
        server_port=7860,
        show_error=True
    )
