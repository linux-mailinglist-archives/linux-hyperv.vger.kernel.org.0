Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCA55B4FFD
	for <lists+linux-hyperv@lfdr.de>; Sun, 11 Sep 2022 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIKQVi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 11 Sep 2022 12:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiIKQVU (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 11 Sep 2022 12:21:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E176713F3C;
        Sun, 11 Sep 2022 09:21:19 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
        id A2339204CA0B; Sun, 11 Sep 2022 09:21:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A2339204CA0B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1662913279;
        bh=Z4QMTDUS2dSBcOU+9vvtM4dEnmR8yddlU4SZvyzFekg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MyEWnvVu3dsnLw8poRMoSa6YY4x+ckJRSbanuAxolY57UgncQ/5UQ+l9jr53JK81v
         PIs46XiNi9Hg4WrlJ7w36VjWdXmy/ggnXWlBEbl/RvVoo5lnBVOAWWyA9wZc7XSdvq
         zsKLYL5uvtfx38ZTYt18HPcGhzmKMTFf0FFo+8Sc=
Date:   Sun, 11 Sep 2022 09:21:19 -0700
From:   Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     ssengar@microsoft.com, drawat.floss@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        mikelley@microsoft.com
Subject: Re: [PATCH] drm/hyperv: Don't rely on screen_info.lfb_base for Gen1
 VMs
Message-ID: <20220911162119.GB7754@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1662734639-27164-1-git-send-email-ssengar@linux.microsoft.com>
 <14302178-c797-8635-4325-070f78b7f805@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14302178-c797-8635-4325-070f78b7f805@suse.de>
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

On Sat, Sep 10, 2022 at 08:11:24PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 09.09.22 um 16:43 schrieb Saurabh Sengar:
> >hyperv_setup_vram tries to remove conflicting framebuffer based on
> >'screen_info'. As observed in past due to some bug or wrong setting
> >in grub, the 'screen_info' fields may not be set for Gen1, and in such
> >cases drm_aperture_remove_conflicting_framebuffers will not do anything
> >useful.
> >For Gen1 VMs, it should always be possible to get framebuffer
> >conflict removed using PCI device instead.
> >
> >Fixes: a0ab5abced55 ("drm/hyperv : Removing the restruction of VRAM allocation with PCI bar size")
> >Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> >---
> >  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 24 ++++++++++++++++++++----
> >  1 file changed, 20 insertions(+), 4 deletions(-)
> >
> >diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >index 6d11e7938c83..b0cc974efa45 100644
> >--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> >@@ -73,12 +73,28 @@ static int hyperv_setup_vram(struct hyperv_drm_device *hv,
> >  			     struct hv_device *hdev)
> >  {
> >  	struct drm_device *dev = &hv->dev;
> >+	struct pci_dev *pdev;
> >  	int ret;
> >-	drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
> >-						     screen_info.lfb_size,
> >-						     false,
> >-						     &hyperv_driver);
> >+	if (efi_enabled(EFI_BOOT)) {
> >+		drm_aperture_remove_conflicting_framebuffers(screen_info.lfb_base,
> >+							     screen_info.lfb_size,
> 
> Using screen_info here seems wrong in any case. You want to remove
> the framebuffer devices that conflict with your driver, which might
> be unrelated to screen_info. AFAICT the correct solution would
> always retrieve the PCI device for removal (i.e., always do the else
> branch).

In a Gen2 VM, the Hyper-V frame buffer device is presented only as a VMbus device.
It's not presented as a PCI device like it is in a Gen1 VM. This would have worked
if we had the frame buffer device available as PCI device in Gen2 but unfortunately
thats not the case here.

Regards,
Saurabh

> 
> Best regard
> Thomas
> 
> >+							     false,
> >+							     &hyperv_driver);
> >+	} else {
> >+		pdev = pci_get_device(PCI_VENDOR_ID_MICROSOFT, PCI_DEVICE_ID_HYPERV_VIDEO, NULL);
> >+		if (!pdev) {
> >+			drm_err(dev, "Unable to find PCI Hyper-V video\n");
> >+			return -ENODEV;
> >+		}
> >+
> >+		ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &hyperv_driver);
> >+		pci_dev_put(pdev);
> >+		if (ret) {
> >+			drm_err(dev, "Not able to remove boot fb\n");
> >+			return ret;
> >+		}
> >+	}
> >  	hv->fb_size = (unsigned long)hv->mmio_megabytes * 1024 * 1024;
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev



