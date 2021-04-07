using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace SportHub.API.Interfaces
{
    public interface IJwtAuthenticationManager
    {
        Task<string> Authenticate(string userName, string password);
    }
}
