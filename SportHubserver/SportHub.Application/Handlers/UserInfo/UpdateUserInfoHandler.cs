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
    public class UpdateUserInfoHandler : IRequestHandler<UpdateUserInfoCommand, UserInfoResponse>
    {
        private readonly IUserInfoRepository _userInfoRepository;

        public UpdateUserInfoHandler(IUserInfoRepository userInfoRepository)
        {
            _userInfoRepository = userInfoRepository;
        }

        public async Task<UserInfoResponse> Handle(UpdateUserInfoCommand request, CancellationToken cancellationToken)
        {
            var userEntity = UserInfoMapper.Mapper.Map<UserInfo>(request);

            if (userEntity is null)
            {
                throw new ApplicationException("There is an issue with mapping");
            }

            var userInfo = await _userInfoRepository.GetUserInfoByGuidAsync(userEntity.UserId);

            userEntity.Id = userInfo.Id;

            await _userInfoRepository.UpdateAsync(userEntity);
            var userResponse = UserInfoMapper.Mapper.Map<UserInfoResponse>(userEntity);
            return userResponse;
        }
    }
}
