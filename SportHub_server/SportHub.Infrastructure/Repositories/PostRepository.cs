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
            return await _context.Posts.Where(u => u.UserId.Equals(id)).ToListAsync();
        }
    }
}
