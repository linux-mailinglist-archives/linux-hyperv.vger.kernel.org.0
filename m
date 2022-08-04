Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12A658A1D5
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 22:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiHDUTe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 16:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiHDUTd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 16:19:33 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF621248F0
        for <linux-hyperv@vger.kernel.org>; Thu,  4 Aug 2022 13:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2iUOG0JbFBjC8R5X/ZJi48U7NYfcUuR5if41+FmBzho=;
        b=HJeEumZqd4ahT9P/Fh/C3wj6aISHMJ+SoNR6mTF/fdGhKIy9nwt26Wp+UDM04Zu9nhtTti52u5Kbs
         W3npzkogt2I6xGPnIiMJpUrVpkThQpAl1N/FLapok8IEF6m18GWk2RK1NSRyjlLLrl11OmUJ6p38bf
         v3MlvCwr+DiwJrFlBXTgCjQTXXfs2tlbw3F2maVfH0lud+sLoPa2IWrgmf/Gw9NS0qVVUlbLsNxvN1
         91h3YGQ/qGbdaK6UKh1ckZ0ByZ7mUTaSVUohf63Udv7kBZtr5Lni8GVm/x+IXYNzRaO/Gof/cFPHtb
         aTHNPN/3WIVyQFnloebdtKjt2Dr5KSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2iUOG0JbFBjC8R5X/ZJi48U7NYfcUuR5if41+FmBzho=;
        b=B58cyooq2SKqJu3SDW43klt4fZBKNHf7FR7w0LklY9HOteLJyqEd62vyW/cUiuUBpJ8KJGg0WKqbR
         ZX7icitDA==
X-HalOne-Cookie: d0924cb7e513ecc829ce6caa7a22fd2142fcd7a2
X-HalOne-ID: bdae5f87-1432-11ed-a91b-d0431ea8a290
Received: from mailproxy4.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id bdae5f87-1432-11ed-a91b-d0431ea8a290;
        Thu, 04 Aug 2022 20:19:28 +0000 (UTC)
Date:   Thu, 4 Aug 2022 22:19:26 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     noralf@tronnes.org, daniel@ffwll.ch, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        airlied@redhat.com, javierm@redhat.com, drawat.floss@gmail.com,
        kraxel@redhat.com, david@lechnology.com, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 10/12] drm/format-helper: Rework XRGB8888-to-GRAY8
 conversion
