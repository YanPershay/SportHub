using MediatR;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using SportHub.Application.Queries;
using SportHub.Application.Responses;
using SportHub.Infrastructure.Data;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using BC = BCrypt.Net.BCrypt;

namespace SportHub.API.JwtMiddlewareTest
{
    public class UserService : IUserService
    {

        private readonly AppSettings _appSettings;
        private readonly SportHubContext _context;
        private readonly IMediator _mediator;

        public UserService(IOptions<AppSettings> appSettings, SportHubContext context, IMediator mediator)
        {
            _appSettings = appSettings.Value;
            _context = context;
            _mediator = mediator;
        }

        public AuthenticateResponse Authenticate(AuthenticateRequest model)
        {
            var user = _context.Users.SingleOrDefault(x => x.Username == model.Username);

            // return null if user not found
            if (user == null || !BC.Verify(model.Password, user.Password)) return null;

            var userResponse = new UserResponse
            {
                GuidId = user.GuidId,
                Username = user.Username,
                IsTrainer = user.IsTrainer,
                Email = user.Email
            };
            // authentication successful so generate jwt token
            var token = GenerateJwtToken(userResponse);

            return new AuthenticateResponse(userResponse, token);
        }

        public async Task<UserResponse> GetUserById(Guid userId)
        {
            var query = new GetUserByGuidQuery(userId);
            return await _mediator.Send(query);
        }

        // helper methods

        private string GenerateJwtToken(UserResponse user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_appSettings.Secret);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new[] { new Claim("guidId", user.GuidId.ToString()) }),
                Expires = DateTime.UtcNow.AddDays(900),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
