Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099AE58397A
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Jul 2022 09:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbiG1H0j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jul 2022 03:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiG1H0h (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jul 2022 03:26:37 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6E5A166
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 00:26:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso2072158wma.2
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Jul 2022 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6jXyox9CMZw1Uh3/DzaLPDbI0DbQu1TVSdfnXCR3CiQ=;
        b=Y25A2dZ3peDYSJaq8Lh8E7uUmF8oIAyeZ73Eot2meLEwM1AlWiXNAq0llleQOkuSLv
         JuCZXqs1IAOCJzeq5+9R3gijlqM+/Di0YbRg0pbQ+iftVcMStNSwwo7/pbHyQN1z31ml
         7pzoThUY977QfJNCufBUms1L0vyQNAcTnQg/oc4sHXn1koKkn4pPLPPKGLf26MlPZIIQ
         neTEOp6HqXuw0jw0dK4FM4A9fNzFIk/R0vGo7dIVr+9KK3s7SbVwm93ZIDoVBDR0bpag
         NbFL8eXyZScl4UKy7CAMBB6sBn5xW/ABASF6RB+SzgQg+rR3JtO6DhHurTF5TbSHgKKy
         49nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6jXyox9CMZw1Uh3/DzaLPDbI0DbQu1TVSdfnXCR3CiQ=;
        b=Oz0897Dm8e2pYw37vCkOBCfWNM/s9/ypr1sCZ6245CrL/ufjus9O/V2BQ8J/sqvSc8
         9pthZMuShLKT4nuneAvthPtx74kOQ+9MMncJMEkjL3gjcNMB+2BVIa3cAsnbQscxSrpg
         XqDBejrWImBHcelr+G+lw8cfkSQPwpY51mOeSFJvI/rWCVzVA7iaHhNV5YsBv8QpKT9H
         H25s2jbVa+Y7ncD14xZjE4MW/XZL3mRI1R57bFtXD6GsibttKBZHaICRHqulF6cLnx0V
         PE1XZMSBqWFK0h9w1Ex3SkymfAEYm0je0l12lMNW7LaYmvvCScnTt8k7hr/c4OL/j1De
         qHlg==
X-Gm-Message-State: AJIora/i1y4mAVfKSBdtkDZ33IZ917TpD5zI2t+dKVSLd6Ehy9eA74gF
        ks9qfj5rJMsX4SxbnVpx/H8=
X-Google-Smtp-Source: AGRyM1uEuSIzcwZU3eQ+FRIzak9+SYWR+aOOYemX/mkDkxSM9WDeNEoAt8W8wP/1nD/e88a3glYoaw==
X-Received: by 2002:a05:600c:3d93:b0:3a3:3a93:fb16 with SMTP id bi19-20020a05600c3d9300b003a33a93fb16mr5711807wmb.190.1658993194219;
        Thu, 28 Jul 2022 00:26:34 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id i18-20020adfaad2000000b0021d70a871cbsm158488wrc.32.2022.07.28.00.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 00:26:33 -0700 (PDT)
Date:   Thu, 28 Jul 2022 09:26:30 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     sam@ravnborg.org, noralf@tronnes.org, daniel@ffwll.ch,
        airlied@linux.ie, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com, airlied@redhat.com,
        javierm@redhat.com, drawat.floss@gmail.com, kraxel@redhat.com,
        david@lechnology.com, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 12/12] drm/format-helper: Move destination-buffer
 handling into internal helper
Message-ID: <20220728072630.GB56421@elementary>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-13-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-13-tzimmermann@suse.de>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi!

