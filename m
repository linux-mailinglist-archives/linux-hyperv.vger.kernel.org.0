Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDB5B76B6
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Sep 2022 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiIMQsD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Sep 2022 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIMQrn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Sep 2022 12:47:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C897606A2;
        Tue, 13 Sep 2022 08:41:44 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id C272620B929D; Tue, 13 Sep 2022 08:15:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C272620B929D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663082155;
        bh=WTd0YT7pAoz6+7BUN2oTnacIxnBrjt3cagXvZkHwe44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YrI2ja/4BU+u+NWsYX5ro5uhm+4IimKhZK/vgeiSiAKvpxAyBRwyUEBEhqXLUyKLQ
         mW3ieqiOY6/XCYrcHV5549Oat6uj3V7krsUzfqquajHFkBGmkez4ZQeehiE1riIIdg
         OJ6686lkJu4Frsd8ORcbB1WZZhDuPjeHUU2YW2kY=
Date:   Tue, 13 Sep 2022 08:15:55 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-hyperv@vger.kernel.org, airlied@linux.ie,
        ssengar@microsoft.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mikelley@microsoft.com,
        drawat.floss@gmail.com
Subject: Re: [PATCH] drm/hyperv: Don't rely on screen_info.lfb_base for Gen1
 VMs
Message-ID: <20220913151555.GA22169@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1662734639-27164-1-git-send-email-ssengar@linux.microsoft.com>
 <14302178-c797-8635-4325-070f78b7f805@suse.de>
 <20220911162119.GB7754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <34e6ccfe-d6a0-e832-14a9-0445b61db106@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34e6ccfe-d6a0-e832-14a9-0445b61db106@suse.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 12, 2022 at 09:03:53AM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 11.09.22 um 18:21 schrieb Saurabh Singh Sengar:
> >On Sat, Sep 10, 2022 at 08:11:24PM +0200, Thomas Zimmermann wrote:
> >>Hi
> >>
> >>Am 09.09.22 um 16:43 schrieb Saurabh Sengar:
> >>>hyperv_setup_vram tries to remove conflicting framebuffer based on
> >>>'screen_info'. As observed in past due to some bug or wrong setting
> >>>in grub, the 'screen_info' fields may not be set for Gen1, and in such
> >>>cases drm_aperture_remove_conflicting_framebuffers will not do anything
> >>>useful.
> >>>For Gen1 VMs, it should always be possible to get framebuffer
> >>>conflict removed using PCI device instead.
> >>>
> >>>Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
> >>>Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >>>---
> >>>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 24 ++++++++++++++++++++----
> >>>  1 file changed, 20 insertions(+), 4 deletions(-)
> >>>
> >>>diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >>>index 6d11e7938c83..b0cc974efa45 100644
> >>>--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >>>+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >>>@@ -73,12 +73,28 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
> >>>  			     struct hv_device *hdev)
> >>>  {
> >>>  	struct drm_device *dev = &hv->dev;
> >>>+	struct pci_dev *pdev;
> >>>  	int ret;
> >>>-	drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
> >>>-						     screen_info.lfb_size,
> >>>-						     false,
> >>>-						     &hyperv_driver);
> >>>+	if (efi_enabled(EFI_BOOT)) {
> >>>+		drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
> >>>+							     screen_info.lfb_size,
> >>
> >>Using screen_info here seems wrong in any case. You want to remove
> >>the framebuffer devices that conflict with your driver, which might
> >>be unrelated to screen_info. AFAICT the correct solution would
> >>always retrieve the PCI device for removal (i.e., always do the else
> >>branch).
> >
> >In a Gen2 VM, the Hyper-V frame buffer device is presented only as a VMbus device.
> >It's not presented as a PCI device like it is in a Gen1 VM. This would have worked
> >if we had the frame buffer device available as PCI device in Gen2 but unfortunately
> >thats not the case here.
> 
> Thanks for explaining. There is an instance of struct hv_device
> passed to the probe function. I suspect you cannot get the
> framebuffer range from this instance (e.g., via the device's
> platform_data)?
> 
> If you absolutely can't get the actual memory region from the
> device, it's better to remove all framebuffers via
> drm_aperture_remove_framebuffers() than to use screen_info.
> 
> Best regards
> Thomas

Thanks for your suggestion, and I thought of using drm_aperture_remove_framebuffers
here, but this driver will be used in many different systems with many other graphics
devices (GPU etc). Removing all the framebuffer is a bit blunt approach which may disturb
the devices we are not intended to and which are even outside of the HyperV MMIO region.
I feel this API use will be risky, and I would like to stick to the earlier method which
is proven to be working for many years and we are sure it won't disturb anyone outside
MMIO region.

Regards,
Saurabh
> 
> >
> >Regards,
> >Saurabh
> >
> >>
> >>Best regard
> >>Thomas
> >>
> >>>+							     false,
> >>>+							     &hyperv_driver);
> >>>+	} else {
> >>>+		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> >>>+		if (!pdev) {
> >>>+			drm_err(dev, "Unable to find PCI Hyper-V video\n");
> >>>+			return -ENODEV;
> >>>+		}
> >>>+
> >>>+		ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &hyperv_driver);
> >>>+		pci_dev_put(pdev);
> >>>+		if (ret) {
> >>>+			drm_err(dev, "Not able to remove boot fb\n");
> >>>+			return ret;
> >>>+		}
> >>>+	}
> >>>  	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
> >>
> >>-- 
> >>Thomas Zimmermann
> >>Graphics Driver Developer
> >>SUSE Software Solutions Germany GmbH
> >>Maxfeldstr. 5, 90409 Nürnberg, Germany
> >>(HRB 36809, AG Nürnberg)
> >>Geschäftsführer: Ivo Totev
> >
> >
> >
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev



