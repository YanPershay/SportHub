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
    class GetUserInfoByGuidHandler : IRequestHandler<GetUserInfoByGuidQuery, UserInfoResponse>
    {
        private readonly IUserInfoRepository _userInfoRepository;

        public GetUserInfoByGuidHandler(IUserInfoRepository userInfoRepository)
        {
            _userInfoRepository = userInfoRepository;
        }

        public async Task<UserInfoResponse> Handle(GetUserInfoByGuidQuery request, CancellationToken cancellationToken)
        {
            var user = await _userInfoRepository.GetUserInfoByGuidAsync(request.UserId);
            var userInfoResponse = UserInfoMapper.Mapper.Map<UserInfoResponse>(user);
            return userInfoResponse;
        }
    }
}
