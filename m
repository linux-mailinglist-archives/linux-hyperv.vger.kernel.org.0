Return-Path: <linux-hyperv+bounces-6913-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01800B8026C
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 16:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6522D3A64AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4891303A3D;
	Wed, 17 Sep 2025 14:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hd3g/6Dj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFNU9JD8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hd3g/6Dj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GFNU9JD8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178902F5320
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Sep 2025 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758120143; cv=none; b=PjWIiJseO4HtXetArRBkx7e1akGpsGENSAObmU+9qwRw0vCVhYyZePWLtXCNvu5SzpDnIF1v8EpCwTWEeIaULkytzoVMKaEnxDlF4RpWyfCaHTTcUJltizC0hSZlPMf0zWqt+JtN/3jHdnC5zCGSinLIjNaFb04Tdd8YA7PYokk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758120143; c=relaxed/simple;
	bh=Gwbj8cAXfdJkYJEQ7+XlomdhEFT9f1jRaaT+7CjNaAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XjaMDAFOz/FqTzOQcebq3keHy36bBYFBvHvwmDJWkkqgtpI05i/0os7Akrv+EG30qgyknItYRgV5WV6RU025qxothQwaQFhrUPgwNuYIRABVprJ4Gn9Pp6NiX+s58UZq6Ll2JLLMOgAon7gA2iYRLbhW4gv9C+i2yBA5QZGtKrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hd3g/6Dj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFNU9JD8; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hd3g/6Dj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GFNU9JD8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2224C21F40;
	Wed, 17 Sep 2025 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758120140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jK638bioaxkZxLlVgxZJprmO1A7vlWiaLe3zNBFT2SM=;
	b=hd3g/6DjXub6Lxbn3m7k4bfdc8nkLazrKvSYSZWhkh7JGZRrT9z5HA1/UgxhWUd5fWd6UF
	IrrizBB6hgPU55exY75Vz5CorDkpAFDOqZ20/Bt7mujFahST5NmmHT3Mt4vfWg4Y3cm4pG
	ppOMlQNSZ39FcsMF/5Mj13qpohngbMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758120140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jK638bioaxkZxLlVgxZJprmO1A7vlWiaLe3zNBFT2SM=;
	b=GFNU9JD8R1OQJppcwO60HWqqnuYbb4VHXiI0mYXwNK525sfBhOIQkxgjc4AHs+Kd8i78a7
	cRtIkwsPr6Fs5yCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="hd3g/6Dj";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GFNU9JD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758120140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jK638bioaxkZxLlVgxZJprmO1A7vlWiaLe3zNBFT2SM=;
	b=hd3g/6DjXub6Lxbn3m7k4bfdc8nkLazrKvSYSZWhkh7JGZRrT9z5HA1/UgxhWUd5fWd6UF
	IrrizBB6hgPU55exY75Vz5CorDkpAFDOqZ20/Bt7mujFahST5NmmHT3Mt4vfWg4Y3cm4pG
	ppOMlQNSZ39FcsMF/5Mj13qpohngbMo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758120140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jK638bioaxkZxLlVgxZJprmO1A7vlWiaLe3zNBFT2SM=;
	b=GFNU9JD8R1OQJppcwO60HWqqnuYbb4VHXiI0mYXwNK525sfBhOIQkxgjc4AHs+Kd8i78a7
	cRtIkwsPr6Fs5yCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0E1A1368D;
	Wed, 17 Sep 2025 14:42:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id noS4KcvIymg3DwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 17 Sep 2025 14:42:19 +0000
Message-ID: <4472af4a-c538-4129-97a7-aa1736c9c777@suse.de>
Date: Wed, 17 Sep 2025 16:42:19 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] MAINTAINERS: Mark hyperv_fb driver Obsolete
To: Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssengar@linux.microsoft.com, mhklinux@outlook.com, rdunlap@infradead.org,
 bartosz.golaszewski@linaro.org, gonzalo.silvalde@gmail.com, arnd@arndb.de,
 decui@microsoft.com, wei.liu@kernel.org, deller@gmx.de, kys@microsoft.com,
 haiyangz@microsoft.com
References: <E5C2A201B1BD>
 <1758117804-20798-1-git-send-email-ptsm@linux.microsoft.com>
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
In-Reply-To: <1758117804-20798-1-git-send-email-ptsm@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de,outlook.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[linux.microsoft.com,lists.freedesktop.org,vger.kernel.org,outlook.com,infradead.org,linaro.org,gmail.com,arndb.de,microsoft.com,kernel.org,gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linaro.org:email];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 2224C21F40
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01



Am 17.09.25 um 16:03 schrieb Prasanna Kumar T S M:
> The hyperv_fb driver is deprecated in favor of Hyper-V DRM driver. Split
> the hyperv_fb entry from the hyperv drivers list, mark it obsolete.
>
> Signed-off-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   MAINTAINERS | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f6206963efbf..aa9d0fa6020b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11424,7 +11424,6 @@ F:	drivers/pci/controller/pci-hyperv-intf.c
>   F:	drivers/pci/controller/pci-hyperv.c
>   F:	drivers/scsi/storvsc_drv.c
>   F:	drivers/uio/uio_hv_generic.c
> -F:	drivers/video/fbdev/hyperv_fb.c
>   F:	include/asm-generic/mshyperv.h
>   F:	include/clocksource/hyperv_timer.h
>   F:	include/hyperv/hvgdk.h
> @@ -11438,6 +11437,16 @@ F:	include/uapi/linux/hyperv.h
>   F:	net/vmw_vsock/hyperv_transport.c
>   F:	tools/hv/
>   
> +HYPER-V FRAMEBUFFER DRIVER
> +M:	"K. Y. Srinivasan" <kys@microsoft.com>
> +M:	Haiyang Zhang <haiyangz@microsoft.com>
> +M:	Wei Liu <wei.liu@kernel.org>
> +M:	Dexuan Cui <decui@microsoft.com>
> +L:	linux-hyperv@vger.kernel.org
> +S:	Obsolete
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> +F:	drivers/video/fbdev/hyperv_fb.c
> +
>   HYPERBUS SUPPORT
>   M:	Vignesh Raghavendra <vigneshr@ti.com>
>   R:	Tudor Ambarus <tudor.ambarus@linaro.org>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)



