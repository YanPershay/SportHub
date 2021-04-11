using Microsoft.EntityFrameworkCore;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using SportHub.Infrastructure.Data;
using SportHub.Infrastructure.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Infrastructure.Repositories
{
    public class PostRepository : Repository<Post>, IPostRepository
    {
        public PostRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<IEnumerable<Post>> GetPostsByGuidAsync(Guid id)
        {
            return await _context.Posts.Where(u => u.UserId.Equals(id)).Include(u => u.User).Include(p=>p.Likes).Include(p => p.Comments).ToListAsync();
        }

        public async Task<IEnumerable<Post>> GetSubscribesPosts(Guid subscriberId)
        {
            var posts = new List<Post>();
            var subscribes = await _context.Subscribes.Where(s => s.SubscriberId.Equals(subscriberId)).ToListAsync();
            foreach (var user in subscribes)
            {
                var res = await _context.Posts.Include(p => p.Likes).Include(p => p.Comments).Include(u => u.User).ThenInclude(u => u.UserInfo).FirstOrDefaultAsync(u => u.UserId.Equals(user.UserId));
                posts.Add(res);
            }

            return posts;
        }

        public async Task<IEnumerable<Post>> GetSavedPosts(Guid userId)
        {
            var posts = new List<Post>();
            var savedPosts = await _context.SavedPosts.Where(s => s.UserId.Equals(userId)).ToListAsync();
            foreach (var savedPost in savedPosts)
            {
                var res = await _context.Posts.Include(p => p.Likes).Include(p => p.Comments).Include(u => u.User).ThenInclude(u => u.UserInfo).FirstOrDefaultAsync(u => u.Id.Equals(savedPost.PostId));
                posts.Add(res);
            }

            return posts;
        }
    }
}
