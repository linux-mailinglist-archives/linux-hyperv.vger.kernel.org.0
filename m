Return-Path: <linux-hyperv+bounces-11306-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLUsN5r1F2q5WAgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11306-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 09:58:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D835EE23D
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECB38301BCD4
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 07:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704E352028;
	Thu, 28 May 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Vibv4b2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N9krKUA1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iPU0Jk9T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GjZHsRQG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68490352033
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 07:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779954862; cv=none; b=nZKBIoZUoLeTCwqmjzHy4O+yv20bZhBF7CrjMoFnegFA66hHYNyYMyPDTUaT/1KrpD+kv0IZnNQRtvNPIx/8xy41V7HT2LJSid58gtr/dUQIOdgICg03p77KbbjtnZE/fwiWUF7dADvn0EFbV7Vw1XOBGBnnzLu7C2vL4jSUvqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779954862; c=relaxed/simple;
	bh=EV8yF7IKuRIViS0hsn4EyG1MflkEMwKRmcSfp15QYYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P30UyFO4fT7XLJp+mKqCfPo3366KhX+6uDQcC5uTAUPsCFSKN8MzJXwg7jKU/Eo1NCujr+Wem8Q6b0jXQgDdzo91T9nOZ4pEcp+MuvHIDX0TxAfqJoNO4eeN0S1lEKl0csnvSbWJq+MQXZgTBfWNPz4tc5JFn6YS50SP9Hg3Wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Vibv4b2t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N9krKUA1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iPU0Jk9T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GjZHsRQG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7382D6AAFF;
	Thu, 28 May 2026 07:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779954858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nIFtEp8XNRLMDTgplchOXvBKr/AWJ8CoFKLco2rj1TI=;
	b=Vibv4b2tN84Hue1lY0RmmIbay0Lyx5VmfDU2oMVp7/9PUXR9frjPzjsYaCKNT17GVHsOhU
	HeKNhTpIS/M1AxPNzQ3nLjM+krKdc9Q+Rfj5krHroMUW5F1xFqQPKrzlS34obps7+TNV9E
	A5jnPk4chUG8b73qNbd9OuRt7x3jACg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779954858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nIFtEp8XNRLMDTgplchOXvBKr/AWJ8CoFKLco2rj1TI=;
	b=N9krKUA1KgGc3J0zgor7SkZxGamN7dtY2O19CnV4Tb0qVyM411Dc+5BTPDISA6oUV2ogl5
	c9PvWIvgPZ+zLPBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iPU0Jk9T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GjZHsRQG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779954857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nIFtEp8XNRLMDTgplchOXvBKr/AWJ8CoFKLco2rj1TI=;
	b=iPU0Jk9TcyIT1jIz4sLNnE0aYJ6qPawt/UPUXEN9yt4ROET6SvgUupWCqOWqX7gSciX/+V
	e2eNcD7XgFoh9NTjUQzBCeduNHPCs76dFrrq6aS7OX0CWEF8C2I8SmZewmj9yl86SGls42
	ZLXAD8MvE/napEwcK4CKF58H7CHeztE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779954857;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nIFtEp8XNRLMDTgplchOXvBKr/AWJ8CoFKLco2rj1TI=;
	b=GjZHsRQGDCs4T6IyCm2heJ2vbAHLAVE4iA2S5CeM0lxNwxHGurTJT6nr8jkHYI+tFIMVEK
	hgktSEDhRZFqQLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A3715AC99;
	Thu, 28 May 2026 07:54:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w30pAan0F2qvZgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 07:54:17 +0000
Message-ID: <1d399c2d-b50f-4d19-8170-9db8961e4227@suse.de>
Date: Thu, 28 May 2026 09:54:16 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank
 interrupts
To: Julian Orth <ju.orth@gmail.com>
Cc: simona@ffwll.ch, airlied@gmail.com, mdaenzer@redhat.com,
 pekka.paalanen@collabora.com, jadahl@gmail.com, contact@emersion.fr,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mhklinux@outlook.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 wayland-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org