Message-ID: <YuwpzrAavyMxr3NQ@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-11-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-11-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 27, 2022 at 01:33:10PM +0200, Thomas Zimmermann wrote:
> Update XRGB8888-to-GRAY8 conversion to support struct iosys_map
> and convert all users. Although these are single-plane color formats,
> the new interface supports multi-plane formats for consistency with
> drm_fb_blit().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 25 +++++++++++++++++++------
>  drivers/gpu/drm/gud/gud_pipe.c      |  7 +++++--
>  drivers/gpu/drm/tiny/st7586.c       |  5 ++++-
>  include/drm/drm_format_helper.h     |  5 +++--
>  4 files changed, 31 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 209f63b66c5f..521932fac491 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -552,9 +552,9 @@ static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned
>  
>  /**
>   * drm_fb_xrgb8888_to_gray8 - Convert XRGB8888 to grayscale
> - * @dst: 8-bit grayscale destination buffer
> - * @dst_pitch: Number of bytes between two consecutive scanlines within dst
> - * @vaddr: XRGB8888 source buffer
> + * @dst: Array of 8-bit grayscale destination buffers
> + * @dst_pitch: Array of number of bytes between two consecutive scanlines within dst
> + * @vmap: Array of XRGB8888 source buffers
>   * @fb: DRM framebuffer
>   * @clip: Clip rectangle area to copy
>   *
> @@ -567,10 +567,23 @@ static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned
>   *
>   * ITU BT.601 is used for the RGB -> luma (brightness) conversion.
>   */
> -void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
> -			      const struct drm_framebuffer *fb, const struct drm_rect *clip)
> +void drm_fb_xrgb8888_to_gray8(struct iosys_map *dst, const unsigned int *dst_pitch,
> +			      const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +			      const struct drm_rect *clip)
>  {
> -	drm_fb_xfrm(dst, dst_pitch, 1, vaddr, fb, clip, false, drm_fb_xrgb8888_to_gray8_line);
> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> +		0, 0, 0, 0
> +	};
> +
> +	if (!dst_pitch)
> +		dst_pitch = default_dst_pitch;
> +
> +	if (dst[0].is_iomem)
> +		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, fb,
> +				 clip, false, drm_fb_xrgb8888_to_gray8_line);
> +	else
> +		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb,
> +			    clip, false, drm_fb_xrgb8888_to_gray8_line);
>  }
>  EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
>  
> diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
> index 0caa228f736d..7c6dc2bcd14a 100644
> --- a/drivers/gpu/drm/gud/gud_pipe.c
> +++ b/drivers/gpu/drm/gud/gud_pipe.c
> @@ -59,6 +59,7 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
>  	unsigned int bits_per_pixel = 8 / block_width;
>  	unsigned int x, y, width, height;
>  	u8 pix, *pix8, *block = dst; /* Assign to silence compiler warning */
> +	struct iosys_map dst_map, vmap;
>  	size_t len;
>  	void *buf;
>  
> @@ -74,7 +75,9 @@ static size_t gud_xrgb8888_to_r124(u8 *dst, const struct drm_format_info *format
>  	if (!buf)
>  		return 0;
>  
> -	drm_fb_xrgb8888_to_gray8(buf, 0, src, fb, rect);
> +	iosys_map_set_vaddr(&dst_map, buf);
> +	iosys_map_set_vaddr(&vmap, src);
> +	drm_fb_xrgb8888_to_gray8(&dst_map, NULL, &vmap, fb, rect);
>  	pix8 = buf;
>  
>  	for (y = 0; y < height; y++) {
> @@ -194,7 +197,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
>  				goto end_cpu_access;
>  			}
>  		} else if (format->format == DRM_FORMAT_R8) {
> -			drm_fb_xrgb8888_to_gray8(buf, 0, vaddr, fb, rect);
> +			drm_fb_xrgb8888_to_gray8(&dst, NULL, map_data, fb, rect);
>  		} else if (format->format == DRM_FORMAT_RGB332) {
>  			drm_fb_xrgb8888_to_rgb332(&dst, NULL, map_data, fb, rect);
>  		} else if (format->format == DRM_FORMAT_RGB565) {
> diff --git a/drivers/gpu/drm/tiny/st7586.c b/drivers/gpu/drm/tiny/st7586.c
> index 8eddb020c43e..702350d0f8bc 100644
> --- a/drivers/gpu/drm/tiny/st7586.c
> +++ b/drivers/gpu/drm/tiny/st7586.c
> @@ -69,12 +69,15 @@ static void st7586_xrgb8888_to_gray332(u8 *dst, void *vaddr,
>  	size_t len = (clip->x2 - clip->x1) * (clip->y2 - clip->y1);
>  	unsigned int x, y;
>  	u8 *src, *buf, val;
> +	struct iosys_map dst_map, vmap;
>  
>  	buf = kmalloc(len, GFP_KERNEL);
>  	if (!buf)
>  		return;
>  
> -	drm_fb_xrgb8888_to_gray8(buf, 0, vaddr, fb, clip);
> +	iosys_map_set_vaddr(&dst_map, buf);
> +	iosys_map_set_vaddr(&vmap, vaddr);
> +	drm_fb_xrgb8888_to_gray8(&dst_map, NULL, &vmap, fb, clip);
>  	src = buf;
>  
>  	for (y = clip->y1; y < clip->y2; y++) {
> diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
> index 6807440ce29c..68087c982497 100644
> --- a/include/drm/drm_format_helper.h
> +++ b/include/drm/drm_format_helper.h
> @@ -32,8 +32,9 @@ void drm_fb_xrgb8888_to_rgb888(struct iosys_map *dst, const unsigned int *dst_pi
>  void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *dst_pitch,
>  				    const struct iosys_map *vmap, const struct drm_framebuffer *fb,
>  				    const struct drm_rect *clip);
> -void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
> -			      const struct drm_framebuffer *fb, const struct drm_rect *clip);
> +void drm_fb_xrgb8888_to_gray8(struct iosys_map *dst, const unsigned int *dst_pitch,
> +			      const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> +			      const struct drm_rect *clip);
>  
>  int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t dst_format,
>  		const struct iosys_map *vmap, const struct drm_framebuffer *fb,
> -- 
> 2.37.1
