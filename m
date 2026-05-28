Return-Path: <linux-hyperv+bounces-11305-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLUBLjvgF2rxTggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11305-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:27:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC805ED462
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 22A313010606
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 06:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA3632FA2B;
	Thu, 28 May 2026 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d8pBGsQu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nwK/O7MD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V2CnhzN+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HUdrrIFV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA8932C316
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 06:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949623; cv=none; b=NXpjkKNWaK+3MjJkneRr81ssCREuF0HOa3vhaBk8JBKhVL81VX1o1BrXw35W8QPhV7gV3NyP4rqyYqS0zC59iMPdqOWSyP2pmJYg70Y7e+MoFH14zy3WQFnj6peRxkpwwtZkGoOrmC6791kJr+kZV8SnGsQ+mZdz466OednNTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949623; c=relaxed/simple;
	bh=RkB8zVS4nRXyHYj7g/gRXe5bdl9fvscMxla7Qghq11A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mw/HhVrR0o3fvtjsm4nzPi/YyQjhCXI88k5r/JWNuoeLYa+3eH9kRqmPc+FXPhAXpC7kAA0X+reEbMlDziWpbFgGzFY5WFOqtBeiC/u7ll2PctXmM8FlEk1Z1F3OZdak9oVIDlxT4fbR8NfjRxKkKX44ELbbNlCzN4rIQAwFdHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d8pBGsQu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nwK/O7MD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V2CnhzN+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HUdrrIFV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E5A8A672AF;
	Thu, 28 May 2026 06:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779949615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ekO+IfVzmyu3akfxeO+hwC59c6WXPcfrFrNRtYEq/+U=;
	b=d8pBGsQuwe5x4IMuk4uZPTfZ0F10GJ4vSON7cLzpJ6F/97c8OL94pDDLwzHuNQ8fgXawCn
	WkRUiMXNvbHhnAyYWAUNolgjaQ9rDK/Jvu/OXuX0z7WitLkKAsN7FJerdsybve2QDBwTPy
	r59EFtG+ED2pso85bC/MsdWUKqoEt9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779949615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ekO+IfVzmyu3akfxeO+hwC59c6WXPcfrFrNRtYEq/+U=;
	b=nwK/O7MDlSW5yT+pjQ8L9HumZKjGI4Ky8xzTIeM455jIHUqxy1EijpMs1Mf5EoNnH4WWPh
	yMQlLaY+BBMyUbAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V2CnhzN+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HUdrrIFV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779949614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ekO+IfVzmyu3akfxeO+hwC59c6WXPcfrFrNRtYEq/+U=;
	b=V2CnhzN+/j1njcALid/BiqKatsEKHd5UEJCMh1eFecz6/MLFJjvD7ch/3vMSWZdE52AaNt
	RkfaIEGHYuV257iD/TlCiTD9roC5TQud5DNAimjHOktZeCfy8cnyBvA0n5bBXpkSz2IePN
	AqqOcUpXbImTFoFZDAByleRmszBL5Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779949614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ekO+IfVzmyu3akfxeO+hwC59c6WXPcfrFrNRtYEq/+U=;
	b=HUdrrIFVUNXmp1ulXzKVeF85CUbmlaNneOEclNqP8DHhny/FhiosJLU2OEZnWdcyU3JBvQ
	iWvV+02Opmze88AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71D455AC42;
	Thu, 28 May 2026 06:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dBYdGi7gF2pPEAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 06:26:54 +0000
Message-ID: <9a97aec6-a9b3-466b-bd28-57d5d19bfcc1@suse.de>
Date: Thu, 28 May 2026 08:26:53 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] drm/appletbdrm: Allocate request/response
 buffers in begin_fb_access
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, Aditya Garg <gargaditya08@proton.me>,
 Aun-Ali Zaidi <admin@kodeit.net>
References: <20260527145113.241595-6-tzimmermann@suse.de>
 <20260527154205.140101F000E9@smtp.kernel.org>
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
In-Reply-To: <20260527154205.140101F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11305-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,suse.com:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5CC805ED462
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

