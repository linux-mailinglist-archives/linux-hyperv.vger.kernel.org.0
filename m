Return-Path: <linux-hyperv+bounces-5529-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F7AAB867F
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CA64C307E
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 May 2025 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3394F2222CB;
	Thu, 15 May 2025 12:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2IG/ITz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D9A205AA8
	for <linux-hyperv@vger.kernel.org>; Thu, 15 May 2025 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747312609; cv=none; b=IvxZu2lfEUq6EhFmtFjxwyJNmQ7Lr0LhZWIb8o7JzFXkBToknWm9E1+4GUZ6n/yhl1979MUyjXHHHk0Ai3X9hfQdbf4TDqU93tdwYfxNTr5xMvdQanqn19hnFxFgurc4pUL795s2SvzObhjgxAZPAsqHJIr114UhzMujp4TOPvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747312609; c=relaxed/simple;
	bh=KtItst+tVPfUX6Jz/l7wT1Izd03aa/Nyona6L26fLuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGQbCWMOMgAavD+lK5m26YW5rn+79HAH+qG6orKVpe56RvhfBPkdTVyxALw/Uj4ZyFTR6WeTz9qTV+SplWH34CVaHa35EJY8qDssK0c6cieR59S+8xnpTlws2YTOWh/GGu4jSQBdHFWDnaWIuajfuo8DsHqRw3OAe0pJLdvjXYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2IG/ITz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747312606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3/S03dH18mvOsKY8E0A6cSfSyQYJM5zIpawOtXGVuR0=;
	b=L2IG/ITzak+8BtlDM2nE5EjomruwilLM03P1icQmbS97OhGMQajxkGVtUrxCK/+3iGgf3f
	BPnwQUxEiBM12fKvdTUKPEFEs1W9wVDob8IYgPUv1iVzgGPACYVMcXngfGXCAt1QWz6PaI
	GbpoP2RWRFc/kKWH5GplGnpOVfq2WaI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-aE2vx_SePZG9lTb3BF26mQ-1; Thu, 15 May 2025 08:36:44 -0400
X-MC-Unique: aE2vx_SePZG9lTb3BF26mQ-1
X-Mimecast-MFC-AGG-ID: aE2vx_SePZG9lTb3BF26mQ_1747312603
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so5148815e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 15 May 2025 05:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747312603; x=1747917403;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/S03dH18mvOsKY8E0A6cSfSyQYJM5zIpawOtXGVuR0=;
        b=wDUe8KNPuzh/hpNKw5HZ4+W7wMNJmIzoThOPkgnUphyIk4DSwvWmSVy5mJh43423YQ
         5BY5pHSuVEUcFE1kFJpQb0cf2WA1sXBQYSMMgSTP4VW5AEfLSkl/P0LEpxRn8gvN5cHP
         IPIH2XbtC1r7FTleIiwgtNVmmilcp79T49aaOfQrt4CRqTH/JA9zuIx8Uf0/kBEjbgGq
         qinmepHPY7sXkbN/2/InYzpMIeIg1Hl7SpjrITLCuwh1G0zXkcJpKhnU3mJz/F8eDJ2h
         Q2uNm2LAW6/DElzWLvO5JxJcHu/rmtRjuCBtUbvTmP9qFy9p7/XbI0n6QGxHElUuucI7
         66Yg==
X-Gm-Message-State: AOJu0YyQ/SJgdOuCIKg3Wg38BaFlOlUy3M6H9n7fOkWdzrfdrqrQKg6j
	g6eECyrCjXmAGeXDJlxqf3llS5FTQR2gEvKmI/eNgSHvw6VTt+YQbqJruKXgrK7FVfrrCrM+8lD
	WzolXWAG8wVplOhNQOdv0w3XIJW+571LSvnQ0CzfLSQ1qHHw/J+xDb2/IG8jNASMWjUGnrA==
X-Gm-Gg: ASbGncvHlhd3LIq02X50osnxMH9mfRgcAGaJgwtQb8mQftDWHTu9R1Gf6K4OmBN4sSX
	/FISnCEFtlolQbF1utjTwaOEdqAJAg27SP6nCT9wDNuRf5+Rh3GBsQXhUlUFk6AXPNFI8r9VkSx
	jEqUif5tN2MfHp4NIkBIRFJTaboL0YHqWq2RcIaeWk3CIYhOR66Yv6xqJOOISK7HWxcndiS7oYH
	Qk5H6sFNpIGFvRJpq4K/zAkJ7aNGR2czJ0DzotOopPegD4KQsbpJ2AQGX6nK0diCMAOQweAN3wo
	z7JkXS0RzSpgcyrKXZgSzf1dqTFh1AK61pSVc4V1auYr51GRkbc=
