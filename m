Return-Path: <linux-hyperv+bounces-11304-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG7mHgDfF2rxTggAu9opvQ
	(envelope-from <linux-hyperv+bounces-11304-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:21:52 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 233475ED398
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 08:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ED6D302D0D4
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 May 2026 06:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B148A31F993;
	Thu, 28 May 2026 06:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1hVfXW36";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lRGkNV6j";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1hVfXW36";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lRGkNV6j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4130A30C170
	for <linux-hyperv@vger.kernel.org>; Thu, 28 May 2026 06:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949309; cv=none; b=ZuV3KhwvMb7bU31EjF5gRV9lDWSzTnX8YT7vwrFkwPtE1urg4op+t69mfMNTg77h9dyarWmJr6d5Aj5fIHo7c92bjqgy1rtC9dQOBrqfQIQE/a2I88Z0Hu+MDIQllsyuu2p8BuA/dEjffvzg8kIH4nLerMKy1Qkax8eT2lhVPCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949309; c=relaxed/simple;
	bh=M4zu65y+c6y4P0PzPlhFWue1AXUkxw/VTXuJpKjE4vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RLvd6ve3lF+9/er1yhmNeXbJk4pbvR5rSlkmvrheqvBfQUsEoal9+mwCwLeV9sFGiFM5L7VM2yJM5NRjCDeNCApNv0TeC611YCE07uXPwet+kZYSXgEEisPrpemN+6uTLhYpn8Xa6QI86loJPmiiC9fCMMw5URQRGM9g5bE0jzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1hVfXW36; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lRGkNV6j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1hVfXW36; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lRGkNV6j; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 825EE6A8F1;
	Thu, 28 May 2026 06:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779949306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9TnLwmYEvlWD3/o/kpjtyUlqcl/n9Vz14xvKtU/ybhw=;
	b=1hVfXW365mJ2zbrRs+PhoxPOlZWt25nYD0xvWRHt307KJgn4wKVWejoKFHG4l4vTK7tS4n
	QeiY2KZE16kdhk6wl8mRHdDaSBeTcLymKDL6NJXgnLvhJG9emBVIaOzsoENaaPFHtWXnvl
	eTBg/ni0cnzOAgbopI8/zmGbHIMBaok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779949306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9TnLwmYEvlWD3/o/kpjtyUlqcl/n9Vz14xvKtU/ybhw=;
	b=lRGkNV6jyYon7nlyaWHOF37zYrF8tZjKecZmaaqZIgbtQysKJjZkdhTPOsdrTOwTfPh0sO
	g+RDUkqyrnddFOAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779949306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9TnLwmYEvlWD3/o/kpjtyUlqcl/n9Vz14xvKtU/ybhw=;
	b=1hVfXW365mJ2zbrRs+PhoxPOlZWt25nYD0xvWRHt307KJgn4wKVWejoKFHG4l4vTK7tS4n
	QeiY2KZE16kdhk6wl8mRHdDaSBeTcLymKDL6NJXgnLvhJG9emBVIaOzsoENaaPFHtWXnvl
	eTBg/ni0cnzOAgbopI8/zmGbHIMBaok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779949306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9TnLwmYEvlWD3/o/kpjtyUlqcl/n9Vz14xvKtU/ybhw=;
	b=lRGkNV6jyYon7nlyaWHOF37zYrF8tZjKecZmaaqZIgbtQysKJjZkdhTPOsdrTOwTfPh0sO
	g+RDUkqyrnddFOAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 43E425AC3D;
	Thu, 28 May 2026 06:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/YrD/reF2rDCwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 28 May 2026 06:21:46 +0000
Message-ID: <0401c8d5-e7f6-48bf-a90d-f6c748e4cc6a@suse.de>
Date: Thu, 28 May 2026 08:21:45 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] drm/vmwgfx: Remove unused field struct
 vmwgfx_du_update_plane.old_state
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org
References: <20260527145113.241595-11-tzimmermann@suse.de>
 <20260527152200.9F49F1F000E9@smtp.kernel.org>
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
In-Reply-To: <20260527152200.9F49F1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11304-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.de:email,suse.de:mid,suse.de:dkim,suse.com:url]
X-Rspamd-Queue-Id: 233475ED398
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



Am 27.05.26 um 17:22 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Plane atomic_update callbacks indirectly call sleeping functions (mutex_lock/mutex_lock_interruptible) from an atomic context.
> --

Preexisting issues should be fixed separately.

>
> commit deccb03fba43ed6006d88ae9933240eb52b52fee
> Author: Thomas Zimmermann <tzimmermann@suse.de>
>
> drm/vmwgfx: Remove unused field struct vmwgfx_du_update_plane.old_state
>
> This commit removes the unused old_state field from the
> vmw_du_update_plane structure and updates all caller functions to
> accommodate this change.
>
>> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
>> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
>> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
> [ ... ]
>> @@ -721,7 +717,6 @@ static void
>>   vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
>>   				    struct drm_atomic_commit *state)
>>   {
>> -	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
>>   	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
>>   	struct drm_crtc *crtc = new_state->crtc;
>>   	struct vmw_fence_obj *fence = NULL;
>> @@ -734,12 +729,9 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
>>   			vmw_framebuffer_to_vfb(new_state->fb);
>>   
>>   		if (vfb->bo)
>> -			ret = vmw_sou_plane_update_bo(dev_priv, plane,
>> -						      old_state, vfb, &fence);
>> +			ret = vmw_sou_plane_update_bo(dev_priv, plane, vfb, &fence);
>>   		else
>> -			ret = vmw_sou_plane_update_surface(dev_priv, plane,
>> -							   old_state, vfb,
>> -							   &fence);
>> +			ret = vmw_sou_plane_update_surface(dev_priv, plane, vfb, &fence);
> [Severity: High]
> This is a pre-existing issue, but does this code path end up calling sleeping
> functions from an atomic context?
>
> Looking at the call chain, vmw_sou_primary_plane_atomic_update() is a plane
> atomic update callback, which runs in atomic context where sleeping is
> forbidden. However, it calls vmw_sou_plane_update_surface(), which assigns a
> mutex pointer to the update structure:
>
> vmw_sou_plane_update_surface()
>    srf_update.base.mutex = &dev_priv->cmdbuf_mutex;
>    vmw_du_helper_plane_update(&srf_update.base);
>
> This closure is then passed down to vmw_du_helper_plane_update(), which calls
> vmw_validation_prepare(). That function then takes the lock using
> mutex_lock() or mutex_lock_interruptible().
>
> Could this lead to system instability or deadlocks if the atomic commit runs
> in a non-blocking path where sleeping is not allowed?
>
> [ ... ]
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



