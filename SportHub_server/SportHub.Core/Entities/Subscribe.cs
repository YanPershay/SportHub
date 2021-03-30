using SportHub.Core.Entities.Base;
using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities
{
    public class Subscribe : Entity
    {
        public Guid UserId{ get; set; }
        public User User { get; set; }

        public Guid SubscriberId { get; set; }
        public User Subscriber { get; set; }

        public Subscribe(Guid userId, Guid subscruberId)
        {
            UserId = userId;
            SubscriberId = subscruberId;
        }
    }
}
