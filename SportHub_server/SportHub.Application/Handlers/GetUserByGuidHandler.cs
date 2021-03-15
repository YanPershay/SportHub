using MediatR;
using SportHub.Application.Mappers;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class GetUserByGuidHandler : IRequestHandler<GetUserByGuidQuery, UserResponse>
    {
        private readonly IUserRepository _userRepository;

        public GetUserByGuidHandler(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<UserResponse> Handle(GetUserByGuidQuery request, CancellationToken cancellationToken)
        {
            var user = await _userRepository.GetUserByGuidAsync(request.GuidId);
            var userResponse = UserMapper.Mapper.Map<UserResponse>(user);
            return userResponse;
        }
    }
}