(cc'ing Aditya, Aun-Ali)

Am 27.05.26 um 17:42 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> Pre-existing issues:
> - [Critical] Unbounded accumulation of damage clip sizes causes an integer overflow, resulting in an undersized buffer allocation and subsequent out-of-bounds heap write.
> - [High] The plane `atomic_update` callback incorrectly calls sleeping functions, violating DRM atomic context guidelines.
> - [High] Mismatched coordinate space intersection and inconsistent calculation ordering lead to uninitialized memory gaps and malformed hardware payloads.
> --
>
> commit fc37b98d4bfc3183056fa690c4e2e659894c67e7
> Author: Thomas Zimmermann <tzimmermann@suse.de>
> Date:   Wed May 27 14:46:24 2026 +0000
>
> drm/appletbdrm: Allocate request/response buffers in begin_fb_access
>
> In atomic_check, damage handling is not fully evaluated. Another
> atomic_check helper could trigger a full modeset and thus invalidate
> damage clips.
>
> Allocation of the request/response buffers in appletbdrm depends on
> correct damage information. Otherwise it might allocate incorrectly
> sized buffers. Allocate the buffers in the driver's begin_fb_access
> helper. It runs early during the commit when damage clipping has been
> fully evaluated.
>
>> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/appletbdrm.c
>> index cdd35af498920..b683dcb35b0be 100644
>> --- a/drivers/gpu/drm/tiny/appletbdrm.c
>> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
>> @@ -315,33 +315,16 @@ static const u32 appletbdrm_primary_plane_formats[] = {
>>   	DRM_FORMAT_XRGB8888, /* emulated */
>>   };
>>   
>> -static int appletbdrm_primary_plane_helper_atomic_check(struct drm_plane *plane,
>> -						   struct drm_atomic_commit *state)
>> +static int appletbdrm_primary_plane_helper_begin_fb_access(struct drm_plane *plane,
>> +							   struct drm_plane_state *new_plane_state)
>>   {
>>   	struct appletbdrm_plane_state *appletbdrm_state = to_appletbdrm_plane_state(new_plane_state);
>> +	size_t frames_size = 0;
>>   	struct drm_atomic_helper_damage_iter iter;
>>   	struct drm_rect damage;
>>   	size_t request_size;
>>   
>> -	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, new_plane_state);
>> +	drm_atomic_helper_damage_iter_init(&iter, NULL, new_plane_state);
>>   	drm_atomic_for_each_plane_damage(&iter, &damage) {
>>   		frames_size += struct_size((struct appletbdrm_frame *)0, buf, rect_size(&damage));
>>   	}
> [Severity: Critical]
> This is a pre-existing issue, but could the unbounded accumulation of damage
> clip sizes cause an integer overflow?

Pre-existing issues should be fixed separately.

>
> The FB_DAMAGE_CLIPS property allows userspace to pass an unbounded number of
> damage clips, limited only by the maximum DRM property blob size.
>
> If millions of clips are provided, accumulating the sizes with:
>
>      frames_size += struct_size(...)
>
> could wrap around size_t on 32-bit systems. Even if frames_size doesn't wrap,
> the subsequent calculation:
>
>      request_size = ALIGN(sizeof(...) + frames_size + sizeof(...), 16)
>
> might easily wrap around to a small value, causing kvzalloc() to successfully
> allocate an undersized buffer.
>
> When appletbdrm_flush_damage() iteratively processes the exact same clips,
> could it trust the per-clip buf_size and copy pixel data into the undersized
> buffer via drm_fb_memcpy(), resulting in an out-of-bounds heap write?
>
> [Severity: High]
> This is also a pre-existing issue, but does this allocation properly account
> for the intersection calculations that happen later?
>
> In appletbdrm_flush_damage(), buf_size is calculated before the intersection:
>
>      buf_size = rect_size(&damage);
>      if (!drm_rect_intersect(&dst_clip, &damage))
>          continue;
>
> If the intersection shrinks the damage rectangle, drm_fb_memcpy() copies fewer
> bytes than buf_size, leaving zeroed memory at the end of the frame buffer.
> Since frame->buf_size was already set to the original size, the hardware will
> read these zeroes as pixel data.
>
> Furthermore, dst_clip is in CRTC coordinates while damage is in Framebuffer
> (SRC) coordinates. If userspace utilizes a framebuffer larger than the CRTC
> and applies a source offset, the coordinate spaces will not overlap properly.
> This causes valid damage clips to be skipped entirely.
>
> Since the begin_fb_access() helper factored these skipped clips into the total
> frames_size allocation without performing the intersection, skipping them later
> fails to advance the frame pointer.
>
> Could this leave uninitialized gaps before the footer, corrupting the packed
> payload structure sent to the hardware?
>
> [ ... ]
>
>> @@ -468,7 +474,7 @@ static int appletbdrm_flush_damage(struct appletbdrm_device *adev,
>>   }
>>   
>>   static void appletbdrm_primary_plane_helper_atomic_update(struct drm_plane *plane,
>> -						     struct drm_atomic_commit *old_state)
>> +							  struct drm_atomic_commit *old_state)
>>   {
>>   	struct appletbdrm_device *adev = drm_to_adev(plane->dev);
>>   	struct drm_device *drm = plane->dev;
> [Severity: High]
> This is a pre-existing issue, but does this code execute sleeping functions
> from an atomic context?
>
> According to DRM atomic context guidelines, plane atomic update callbacks
> execute in an atomic context where sleeping is forbidden.
>
> The appletbdrm_primary_plane_helper_atomic_update() callback invokes
> appletbdrm_flush_damage(), which subsequently calls:
>
>      drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
>
> This function takes locks and can wait on fences. The flush function then
> performs synchronous USB bulk transfers, which also sleep.
>
> Could this break atomic context rules and cause system instability?
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



