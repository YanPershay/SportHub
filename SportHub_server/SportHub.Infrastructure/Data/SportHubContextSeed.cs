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

                if (!await context.UsersInfo.AnyAsync())
                {
                    await context.UsersInfo.AddRangeAsync(GetUsersInfo());
                    await context.SaveChangesAsync();
                }

                if (!await context.Posts.AnyAsync())
                {
                    await context.Posts.AddRangeAsync(GetPosts());
                    await context.SaveChangesAsync();
                }

                if (!await context.PostCategories.AnyAsync())
                {
                    await context.PostCategories.AddRangeAsync(GetPostCategories());
                    await context.SaveChangesAsync();
                }

                if (!await context.AdminPosts.AnyAsync())
                {
                    await context.AdminPosts.AddRangeAsync(GetAdminPosts());
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

        private static Guid guid = Guid.Parse("3fa85f64-5717-4562-b3fc-2c963f66afa6");
        

        private static IEnumerable<User> GetUsers()
        {
            return new List<User>()
            {
                new User(guid, "yan_pershay", "yanpershay@gmail.com", "12345678", false, true)
            };
        }

        private static IEnumerable<UserInfo> GetUsersInfo()
        {
            return new List<UserInfo>()
            {
                new UserInfo("Yan", "Pershay", "Belarus", "Minsk", "27.01.2000", "Newer", 178, 75,
                "I like sport! I train every day!",
                "Up to 85kg",
                "https://sun9-52.userapi.com/impg/dGpjgpkRRVUZeKb8NCjJDkwjoVI_vSxj2WeDuQ/frO2qVmmqxk.jpg?size=960x1280&quality=96&sign=03354df4b6a772466325e5926f835506&type=album",
                guid)
            };
        }

        private static IEnumerable<Post> GetPosts()
        {
            return new List<Post>()
            {
                new Post("My first train!", "http://the-runners.com/wp-content/uploads/2017/02/62144-1024x682.jpg",
                DateTime.Now, false, guid)
            };
        }

        private static IEnumerable<PostCategory> GetPostCategories()
        {
            return new List<PostCategory>()
            {
                new PostCategory("Trains"),
                new PostCategory("Exercises"),
                new PostCategory("Food"),
                new PostCategory("Motivation"),
                new PostCategory("Medicine"),
                new PostCategory("Other")
            };
        }

        private static IEnumerable<AdminPost> GetAdminPosts()
        {
            return new List<AdminPost>()
            {
                new AdminPost(3, "Healthy food", "Eat healthy food please!!!", 3, 3,
                "https://fathom-news.com/wp-content/uploads/2021/03/02-Blog-Healthy-Food-L-1000x530.jpg",
                DateTime.Now, true, guid)
            };
        }
    }
}
