Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B68585A69
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Jul 2022 14:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiG3M1n (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 30 Jul 2022 08:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiG3M1n (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 30 Jul 2022 08:27:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C654E647A
        for <linux-hyperv@vger.kernel.org>; Sat, 30 Jul 2022 05:27:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l22so8779489wrz.7
        for <linux-hyperv@vger.kernel.org>; Sat, 30 Jul 2022 05:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=y251+SMw9dFcMWhUuvxqMsxuuJVpgWF8D/ESUIMfYm8=;
        b=fu9SwVvu/AtCgZPViD9wD1lgJOrCBVDJgZd5mwHhlo7AaPmP8TyeSjJocGTY7y0njg
         +MqlORRbFyuDjeduj9GSrGQLwPor/DYpgX7VV6vgEwcKSfOEz9vjCGC6US8o+VisUAMx
         YY1s+Fu5eSjEb6r6MEpWs25IM7iY4VjmEf1pi5urS5rtTz/OVTLp0zV7eaSh0/s1cS2n
         Y70FcaRyjljifjG5STsnKeln/+ievQf1gdp3Jg4Ob6q+2B1vCiDa8W+RUtbIahNqcOje
         sCZDPmi+B4FWH5YXzE0t483rIrsRl7fU4RgHziC3GNTEQmObGr6KZPNec/ZC7bcDGlR1
         0Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=y251+SMw9dFcMWhUuvxqMsxuuJVpgWF8D/ESUIMfYm8=;
        b=bhZ6g39y05UUF+cuIskR83QxSYkTvEIR6l6L4e1Ht0wCUs40Y0eq8T2+GN3Y5CjhQ2
         wQzoSOhMfZfiv9GAVEDu0yHRirYN0I5XsCswFW3RWzsaj0hr72E0JT8BbZ7j6892bm69
         TkTs/H5cPIaAZKlBhVBxeU98DzbVoeL0r3RbMQb9MrT4Y9VHQ0X+GJXKqNfsKGMStxzX
         91yzjagtBNf13oGkyShSV4y85IXhhJj0lcH+WyJBiSOe0GTmNPrzFmjrxH5/5lJdOnmW
         ikPqcPt2DVAuw068Bad7bIkA46GXHZ7k5qVP3Kra6R3t67SLV+yQPODdmqukUwfko7ZL
         0P/g==
X-Gm-Message-State: ACgBeo06c9mMohoqdHfSoRrae6e92uHExjfwNYbQfLuQImXBw/eSnNCU
        EsagHRbpitsl7ddUdiSCJtU=
X-Google-Smtp-Source: AA6agR6YTlIJruWlAlXRtoIxG9zqyTFlFOf3MS8bEvDBJKvULEr5qoXMm8uva23JEwe2iTvW4EQD5g==
X-Received: by 2002:a05:6000:547:b0:218:5f6a:f5db with SMTP id b7-20020a056000054700b002185f6af5dbmr5105690wrf.480.1659184060271;
        Sat, 30 Jul 2022 05:27:40 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c220700b003a3188bef63sm7544067wml.11.2022.07.30.05.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 05:27:39 -0700 (PDT)
Date:   Sat, 30 Jul 2022 14:27:37 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     sam@ravnborg.org, noralf@tronnes.org, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, airlied@redhat.com,
        javierm@redhat.com, drawat.floss@gmail.com, kraxel@redhat.com,
        david@lechnology.com, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 05/12] drm/format-helper: Rework XRGB8888-to-RGBG565
 conversion
Message-ID: <20220730122737.GA108772@elementary>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-6-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220727113312.22407-6-tzimmermann@suse.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Thomas,

On Wed, Jul 27, 2022 at 01:33:05PM +0200, Thomas Zimmermann wrote:
> Update XRGB8888-to-RGB565 conversion to support struct iosys_map
> and convert all users. Although these are single-plane color formats,
> the new interface supports multi-plane formats for consistency with
> drm_fb_blit().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Tested-by: José Expósito <jose.exposito89@gmail.com>
Reviewed-by: José Expósito <jose.exposito89@gmail.com>

In order to continue working on the missing tests for drm_format_helper
I rebased your series on top of drm-misc-next and fixed the conflicts
in the tests [1]. It is an easy fix, but feel free to copy & paste the
code if you want to save a couple of minutes.

FWIW, I ran the existing test for RGB565 on little and big endian archs
and they are working as expected.

Jose

[1] https://github.com/JoseExposito/linux/commit/175af3a6b6b9b8013e9925c06b4951fffbbce15b

> ---
>  drivers/gpu/drm/drm_format_helper.c | 59 +++++++++++------------------
>  drivers/gpu/drm/drm_mipi_dbi.c      |  4 +-
>  drivers/gpu/drm/gud/gud_pipe.c      |  3 +-
>  drivers/gpu/drm/tiny/cirrus.c       |  3 +-
>  include/drm/drm_format_helper.h     |  9 ++---
>  5 files changed, 30 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 2b5c3746ff4a..8bf5655f5ce0 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -330,9 +330,9 @@ static void drm_fb_xrgb8888_to_rgb565_swab_line(void *dbuf, const void *sbuf,
>  
>  /**
>   * drm_fb_xrgb8888_to_rgb565 - Convert XRGB8888 to RGB565 clip buffer
> - * @dst: RGB565 destination buffer
> - * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> - * @vaddr: XRGB8888 source buffer
> + * @dst: Array of RGB565 destination buffers
> + * @dst_pitch: Array of numbers of bytes between two consecutive scanlines within dst
> + * @vmap: Array of XRGB8888 source buffer
>   * @fb: DRM framebuffer
>   * @clip: Clip rectangle area to copy
>   * @swab: Swap bytes
> @@ -340,43 +340,31 @@ static void drm_fb_xrgb8888_to_rgb565_swab_line(void *dbuf, const void *sbuf,
>   * Drivers can use this function for RGB565 devices that don't natively
>   * support XRGB8888.
>   */
> -void drm_fb_xrgb8888_to_rgb565(void *dst, unsigned int dst_pitch, const void *vaddr,
> -			       const struct drm_framebuffer *fb, const struct drm_rect *clip,
> -			       bool swab)
> +void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst, const unsigned int *dst_pitch,
> +			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +			       const struct drm_rect *clip, bool swab)
>  {
> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> +		0, 0, 0, 0
> +	};
> +	void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels);
> +
>  	if (swab)
> -		drm_fb_xfrm(dst, dst_pitch, 2, vaddr, fb, clip, false,
> -			    drm_fb_xrgb8888_to_rgb565_swab_line);
> +		xfrm_line = drm_fb_xrgb8888_to_rgb565_swab_line;
>  	else
> -		drm_fb_xfrm(dst, dst_pitch, 2, vaddr, fb, clip, false,
> -			    drm_fb_xrgb8888_to_rgb565_line);
> -}
> -EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
> +		xfrm_line = drm_fb_xrgb8888_to_rgb565_line;
>  
> -/**
> - * drm_fb_xrgb8888_to_rgb565_toio - Convert XRGB8888 to RGB565 clip buffer
> - * @dst: RGB565 destination buffer (iomem)
> - * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> - * @vaddr: XRGB8888 source buffer
> - * @fb: DRM framebuffer
> - * @clip: Clip rectangle area to copy
> - * @swab: Swap bytes
> - *
> - * Drivers can use this function for RGB565 devices that don't natively
> - * support XRGB8888.
> - */
> -void drm_fb_xrgb8888_to_rgb565_toio(void __iomem *dst, unsigned int dst_pitch,
> -				    const void *vaddr, const struct drm_framebuffer *fb,
> -				    const struct drm_rect *clip, bool swab)
> -{
> -	if (swab)
> -		drm_fb_xfrm_toio(dst, dst_pitch, 2, vaddr, fb, clip, false,
> -				 drm_fb_xrgb8888_to_rgb565_swab_line);
> +	if (!dst_pitch)
> +		dst_pitch = default_dst_pitch;
> +
> +	if (dst[0].is_iomem)
> +		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 2, vmap[0].vaddr, fb, clip,
> +				 false, xfrm_line);
>  	else
> -		drm_fb_xfrm_toio(dst, dst_pitch, 2, vaddr, fb, clip, false,
> -				 drm_fb_xrgb8888_to_rgb565_line);
> +		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 2, vmap[0].vaddr, fb, clip,
> +			    false, xfrm_line);
>  }
> -EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_toio);
> +EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
>  
>  static void drm_fb_xrgb8888_to_rgb888_line(void *dbuf, const void *sbuf, unsigned int pixels)
>  {
> @@ -605,8 +593,7 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
>  
>  	} else if (dst_format == DRM_FORMAT_RGB565) {
>  		if (fb_format == DRM_FORMAT_XRGB8888) {
> -			drm_fb_xrgb8888_to_rgb565_toio(dst[0].vaddr_iomem, dst_pitch[0],
> -						       vmap[0].vaddr, fb, clip, false);
> +			drm_fb_xrgb8888_to_rgb565(dst, dst_pitch, vmap, fb, clip, false);
>  			return 0;
>  		}
>  	} else if (dst_format == DRM_FORMAT_RGB888) {
> diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
> index 973a75585cad..d0bdbcb96705 100644
> --- a/drivers/gpu/drm/drm_mipi_dbi.c
> +++ b/drivers/gpu/drm/drm_mipi_dbi.c
> @@ -206,7 +206,6 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  	struct iosys_map map[DRM_FORMAT_MAX_PLANES];
>  	struct iosys_map data[DRM_FORMAT_MAX_PLANES];
>  	struct iosys_map dst_map = IOSYS_MAP_INIT_VADDR(dst);
> -	void *src;
>  	int ret;
>  
>  	ret = drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
> @@ -216,7 +215,6 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  	ret = drm_gem_fb_vmap(fb, map, data);
>  	if (ret)
>  		goto out_drm_gem_fb_end_cpu_access;
> -	src = data[0].vaddr; /* TODO: Use mapping abstraction properly */
>  
>  	switch (fb->format->format) {
>  	case DRM_FORMAT_RGB565:
> @@ -226,7 +224,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
>  			drm_fb_memcpy(&dst_map, NULL, data, fb, clip);
>  		break;
>  	case DRM_FORMAT_XRGB8888:
> -		drm_fb_xrgb8888_to_rgb565(dst, 0, src, fb, clip, swap);
> +		drm_fb_xrgb8888_to_rgb565(&dst_map, NULL, data, fb, clip, swap);
>  		break;
>  	default:
>  		drm_err_once(fb->dev, "Format is not supported: %p4cc\n",
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 426a3ae6cc50..a43eb6645352 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -198,7 +198,8 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
>  		} else if (format->format == DRM_FORMAT_RGB332) {
>  			drm_fb_xrgb8888_to_rgb332(&dst, NULL, map_data, fb, rect);
>  		} else if (format->format == DRM_FORMAT_RGB565) {
> -			drm_fb_xrgb8888_to_rgb565(buf, 0, vaddr, fb, rect, gud_is_big_endian());
> +			drm_fb_xrgb8888_to_rgb565(&dst, NULL, map_data, fb, rect,
> +						  gud_is_big_endian());
>  		} else if (format->format == DRM_FORMAT_RGB888) {
>  			drm_fb_xrgb8888_to_rgb888(buf, 0, vaddr, fb, rect);
>  		} else {
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index 73fb9f63d227..9cd398e4700b 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -335,8 +335,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
>  
>  	} else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2) {
>  		iosys_map_incr(&dst, drm_fb_clip_offset(cirrus->pitch, fb->format, rect));
> -		drm_fb_xrgb8888_to_rgb565_toio(dst.vaddr_iomem, cirrus->pitch, vaddr, fb, rect,
> -					       false);
> +		drm_fb_xrgb8888_to_rgb565(&dst, &cirrus->pitch, vmap, fb, rect, false);
>  
>  	} else if (fb->format->cpp[0] == 4 && cirrus->cpp == 3) {
>  		iosys_map_incr(&dst, drm_fb_clip_offset(cirrus->pitch, fb->format, rect));
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index 3c28f099e3ed..9f1d45d7ce84 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -23,12 +23,9 @@ void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
>  void drm_fb_xrgb8888_to_rgb332(struct iosys_map *dst, const unsigned int *dst_pitch,
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip);
> -void drm_fb_xrgb8888_to_rgb565(void *dst, unsigned int dst_pitch, const void *vaddr,
> -			       const struct drm_framebuffer *fb, const struct drm_rect *clip,
> -			       bool swab);
> -void drm_fb_xrgb8888_to_rgb565_toio(void __iomem *dst, unsigned int dst_pitch,
> -				    const void *vaddr, const struct drm_framebuffer *fb,
> -				    const struct drm_rect *clip, bool swab);
> +void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst, const unsigned int *dst_pitch,
> +			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +			       const struct drm_rect *clip, bool swab);
>  void drm_fb_xrgb8888_to_rgb888(void *dst, unsigned int dst_pitch, const void *src,
>  			       const struct drm_framebuffer *fb, const struct drm_rect *clip);
>  void drm_fb_xrgb8888_to_rgb888_toio(void __iomem *dst, unsigned int dst_pitch,
> -- 
> 2.37.1
> 