References: <20260527133917.207150-1-tzimmermann@suse.de>
 <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
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
In-Reply-To: <CAHijbEVZBRTK7yhZy8gaZwb19JMzUD_nA2S1LOKX2NrK19RBsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11306-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[ffwll.ch,gmail.com,redhat.com,collabora.com,emersion.fr,linux.intel.com,kernel.org,outlook.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,suse.com:url,people.freedesktop.org:url,suse.de:email,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: E7D835EE23D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 27.05.26 um 18:31 schrieb Julian Orth:
> On Wed, May 27, 2026 at 3:39 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
>> refresh. This is meaningless with vblank timers, which run unrelated
>> to the hardware's vblank.
>>
>> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
>> for CRTCs with simulated vblank events in all such drivers. The vblank
>> timers of these devices still rate-limit the number of page-flip events
>> to match the display refresh.
>>
>> According to maintainers, user-space compositors do not require the ioctl
>> for rate-limitting display output. Weston, Kwin and Mutter rely on completion
>> events. Mutter optionally uses the WAIT_VBLANK ioctl only to optimize the
>> time from input to output.
>>
>> When testing with mutter and weston, the page-flip rate appears correct
>> with the patch set applied.
> To avoid this being a regression, you need to test that this change
> does not regress input latency.

Let me stress that the current situation is that there's high-quality, 
and low-quality and no timing information. Depends on the driver and 
hardware.

>
> As discussed on IRC, compositors use vblank data to predict the time
> of the next flip event. For each device that you are touching here,
> there are two possibilities:
>
> - The vblank data is related to the flip timing, i.e. flip events and
> vblank events are sent at almost the same time. In this case removing
> these apis removes the path for compositors to predict the time of the
> next flip event. Input latency will therefore regress after idle
> periods when the compositor no longer has the time of the last vblank.

User-space compositors seem to operate under this assumption. That, I 
think, makes sense on better hardware with rendering and vblank IRQs. 
Page flips are fast on such systems.

>
> - The vblank data has nothing to do with the time of the next flip
> event. In this case this series could in fact improve latency because
> it removes the incorrect data from the compositor.

Most of the hardware that would use vblank timers falls in this 
category. Page flips often consist of memcpys into video memory, or they 
transfer pixel data over slow peripheral busses. The amount of work per 
page flip varies with the size of the damage rectangles.

Any vblank timing information here is therefore of low quality. For some 
scenarios, it would be common to miss a vblank or even the one after it.


IMHO, the first thing to discuss is whether having possibly low-quality 
timing information is preferable to having either high-quality timing or 
none. I have no strong opinion, but would tend to the latter.

Best regards
Thomas


>
> Whether the times of the flip events correspond to hardware timings is
> not relevant. Everything in wayland compositors is scheduled against
> flip event timings and they are also forwarded to clients for their
> frame scheduling. If the flip timings are wrong/out of sync with the
> hardware, then removing the vblank apis does not improve this
> situation.
>
>> This change has been discussed at length on IRC recently.
>>
>> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-08&show_html=true
>> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-12&show_html=true
>> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-13&show_html=true
>> https://people.freedesktop.org/~cbrill/dri-log/?channel=dri-devel&highlight_names=&date=2026-05-15&show_html=true
>>
>> v2:
>> - add filter to CRTC_GET_SEQUENCE and CRTC_QUEUE_SEQUENCE ioctls (Michel)
>> - clarify Mutter's behavior in cover letter (Michel)
>>
>> Thomas Zimmermann (9):
>>    drm/vblank: Add drmm_vblank_init() to indicate managed cleanup
>>    drm/vblank: Add DRM_VBLANK_FLAG_SIMULATED
>>    drm/amdgpu: vkms: Set DRM_VBLANK_FLAG_SIMULATED
>>    drm/bochs: Set DRM_VBLANK_FLAG_SIMULATED
>>    drm/cirrus: Set DRM_VBLANK_FLAG_SIMULATED
>>    drm/hypervdrm: Set DRM_VBLANK_FLAG_SIMULATED
>>    drm/qxl: Set DRM_VBLANK_FLAG_SIMULATED
>>    drm/virtgpu: Set DRM_VBLANK_FLAG_SIMULATED
>>    drm/vkms: Set DRM_VBLANK_FLAG_SIMULATED
>>
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c    |  3 ++-
>>   drivers/gpu/drm/drm_vblank.c                | 26 +++++++++++++++------
>>   drivers/gpu/drm/drm_vblank_helper.c         |  2 +-
>>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c |  2 +-
>>   drivers/gpu/drm/qxl/qxl_display.c           |  2 +-
>>   drivers/gpu/drm/tiny/bochs.c                |  2 +-
>>   drivers/gpu/drm/tiny/cirrus-qemu.c          |  2 +-
>>   drivers/gpu/drm/virtio/virtgpu_display.c    |  2 +-
>>   drivers/gpu/drm/vkms/vkms_drv.c             |  4 ++--
>>   include/drm/drm_crtc.h                      |  2 +-
>>   include/drm/drm_device.h                    |  2 +-
>>   include/drm/drm_vblank.h                    | 15 +++++++++++-
>>   12 files changed, 45 insertions(+), 19 deletions(-)
>>
>>
>> base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
>> --
>> 2.54.0
>>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



