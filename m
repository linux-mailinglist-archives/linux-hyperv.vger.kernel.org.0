Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A952F043
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 May 2022 18:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiETQMT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 20 May 2022 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbiETQMS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 20 May 2022 12:12:18 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264449F0B;
        Fri, 20 May 2022 09:12:15 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2fed823dd32so91785627b3.12;
        Fri, 20 May 2022 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pqyi41QHS9ba9YCVsZZlxgBFqkmxdii+DOUhWsNf4JM=;
        b=pP66Xe8ijIgmgl31Z/kiMDxKh22aJaoVav0zIa60uSGQ4LdQCbEGb3tS0k2UT+HXEL
         gSMi0+ul0SutrYvq4AtHncggCfFsWrVWcylzfn189g5irleNcf0tCKxNfdM2nKIdUtH2
         M8XSoIjMjVZTi4WaWieoAkWZni/ICU8bi5lEmcU88oJqMNxUvIdXbnVgEqblseViKBrE
         sMMSqY7xRVqMSIdhKaMO1uzpgO2RXUoM8uz34W7aIeNKnXkifYS5QjEL05cYsNH58ZC+
         b5C3+QIswMaiwrfsk50mUmacgz/TorB8CI/2nKvVK/D7HzUM48TqywDKLE/UbO0C5P88
         ZBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pqyi41QHS9ba9YCVsZZlxgBFqkmxdii+DOUhWsNf4JM=;
        b=uDbEV+nJu4HOFlErzP5FswCMIn9I2mifeUZ1opZY15DNoh8teWgXGqx0ki2P53Vnd0
         85HW5kgHhLDq/JfDfUhu8yS4QNt/gjeg0sNdzpPvDbjGP++suUVAIzMBY9/CmVKmmedJ
         SKtKvV/A/Ctx6IeFkUluG46InN6a0F2kJ9aR9Kav4YmqgTKie9gVgJo3uxyaFRF2O8Qs
         1OQo4KVUdrsDfesZ3jJILNJgIAA0/FUX7qw2S13wFaYoEPQ1f9cDVCHfkJX6TXDh250M
         DxE5SWxeYhhxjUCBbRaEYYJ59ciPbFvwq5Zs2Sd+ah2cbJMthfR3CFssGV4hwBjwo4MX
         AZ/A==
X-Gm-Message-State: AOAM530kIIhhuQxIQPMbHhphzKIm3g6gpaKSMwihihRWYRJNFJ9QQq/3
        fPYabHaN8Ar+5euM/dO9ywUW4aLaRAJkTKq4X3/Oe6zn8ZI=
X-Google-Smtp-Source: ABdhPJxKP8s7sEVnqbYH7qAZQFC4arPAJxuj8I3habwoVp/wJFjzMmoEthmrmYhmLJq9L0XjlSC2xwc7eMXvYCjLJZY=
X-Received: by 2002:a81:3605:0:b0:2ff:29ec:2ef2 with SMTP id
 d5-20020a813605000000b002ff29ec2ef2mr10708414ywa.137.1653063135013; Fri, 20
 May 2022 09:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <1653031240-13623-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1653031240-13623-1-git-send-email-ssengar@linux.microsoft.com>
