Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408E4457A3D
	for <lists+linux-hyperv@lfdr.de>; Sat, 20 Nov 2021 01:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbhKTApd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 19 Nov 2021 19:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbhKTApd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 19 Nov 2021 19:45:33 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F207C061574;
        Fri, 19 Nov 2021 16:42:30 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 28so9957378pgq.8;
        Fri, 19 Nov 2021 16:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=irIwRt0uQVberAOzG4zQ4T92lCT1W8NvllFkKqhTIJQ=;
        b=KMCWUeJ06/7oIUz63K1fe9YikKKHUVieN8mL/FOYTDTUZ+Zt8FjVr/fpkOAr1UoTRU
         UMFLwRPY2o+yhhnvEpYWyXqPfqzUZp7V+SBJcAVdkqN1leJFVOHcrrxajV5d0q5JIN3X
         4s/4tkhJgft/fjgGgiCYM+JDszyfszBQ3zR+q+VGUyyhUohPWHessoCms+bA90JH5/aV
         eA/4jQojzpypo19mlbh1hPOlmBGq2bCUbfJ0rf+hKTfBofa15g1KAJkY0JftNQGMm6nI
         1KykALsPF8wUqcMrwS/khbTnqDI0O85D3lkH9/XTJXimEQqSYtU1jeHRsScUj2YfVglS
         kuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=irIwRt0uQVberAOzG4zQ4T92lCT1W8NvllFkKqhTIJQ=;
        b=vigLpkoy5yFpJXGTQpBn3j/R4rpIy4abnpu7nNbpVMVR9TOfWz8r7j1gBtTsqkmvsJ
         9Pz89guaYvm0gUGABWMmorAmTtuFaCs3Nq+5qMYwp5JIgepXHbD+RhOQ/I29GtAKwA8G
         T6V/ICC5vChDdpu1kRSlAGwWKKfTL0C3OVoVG3mXhTVbjRxbDegG6hWvXKM2BuDEsxtE
         S3NjP3jT0bP29D0jkhB03wnIO2wDS0ijeI6dI2ndQ8fLQ70Qx2WEgYvco31rGJAiu944
         kaTE04UlE8sS2Lj1JGMPr1eZW399bqOXMj025TqqxRcP/+DC9IBKFvblobuk/CtKCfdF
         QjNA==
X-Gm-Message-State: AOAM5321kpG3Ln6t44VyUBCN+OdTjb09j9M2Qvq8GQfPkNrId05FDf8x
        QA4ulgJqPjFTv9vP2101brw=
X-Google-Smtp-Source: ABdhPJxZVch1sP01OjM9CLatGFjDLx0Dydvw3Yd5BD9eoHy8ihOX/8jnjD4i3XNOY/+LckFx4AQlMQ==
X-Received: by 2002:a05:6a00:2313:b0:49f:d9ec:7492 with SMTP id h19-20020a056a00231300b0049fd9ec7492mr69466617pfh.25.1637368949833;
        Fri, 19 Nov 2021 16:42:29 -0800 (PST)
Received: from ?IPv6:2601:600:9a7f:e1e0::26b0? ([2601:600:9a7f:e1e0::26b0])
        by smtp.gmail.com with ESMTPSA id c20sm740480pfl.201.2021.11.19.16.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 16:42:29 -0800 (PST)
Message-ID: <ec14aa50bbf1ebcf4e7edd54a3f5ad7409951cbb.camel@gmail.com>
Subject: Re: [PATCH] drm/hyperv: Fix device removal on Gen1 VMs
From:   Deepak Rawat <drawat.floss@gmail.com>
To:     Mohammed Gamal <mgamal@redhat.com>, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, decui@microsoft.com
Cc:     linux-kernel@vger.kernel.org, daniel@ffwll.ch, airlied@linux.ie
Date:   Fri, 19 Nov 2021 16:42:28 -0800
In-Reply-To: <20211119112900.300537-1-mgamal@redhat.com>
References: <20211119112900.300537-1-mgamal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks for the patch.

Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>

I will push this to drm-fixes, let me know otherwise.

Deepak

On Fri, 2021-11-19 at 12:29 +0100, Mohammed Gamal wrote:
> The Hyper-V DRM driver tries to free MMIO region on removing
> the device regardless of VM type, while Gen1 VMs don't use MMIO
> and hence causing the kernel to crash on a NULL pointer dereference.
> 
> Fix this by making deallocating MMIO only on Gen2 machines and
> implement
> removal for Gen1
> 
> Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic
> video device")
> 
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index cd818a629183..9f923beb7d8d 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -225,12 +225,29 @@ static int hyperv_vmbus_remove(struct hv_device
> *hdev)
>  {
>         struct drm_device *dev = hv_get_drvdata(hdev);
>         struct hyperv_drm_device *hv = to_hv(dev);
> +       struct pci_dev *pdev;
>  
>         drm_dev_unplug(dev);
>         drm_atomic_helper_shutdown(dev);
>         vmbus_close(hdev->channel);
>         hv_set_drvdata(hdev, NULL);
> -       vmbus_free_mmio(hv->mem->start, hv->fb_size);
> +
> +       /*
> +        * Free allocated MMIO memory only on Gen2 VMs.
> +        * On Gen1 VMs, release the PCI device
> +        */
> +       if (efi_enabled(EFI_BOOT)) {
> +               vmbus_free_mmio(hv->mem->start, hv->fb_size);
> +       } else {
> +               pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> +                               PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> +               if (!pdev) {
> +                       drm_err(dev, "Unable to find PCI Hyper-V
> video\n");
> +                       return -ENODEV;
> +               }
> +               pci_release_region(pdev, 0);
> +               pci_dev_put(pdev);
> +       }
>  
>         return 0;
>  }