X-Received: by 2002:a5d:64ef:0:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3a3537b2b19mr2119417f8f.48.1747312603028;
        Thu, 15 May 2025 05:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW+fc/paIy0LngUuAZvkr2KSybx6XcshvfV0u1EKTGvMHktZ02hVPJFpm8v6TN4gX6XJjj9Q==
X-Received: by 2002:a5d:64ef:0:b0:3a0:aed9:e34 with SMTP id ffacd0b85a97d-3a3537b2b19mr2119381f8f.48.1747312602550;
        Thu, 15 May 2025 05:36:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c7a5sm22898309f8f.98.2025.05.15.05.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 05:36:41 -0700 (PDT)
Message-ID: <5d507ba5-8205-4305-ad06-b0f2ac46b7c8@redhat.com>
Date: Thu, 15 May 2025 14:36:40 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH drm-next v3] drm/hyperv: Replace simple-KMS with regular
 atomic helpers
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, drawat.floss@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, javierm@redhat.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
References: <20250427101825.812766-1-ryasuoka@redhat.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20250427101825.812766-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27/04/2025 12:18, Ryosuke Yasuoka wrote:
> Drop simple-KMS in favor of regular atomic helpers to make the code more
> modular. The simple-KMS helper mix up plane and CRTC state, so it is
> obsolete and should go away [1]. Since it just split the simple-pipe
> functions into per-plane and per-CRTC, no functional changes is
> expected.

I just pushed it to drm-misc-next, thanks for your contribution.

Best regards,

-- 

Jocelyn

