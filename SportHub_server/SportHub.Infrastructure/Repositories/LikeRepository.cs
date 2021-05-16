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
    public class LikeRepository : Repository<Like>, ILikeRepository
    { 
        public LikeRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<int> GetLikesCountByPostIdAsync(int id)
        {
            return await _context.Likes.Where(l => l.PostId == id).CountAsync();
        }
    }
}
