Return-Path: <linux-hyperv+bounces-11246-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO2FEh4MF2oR2gcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11246-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:22:06 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9625E6CA4
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 17:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C23303DD1D
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154841A9F87;
	Wed, 27 May 2026 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zd4OU75J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hflNZb+8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Zd4OU75J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hflNZb+8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B923176EE
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779895051; cv=none; b=gdFP7BcGg1mnTJT+X1QIU2kMcZ9NNUDX5G7S1EEmuP19kCKcO3sHysJtM8O9BFER4EESuWpy5RHAikoIr3+PVMl85djxKozVoUaybOmKzRCG7B0UPB1E1sbBn9fIWAkgxPlEIaZFkzlpQy3p+tKZMLe2CWGxuXNj+atXZ5J8mAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779895051; c=relaxed/simple;
	bh=OoMgu8lc4ZCQhTa+NKdwxlwIbrqthTdX7mEVcaRKtLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ajvxh4+J0rTrgLbC228E0T28A2VZACfcZ1yB/VfFNwuw4dXVhtSINwTvbZetDVfsRunLZlonQZPh1yDbENul8qvqVCsqm+DkkuXiwm0SAMzm7UDsTPMjSmfUFVPumTrpzQNzSvYx1btcBLRPFaaAsaQH8MP2u4ZcTgD/dj71Axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zd4OU75J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hflNZb+8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Zd4OU75J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hflNZb+8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 053AB6AA37;
	Wed, 27 May 2026 15:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779895048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GpmrI14U1zRKg9Ft8HCdKifIOo3atbqffDM/wjrE0sE=;
	b=Zd4OU75JnmqVM0QH1YVMAYVh2GO3JhgIo2g5fzm5k8Yy9+AGyj0XfK3nr/B69yzYq/YFXm
	t4Cw/q9r27+oXrEK2AfPuY77Eq/wfHyNjPqBrIIIE+pS7B1IsnZl+mSWQ7uXT4GhwWSJXI
	IAjKhNkm8jQ4HFYexUNiZ3u4Gn0U3UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779895048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GpmrI14U1zRKg9Ft8HCdKifIOo3atbqffDM/wjrE0sE=;
	b=hflNZb+8oVB2a+7/Iz3RBlSMhoxMfTaSZ13xqcKmRCZMT30z3xcle53Dk+i3EUsTjraod+
	m8MtH/jWlalsJgCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779895048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GpmrI14U1zRKg9Ft8HCdKifIOo3atbqffDM/wjrE0sE=;
	b=Zd4OU75JnmqVM0QH1YVMAYVh2GO3JhgIo2g5fzm5k8Yy9+AGyj0XfK3nr/B69yzYq/YFXm
	t4Cw/q9r27+oXrEK2AfPuY77Eq/wfHyNjPqBrIIIE+pS7B1IsnZl+mSWQ7uXT4GhwWSJXI
	IAjKhNkm8jQ4HFYexUNiZ3u4Gn0U3UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779895048;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GpmrI14U1zRKg9Ft8HCdKifIOo3atbqffDM/wjrE0sE=;
	b=hflNZb+8oVB2a+7/Iz3RBlSMhoxMfTaSZ13xqcKmRCZMT30z3xcle53Dk+i3EUsTjraod+
	m8MtH/jWlalsJgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B0845A8C2;
	Wed, 27 May 2026 15:17:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dT6MHAcLF2qmFgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 15:17:27 +0000
Message-ID: <ed56eba9-8a34-4f17-b400-0ebf538ebcb4@suse.de>
Date: Wed, 27 May 2026 17:17:27 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] drm: Improve logic behind damage handling
To: mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 airlied@redhat.com, airlied@gmail.com, simona@ffwll.ch, admin@kodeit.net,
 gargaditya08@proton.me, paul@crapouillou.net, jani.nikula@linux.intel.com,
 mhklinux@outlook.com, zack.rusin@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mips@vger.kernel.org, virtualization@lists.linux.dev
