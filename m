Return-Path: <linux-hyperv+bounces-5666-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A942AC49EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D811917AA05
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161BB248F47;
	Tue, 27 May 2025 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ivVl5llu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E8188715
	for <linux-hyperv@vger.kernel.org>; Tue, 27 May 2025 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333519; cv=none; b=KRh9d0Pr7fHNiy54T717RC//nzZQRQuvmvrYLR8p1xF/g/MMbiuU+QIDv43rnhQC3C/8aneaDpaAj58K5ZBOwxjtkWNzerzG+2KUhJveTpzaJXCnUCV5sCbW4vjX/ejOt1eV6nJWFcAzZRFPaIBIfcIbJIIs5ia0YPYtBhX69rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333519; c=relaxed/simple;
	bh=M0Z25TQaMMnFn5IurMQklTpt99v4cvYnHAu/IuqEobk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Loqm5PXJe2Z9U2VB4FZxXcux08PuL7itNrJOLEMT59U5rG41H7bMZcvEeMgGgaZu7OHXM5YpsfbdkvI4cCxQz0JuHfKVQRWAfF39MlIfUpDcyEumfNk4MP2Fnp3I+saogXuCTz8N0wguG0R7aIquNaj0FGiBLCRZS/2nXTibs2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ivVl5llu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748333515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uc8SBIaKuW9hd4Ztl1l2JfCcfjBxitXGrH2FjSYGyBI=;
	b=ivVl5llu4DBwRCGO/v62wKHTpLkR7kCUspjWqEZDX90bcPDQlREBOZxj6zK/sUEu/Hdv7x
	M/NHh2FYdIISFj+Mw1ymCWoTHKfbNd0+pjUHVeoDU/WstdVOggRm7T6Xg0fkAEHY87d8bP
	kOt5RgrMuKnX8LkWA2AYEaxeArSAves=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-Q-_dSc75M-qFPuJCLj8a_g-1; Tue, 27 May 2025 04:11:53 -0400
X-MC-Unique: Q-_dSc75M-qFPuJCLj8a_g-1
X-Mimecast-MFC-AGG-ID: Q-_dSc75M-qFPuJCLj8a_g_1748333512
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso22798505e9.0
        for <linux-hyperv@vger.kernel.org>; Tue, 27 May 2025 01:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748333512; x=1748938312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc8SBIaKuW9hd4Ztl1l2JfCcfjBxitXGrH2FjSYGyBI=;
        b=uCqVX6MDt8A4atGyVb+SUzW/53TWO4xS+gpWWJ1oYvdv0/peEGFXiNTwnqezuE5nI7
         HRhKnOvXV9NgPYJmZ3hV7eq2SgoY8hHeoHm7eCc1n0Sh1CO2IMoR1LsKZ3xKkslDSjjR
         dROOhXxCltFpvZD49n9SY25b7Jt9CBodH4UjqlQfiKuhFKUGi+xZzAchSD702qHg+bOr
         mT6DW6SNjvAmGbgKnjBL7KYSyVlTYCq5ObfNdhPAq3S5u5cAVkZKTuSM/UrMhi4GFU7G
         NIsDd5g63iM7WAOe9WTPaaICrY/kBUuS2DpO1HMgII4eUtwpKguO7UDLx45tU8i5VmxZ
         NHvg==
X-Gm-Message-State: AOJu0YxfsF07fzbnHgi0w6N3Mj/afj26jkhoFVMSrwTAcDgJWHJXJpiE
	GIFcbq1unS+b7NVwvnTN3/zULnphe+alxIyubaTE7pYURQ1HkGTI80MYTT0tcOuwtWwdWv/6tff
	r2lPc2xDXVaA1NMRCbB6deSpZPTKURDUMEvrEXY7mfFpIyKVrKDKIH/usQ3cMUg7LNQ==
X-Gm-Gg: ASbGncsUOmLyYxU1oz5cdNrBkwWE60DKjCjeGP47OdL+BHHxoQn84z0cFgAEoBlN7Jr
	HuWfTyLG79QMJFJSLOS0NlUYnHkhGB1jRCwRacqblTnM29wcRfmBLiDUoZNld7KLlPmcw6URtTy
	lRcdqSNtljmdIgvCNRQ/duvDi5F8LJqCRerBieOqqCR01dXrmzYblemL8hYofbMF2iEZs3MGtzK
	KyX+K6b+++V21WjkC0pqAt89W4LMa8enbVtlo38UR26GzBKfXzleimXccVdxNJRoADYYo4mN+7c
	PP12ffM6DeCBM/QBLHaKSKj51RLnwBLcD94eS5khzrCazCd9ohU=
X-Received: by 2002:a05:600c:64c5:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-44c935dbb26mr120963405e9.30.1748333512423;
        Tue, 27 May 2025 01:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYAtk9413NqBo2PajYHvgPjwcpaG+eT7N4Q6fyVV+Lil0t7i7dtNFpt991DzyOflFbKn4oJA==
X-Received: by 2002:a05:600c:64c5:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-44c935dbb26mr120963055e9.30.1748333511996;
        Tue, 27 May 2025 01:11:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7d975f4sm258858665e9.39.2025.05.27.01.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 01:11:50 -0700 (PDT)
Message-ID: <8bfce982-b22a-4ef3-b79e-5e22a3364c5a@redhat.com>
Date: Tue, 27 May 2025 10:11:49 +0200
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

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
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


