using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class IsUsernameBusyHandler : IRequestHandler<IsUsernameBusyQuery, bool>
    {
        private readonly IUserRepository _userRepository;

        public IsUsernameBusyHandler(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<bool> Handle(IsUsernameBusyQuery request, CancellationToken cancellationToken)
        {
            var isUserNameBusy = await _userRepository.IsUsernameBusy(request.Username);
            var isUserNameBusyResponse = UserMapper.Mapper.Map<bool>(isUserNameBusy);
            return isUserNameBusyResponse;
        }
    }
}
