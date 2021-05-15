using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities.Base
{
    public abstract class EntityBase<TId> : IEntityBase<TId>
    {
        public virtual TId Id { get; set; }
    }
}
