using Testcontainers.K3s;
using DotNet.Testcontainers.Containers;
using System;
using Microsoft.Extensions.Logging;
using DotNet.Testcontainers.Images;
using System.Threading.Tasks;
using DotNet.Testcontainers.Configurations;
using System.Threading;
using System.IO;
using System.Collections.Generic;

namespace TestcontainersPwsh.K3s
{
    public class WrappedK3sContainer : IContainer
    {
        private readonly K3sContainer _originalContainer;

        public WrappedK3sContainer()
        {
            _originalContainer = new K3sBuilder().Build();
        }

        #region IContainer
        public DateTime CreatedTime => _originalContainer.CreatedTime;
        public DateTime StartedTime => _originalContainer.StartedTime;
        public DateTime StoppedTime => _originalContainer.StoppedTime;
        public ILogger Logger => _originalContainer.Logger;
        public string Id => _originalContainer.Id;
        public string Name => _originalContainer.Name;
        public string IpAddress => _originalContainer.IpAddress;
        public string MacAddress => _originalContainer.MacAddress;
        public string Hostname => _originalContainer.Hostname;
        public IImage Image => _originalContainer.Image;
        public TestcontainersStates State => _originalContainer.State;
        public TestcontainersHealthStatus Health => _originalContainer.Health;
        public long HealthCheckFailingStreak => _originalContainer.HealthCheckFailingStreak;

        public event EventHandler Creating {
            add => _originalContainer.Creating += value;
            remove => _originalContainer.Creating -= value;
        }

        public event EventHandler Starting {
            add => _originalContainer.Starting += value;
            remove => _originalContainer.Starting -= value;
        }
        public event EventHandler Stopping {
            add => _originalContainer.Stopping += value;
            remove => _originalContainer.Stopping -= value;
        }
        public event EventHandler Created {
            add => _originalContainer.Created += value;
            remove => _originalContainer.Created -= value;
        }
        public event EventHandler Started {
            add => _originalContainer.Started += value;
            remove => _originalContainer.Started -= value;
        }
        public event EventHandler Stopped {
            add => _originalContainer.Stopped += value;
            remove => _originalContainer.Stopped -= value;
        }

        public Task CopyAsync(byte[] fileContent, string filePath, UnixFileModes fileMode = UnixFileModes.OtherRead | UnixFileModes.GroupRead | UnixFileModes.UserWrite | UnixFileModes.UserRead, CancellationToken ct = default)
        {
            return _originalContainer.CopyAsync(fileContent, filePath, fileMode, ct);
        }

        public Task CopyAsync(string source, string target, UnixFileModes fileMode = UnixFileModes.OtherRead | UnixFileModes.GroupRead | UnixFileModes.UserWrite | UnixFileModes.UserRead, CancellationToken ct = default)
        {
            return _originalContainer.CopyAsync(source, target, fileMode, ct);
        }

        public Task CopyAsync(DirectoryInfo source, string target, UnixFileModes fileMode = UnixFileModes.OtherRead | UnixFileModes.GroupRead | UnixFileModes.UserWrite | UnixFileModes.UserRead, CancellationToken ct = default)
        {
            return _originalContainer.CopyAsync(source, target, fileMode, ct);
        }

        public Task CopyAsync(FileInfo source, string target, UnixFileModes fileMode = UnixFileModes.OtherRead | UnixFileModes.GroupRead | UnixFileModes.UserWrite | UnixFileModes.UserRead, CancellationToken ct = default)
        {
            return _originalContainer.CopyAsync(source, target, fileMode, ct);
        }

        public ValueTask DisposeAsync() => _originalContainer.DisposeAsync();

        public Task<ExecResult> ExecAsync(IList<string> command, CancellationToken ct = default)
        {
            return _originalContainer.ExecAsync(command,ct);
        }

        public Task<long> GetExitCodeAsync(CancellationToken ct = default)
        {
            return _originalContainer.GetExitCodeAsync(ct);
        }

        public Task<(string Stdout, string Stderr)> GetLogsAsync(DateTime since = default, DateTime until = default, bool timestampsEnabled = true, CancellationToken ct = default)
        {
            return _originalContainer.GetLogsAsync(since,until,timestampsEnabled,ct);
        }

        public ushort GetMappedPublicPort(int containerPort)
        {
            return _originalContainer.GetMappedPublicPort(containerPort);
        }

        public ushort GetMappedPublicPort(string containerPort)
        {
            return _originalContainer.GetMappedPublicPort(containerPort);
        }

        public Task<byte[]> ReadFileAsync(string filePath, CancellationToken ct = default)
        {
            return _originalContainer.ReadFileAsync(filePath,ct);
        }

        public Task StartAsync(CancellationToken ct = default)
        {
            return _originalContainer.StartAsync(ct);
        }

        public Task StopAsync(CancellationToken ct = default)
        {
            return _originalContainer.StopAsync(ct);
        }
        #endregion IContainer

        public async Task<string> GetKubeconfigAsync() {
            return await _originalContainer.GetKubeconfigAsync();
        }

        public string GetKubeconfig()
        {
            return _originalContainer.GetKubeconfigAsync().GetAwaiter().GetResult();
        }
    }
}