On Wed, Jul 27, 2022 at 01:33:12PM +0200, Thomas Zimmermann wrote:
> The format-convertion helpers handle several cases for different
> values of destination buffer and pitch. Move that code into the
> internal helper drm_fb_xfrm() and avoid quite a bit of duplucation.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 169 +++++++++++-----------------
>  1 file changed, 64 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index d296d181659d..35aebdb90165 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -41,11 +41,11 @@ unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info
>  }
>  EXPORT_SYMBOL(drm_fb_clip_offset);
>  
> -/* TODO: Make this functon work with multi-plane formats. */
> -static int drm_fb_xfrm(void *dst, unsigned long dst_pitch, unsigned long dst_pixsize,
> -		       const void *vaddr, const struct drm_framebuffer *fb,
> -		       const struct drm_rect *clip, bool vaddr_cached_hint,
> -		       void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels))
> +/* TODO: Make this function work with multi-plane formats. */
> +static int __drm_fb_xfrm(void *dst, unsigned long dst_pitch, unsigned long dst_pixsize,
> +			 const void *vaddr, const struct drm_framebuffer *fb,
> +			 const struct drm_rect *clip, bool vaddr_cached_hint,
> +			 void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels))
>  {
>  	unsigned long linepixels = drm_rect_width(clip);
>  	unsigned long lines = drm_rect_height(clip);
> @@ -84,11 +84,11 @@ static int drm_fb_xfrm(void *dst, unsigned long dst_pitch, unsigned long dst_pix
>  	return 0;
>  }
>  
> -/* TODO: Make this functon work with multi-plane formats. */
> -static int drm_fb_xfrm_toio(void __iomem *dst, unsigned long dst_pitch, unsigned long dst_pixsize,
> -			    const void *vaddr, const struct drm_framebuffer *fb,
> -			    const struct drm_rect *clip, bool vaddr_cached_hint,
> -			    void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels))
> +/* TODO: Make this function work with multi-plane formats. */
> +static int __drm_fb_xfrm_toio(void __iomem *dst, unsigned long dst_pitch, unsigned long dst_pixsize,
> +			      const void *vaddr, const struct drm_framebuffer *fb,
> +			      const struct drm_rect *clip, bool vaddr_cached_hint,
> +			      void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels))
>  {
>  	unsigned long linepixels = drm_rect_width(clip);
>  	unsigned long lines = drm_rect_height(clip);
> @@ -129,6 +129,29 @@ static int drm_fb_xfrm_toio(void __iomem *dst, unsigned long dst_pitch, unsigned
>  	return 0;
>  }
>  
> +/* TODO: Make this function work with multi-plane formats. */
> +static int drm_fb_xfrm(struct iosys_map *dst,
> +		       const unsigned int *dst_pitch, const u8 *dst_pixsize,
> +		       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +		       const struct drm_rect *clip, bool vaddr_cached_hint,
> +		       void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels))
> +{
> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> +		0, 0, 0, 0
> +	};
> +
> +	if (!dst_pitch)
> +		dst_pitch = default_dst_pitch;
> +
> +	if (dst[0].is_iomem)
> +		return __drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], dst_pixsize[0],
> +					  vmap[0].vaddr, fb, clip, false, xfrm_line);
> +	else
> +		return __drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], dst_pixsize[0],
> +				     vmap[0].vaddr, fb, clip, false, xfrm_line);
> +}
> +
> +

Nit: Extra blank line

