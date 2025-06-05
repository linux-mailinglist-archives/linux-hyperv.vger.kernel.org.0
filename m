Return-Path: <linux-hyperv+bounces-5783-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A5ACEFD8
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jun 2025 15:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F4516B5CF
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Jun 2025 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3A3218E91;
	Thu,  5 Jun 2025 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCQBByXq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470E913D24D
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Jun 2025 13:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128576; cv=none; b=t3X7ptYniM6e8CTf0tEBDI817TEw6fShMvlSI9TpBtx6BOOfQlSLqrJ9rTjTg/VcF0euxWKpFySXEczd8F7P8u7C+duJRVOFxsXj/j+5lDkAovWa7z3wqR6PjDfwwj3XWkfo/Y3FCt2Kyw/QXi+hSh4QqdcKcdXBSU9s9kvgLVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128576; c=relaxed/simple;
	bh=5de8RG8f3o6sWoFM1mI4X9Fp3LN5IoyHomEe0eRNiZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCLawhRUBUxG3INBpu4WCXCua6W+ykJ3UID8MIRjIYs+PXdNHPdwew/xFv2BDAwNP7ADz+HeLVBUXb+S21tSj5YiCEI/Brr+nbF1q18OtVa3Mnnh0fDpRltHKn2klXkWiEWmDC+V4Suptx9hbwPlPh0tWen1MZyIkEajEcF+axc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SCQBByXq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749128573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xg498BWU6yCD+3EXYlmoQ452Swm7wT/w2qqavlOm8pU=;
	b=SCQBByXqUjYZPGfpazz9qFT8NpPnIuSs4gt3rJ4T9nWw77OnYYtrfC+XlkL0BA4l+ixT/m
	MSpcMJnPUA0K3Uo2yyvKN+Y24+Mkzo0GmbmYNqUnCctt7eWi9WUjTgH29ssUshtyDpvwVw
	MQD9g0IqbS8yQK7O3BhEeBcX67zLMmA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-1ibcN2JbOMyc6Nzc8B40ug-1; Thu, 05 Jun 2025 09:02:51 -0400
X-MC-Unique: 1ibcN2JbOMyc6Nzc8B40ug-1
X-Mimecast-MFC-AGG-ID: 1ibcN2JbOMyc6Nzc8B40ug_1749128569
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so5592505e9.2
        for <linux-hyperv@vger.kernel.org>; Thu, 05 Jun 2025 06:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749128569; x=1749733369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xg498BWU6yCD+3EXYlmoQ452Swm7wT/w2qqavlOm8pU=;
        b=CbUEdG2TrooiTLEyPUH7Ho1EZpmS50gAxd+cAmPQQnQaSn0MLkNWxObGanntFBJnd4
         oOayZP056jVYNTSjhQdtMdp3lQ2Dt4pRMScXmM1npMaZuHgIAkXhNAGUjwHKLQxtn/p3
         hobJtDpCGdGevotyQP58+oxEPf4wkSSq2woRDvQEXbKg6Jm4+ByXKg9VGkkg9tGyHClQ
         BieUE0LYiZjJS6JuvezKCvHj/HBJZefWp16WNTfqlx1ZCgkiEqShdm/KPpPNgNCdLFJc
         HrHcwmToNbFMYca6ssmFf+zBEyJzD2hO6FcXTC5ZREmYOZ/rS/SAgqiguuEpggY5Nky/
         D82w==
X-Gm-Message-State: AOJu0Yx80pKAPnH1ESexUGBJD/9CCeoBPfue7rCfwn3yeT6PCd2/Ewe8
	InXyr7tYv0rzAAYjTKVge5nK9H7NSS5JZus71GAv4YhcaC1nNK6WGlwqrL9OVQr6T3JQoFo4AXU
	tDb9TesvAu1rdHRf4b1u0eoLBHjqW7vbdtl4GkZWBb63B3rua8yIp4+8J2MLcKsS8hw==
