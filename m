Return-Path: <linux-hyperv+bounces-8786-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEW2JJH6jGn5wQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8786-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 22:54:25 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F387127E91
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 22:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A8DE303A0C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Feb 2026 21:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491936BCF8;
	Wed, 11 Feb 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PL02LyKb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ze64SQhM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDA036BCF7
	for <linux-hyperv@vger.kernel.org>; Wed, 11 Feb 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770846862; cv=none; b=k5woow+6GjH9qY5l5+f20Ca2NzjZuyXT+v6oOaElqKDMHyiCniQn/lDgd8Yhyp7ZjfIrfGRWV7opRcvLYtl18KBNrfGnTK+9OqxDr17uQIFu/eVMh2/vuw6hfEvj1aH+FBVmjB2lgogj9mDratKCnnt7i59LRay0Q39qzXhPPy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770846862; c=relaxed/simple;
	bh=q/WxrZyetVMNgjoPxdvbdSU+SXN1AYSXgG+wZiSAZ6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YIfRvty6sTgaFasWjqKkCkw+n9nc0sSxW4oXXw1Z97btDipWuvwyfp7KajKRVKs6i9JD41DtVLmYbzsFGacC0WaFatqp/ph6UcawaBfakxPcF2iFuE0/SUWA8pTWmDaXNxGBCTVYxn1S0UskPwDi4Cj/P+AfMFb0a0Ddc5x7EhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PL02LyKb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ze64SQhM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770846859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SI+sBRtkzJlBVk5fRANqyWyEonINF8qLvx0gBLbpWBU=;
	b=PL02LyKbNsp+6XG+nzhcLN9yIdX3kpKEHh6PRHgGoMwU4gZIT4yKog98nc+BkJ/aiGTYHz
	Q+ucv4SPV+OSguEYcz5Iy7nBe71B10v2h/ou/2I5/6z6LivAkL1LqyPPhSfLHrbg5pkFtU
	q9C9t5ZvNNjSb+xeHg6LxPKEjq9tS54=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-Q7yjqReYO7C-HQlbwyoNNw-1; Wed, 11 Feb 2026 16:54:18 -0500
X-MC-Unique: Q7yjqReYO7C-HQlbwyoNNw-1
X-Mimecast-MFC-AGG-ID: Q7yjqReYO7C-HQlbwyoNNw_1770846857
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-480711d09f1so34714545e9.0
        for <linux-hyperv@vger.kernel.org>; Wed, 11 Feb 2026 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770846857; x=1771451657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SI+sBRtkzJlBVk5fRANqyWyEonINF8qLvx0gBLbpWBU=;
        b=Ze64SQhMNPS5H74bz8Rt+Zz/PAREBNycIKyoPzDqjCEoXK9kqbk6l5V/5oSWiKqrcQ
         OGLrU2+z9COK1UY4ivFXXI2/Tll+5Meyjp7W556ec1KxHZ2uFQToGpTsGrlRWaMvjksz
         +KfX4DM8AemYajLfecQJ6LRhUGcxEunYRORInj7pRhwhrhDmrd24eUp8725z+mxSuFqz
         SS6kc7bkmvT/fZ4fK+gh00L05WIiUXdWGZf8+r7Byh8v9GfNlqhQ2d9zBcODg4SAr2uX
         Tzl5l519HObcHx2z2HgraORXKR0XRwaJEf2u5Q8NMoEwPP8ywdlYbd9KjY/EoM8JY2Z9
         ymYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770846857; x=1771451657;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI+sBRtkzJlBVk5fRANqyWyEonINF8qLvx0gBLbpWBU=;
        b=VQcdJcoxpczht0Qb6ZBuFlsGFZAPPH6y9LurOWSxOW5Ifg6fuytAfreQL+DQSgDLDn
         6GoF8h8Dvs9ZTY8Z+ltK0/u1izDv2NYFpJqvTebM8XRPv1+mzTBaJ68+ZBdW4pt+DcVi
         6VPGOHOjJKrMQ60TP7z7064l0A4kqmmy7bOxdsTmZgQ+NhQWH3KAWKT6VsVRtiAPNVCl
         HCeltObb1EJEYfF7laR9lO4gSMwDRdKZGoQ9WwMX1c/ZMuLzRLDUhKy+Bdb2XgC+RbAH
         d1s6tIsMXesarA+r+X1ZuKPxZMRXVcwW2OpNUtGWt+cuWCiOb2zDmqCvYGq21XNxNNtu
         OvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgA8XtAIZBF9L9ZuVH6Zeyn3pqh7e9frHED63wUGE5Zi/GJce8ZxAkVHLEQNXFzGqMZVlaeQW/X9iPSwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb3mL5JpfQvAPMkyV7viAhxg68XHptjqDOd8g1/niZ3IGep2r2
	FH3vl/Qd6Q9beIS7qdqpIVn1xpYlC95h4LI/r0+YCQ5HjbYVxiaoDLFbTSwmT8dZQwQ+X3bju6d
	ZrGVzhTovbA9lOFiV43oBKr55NjPEdXHkOU1JG1EpERn51mQlb5Resu5I8RANthYLYQ==
