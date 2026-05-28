Return-Path: <linux-hyperv+bounces-11303-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBIlAtPeF2rxTggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11303-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:21:07 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8845ED390
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 11170301CD84
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 06:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA225782A;
	Thu, 28 May 2026 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pkKT41ah";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2sIuA+aL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pkKT41ah";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2sIuA+aL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBD31F993
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 06:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949263; cv=none; b=tw0A2nkf/5qiFvCEumfe/nN4hxtGS3IyfPORADT1imfvcfXSYvhxia8v4SoY2O5ZvNfygF9WTphbNCEEgZW6ahZGMHXNbHe4gNll377MiJklGAp5t9zej22K5zvqt+mj1TvBdMNslnmplBJvaRwG6qFgC8wJ/w/dQONEzBs4IXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949263; c=relaxed/simple;
	bh=BUHkbn2J4r4KGXEgZlSRo6FuS2qZaril07chINl0pFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=holuho9YID4GHbMrGe1BPfcUccvlloH1EtuqGvXvqsjG+BBKzhMt/LAZnSgkHgICHIYTKjq1C8F//QzIcwRyNWhkeoiH6KpQdPamCd50BO4OHMqKryCHnOXHstpiQUWroZRkvXHOxQUS1E16XeHV8Amf6bF7GwWm/sfjgewrrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pkKT41ah; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2sIuA+aL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pkKT41ah; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2sIuA+aL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1EDB06AED9;
	Thu, 28 May 2026 06:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779949260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pMrZfHA0Lmy+Y0m+L++ljOdA9SyMNg2I8/Me8AMxrw4=;
	b=pkKT41ahLDJfDYkDG4H/mo7VJvapeb72VJWt+Chg9vBlWQSa5bw9tUfDQSuKzCfOTpPfvE
	h+bMFf6h1wZSTdWPt3ddfT1wli1PrJx4KmU0/ry8hixUrbW+hdS4N/6s+NM0smk24Tkaee
	MfynaLKyyfuMGoOglkHvMFp95V20e1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779949260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pMrZfHA0Lmy+Y0m+L++ljOdA9SyMNg2I8/Me8AMxrw4=;
	b=2sIuA+aL8wb99LUx6KUmeZuJuJqSV7h34WCSgIihWvHtTymb0va0nfwM/7aMUOWn1IeYSD
	Zf8BmOhKWc5euIAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779949260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pMrZfHA0Lmy+Y0m+L++ljOdA9SyMNg2I8/Me8AMxrw4=;
	b=pkKT41ahLDJfDYkDG4H/mo7VJvapeb72VJWt+Chg9vBlWQSa5bw9tUfDQSuKzCfOTpPfvE
	h+bMFf6h1wZSTdWPt3ddfT1wli1PrJx4KmU0/ry8hixUrbW+hdS4N/6s+NM0smk24Tkaee
	MfynaLKyyfuMGoOglkHvMFp95V20e1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779949260;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pMrZfHA0Lmy+Y0m+L++ljOdA9SyMNg2I8/Me8AMxrw4=;
	b=2sIuA+aL8wb99LUx6KUmeZuJuJqSV7h34WCSgIihWvHtTymb0va0nfwM/7aMUOWn1IeYSD
	Zf8BmOhKWc5euIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01AA75AC3C;
	Thu, 28 May 2026 06:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Mtg2OsveF2roCQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 06:20:59 +0000
Message-ID: <56ae6c6c-be94-49eb-a1be-85183402dbfc@suse.de>
Date: Thu, 28 May 2026 08:20:59 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] drm/damage-helper: Remove old state from
 drm_atomic_helper_damage_merged()
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
References: <20260527145113.241595-8-tzimmermann@suse.de>
 <20260527151003.4F25D1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260527151003.4F25D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11303-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:email,suse.de:mid,suse.de:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C8845ED390
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 27.05.26 um 17:10 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but the plane atomic update callback `gm12u320_pipe_update` executes a path that acquires a mutex. Plane atomic update callbacks run in atomic context during non-blocking commits, making the use of sleeping locks unsafe.
> - [High] This problem wasn't introduced by this patch, but the plane atomic update callback `repaper_pipe_update` executes a path that performs a memory allocation with `GFP_KERNEL`. Plane atomic update callbacks run in atomic context, where allocations that may sleep are strictly prohibited.

Unrelated issues should be fixed separately.

> --
>
> commit da86f07c371224a54756c1f750c01c663a2a7a86
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/damage-helper: Remove old state from drm_atomic_helper_damage_merged()
>
> This patch removes the unused old_state parameter from
> drm_atomic_helper_damage_merged() and updates all callers. It also cleans up
> the old_plane_state variable in caller functions where it is no longer
> needed.
>
> [ ... ]
>
>> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
>> --- a/drivers/gpu/drm/tiny/gm12u320.c
>> +++ b/drivers/gpu/drm/tiny/gm12u320.c
>> @@ -582,7 +582,7 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
>>   	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
>>   	struct drm_rect rect;
>>   
>> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>> +	if (drm_atomic_helper_damage_merged(state, &rect))
> [Severity: High]
> This is a pre-existing issue, but does gm12u320_pipe_update() safely execute
> in an atomic context?
>
> This function acts as the simple display pipe's plane atomic update callback,
> which runs in atomic context during non-blocking commits. However, it calls
> gm12u320_fb_mark_dirty(), which acquires a mutex:
>
> drivers/gpu/drm/tiny/gm12u320.c:gm12u320_fb_mark_dirty() {
>      ...
>      mutex_lock(&gm12u320->fb_update.lock);
>      ...
> }
>
> Since mutex_lock() is a sleeping function, could this lead to deadlocks or
> kernel warnings when called from an atomic context?
>
>>   		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
>>   }
> [ ... ]
>
>> diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
>> --- a/drivers/gpu/drm/tiny/repaper.c
>> +++ b/drivers/gpu/drm/tiny/repaper.c
>> @@ -837,7 +837,7 @@ static void repaper_pipe_update(struct drm_simple_display_pipe *pipe,
>>   	if (!pipe->crtc.state->active)
>>   		return;
>>   
>> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>> +	if (drm_atomic_helper_damage_merged(state, &rect))
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe for
> repaper_pipe_update() to trigger allocations with GFP_KERNEL?
>
> Like the issue above, this acts as the plane atomic update callback. It calls
> repaper_fb_dirty(), which performs a memory allocation that may sleep:
>
> drivers/gpu/drm/tiny/repaper.c:repaper_fb_dirty() {
>      ...
>      buf = kmalloc(fb->width * fb->height / 8, GFP_KERNEL);
>      ...
>      ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
>      ...
> }
>
> Because plane atomic update callbacks run in atomic context, allocations that
> may sleep (like GFP_KERNEL) and sleeping functions like
> drm_gem_fb_begin_cpu_access() are strictly prohibited. Is there a plan to
> shift these sleeping operations to a workqueue or use non-sleeping
> allocations?
>
>>   		repaper_fb_dirty(state->fb, shadow_plane_state->data,
>>   				 &shadow_plane_state->fmtcnv_state);
>>   }

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



