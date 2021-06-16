using Microsoft.VisualStudio.TestTools.UnitTesting;
using Rent_A_Movie;


namespace MovieDBTest
{
    [TestClass]
    public class UnitTest1
    {
        [TestMethod]
        public void TestMethod1()
        {
            Database myDatabase = new Database();

            int Actual = myDatabase.FeeCalculation(2016, 2020);
            Assert.AreEqual(5, Actual);

        }

        [TestMethod]
        public void TestMethod2()
        {
            Database myDatabase = new Database();

            string Actual = myDatabase.UpdateMovie("382", "ABC", "Jaws", "1975", "When a gigantic great white shark begins to menace the small island community of Amity, a police chief, a marine scientist and grizzled fisherman set out to stop it.", "Adventure, Horror, Thriller");

            Assert.AreEqual("Movie Updated", Actual);

        }




    }
}