X-Gm-Gg: ASbGncsmHji/bXmXOw8ojjJJCNXJ3Va2WERwFhTzwmAN0iqTEbd/ouG9GB6uwMurcXo
	VCDdWsj9vxW3oTgnK/VaP6dpU7V7wC4PMfXmvW8G6Qu+Yun8foqX3aAy/Q6sluvlZsAYfOi+Pn2
	W7OJrUHPzoaawgcNRTR1/7Z920QR8zfryLGQioa6h2abgcaWYdfBjb8fYPKLIPL0PNRVSLZeMEc
	W1dctRqtCzbKcefmTap6L7YduK+Yy9NwXnS/GpDkR6fbIhPIP2lDVC/o7ph+ur0QQlOfEC7T81a
	FXKVhREkWUulAvkbbxfGeOUszbltHX7mdMMgBQEx42c0alUBv9o=
X-Received: by 2002:a05:6000:2204:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3a51d961c1fmr5842942f8f.36.1749128569240;
        Thu, 05 Jun 2025 06:02:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLOWcpTWTCDyXBY4w2ZvbieYKYJr5NwdKMUi24PSZUQgwCDHfdsFZ1q9E35GmfdHu/7yFH7g==
X-Received: by 2002:a05:6000:2204:b0:3a1:f564:cd9d with SMTP id ffacd0b85a97d-3a51d961c1fmr5842816f8f.36.1749128568020;
        Thu, 05 Jun 2025 06:02:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f00a13fasm24830979f8f.98.2025.06.05.06.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:02:47 -0700 (PDT)
Message-ID: <f1927c1b-95b7-4d98-9d95-fcd52bd06766@redhat.com>
Date: Thu, 5 Jun 2025 15:02:46 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC drm-misc-next v2 1/1] drm/hyperv: Add support for
 drm_panic
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250526090117.80593-1-ryasuoka@redhat.com>
 <20250526090117.80593-2-ryasuoka@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250526090117.80593-2-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/05/2025 11:01, Ryosuke Yasuoka wrote:
> Add drm_panic module for hyperv drm so that panic screen can be
> displayed on panic.

I've just pushed it to drm-misc-next.

Thanks for your contribution.

-- 

Jocelyn

> 
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 36 +++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index f7d2e973f79e..945b9482bcb3 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -17,6 +17,7 @@
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_probe_helper.h>
> +#include <drm/drm_panic.h>
>   #include <drm/drm_plane.h>
>   
>   #include "hyperv_drm.h"
> @@ -181,10 +182,45 @@ static void hyperv_plane_atomic_update(struct drm_plane *plane,
>   	}
>   }
>   
> +static int hyperv_plane_get_scanout_buffer(struct drm_plane *plane,
> +					   struct drm_scanout_buffer *sb)
> +{
> +	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct iosys_map map = IOSYS_MAP_INIT_VADDR_IOMEM(hv->vram);
> +
> +	if (plane->state && plane->state->fb) {
> +		sb->format = plane->state->fb->format;
> +		sb->width = plane->state->fb->width;
> +		sb->height = plane->state->fb->height;
> +		sb->pitch[0] = plane->state->fb->pitches[0];
> +		sb->map[0] = map;
> +		return 0;
> +	}
> +	return -ENODEV;
> +}
> +
> +static void hyperv_plane_panic_flush(struct drm_plane *plane)
> +{
> +	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct drm_rect rect;
> +
> +	if (!plane->state || !plane->state->fb)
> +		return;
> +
> +	rect.x1 = 0;
> +	rect.y1 = 0;
> +	rect.x2 = plane->state->fb->width;
> +	rect.y2 = plane->state->fb->height;
> +
> +	hyperv_update_dirt(hv->hdev, &rect);
> +}
> +
>   static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
>   	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
>   	.atomic_check = hyperv_plane_atomic_check,
>   	.atomic_update = hyperv_plane_atomic_update,
> +	.get_scanout_buffer = hyperv_plane_get_scanout_buffer,
> +	.panic_flush = hyperv_plane_panic_flush,
>   };
>   
>   static const struct drm_plane_funcs hyperv_plane_funcs = {


