Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8DAA4389C4
	for <lists+linux-hyperv@lfdr.de>; Sun, 24 Oct 2021 17:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbhJXPXJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 24 Oct 2021 11:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJXPXI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:08 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC955C061745
        for <linux-hyperv@vger.kernel.org>; Sun, 24 Oct 2021 08:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Z+JCqRsIAZ4rGW6LUUM6/W+OopfRqSRXjgw2egWOJo=; b=wJYe6FTwloWwN01yrvYl1lf3Kl
        STs5TC9+qdg7ZlrstbwCK8RDMZvjyU8y9XmGh5IaK/u9PrQyi6hdVm6bVC6ooN851XN/5p7+caiIN
        0JFN1wKyd5xhltDeTBtGkuK5zoC7ciBxPmvR6QzlU/3hXAP3GKBL2AlNU8ocS8ZwWDNn3iKpEmUoB
        eXnsD5Pjn68AfOBmj3kT9u8GcamFlHU688Hi8njP2W3GB3eIO3ivqG3p+JdzQNXo/iOXxGXmPbMqJ
        /AeZHNg6hf8Vw6QkobkPwLj2962B51R96/NhENJ8JShgX2w0wAjDnjl1mYVDOfQ4air9/JVfcYEsC
        49FFYwpw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49254 helo=[192.168.10.61])
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <noralf@tronnes.org>)
        id 1mefIj-00075m-IR; Sun, 24 Oct 2021 17:20:45 +0200
Subject: Re: [PATCH 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, drawat.floss@gmail.com,
        airlied@redhat.com, kraxel@redhat.com, david@lechnology.com,
        sam@ravnborg.org, javierm@redhat.com, kernel@amanoeldawod.com,
        dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch, aros@gmx.com,
        joshua@stroblindustries.com, arnd@arndb.de
Cc:     dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-8-tzimmermann@suse.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <14b1c21f-25e5-d862-40ea-dda1e076ef63@tronnes.org>
Date:   Sun, 24 Oct 2021 17:20:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-8-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



Den 22.10.2021 15.28, skrev Thomas Zimmermann:
> Enable the FB_DAMAGE_CLIPS property to reduce display-update
> overhead. Also fixes a warning in the kernel log.
> 
>   simple-framebuffer simple-framebuffer.0: [drm] drm_plane_enable_fb_damage_clips() not called
> 
> Fix the computation of the blit rectangle. This wasn't an issue so
> far, as simpledrm always blitted the full framebuffer. The code now
> supports damage clipping and virtual screen sizes.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/simpledrm.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
> index 571f716ff427..e872121e9fb0 100644
> --- a/drivers/gpu/drm/tiny/simpledrm.c
> +++ b/drivers/gpu/drm/tiny/simpledrm.c
> @@ -642,7 +642,7 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
>  	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
>  	struct drm_device *dev = &sdev->dev;
>  	void __iomem *dst = sdev->screen_base;
> -	struct drm_rect clip;
> +	struct drm_rect src_clip, dst_clip;
>  	int idx;
>  
>  	if (!fb)
> @@ -651,10 +651,14 @@ simpledrm_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
>  	if (!drm_dev_enter(dev, &idx))
>  		return;
>  
> -	drm_rect_init(&clip, 0, 0, fb->width, fb->height);
> +	drm_rect_fp_to_int(&src_clip, &plane_state->src);
>  
> -	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &clip);
> -	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &clip);
> +	dst_clip = plane_state->dst;
> +	if (!drm_rect_intersect(&dst_clip, &src_clip))
> +		return;
> +
> +	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
> +	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
>  
>  	drm_dev_exit(idx);
>  }
> @@ -686,20 +690,28 @@ simpledrm_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
>  	struct drm_framebuffer *fb = plane_state->fb;
>  	struct drm_device *dev = &sdev->dev;
>  	void __iomem *dst = sdev->screen_base;
> -	struct drm_rect clip;
> +	struct drm_rect damage_clip, src_clip, dst_clip;
>  	int idx;
>  
>  	if (!fb)
>  		return;
>  
> -	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &clip))
> +	if (!drm_atomic_helper_damage_merged(old_plane_state, plane_state, &damage_clip))
> +		return;
> +

I'm afraid I don't understand what's going on here, but isn't it
possible to put this logic into drm_atomic_helper_damage_merged()?

Noralf.

> +	drm_rect_fp_to_int(&src_clip, &plane_state->src);
> +	if (!drm_rect_intersect(&src_clip, &damage_clip))
> +		return;
> +
> +	dst_clip = plane_state->dst;
> +	if (!drm_rect_intersect(&dst_clip, &src_clip))
>  		return;
>  
>  	if (!drm_dev_enter(dev, &idx))
>  		return;
>  
> -	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &clip);
> -	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &clip);
> +	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
> +	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
>  
>  	drm_dev_exit(idx);
>  }
> @@ -794,6 +806,8 @@ static int simpledrm_device_init_modeset(struct simpledrm_device *sdev)
>  	if (ret)
>  		return ret;
>  
> +	drm_plane_enable_fb_damage_clips(&pipe->plane);
> +
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> 
