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
    public class SearchUserHandler : IRequestHandler<SearchUserQuery, IEnumerable<UserResponse>>
    {
        private readonly IUserRepository _userRepository;

        public SearchUserHandler(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<IEnumerable<UserResponse>> Handle(SearchUserQuery request, CancellationToken cancellationToken)
        {
            var user = await _userRepository.SearchUserAsync(request.SearchString);
            var userResponse = UserMapper.Mapper.Map<IEnumerable<UserResponse>>(user);
            return userResponse;
        }
    }
}
