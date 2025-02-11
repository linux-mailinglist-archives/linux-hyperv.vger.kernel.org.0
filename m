Return-Path: <linux-hyperv+bounces-3894-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB12A30EE5
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 15:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B051613AE
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 14:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F267424F5A4;
	Tue, 11 Feb 2025 14:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RBwcfGYw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9SgXniEK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RBwcfGYw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9SgXniEK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24519250C0B;
	Tue, 11 Feb 2025 14:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285895; cv=none; b=rHjGnUinKI8m2hnGAxkrWH9j527Y6uGcZPfeEU5iaKeyYConzyfMT3qH5P7EsJHChSYF56igEg4j/q2pKmM4H+94/Ry6U/lpSpvhMJVDqGVyhBqL9UBAtg73aW5/R2pi3W1FiUspeeISPW7463l0K/tohuX1huVoAEpzsyJ2f4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285895; c=relaxed/simple;
	bh=A+ZxdNHgPEBoJkbpOb1yl7fY7KsM0eon7pme0YqeyFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B32cWs7aNWvILwvsyTIW1LkLin6hm550Gg0NjkEfllnYIiAcumNqP72YcXK20+EXha6KWB+boYzKUtCZZ7eSHdLD/Q5O+ZkoO7223v1DRxAg4OeM0TI/QS+K/aXmtSqig8XB5XtcVO8iqNe/HnewGKu/udgEeBCcVQO2QjP4GXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RBwcfGYw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9SgXniEK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RBwcfGYw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9SgXniEK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 881EB5BD0B;
	Tue, 11 Feb 2025 07:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739259278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XapZj8fn6hrk1id5K05g62Ja0OL4RYHu3GDtWlZPihY=;
	b=RBwcfGYw0yV15g9Y38dTYAOL0jreQqZFZcO75ovIfm3fpcjx9uMw68jBiSVACuUwxNOtx3
	hFlH0S9JZbRMJr/gWlNMpKOdlEmkbdqdVoXkC3sljfk5WMIYP+/+TXCojWgfiiCXaT1rzS
	K341cQ5mdUt5fLm85GGK72hsEiTQtck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739259278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XapZj8fn6hrk1id5K05g62Ja0OL4RYHu3GDtWlZPihY=;
	b=9SgXniEKHlA9c3nYPYJKLSsJghNvVShM29e9bprznAlP+ahGEqd7Bw8klBuOog1SUhjVfm
	JvNktnZe06ZbArBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739259278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XapZj8fn6hrk1id5K05g62Ja0OL4RYHu3GDtWlZPihY=;
	b=RBwcfGYw0yV15g9Y38dTYAOL0jreQqZFZcO75ovIfm3fpcjx9uMw68jBiSVACuUwxNOtx3
	hFlH0S9JZbRMJr/gWlNMpKOdlEmkbdqdVoXkC3sljfk5WMIYP+/+TXCojWgfiiCXaT1rzS
	K341cQ5mdUt5fLm85GGK72hsEiTQtck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739259278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XapZj8fn6hrk1id5K05g62Ja0OL4RYHu3GDtWlZPihY=;
	b=9SgXniEKHlA9c3nYPYJKLSsJghNvVShM29e9bprznAlP+ahGEqd7Bw8klBuOog1SUhjVfm
	JvNktnZe06ZbArBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3ACBD13715;
	Tue, 11 Feb 2025 07:34:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WjLoDI79qme/QAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 11 Feb 2025 07:34:38 +0000
Message-ID: <445e33f1-280a-436d-8f9a-c94d16c17efd@suse.de>
Date: Tue, 11 Feb 2025 08:34:37 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/hyperv: Fix address space leak when Hyper-V DRM
 device is removed
To: mhklinux@outlook.com, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, christophe.jaillet@wanadoo.fr, ssengar@linux.microsoft.com,
 wei.liu@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20250210193441.2414-1-mhklinux@outlook.com>
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
In-Reply-To: <20250210193441.2414-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[outlook.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch,wanadoo.fr,linux.microsoft.com];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com,wanadoo.fr];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Hi

Am 10.02.25 um 20:34 schrieb mhkelley58@gmail.com:
> From: Michael Kelley <mhklinux@outlook.com>
>
> When a Hyper-V DRM device is probed, the driver allocates MMIO space for
> the vram, and maps it cacheable. If the device removed, or in the error
> path for device probing, the MMIO space is released but no unmap is done.
> Consequently the kernel address space for the mapping is leaked.
>
> Fix this by adding iounmap() calls in the device removal path, and in the
> error path during device probing.

Could this driver use devm_ helpers for iomap operations? That should 
fix the issue automatically.

Best regards
Thomas

>
> Fixes: f1f63cbb705d ("drm/hyperv: Fix an error handling path in hyperv_vmbus_probe()")
> Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index e0953777a206..b491827941f1 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -156,6 +156,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>   	return 0;
>   
>   err_free_mmio:
> +	iounmap(hv->vram);
>   	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>   err_vmbus_close:
>   	vmbus_close(hdev->channel);
> @@ -174,6 +175,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
>   	vmbus_close(hdev->channel);
>   	hv_set_drvdata(hdev, NULL);
>   
> +	iounmap(hv->vram);
>   	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>   }
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


