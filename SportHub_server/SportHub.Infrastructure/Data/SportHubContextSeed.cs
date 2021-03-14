using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Infrastructure.Data
{
    public class SportHubContextSeed
    {
        public static async Task SeedAsync(SportHubContext context, ILoggerFactory loggerFactory, int? retry = 0)
        {
            int retryForAvailability = retry.Value;

            try
            {
                await context.Database.EnsureCreatedAsync();

                if (!await context.Users.AnyAsync())
                {
                    await context.Users.AddRangeAsync(GetUsers());
                    await context.SaveChangesAsync();
                }
            }
            catch(Exception ex)
            {
                if(retryForAvailability < 3)
                {
                    retryForAvailability++;
                    var log = loggerFactory.CreateLogger<SportHubContextSeed>();
                    log.LogError($"Exception occured while connecting: {ex.Message}");
                    await SeedAsync(context, loggerFactory, retryForAvailability);
                }
            }
        }

        private static IEnumerable<User> GetUsers()
        {
            return new List<User>()
            {
                new User
                {
                    UserId = new Guid(),
                    Username = "yan_pershay",
                    Email = "yanpershay@gmail.com",
                    Password = "12345678",
                    IsOnline = false,
                    IsAdmin = true
                }
            };
        }
    }
}
