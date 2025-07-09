@isTest
public class TestVerifyDate {
    @isTest static void testDateWithin30Days() {
        Date today = Date.today();
        Date within30 = today.addDays(15);
        Date after30 = today.addDays(31);
        Date beforeToday = today.addDays(-1);

        // Test date2 within 30 days of date1: should return date2
        Date result1 = VerifyDate.CheckDates(today, within30);
        System.assertEquals(within30, result1, 'Date within 30 days should return date2');

        // Test date2 after 30 days: should return end of month of date1
        Date result2 = VerifyDate.CheckDates(today, after30);
        Date expectedEndOfMonth = Date.newInstance(today.year(), today.month(), Date.daysInMonth(today.year(), today.month()));
        System.assertEquals(expectedEndOfMonth, result2, 'Date after 30 days should return end of month');

        // Test date2 before date1: should return end of month of date1
        Date result3 = VerifyDate.CheckDates(today, beforeToday);
        System.assertEquals(expectedEndOfMonth, result3, 'Date before date1 should return end of month');
    }

    @isTest static void testEndOfMonthForDifferentMonths() {
        // Test end of month for February (non-leap year)
        Date febDate = Date.newInstance(2023, 2, 10);
        Date endOfFeb = VerifyDate.CheckDates(febDate, febDate.addDays(31));
        System.assertEquals(Date.newInstance(2023, 2, 28), endOfFeb);

        // Test end of month for February (leap year)
        Date leapFebDate = Date.newInstance(2024, 2, 10);
        Date endOfLeapFeb = VerifyDate.CheckDates(leapFebDate, leapFebDate.addDays(31));
        System.assertEquals(Date.newInstance(2024, 2, 29), endOfLeapFeb);

        // Test end of month for April (30 days)
        Date aprilDate = Date.newInstance(2023, 4, 1);
        Date endOfApril = VerifyDate.CheckDates(aprilDate, aprilDate.addDays(40));
        System.assertEquals(Date.newInstance(2023, 4, 30), endOfApril);
    }
}