X-Gm-Gg: AZuq6aJ8WzgFM2KdTX0rPThCERxCLVAw5vVXnvuzKnQyLobYP5UANYqQon1QRv8QnGB
	2taXHssrt8ba0JV1peOJZnx94inUBsIcW42aAy7n4VXaU0VHIUFSkUAirkEh4hAYGOiY/S9Maug
	P6vRfqfQwqPY5SDavAJv/lbEhC/Zc2ILsf6LnELyccQPuzyvSHIHMLjJ3A0xOHdu/weHUK8EMmn
	CuGSTlchOH82QK+qT4BH6OeMDdO9YFKpi63hfppIDb8oOBdqenXqitN1J+A8+MzXr75gGfUuSAD
	3vymBNgnstGjTduRCZWl02/g4/5ZrYstUlN/LpyKcBNJduY8Av83/N05aJGKwgJ3QR/B99wnTOg
	hDoVe4BQZ9ddG587NxhK+BmksBRQoR1M3ocYh4V3ug8987AG5WUwF3v3l8qm/xA==
X-Received: by 2002:a05:600c:5252:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4836715a470mr429025e9.21.1770846856897;
        Wed, 11 Feb 2026 13:54:16 -0800 (PST)
X-Received: by 2002:a05:600c:5252:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-4836715a470mr428695e9.21.1770846856390;
        Wed, 11 Feb 2026 13:54:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5e0ed5sm141422575e9.5.2026.02.11.13.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 13:54:15 -0800 (PST)
Message-ID: <a5372b72-8dc0-4f2d-ad5c-086f3e75ee81@redhat.com>
Date: Wed, 11 Feb 2026 22:54:11 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/hyperv: During panic do VMBus unload after frame
 buffer is flushed
To: mhklinux@outlook.com, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, ryasuoka@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, stable@vger.kernel.org
References: <20260209070201.1492-1-mhklinux@outlook.com>
 <20260209070201.1492-2-mhklinux@outlook.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20260209070201.1492-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,microsoft.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8786-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jfalempe@redhat.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 3F387127E91
X-Rspamd-Action: no action

On 09/02/2026 08:02, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> In a VM, Linux panic information (reason for the panic, stack trace,
> etc.) may be written to a serial console and/or a virtual frame buffer
> for a graphics console. The latter may need to be flushed back to the
> host hypervisor for display.
> 
> The current Hyper-V DRM driver for the frame buffer does the flushing
> *after* the VMBus connection has been unloaded, such that panic messages
> are not displayed on the graphics console. A user with a Hyper-V graphics
> console is left with just a hung empty screen after a panic. The enhanced
> control that DRM provides over the panic display in the graphics console
> is similarly non-functional.
> 
> Commit 3671f3777758 ("drm/hyperv: Add support for drm_panic") added
> the Hyper-V DRM driver support to flush the virtual frame buffer. It
> provided necessary functionality but did not handle the sequencing
> problem with VMBus unload.
> 
> Fix the full problem by using VMBus functions to suppress the VMBus
> unload that is normally done by the VMBus driver in the panic path. Then
> after the frame buffer has been flushed, do the VMBus unload so that a
> kdump kernel can start cleanly. As expected, CONFIG_DRM_PANIC must be
> selected for these changes to have effect. As a side benefit, the
> enhanced features of the DRM panic path are also functional.

Thanks for properly fixing this issue with DRM Panic on hyperv.

I've a small comment below.

With that fixed:
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

The first patch looks good too, I can review it if no other step up, as 
I'm not familiar with hyperv.

> 
> Fixes: 3671f3777758 ("drm/hyperv: Add support for drm_panic")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   drivers/gpu/drm/hyperv/hyperv_drm_drv.c     |  4 ++++
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 15 ++++++++-------
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 06b5d96e6eaf..79e51643be67 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -150,6 +150,9 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>   		goto err_free_mmio;
>   	}
>   
> +	/* If DRM panic path is stubbed out VMBus code must do the unload */
> +	if (IS_ENABLED(CONFIG_DRM_PANIC) && IS_ENABLED(CONFIG_PRINTK))

I think drm_panic should still work without printk.
The "user" panic screen would be unaffected, but the "kmsg" screen might 
be blank, and the "qr_code" would generate an empty qr code.
(Actually I never tried to build a kernel without printk).

> +		vmbus_set_skip_unload(true);
>   	drm_client_setup(dev, NULL);
>   
>   	return 0;
> @@ -169,6 +172,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
>   	struct drm_device *dev = hv_get_drvdata(hdev);
>   	struct hyperv_drm_device *hv = to_hv(dev);
>   
> +	vmbus_set_skip_unload(false);
>   	drm_dev_unplug(dev);
>   	drm_atomic_helper_shutdown(dev);
>   	vmbus_close(hdev->channel);
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 7978f8c8108c..d48ca6c23b7c 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -212,15 +212,16 @@ static void hyperv_plane_panic_flush(struct drm_plane *plane)
>   	struct hyperv_drm_device *hv = to_hv(plane->dev);
>   	struct drm_rect rect;
>   
> -	if (!plane->state || !plane->state->fb)
> -		return;
> +	if (plane->state && plane->state->fb) {
> +		rect.x1 = 0;
> +		rect.y1 = 0;
> +		rect.x2 = plane->state->fb->width;
> +		rect.y2 = plane->state->fb->height;
>   
> -	rect.x1 = 0;
> -	rect.y1 = 0;
> -	rect.x2 = plane->state->fb->width;
> -	rect.y2 = plane->state->fb->height;
> +		hyperv_update_dirt(hv->hdev, &rect);
> +	}
>   
> -	hyperv_update_dirt(hv->hdev, &rect);
> +	vmbus_initiate_unload(true);
>   }
>   
>   static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {

-- 

Jocelyn


