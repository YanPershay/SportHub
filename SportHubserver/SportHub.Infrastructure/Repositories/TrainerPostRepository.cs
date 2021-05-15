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
    public class TrainerPostRepository : Repository<TrainerPost>, ITrainerPostRepository
    {
        public TrainerPostRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<IEnumerable<TrainerPost>> GetTrainerPostsAsync()
        {
            return await _context.TrainerPosts.Include(p => p.User).OrderByDescending(p => p.DateCreated).ToListAsync();
        }
    }
}
