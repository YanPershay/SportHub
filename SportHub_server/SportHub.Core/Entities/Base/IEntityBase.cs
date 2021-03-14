using System;
using System.Collections.Generic;
using System.Text;

namespace SportHub.Core.Entities.Base
{
    public interface IEntityBase<TId>
    {
        TId Id { get; }
    }
}