From:   Deepak Rawat <drawat.floss@gmail.com>
Date:   Fri, 20 May 2022 09:12:04 -0700
Message-ID: <CAHFnvW01rOJq2yuFQ2u692XKz9uNfoDoYmXYShpkS+rjeZSyUg@mail.gmail.com>
Subject: Re: [PATCH] drm/hyperv : Removing the restruction of VRAM allocation
 with PCI bar size
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, May 20, 2022 at 12:20 AM Saurabh Sengar
<ssengar@linux.microsoft.com> wrote:
>
> There were two different approaches getting used in this driver to
> allocate vram:
>         1. VRAM allocation from PCI region for Gen1
>         2. VRAM alloaction from MMIO region for Gen2
> First approach limilts the vram to PCI BAR size, which is 64 MB in most
> legacy systems. This limits the maximum resolution to be restricted to
> 64 MB size, and with recent conclusion on fbdev issue its concluded to have
> similar allocation strategy for both Gen1 and Gen2. This patch unifies
> the Gen1 and Gen2 vram allocation strategy.
>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> FBdev patch Ref :
> https://lore.kernel.org/lkml/20220428143746.sya775ro5zi3kgm3@liuwe-devbox-debian-v2/T/
>
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 76 ++-----------------------
>  1 file changed, 4 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 4a8941fa0815..a32afd84f361 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -69,57 +69,8 @@ static struct pci_driver hyperv_pci_driver = {
>         .remove =       hyperv_pci_remove,
>  };
>
> -static int hyperv_setup_gen1(struct hyperv_drm_device *hv)
> -{
> -       struct drm_device *dev = &hv->dev;
> -       struct pci_dev *pdev;
> -       int ret;
> -
> -       pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> -                             PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> -       if (!pdev) {
> -               drm_err(dev, "Unable to find PCI Hyper-V video\n");
> -               return -ENODEV;
> -       }
> -
> -       ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &hyperv_driver);
> -       if (ret) {
> -               drm_err(dev, "Not able to remove boot fb\n");
> -               return ret;
> -       }
> -
> -       if (pci_request_region(pdev, 0, DRIVER_NAME) != 0)
> -               drm_warn(dev, "Cannot request framebuffer, boot fb still active?\n");
> -
> -       if ((pdev->resource[0].flags & IORESOURCE_MEM) == 0) {
> -               drm_err(dev, "Resource at bar 0 is not IORESOURCE_MEM\n");
> -               ret = -ENODEV;
> -               goto error;
> -       }
> -
> -       hv->fb_base = pci_resource_start(pdev, 0);
> -       hv->fb_size = pci_resource_len(pdev, 0);
> -       if (!hv->fb_base) {
> -               drm_err(dev, "Resource not available\n");
> -               ret = -ENODEV;
> -               goto error;
> -       }
> -
> -       hv->fb_size = min(hv->fb_size,
> -                         (unsigned long)(hv->mmio_megabytes * 1024 * 1024));
> -       hv->vram = devm_ioremap(&pdev->dev, hv->fb_base, hv->fb_size);
> -       if (!hv->vram) {
> -               drm_err(dev, "Failed to map vram\n");
> -               ret = -ENOMEM;
> -       }
> -
> -error:
> -       pci_dev_put(pdev);
> -       return ret;
> -}
> -
> -static int hyperv_setup_gen2(struct hyperv_drm_device *hv,
> -                            struct hv_device *hdev)
> +static int hyperv_setup_gen(struct hyperv_drm_device *hv,
> +                           struct hv_device *hdev)
>  {

nit: This can be renamed to hyperv_setup_vram instead.

Reviewed-by: Deepak Rawat <drawat.floss@gmail.com>

>         struct drm_device *dev = &hv->dev;
>         int ret;
> @@ -181,10 +132,7 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
>                 goto err_hv_set_drv_data;
>         }
>
> -       if (efi_enabled(EFI_BOOT))
> -               ret = hyperv_setup_gen2(hv, hdev);
> -       else
> -               ret = hyperv_setup_gen1(hv);
> +       ret = hyperv_setup_gen(hv, hdev);
>
>         if (ret)
>                 goto err_vmbus_close;
> @@ -225,29 +173,13 @@ static int hyperv_vmbus_remove(struct hv_device *hdev)
>  {
>         struct drm_device *dev = hv_get_drvdata(hdev);
>         struct hyperv_drm_device *hv = to_hv(dev);
> -       struct pci_dev *pdev;
>
>         drm_dev_unplug(dev);
>         drm_atomic_helper_shutdown(dev);
>         vmbus_close(hdev->channel);
>         hv_set_drvdata(hdev, NULL);
>
> -       /*
> -        * Free allocated MMIO memory only on Gen2 VMs.
> -        * On Gen1 VMs, release the PCI device
> -        */
> -       if (efi_enabled(EFI_BOOT)) {
> -               vmbus_free_mmio(hv->mem->start, hv->fb_size);
> -       } else {
> -               pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT,
> -                                     PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> -               if (!pdev) {
> -                       drm_err(dev, "Unable to find PCI Hyper-V video\n");
> -                       return -ENODEV;
> -               }
> -               pci_release_region(pdev, 0);
> -               pci_dev_put(pdev);
> -       }
> +       vmbus_free_mmio(hv->mem->start, hv->fb_size);
>
>         return 0;
>  }
> --
> 2.25.1
>
