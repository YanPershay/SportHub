using SportHub.Core.Entities;
using SportHub.Core.Repositories.Base;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading.Tasks;

namespace SportHub.Core.Repositories
{
    public interface ISubscribeRepository : IRepository<Subscribe>
    {
        Task<IEnumerable<Subscribe>> GetMySubscribesByUserId(Guid subscriberId);
        Task<IEnumerable<Subscribe>> GetSubscribersByUserId(Guid id);
        Task<SubscriptionsCount> GetSubscriptionsCountByUserId(Guid userId);
        Task<int> GetSubscribersCountByUserId(Guid id);
        Task<int> GetMySubscribesCountByUserId(Guid subscriberId);
        Task<bool> IsUserSubscribed(Guid userId, Guid subscriberId);

    }
}
