using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SportHub.Core.Entities;
using System;
using System.Collections.Generic;
using BC = BCrypt.Net.BCrypt;
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

                if (!await context.TrainerPosts.AnyAsync())
                {
                    await context.TrainerPosts.AddRangeAsync(GetTrainerPosts());
                    await context.SaveChangesAsync();
                }

                if (!await context.Comments.AnyAsync())
                {
                    await context.Comments.AddRangeAsync(GetComments());
                    await context.SaveChangesAsync();
                }

                if (!await context.Likes.AnyAsync())
                {
                    await context.Likes.AddRangeAsync(GetLikes());
                    await context.SaveChangesAsync();
                }

                if (!await context.Subscribes.AnyAsync())
                {
                    await context.Subscribes.AddRangeAsync(GetSubscribes());
                    await context.SaveChangesAsync();
                }

                if (!await context.SavedPosts.AnyAsync())
                {
                    await context.SavedPosts.AddRangeAsync(GetSavedPosts());
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
        private static Guid guid2 = Guid.Parse("aa3cca72-8fac-4e55-b2ac-d0f59f6a1d7e");

        private const int postId = 1;
        private const int postId2 = 2;

        private static IEnumerable<User> GetUsers()
        {
            return new List<User>()
            {
                new User(guid, "yan_pershay", "yanpershay@gmail.com", BC.HashPassword("12345678"), true),
                new User(guid2, "semenomin", "semenomin@gmail.com", BC.HashPassword("12345678"), true)
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
                guid),

                new UserInfo("Semen", "Pilik", "Belarus", "Minsk", "09.12.1999", "Newer", 178, 75,
                "I like sport! I train every day!",
                "Up to 55kg",
                "https://sun9-51.userapi.com/impf/c851224/v851224926/2c9bd/HxYwQOl1Wv4.jpg?size=1728x2160&quality=96&sign=38505411f40b2ce859a2d163946dec11&type=album",
                guid2)
            };
        }

        private static IEnumerable<Post> GetPosts()
        {
            return new List<Post>()
            {
                new Post("My first train!", "https://sun1.dataix-by-minsk.userapi.com/impg/VIWGCAkv3MbHRH2nxLCjApCLpIDvhonvfhW6LQ/0ViatiAspkU.jpg?size=1080x1080&quality=96&sign=319717f69260eb5678a1154d61f718bf&type=album",
                DateTime.Now, guid),
                new Post("My second train!", "https://freehealthnewz.com/wp-content/uploads/2018/10/eb02e74720dd9168d7b3ff86716de02a.jpg",
                DateTime.Now, guid2)
            };
        }

        private static IEnumerable<TrainerPost> GetTrainerPosts()
        {
            return new List<TrainerPost>()
            {
                new TrainerPost("Healthy food", "Eat healthy food please!!!", 3, 4,
                "https://fathom-news.com/wp-content/uploads/2021/03/02-Blog-Healthy-Food-L-1000x530.jpg",
                DateTime.Now, guid)
            };
        }

        private static IEnumerable<Comment> GetComments()
        {
            return new List<Comment>()
            {
                new Comment("Nice train dude!", DateTime.Now, guid, postId),
                 new Comment("Nice train dude!", DateTime.Now, guid2, postId2)
            };
        }

        private static IEnumerable<Like> GetLikes()
        {
            return new List<Like>()
            {
                new Like(guid, postId),
                new Like(guid2, postId2)
            };
        }

        private static IEnumerable<Subscribe> GetSubscribes()
        {
            return new List<Subscribe>()
            {
                new Subscribe(guid, guid2)
            };
        }

        private static IEnumerable<SavedPost> GetSavedPosts()
        {
            return new List<SavedPost>()
            {
                new SavedPost(guid, postId),
                new SavedPost(guid2, postId2)
            };
        }
    }
}
