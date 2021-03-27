using MediatR;
using SportHub.Application.Commands;
using SportHub.Application.Mappers;
using SportHub.Application.Responses;
using SportHub.Core.Entities;
using SportHub.Core.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace SportHub.Application.Handlers
{
    public class CreateUserInfoHandler : IRequestHandler<CreateUserInfoCommand, UserInfoResponse>
    {
        private readonly IUserInfoRepository _userInfoRepository;

        public CreateUserInfoHandler(IUserInfoRepository userInfoRepository)
        {
            _userInfoRepository = userInfoRepository;
        }

        public async Task<UserInfoResponse> Handle(CreateUserInfoCommand request, CancellationToken cancellationToken)
        {
            var userEntity = UserInfoMapper.Mapper.Map<UserInfo>(request);

            if (userEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var newUser = await _userInfoRepository.AddAsync(userEntity);
            var userResponse = UserInfoMapper.Mapper.Map<UserInfoResponse>(newUser);
            return userResponse;
        }
    }
}