>  /**
>   * drm_fb_memcpy - Copy clip buffer
>   * @dst: Array of destination buffers
> @@ -213,14 +236,10 @@ void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
>  		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  		 const struct drm_rect *clip, bool cached)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> -	};
>  	const struct drm_format_info *format = fb->format;
> -	u8 cpp = format->cpp[0];
>  	void (*swab_line)(void *dbuf, const void *sbuf, unsigned int npixels);
>  
> -	switch (cpp) {
> +	switch (format->cpp[0]) {
>  	case 4:
>  		swab_line = drm_fb_swab32_line;
>  		break;
> @@ -230,21 +249,10 @@ void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
>  	default:
>  		drm_warn_once(fb->dev, "Format %p4cc has unsupported pixel size.\n",
>  			      &format->format);
> -		swab_line = NULL;
> -		break;
> -	}
> -	if (!swab_line)
>  		return;
> +	}
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst->is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], cpp,
> -				 vmap[0].vaddr, fb, clip, cached, swab_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], cpp, vmap[0].vaddr, fb,
> -			    clip, cached, swab_line);
> +	drm_fb_xfrm(dst, dst_pitch, format->cpp, vmap, fb, clip, cached, swab_line);
>  }
>  EXPORT_SYMBOL(drm_fb_swab);
>  
> @@ -277,19 +285,12 @@ void drm_fb_xrgb8888_to_rgb332(struct iosys_map *dst, const unsigned int *dst_pi
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		1,
>  	};

Could "dst_pixsize" be obtained from "drm_format_info->cpp"? (in all
conversion functions, not only in this one).

I think they are similar structures, so we might be able to reuse that
information.

>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, fb, clip,
> -				 false, drm_fb_xrgb8888_to_rgb332_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb, clip,
> -			    false, drm_fb_xrgb8888_to_rgb332_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_rgb332_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb332);
>  
> @@ -344,9 +345,10 @@ void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst, const unsigned int *dst_pi
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip, bool swab)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		2,
>  	};
> +
>  	void (*xfrm_line)(void *dbuf, const void *sbuf, unsigned int npixels);
>  
>  	if (swab)
> @@ -354,15 +356,7 @@ void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst, const unsigned int *dst_pi
>  	else
>  		xfrm_line = drm_fb_xrgb8888_to_rgb565_line;
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 2, vmap[0].vaddr, fb, clip,
> -				 false, xfrm_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 2, vmap[0].vaddr, fb, clip,
> -			    false, xfrm_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false, xfrm_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
>  
> @@ -396,19 +390,12 @@ void drm_fb_xrgb8888_to_rgb888(struct iosys_map *dst, const unsigned int *dst_pi
>  			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			       const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		3,
>  	};
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 3, vmap[0].vaddr, fb,
> -				 clip, false, drm_fb_xrgb8888_to_rgb888_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 3, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_xrgb8888_to_rgb888_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_rgb888_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888);
>  
> @@ -435,19 +422,12 @@ static void drm_fb_rgb565_to_xrgb8888(struct iosys_map *dst, const unsigned int
>  				      const struct drm_framebuffer *fb,
>  				      const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		4,
>  	};
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -				 clip, false, drm_fb_rgb565_to_xrgb8888_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_rgb565_to_xrgb8888_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_rgb565_to_xrgb8888_line);
>  }
>  
>  static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> @@ -470,19 +450,12 @@ static void drm_fb_rgb888_to_xrgb8888(struct iosys_map *dst, const unsigned int
>  				      const struct drm_framebuffer *fb,
>  				      const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		4,
>  	};
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -				 clip, false, drm_fb_rgb888_to_xrgb8888_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_rgb888_to_xrgb8888_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_rgb888_to_xrgb8888_line);
>  }
>  
>  static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *sbuf, unsigned int pixels)
> @@ -518,19 +491,12 @@ void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *d
>  				    const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  				    const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		4,
>  	};
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -				 clip, false, drm_fb_xrgb8888_to_xrgb2101010_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_xrgb8888_to_xrgb2101010_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_xrgb2101010_line);
>  }
>  
>  static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned int pixels)
> @@ -571,19 +537,12 @@ void drm_fb_xrgb8888_to_gray8(struct iosys_map *dst, const unsigned int *dst_pit
>  			      const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  			      const struct drm_rect *clip)
>  {
> -	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> -		0, 0, 0, 0
> +	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
> +		1,
>  	};
>  
> -	if (!dst_pitch)
> -		dst_pitch = default_dst_pitch;
> -
> -	if (dst[0].is_iomem)
> -		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, fb,
> -				 clip, false, drm_fb_xrgb8888_to_gray8_line);
> -	else
> -		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb,
> -			    clip, false, drm_fb_xrgb8888_to_gray8_line);
> +	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, vmap, fb, clip, false,
> +		    drm_fb_xrgb8888_to_gray8_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
>  
> -- 
> 2.37.1
> 
