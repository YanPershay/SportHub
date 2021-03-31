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
    public class SubscribeRepository : Repository<Subscribe>, ISubscribeRepository
    {
        public SubscribeRepository(SportHubContext context) : base(context)
        {

        }

        public async Task<IEnumerable<Subscribe>> GetSubscribersByUserId(Guid id)
        {
            return await _context.Subscribes.Where(s => s.UserId.Equals(id)).ToListAsync();
        }

        public async Task<IEnumerable<Subscribe>> GetMySubscribesByUserId(Guid subscriberId)
        {
            return await _context.Subscribes.Where(s => s.SubscriberId.Equals(subscriberId)).ToListAsync();
        }

        public async Task<int> GetSubscribersCountByUserId(Guid id)
        {
            return await _context.Subscribes.Where(l => l.UserId == id).CountAsync();
        }

        public async Task<int> GetMySubscribesCountByUserId(Guid subscriberId)
        {
            return await _context.Subscribes.Where(l => l.SubscriberId == subscriberId).CountAsync();
        }
    }
}