References: <20260527145113.241595-1-tzimmermann@suse.de>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260527145113.241595-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11246-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linux.intel.com,redhat.com,gmail.com,ffwll.ch,kodeit.net,proton.me,crapouillou.net,outlook.com,broadcom.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18]
X-Rspamd-Queue-Id: 9F9625E6CA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 27.05.26 um 16:46 schrieb Thomas Zimmermann:
> DRM clients can supply information on framebuffer areas to update as
> part of each page flip, called damage clipping rectangles. But DRM's
> processing of this information is inconsistent and prone to errors.
>
> - There are multiple fields and tests that decide if damage clips
> should be taken or ignored.
>
> - Sometimes damage clips are removed behind the back of the DRM client.
>
> - Atomic helpers evaluate damage clipping in the middle of the atomic
> check: after connectors and encoders, but before planes and CRTCs. Hence
> pipeline stages have an inconsistent view.
>
> - Which leads to drivers (ingenic) doing a re-evaluation if necessary.
>
> - Tests of plane source coordinates only happen during commits. At this
> point, the driver should already know if damage clips are to be taken or
> not. Because of this, some drivers (appletbdrm) might operate on incorrect
> damage information for their internal workings. This also leads to excessive
> use of the old plane state.
>
> Therefore go through DRM helpers and drivers and fix the logic.
>
> - Run all of the atomic checks with the damage information supplied by
> DRM clients. Afterwards evaluate plane and CRTC states on whether to
> take or ignore damage clips. Do all related tests in a single atomic
> helper.
>
> - Do not discard damage clips. Set ignore_damage_clips in struct
> drm_plane_state instead. This includes changes to plane source-coordinates.
> The damage iterator now only has to look at this flag to detect if it
> should use the damage clips.
>
> - Go over drivers and fix the damage handling in the plane's
> atomic_update helpers. Most drivers no longer need the old plane state
> in their update.
>
> - The appletbdrm driver requires a fix in how it uses damage information.
> Ingenic and vmwgfx can be simplified. These changes improve the drivers'
> code organization.
>
> - Kunit tests require some changes. Drop some obsolete tests and add a new
> one for ignore_damage_flags.
>
> Tested with bochs, mgag200, Kunit tests.
>
> v3:
> - fix error path in appletbdrm
> v2:
> - rebase on latest upstream
>
> Thomas Zimmermann (10):
>    drm/damage-helper: Do not alter damage clips on modeset, but ignore
>      them
>    drm/atomic-helpers: Evaluate plane damage after atomic_check
>    drm/ingenic: Remove calls to drm_atomic_helper_check_plane_damage()
>    drm/damage-helper: Test src coord in
>      drm_atomic_helper_check_plane_damage()
>    drm/appletbdrm: Allocate request/response buffers in begin_fb_access
>    drm/damage-helper: Remove old state from
>      drm_atomic_helper_damage_iter_init()
>    drm/damage-helper: Remove old state from
>      drm_atomic_helper_damage_merged()
>    drm/atomic_helper: Do not evaluate plane damage before atomic_check
>    drm/damage-helper: Rename state parameters in damage helpers
>    drm/vmwgfx: Remove unused field struct
>      vmwgfx_du_update_plane.old_state
>
>   drivers/gpu/drm/ast/ast_cursor.c              |   3 +-
>   drivers/gpu/drm/ast/ast_mode.c                |   2 +-
>   drivers/gpu/drm/drm_atomic_helper.c           |   6 +-
>   drivers/gpu/drm/drm_atomic_state_helper.c     |   1 +
>   drivers/gpu/drm/drm_damage_helper.c           |  44 ++--
>   drivers/gpu/drm/drm_fb_dma_helper.c           |   2 +-
>   drivers/gpu/drm/drm_mipi_dbi.c                |   3 +-
>   drivers/gpu/drm/gud/gud_pipe.c                |   3 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c   |   3 +-
>   drivers/gpu/drm/i915/display/intel_plane.c    |  11 +-
>   drivers/gpu/drm/i915/display/intel_psr.c      |   3 +-
>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |   3 -
>   drivers/gpu/drm/ingenic/ingenic-ipu.c         |   8 +-
>   drivers/gpu/drm/mgag200/mgag200_mode.c        |   3 +-
>   drivers/gpu/drm/sitronix/st7571.c             |   3 +-
>   drivers/gpu/drm/sitronix/st7586.c             |   3 +-
>   drivers/gpu/drm/sitronix/st7920.c             |   3 +-
>   drivers/gpu/drm/solomon/ssd130x.c             |   9 +-
>   drivers/gpu/drm/sysfb/drm_sysfb_modeset.c     |   3 +-
>   .../gpu/drm/tests/drm_damage_helper_test.c    | 200 +++---------------
>   drivers/gpu/drm/tiny/appletbdrm.c             |  59 +++---
>   drivers/gpu/drm/tiny/bochs.c                  |   3 +-
>   drivers/gpu/drm/tiny/cirrus-qemu.c            |   2 +-
>   drivers/gpu/drm/tiny/gm12u320.c               |   2 +-
>   drivers/gpu/drm/tiny/ili9225.c                |   3 +-
>   drivers/gpu/drm/tiny/repaper.c                |   2 +-
>   drivers/gpu/drm/tiny/sharp-memory.c           |   3 +-
>   drivers/gpu/drm/udl/udl_modeset.c             |   3 +-
>   drivers/gpu/drm/virtio/virtgpu_plane.c        |   2 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.c           |   5 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_kms.h           |   2 -
>   drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c          |  12 +-
>   drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c          |  15 +-
>   include/drm/drm_damage_helper.h               |   9 +-
>   34 files changed, 123 insertions(+), 315 deletions(-)
>
>
> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