> 
> [1] https://lore.kernel.org/lkml/dae5089d-e214-4518-b927-5c4149babad8@suse.de/
> 
> Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> ---
> v3:
> - Remove hyperv_crtc_helper_atomic_disable
> - Use drm_atomic_get_new_plane_state instead of accessing the
>    plane->state directly
> - Iterate and handle each damage areas instead of merge these damage
>    areas
> 
> v2:
> https://lore.kernel.org/lkml/20250425063234.757344-1-ryasuoka@redhat.com/
> 
> - Remove hyperv_crtc_helper_mode_valid
> - Remove hyperv_format_mod_supported
> - Call helper_add after {plane,crtc}_init
> - Move drm_plane_enable_fb_damage_clips to a place close to plane init
> - Move hyperv_conn_init() into hyperv_pipe_init
> - Remove hyperv_blit_to_vram_fullscreen
> - Remove format check
> - Replace hyperv_crtc_helper_atomic_check to drm_crtc_helper_atomic_check
> 
> v1:
> https://lore.kernel.org/all/20250420121945.573915-1-ryasuoka@redhat.com/
> 
>   drivers/gpu/drm/hyperv/hyperv_drm.h         |   4 +-
>   drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 172 +++++++++++++-------
>   2 files changed, 115 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
> index d2d8582b36df..9e776112c03e 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm.h
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
> @@ -11,7 +11,9 @@
>   struct hyperv_drm_device {
>   	/* drm */
>   	struct drm_device dev;
> -	struct drm_simple_display_pipe pipe;
> +	struct drm_plane plane;
> +	struct drm_crtc crtc;
> +	struct drm_encoder encoder;
>   	struct drm_connector connector;
>   
>   	/* mode */
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 6c6b57298797..f7d2e973f79e 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -5,6 +5,8 @@
>   
>   #include <linux/hyperv.h>
>   
> +#include <drm/drm_atomic.h>
> +#include <drm/drm_crtc_helper.h>
>   #include <drm/drm_damage_helper.h>
>   #include <drm/drm_drv.h>
>   #include <drm/drm_edid.h>
> @@ -15,7 +17,7 @@
>   #include <drm/drm_gem_framebuffer_helper.h>
>   #include <drm/drm_gem_shmem_helper.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
> +#include <drm/drm_plane.h>
>   
>   #include "hyperv_drm.h"
>   
> @@ -38,18 +40,6 @@ static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
>   	return 0;
>   }
>   
> -static int hyperv_blit_to_vram_fullscreen(struct drm_framebuffer *fb,
> -					  const struct iosys_map *map)
> -{
> -	struct drm_rect fullscreen = {
> -		.x1 = 0,
> -		.x2 = fb->width,
> -		.y1 = 0,
> -		.y2 = fb->height,
> -	};
> -	return hyperv_blit_to_vram_rect(fb, map, &fullscreen);
> -}
> -
>   static int hyperv_connector_get_modes(struct drm_connector *connector)
>   {
>   	struct hyperv_drm_device *hv = to_hv(connector->dev);
> @@ -98,30 +88,66 @@ static int hyperv_check_size(struct hyperv_drm_device *hv, int w, int h,
>   	return 0;
>   }
>   
> -static void hyperv_pipe_enable(struct drm_simple_display_pipe *pipe,
> -			       struct drm_crtc_state *crtc_state,
> -			       struct drm_plane_state *plane_state)
> +static const uint32_t hyperv_formats[] = {
> +	DRM_FORMAT_XRGB8888,
> +};
> +
> +static const uint64_t hyperv_modifiers[] = {
> +	DRM_FORMAT_MOD_LINEAR,
> +	DRM_FORMAT_MOD_INVALID
> +};
> +
> +static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					     struct drm_atomic_state *state)
>   {
> -	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
> -	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
> +	struct hyperv_drm_device *hv = to_hv(crtc->dev);
> +	struct drm_plane *plane = &hv->plane;
> +	struct drm_plane_state *plane_state = plane->state;
> +	struct drm_crtc_state *crtc_state = crtc->state;
>   
>   	hyperv_hide_hw_ptr(hv->hdev);
>   	hyperv_update_situation(hv->hdev, 1,  hv->screen_depth,
>   				crtc_state->mode.hdisplay,
>   				crtc_state->mode.vdisplay,
>   				plane_state->fb->pitches[0]);
> -	hyperv_blit_to_vram_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
>   }
>   
> -static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
> -			     struct drm_plane_state *plane_state,
> -			     struct drm_crtc_state *crtc_state)
> +static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
> +	.atomic_check = drm_crtc_helper_atomic_check,
> +	.atomic_enable = hyperv_crtc_helper_atomic_enable,
> +};
> +
> +static const struct drm_crtc_funcs hyperv_crtc_funcs = {
> +	.reset = drm_atomic_helper_crtc_reset,
> +	.destroy = drm_crtc_cleanup,
> +	.set_config = drm_atomic_helper_set_config,
> +	.page_flip = drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static int hyperv_plane_atomic_check(struct drm_plane *plane,
> +				     struct drm_atomic_state *state)
>   {
> -	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
> +	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct hyperv_drm_device *hv = to_hv(plane->dev);
>   	struct drm_framebuffer *fb = plane_state->fb;
> +	struct drm_crtc *crtc = plane_state->crtc;
> +	struct drm_crtc_state *crtc_state = NULL;
> +	int ret;
>   
> -	if (fb->format->format != DRM_FORMAT_XRGB8888)
> -		return -EINVAL;
> +	if (crtc)
> +		crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);
> +	if (ret)
> +		return ret;
> +
> +	if (!plane_state->visible)
> +		return 0;
>   
>   	if (fb->pitches[0] * fb->height > hv->fb_size) {
>   		drm_err(&hv->dev, "fb size requested by %s for %dX%d (pitch %d) greater than %ld\n",
> @@ -132,53 +158,85 @@ static int hyperv_pipe_check(struct drm_simple_display_pipe *pipe,
>   	return 0;
>   }
>   
> -static void hyperv_pipe_update(struct drm_simple_display_pipe *pipe,
> -			       struct drm_plane_state *old_state)
> +static void hyperv_plane_atomic_update(struct drm_plane *plane,
> +				       struct drm_atomic_state *state)
>   {
> -	struct hyperv_drm_device *hv = to_hv(pipe->crtc.dev);
> -	struct drm_plane_state *state = pipe->plane.state;
> -	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
> -	struct drm_rect rect;
> -
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect)) {
> -		hyperv_blit_to_vram_rect(state->fb, &shadow_plane_state->data[0], &rect);
> -		hyperv_update_dirt(hv->hdev, &rect);
> +	struct hyperv_drm_device *hv = to_hv(plane->dev);
> +	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
> +	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
> +	struct drm_rect damage;
> +	struct drm_rect dst_clip;
> +	struct drm_atomic_helper_damage_iter iter;
> +
> +	drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> +		dst_clip = new_state->dst;
> +
> +		if (!drm_rect_intersect(&dst_clip, &damage))
> +			continue;
> +
> +		hyperv_blit_to_vram_rect(new_state->fb, &shadow_plane_state->data[0], &damage);
> +		hyperv_update_dirt(hv->hdev, &damage);
>   	}
>   }
>   
> -static const struct drm_simple_display_pipe_funcs hyperv_pipe_funcs = {
> -	.enable	= hyperv_pipe_enable,
> -	.check = hyperv_pipe_check,
> -	.update	= hyperv_pipe_update,
> -	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
> +static const struct drm_plane_helper_funcs hyperv_plane_helper_funcs = {
> +	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
> +	.atomic_check = hyperv_plane_atomic_check,
> +	.atomic_update = hyperv_plane_atomic_update,
>   };
>   
> -static const uint32_t hyperv_formats[] = {
> -	DRM_FORMAT_XRGB8888,
> +static const struct drm_plane_funcs hyperv_plane_funcs = {
> +	.update_plane		= drm_atomic_helper_update_plane,
> +	.disable_plane		= drm_atomic_helper_disable_plane,
> +	.destroy		= drm_plane_cleanup,
> +	DRM_GEM_SHADOW_PLANE_FUNCS,
>   };
>   
> -static const uint64_t hyperv_modifiers[] = {
> -	DRM_FORMAT_MOD_LINEAR,
> -	DRM_FORMAT_MOD_INVALID
> +static const struct drm_encoder_funcs hyperv_drm_simple_encoder_funcs_cleanup = {
> +	.destroy = drm_encoder_cleanup,
>   };
>   
>   static inline int hyperv_pipe_init(struct hyperv_drm_device *hv)
>   {
> +	struct drm_device *dev = &hv->dev;
> +	struct drm_encoder *encoder = &hv->encoder;
> +	struct drm_plane *plane = &hv->plane;
> +	struct drm_crtc *crtc = &hv->crtc;
> +	struct drm_connector *connector = &hv->connector;
>   	int ret;
>   
> -	ret = drm_simple_display_pipe_init(&hv->dev,
> -					   &hv->pipe,
> -					   &hyperv_pipe_funcs,
> -					   hyperv_formats,
> -					   ARRAY_SIZE(hyperv_formats),
> -					   hyperv_modifiers,
> -					   &hv->connector);
> +	ret = drm_universal_plane_init(dev, plane, 0,
> +				       &hyperv_plane_funcs,
> +				       hyperv_formats, ARRAY_SIZE(hyperv_formats),
> +				       hyperv_modifiers,
> +				       DRM_PLANE_TYPE_PRIMARY, NULL);
> +	if (ret)
> +		return ret;
> +	drm_plane_helper_add(plane, &hyperv_plane_helper_funcs);
> +	drm_plane_enable_fb_damage_clips(plane);
> +
> +	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
> +					&hyperv_crtc_funcs, NULL);
>   	if (ret)
>   		return ret;
> +	drm_crtc_helper_add(crtc, &hyperv_crtc_helper_funcs);
>   
> -	drm_plane_enable_fb_damage_clips(&hv->pipe.plane);
> +	encoder->possible_crtcs = drm_crtc_mask(crtc);
> +	ret = drm_encoder_init(dev, encoder,
> +			       &hyperv_drm_simple_encoder_funcs_cleanup,
> +			       DRM_MODE_ENCODER_NONE, NULL);
> +	if (ret)
> +		return ret;
>   
> -	return 0;
> +	ret = hyperv_conn_init(hv);
> +	if (ret) {
> +		drm_err(dev, "Failed to initialized connector.\n");
> +		return ret;
> +	}
> +
> +	return drm_connector_attach_encoder(connector, encoder);
>   }
>   
>   static enum drm_mode_status
> @@ -221,12 +279,6 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
>   
>   	dev->mode_config.funcs = &hyperv_mode_config_funcs;
>   
> -	ret = hyperv_conn_init(hv);
> -	if (ret) {
> -		drm_err(dev, "Failed to initialized connector.\n");
> -		return ret;
> -	}
> -
>   	ret = hyperv_pipe_init(hv);
>   	if (ret) {
>   		drm_err(dev, "Failed to initialized pipe.\n");
> 
> base-commit: d2b9e2f8a15d53121ae8f2c67b69cf06b6fa586c


