import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:study_planner/shared/domain/enums/focus_sound_mode.dart';

/// Manages ambient background sound playback during study sessions.
///
/// Sound loops continuously while the session is active.
/// Calling [pause] stops playback without releasing the player so that
/// [resume] can pick up where it left off.
class SoundService {
  final AudioPlayer _player = AudioPlayer();

  FocusSoundMode _currentMode = FocusSoundMode.none;
  bool _isMuted = false;
  bool _isPlaying = false;

  bool get isMuted => _isMuted;
  bool get isPlaying => _isPlaying;
  FocusSoundMode get currentMode => _currentMode;

  Future<void> _applyVolume() async {
    await _player.setVolume(_isMuted ? 0.0 : 1.0);
  }

  /// Start (or restart) playback for [mode].
  ///
  /// Safe to call repeatedly with the same mode – it will no-op if the
  /// correct track is already playing.
  Future<void> play(FocusSoundMode mode) async {
    final path = mode.assetPath;

    if (path == null) {
      await stop();
      return;
    }

    // If the same mode is already loaded and playing just ensure volume is set.
    if (_currentMode == mode && _isPlaying) {
      await _applyVolume();
      return;
    }

    try {
      _currentMode = mode;
      _isPlaying = true;
      await _player.setReleaseMode(ReleaseMode.loop);
      await _applyVolume();
      await _player.play(AssetSource(path.replaceFirst('assets/', '')));
    } catch (e, st) {
      _isPlaying = false;
      debugPrint('[SoundService] play error: $e');
      debugPrintStack(stackTrace: st);
    }
  }

  /// Pause playback (keeps the track loaded).
  Future<void> pause() async {
    if (!_isPlaying) return;
    try {
      await _player.pause();
      _isPlaying = false;
    } catch (e) {
      debugPrint('[SoundService] pause error: $e');
    }
  }

  /// Resume a previously paused track.
  Future<void> resume() async {
    if (_isPlaying || _currentMode == FocusSoundMode.none) return;
    try {
      await _player.resume();
      _isPlaying = true;
    } catch (e) {
      debugPrint('[SoundService] resume error: $e');
    }
  }

  /// Stop playback completely and reset state.
  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      debugPrint('[SoundService] stop error: $e');
    } finally {
      _isPlaying = false;
      _currentMode = FocusSoundMode.none;
    }
  }

  /// Toggle mute without stopping the track.
  Future<void> toggleMute() async {
    _isMuted = !_isMuted;
    await _applyVolume();
  }

  /// Set mute state explicitly.
  Future<void> setMuted(bool muted) async {
    if (_isMuted == muted) return;
    _isMuted = muted;
    await _applyVolume();
  }

  /// Call when the app no longer needs the service.
  Future<void> dispose() async {
    await _player.dispose();
  }
}
