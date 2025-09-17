Return-Path: <linux-hyperv+bounces-6906-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A81F6B7D1AE
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 14:18:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9EE7B5A3C
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Sep 2025 05:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC65A264634;
	Wed, 17 Sep 2025 05:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fMvtmaDl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7226A266B40
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Sep 2025 05:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758085959; cv=none; b=KKyyfEEe2MW2y8ACK9qdIWSRbxnJaLLwUyKOAeqVlkWP5YIS7U/gHZnPzkjZu+x9Lc27HY7bmPmVzLF3sFRGkB4/Wybk21Nfk8rotS3SqHyJLYubfv1zayOX3z9x9Q0fPVQgtR8o7Hqvzpv6qxx5PVGAaOEzXIbjttIhX5WHD9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758085959; c=relaxed/simple;
	bh=JMTuHGAssw1H2gpwFvikHoGuF/lx0EvCPbMkfpmQ+SM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma/CNCUnLCRsdv1i39EB1R+aQ40hrciXgCXgs7YezYOoNyIwqZyTInZrdoYvb3OgKX/QbzT9Ca/+ruWVDMliUMAR6Ez5O0iM4miGVIBMGPSAJL9S3VP+8aN1P8mIkD8eNU4UTC9fT4QL9jYgvB7HgdLLhyohF3x7ZLhQkurwPw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fMvtmaDl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1188)
	id BC64A2018E60; Tue, 16 Sep 2025 22:12:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC64A2018E60
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758085952;
	bh=zKn800h16nl+4qy2pNwXvBFYZq+ddwqd978lKR97Has=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fMvtmaDlemyFwBAEDZbOBkpv6N9WKQcpaGtkBRMJwuy+ZeD8Lh0U9u6fccdC8B26V
	 UoGSjxKiPADHKqKv/VM4+huKn1CRRpcOTPnWXrGpZVZ6OwlbP8IQt9Za1f7WAFrg7b
	 2fJ2X2ltXQAdnxuYAJSnWe17WUaAZZ8HOQnMMl4g=
Date: Tue, 16 Sep 2025 22:12:32 -0700
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, louis.chauvet@bootlin.com,
	drawat.floss@gmail.com, hamohammed.sa@gmail.com,
	melissa.srw@gmail.com, mhklinux@outlook.com,
	ptsm@linux.microsoft.com, simona@ffwll.ch, airlied@gmail.com,
	maarten.lankhorst@linux.intel.com, ville.syrjala@linux.intel.com,
	lyude@redhat.com, javierm@redhat.com
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v4 4/4] drm/hypervdrm: Use vblank timer
Message-ID: <20250917051232.GA20950@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250916083816.30275-1-tzimmermann@suse.de>
 <20250916083816.30275-5-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916083816.30275-5-tzimmermann@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Sep 16, 2025 at 10:36:22AM +0200, Thomas Zimmermann wrote:
> HyperV's virtual hardware does not provide vblank interrupts. Use a
> vblank timer to simulate the interrupt. Rate-limits the display's
> update frequency to the display-mode settings. Avoids excessive CPU
> overhead with compositors that do not rate-limit their output.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 945b9482bcb3..6e6eb1c12a68 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -19,6 +19,8 @@
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_panic.h>
>  #include <drm/drm_plane.h>
> +#include <drm/drm_vblank.h>
> +#include <drm/drm_vblank_helper.h>
>  
>  #include "hyperv_drm.h"
>  
> @@ -111,11 +113,15 @@ static void hyperv_crtc_helper_atomic_enable(struct drm_crtc *crtc,
>  				crtc_state->mode.hdisplay,
>  				crtc_state->mode.vdisplay,
>  				plane_state->fb->pitches[0]);
> +
> +	drm_crtc_vblank_on(crtc);
>  }
>  
>  static const struct drm_crtc_helper_funcs hyperv_crtc_helper_funcs = {
>  	.atomic_check = drm_crtc_helper_atomic_check,
> +	.atomic_flush = drm_crtc_vblank_atomic_flush,
>  	.atomic_enable = hyperv_crtc_helper_atomic_enable,
> +	.atomic_disable = drm_crtc_vblank_atomic_disable,
>  };
>  
>  static const struct drm_crtc_funcs hyperv_crtc_funcs = {
> @@ -125,6 +131,7 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
>  	.page_flip = drm_atomic_helper_page_flip,
>  	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
> +	DRM_CRTC_VBLANK_TIMER_FUNCS,
>  };
>  
>  static int hyperv_plane_atomic_check(struct drm_plane *plane,
> @@ -321,6 +328,10 @@ int hyperv_mode_config_init(struct hyperv_drm_device *hv)
>  		return ret;
>  	}
>  
> +	ret = drm_vblank_init(dev, 1);
> +	if (ret)
> +		return ret;
> +
>  	drm_mode_config_reset(dev);
>  
>  	return 0;
> 
> -- 
> 2.51.0
> 

Tested this series.

On a Hyper-V VM running Ubuntu,

with this patch

$ time find /
real	0m13.911s
user	0m0.965s
sys	0m3.815s


without this patch

$ time find /
real	0m14.254s
user	0m0.954s
sys	0m3.863s

Tested-by: Prasanna Kumar T S M <ptsm@linux.microsoft.com>

