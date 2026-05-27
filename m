Return-Path: <linux-hyperv+bounces-11219-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Et4D63sFmr7wwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11219-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:07:57 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D76145E4A51
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 15:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04D123009F7C
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2026 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154BE40913B;
	Wed, 27 May 2026 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="esP9OcSl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fw2483cY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="esP9OcSl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fw2483cY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FF40B6C9
	for <linux-hyperv@vger.kernel.org>; Wed, 27 May 2026 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779887240; cv=none; b=AjG1gkJ1BC9E8tjnW9bJxwlTUpHRnZPPaowxvf6ZcnI0gKEh4cqTTu5/xeo372xAfoV8Kvwzhl4WAwO8ZR7tXWITCgV2RGUBv3jPPnhmQlCwb7CKRHUxAAeC2pILF4fkaXDKnqf65SumErjUo1FiRXU1EX1dLW6uTZlQ5zo+AVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779887240; c=relaxed/simple;
	bh=e0VXPthwaahApSLrRt8nO9+n5Hl5i3TjwyDLZ0EoyB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKQyhCiC/yjHzDdQevxXJsD/dOFRQmWJPV059gjdinmGjTkVKabHBORuazQ2qbVMBg652rZxBwzkxuu3l8rPxiTwaSgmDa+Yjs1EO6yazLTW0V/SwpGMSi3FXM1dpQ97bLQIaOMq9qubStVduXaFMka/7hJpMQIUxX56HCUOLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=esP9OcSl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fw2483cY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=esP9OcSl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fw2483cY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A932667569;
	Wed, 27 May 2026 13:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779887230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vlT+/BAQdkxbWapVyZUuqzz0p8aDpSmVgE3x+y2I7Sc=;
	b=esP9OcSlpxOulRHCToW7/6cyCoN5yti/xmoyKd9e79MetL1+XOpIVFuo08ayfmAVG3kFKU
	96TyKKE2tuzmH1p/j3TlrcUUCUFVn+MqHwZcEny6ll9fplJa8mREBHZtbOf1nHi0r0n4Oq
	/SSa2NUcUdqXBVb50nbVXUtWZYyvay0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779887230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vlT+/BAQdkxbWapVyZUuqzz0p8aDpSmVgE3x+y2I7Sc=;
	b=Fw2483cYiiddYwEeOWJJ9pkkLNDS3rNaWDj/sBPwTYlpeqkmEC5ULJGJNMrsiXTLvbcRt/
	q8Hs+4yIXg3FhhCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=esP9OcSl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fw2483cY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779887230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vlT+/BAQdkxbWapVyZUuqzz0p8aDpSmVgE3x+y2I7Sc=;
	b=esP9OcSlpxOulRHCToW7/6cyCoN5yti/xmoyKd9e79MetL1+XOpIVFuo08ayfmAVG3kFKU
	96TyKKE2tuzmH1p/j3TlrcUUCUFVn+MqHwZcEny6ll9fplJa8mREBHZtbOf1nHi0r0n4Oq
	/SSa2NUcUdqXBVb50nbVXUtWZYyvay0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779887230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vlT+/BAQdkxbWapVyZUuqzz0p8aDpSmVgE3x+y2I7Sc=;
	b=Fw2483cYiiddYwEeOWJJ9pkkLNDS3rNaWDj/sBPwTYlpeqkmEC5ULJGJNMrsiXTLvbcRt/
	q8Hs+4yIXg3FhhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4970C5A843;
	Wed, 27 May 2026 13:07:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kaqgEH7sFmq5EQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 13:07:10 +0000
Message-ID: <4a7c2f87-60fd-458c-a579-a36799b86557@suse.de>
Date: Wed, 27 May 2026 15:07:09 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] drm: Limit DRM_IOCTL_WAIT_VBLANK to vblank interrupts
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 simona@ffwll.ch, airlied@gmail.com, pekka.paalanen@collabora.com,
 jadahl@gmail.com, contact@emersion.fr, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 spice-devel@lists.freedesktop.org, wayland-devel@lists.freedesktop.org
References: <20260515120916.333614-1-tzimmermann@suse.de>
 <b5d03921-1e6f-4c4f-900e-fc9e28222176@mailbox.org>
 <cb461424-e4c1-4d2c-934b-ffd7374e2a56@mailbox.org>
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
In-Reply-To: <cb461424-e4c1-4d2c-934b-ffd7374e2a56@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11219-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mailbox.org,ffwll.ch,gmail.com,collabora.com,emersion.fr,linux.intel.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:url]
X-Rspamd-Queue-Id: D76145E4A51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi

Am 15.05.26 um 18:56 schrieb Michel Dänzer:
> [ Adding the wayland-devel list for awareness ]
>
> On 5/15/26 17:12, Michel Dänzer wrote:
>> On 5/15/26 13:55, Thomas Zimmermann wrote:
>>> DRM's WAIT_VBLANK ioctl synchronizes user-space clients to display
>>> refresh. This is meaningless with vblank timers, which run unrelated
>>> to the hardware's vblank.
>>>
>>> Disable the ioctl for simulated vblanks. Set DRM_VBLANK_FLAG_SIMULATED
>>> for CRTCs with simulated vblank events in all such drivers. The vblank
>>> timers of these devices still rate-limit the number of page-flip events
>>> to match the display refresh.
>>>
>>> According to maintainers, user-space compositors do not require the ioctl
>>> for rate-limitting display output. Weston and Kwin rely on page-flip
>>> events. Mutter uses and internal timer to limit the number of display
>>> updates per second.
>> Actually mutter fundamentally relies on atomic commit completion events for that, same as Weston & KWin. Mutter uses the WAIT_VBLANK ioctl only for minimizing input → output latency (which can hide issues when completion of atomic commits isn't properly throttled).
>>
>>
>> (Just a side not on the cover letter, no objections to the patches themselves)
> After more discussion on IRC, I have some concerns.
>
>
> The big one first: For drivers with no strict refresh cycle (i.e. an atomic commit can take effect more or less anytime after at least one "refresh cycle" has passed since the last one), does this change really make sense / what's the actual benefit?

I don't have a strong opinion on that matter. I just think we should 
clarify the meaning of these ioctls.

Timing page flip is currently not supported on any driver without 
hardware vblank IRQ or a vblank timer. The situation might vary among 
compositors, but there have been plenty of reports of animation and 
frame rates either being too high or too low. So I think we should 
rollout vblank timers for all drivers without hardware vblank IRQ.

Right now, vblank timers act like a vblank IRQ in these ioctls. That's a 
convenient position for user space.

But we don't really sync anything with hardware here, so the alternate 
proposal is to not support them.  This also appears to be the original 
intention of these ioctls.  Vblank timers would just limit the internal 
page-flip rate, but nothing else. That's the more defensive approach. 
I'd prefer this, as it does not give out guarantees to user space that 
future drivers might not be able to fulfill.




>
> In the case of the asahi & nvidia drivers, the problem with exposing this functionality to user space is that if the timestamps aren't accurate, it can result in missing display refresh cycles, which are dictated by hardware. That's why it makes sense to reject it there.
>
> When there's no strict refresh cycle, that issue doesn't apply though.
>
>
> Any changes made to the WAIT_VBLANK ioctl should also be made to the CRTC_GET_SEQUENCE / CRTC_QUEUE_SEQUENCE ioctls, which are slightly different UAPI for the same functionality.

I'll send out an update with that fixed in a bit.

Best regards
Thomas


>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)



