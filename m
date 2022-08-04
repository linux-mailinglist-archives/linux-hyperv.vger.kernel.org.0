Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC758A1C7
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Aug 2022 22:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiHDUPW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Aug 2022 16:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDUPV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Aug 2022 16:15:21 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1DB5FFF
        for <linux-hyperv@vger.kernel.org>; Thu,  4 Aug 2022 13:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=XQ+kkmE4Ic07chp0AfJlC9OlFc9+61+pKDSgSKBxebA=;
        b=TCfgUXEUFJ19oq7/funrOIu+L7gd0wRcTbgHqf94s6fkDRsfnewHHvJoJhxjDiQodMJYBQdv3C3Gs
         eOAs2tRs9ZBZW8lL4wuITmNLY2/GMUe7h+njBD7+VFraadwdCqckGxWKKF8JX/j2nokaCxNTLUmgyw
         SjRJ75B2AsoPK6GmyuaZHyvQTdQyvl52QNJlWgP1RYBFT1MtjNftSXfjnWPYZCczDLbBUqSqqK5I5T
         vz9FIjJPJaFoqerWaV24w9wznrXWNpmHXudIDI057U+ZQFrn52zUgWKSgQygYt7ZlZ14n9hZnw1uIO
         DMSR9j4pcXUhJuHsrThRjLK7OpPG9Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=XQ+kkmE4Ic07chp0AfJlC9OlFc9+61+pKDSgSKBxebA=;
        b=VhXfE8BpE6rR/ibzr7tFyWrYtPx5VN1SNhRdc2dXgDRyRcO2Mjs/ydHMboQMt6ffH6Vw+fgb/XTG0
         o3QMju0Cg==
X-HalOne-Cookie: 9aca289c7c13756da8167dac35c4f69f9101c708
X-HalOne-ID: 28663d94-1432-11ed-be81-d0431ea8bb03
Received: from mailproxy4.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 28663d94-1432-11ed-be81-d0431ea8bb03;
        Thu, 04 Aug 2022 20:15:18 +0000 (UTC)
Date:   Thu, 4 Aug 2022 22:15:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     noralf@tronnes.org, daniel@ffwll.ch, airlied@linux.ie,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        airlied@redhat.com, javierm@redhat.com, drawat.floss@gmail.com,
        kraxel@redhat.com, david@lechnology.com, jose.exposito89@gmail.com,
        dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 07/12] drm/format-helper: Rework RGB565-to-XRGB8888
 conversion
Message-ID: <Yuwo1J6UPEDBirQC@ravnborg.org>
References: <20220727113312.22407-1-tzimmermann@suse.de>
 <20220727113312.22407-8-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727113312.22407-8-tzimmermann@suse.de>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Jul 27, 2022 at 01:33:07PM +0200, Thomas Zimmermann wrote:
> Update RGB565-to-XRGB8888 conversion to support struct iosys_map
> and convert all users. Although these are single-plane color formats,
> the new interface supports multi-plane formats for consistency with
> drm_fb_blit().
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/gpu/drm/drm_format_helper.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
> index 4edab44336d8..5ef06f696657 100644
> --- a/drivers/gpu/drm/drm_format_helper.c
> +++ b/drivers/gpu/drm/drm_format_helper.c
> @@ -430,12 +430,24 @@ static void drm_fb_rgb565_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigne
>  	}
>  }
>  
> -static void drm_fb_rgb565_to_xrgb8888_toio(void __iomem *dst, unsigned int dst_pitch,
> -					   const void *vaddr, const struct drm_framebuffer *fb,
> -					   const struct drm_rect *clip)
> +static void drm_fb_rgb565_to_xrgb8888(struct iosys_map *dst, const unsigned int *dst_pitch,
> +				      const struct iosys_map *vmap,
> +				      const struct drm_framebuffer *fb,
> +				      const struct drm_rect *clip)
>  {
> -	drm_fb_xfrm_toio(dst, dst_pitch, 4, vaddr, fb, clip, false,
> -			 drm_fb_rgb565_to_xrgb8888_line);
> +	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
> +		0, 0, 0, 0
> +	};
> +
> +	if (!dst_pitch)
> +		dst_pitch = default_dst_pitch;
> +
> +	if (dst[0].is_iomem)
> +		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
> +				 clip, false, drm_fb_rgb565_to_xrgb8888_line);
> +	else
> +		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
> +			    clip, false, drm_fb_rgb565_to_xrgb8888_line);
>  }
>  
>  static void drm_fb_rgb888_to_xrgb8888_line(void *dbuf, const void *sbuf, unsigned int pixels)
> @@ -600,8 +612,7 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
>  						       vmap[0].vaddr, fb, clip);
>  			return 0;
>  		} else if (fb_format == DRM_FORMAT_RGB565) {
> -			drm_fb_rgb565_to_xrgb8888_toio(dst[0].vaddr_iomem, dst_pitch[0],
> -						       vmap[0].vaddr, fb, clip);
> +			drm_fb_rgb565_to_xrgb8888(dst, dst_pitch, vmap, fb, clip);
>  			return 0;
>  		}
>  	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
> -- 
> 2.37.1
