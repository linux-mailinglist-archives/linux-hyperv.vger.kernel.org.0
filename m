Return-Path: <linux-hyperv+bounces-3886-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A236A30235
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 04:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAB031883B08
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Feb 2025 03:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195801EF01;
	Tue, 11 Feb 2025 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PIdjPFq+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FF26BD95;
	Tue, 11 Feb 2025 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739244808; cv=none; b=PKVepP5r0FlTU3RWCZHsio2CaWqkykJIO2dawyGf+hJVtthnCc/Mwu85OV1eoJ7aN9jjXFdXx9j9ZubugpQ4eSZFYgQT4aYKZGEHSjtQvxFUOEHcsNRNHKTsT87rhjKDZfC066TlPInJT3Bj5uZVJJWb1/9VBeX3CepP1ZzeyAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739244808; c=relaxed/simple;
	bh=Ab+W+P1NZcfs5kpjatg9oivx8gYmwLQ3mgIq8xUBjV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp3jP4iRUK367gldwlfp2qR+WW+f9QhIP6xvslwccC+YXDf2vn6XkzncbAus/O3E78eisB5IPeMduMZVAaJ7ft+z+p8wvlu0BoyKPGGXrCs3jDj2xf0SqB/N6ZKW49TTfZztEwbZPapEC5Nbs9UlRj5Jaw9XzZNpXZ+aGmSoW3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PIdjPFq+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 0C0AD2107A95; Mon, 10 Feb 2025 19:33:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0C0AD2107A95
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739244806;
	bh=fYmFPt08g7qIRdQl9Ec+nj2WGXi6+K9OaWfn1ft+sPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PIdjPFq+YuFtU6QY0NiTugcEB+UE+PvEwaFXsOTcuFRsot15F+tSSeEztLO/rp+pE
	 86ogmfontfdrJ7nwSogcFQOZ/T8DEoToy0MIeFolDYEBEXlgOTFJ13w5I/bZBP4Ren
	 kFgWbEs4ccM1IxxMJZfMOOwXxsR+YyRP+1RgXSws=
Date: Mon, 10 Feb 2025 19:33:26 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: drawat.floss@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, christophe.jaillet@wanadoo.fr, wei.liu@kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] drm/hyperv: Fix address space leak when Hyper-V DRM
 device is removed
Message-ID: <20250211033326.GA17799@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20250210193441.2414-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210193441.2414-1-mhklinux@outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Feb 10, 2025 at 11:34:41AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When a Hyper-V DRM device is probed, the driver allocates MMIO space for
> the vram, and maps it cacheable. If the device removed, or in the error
> path for device probing, the MMIO space is released but no unmap is done.
> Consequently the kernel address space for the mapping is leaked.
> 
> Fix this by adding iounmap() calls in the device removal path, and in the
> error path during device probing.
> 
> Fixes: f1f63cbb705d ("drm/hyperv: Fix an error handling path in hyperv_vmbus_probe()")
> Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index e0953777a206..b491827941f1 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -156,6 +156,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>  	return 0;
>  
>  err_free_mmio:
> +	iounmap(hv->vram);
>  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>  err_vmbus_close:
>  	vmbus_close(hdev->channel);
> @@ -174,6 +175,7 @@ static void hyperv_vmbus_remove(struct hv_device *hdev)
>  	vmbus_close(hdev->channel);
>  	hv_set_drvdata(hdev, NULL);
>  
> +	iounmap(hv->vram);
>  	vmbus_free_mmio(hv->mem->start, hv->fb_size);
>  }
>  
> -- 
> 2.25.1
> 

Thanks for the fix. May I know how do you find such issues ?

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>

- Saurabh


