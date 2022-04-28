Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F74251370B
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Apr 2022 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiD1OlG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Apr 2022 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiD1OlF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Apr 2022 10:41:05 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A6515BF;
        Thu, 28 Apr 2022 07:37:50 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id t6so7091292wra.4;
        Thu, 28 Apr 2022 07:37:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CszHRjQoYJFbbrNoQtqtvbGaCDV1vUEycKzVbNvIqjk=;
        b=Dq/Orag9zgUc8mFXtMaSclVFBune0QOU+m0fR1yQ+vfTMzRdMaRSn+5QSwWmW4l41p
         o29MEpd4eLAGeuTRzEm4Hd9Rp/XkRqPMbAuYttwE8CtmU5AQbW28WiMcprd1uvL5z9Ee
         xqyKhLggaj5PvwE0AF3vvWwmrS1xswroZRi3jABs58+LQGc7kBeLxieXZDFNAMYSOKSc
         WfgKcDDTlvUAxBnKu9ZMCvFRTl5Fg53V+RlMQcDIr4lpv/1keaEsO3D6Z5TRPyd7RPOQ
         7SwTD3Hg28oFZJw26O9/KoBRFfn86oCne4MLKvwNO/Paf8owKiC2H06dI7nvuHt2QNFa
         WPjA==
X-Gm-Message-State: AOAM532ySvA0Vhj3tH1VoR1oeqwCWYQO2NsyGT/ikc/qCx7V5o8tr78I
        n8efFI2IHdRxDHiMV/Qhso8=
X-Google-Smtp-Source: ABdhPJzs5p+R/52J26Y4hNZlqsAqpuaqNSum/qnfJUJoomeoLuITL3BI/R01M0v0Da4gdkvXq3jXdA==
X-Received: by 2002:adf:eb12:0:b0:207:b333:5e7d with SMTP id s18-20020adfeb12000000b00207b3335e7dmr27573896wrn.585.1651156669059;
        Thu, 28 Apr 2022 07:37:49 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o42-20020a05600c512a00b00393f143efd8sm4542105wms.16.2022.04.28.07.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:37:48 -0700 (PDT)
Date:   Thu, 28 Apr 2022 14:37:46 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     ssengar@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        deller@gmx.de, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: hyperv_fb: Allow resolutions with size > 64 MB
 for Gen1
Message-ID: <20220428143746.sya775ro5zi3kgm3@liuwe-devbox-debian-v2>
References: <1651067273-6635-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1651067273-6635-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Apr 27, 2022 at 06:47:53AM -0700, Saurabh Sengar wrote:
> This patch fixes a bug where GEN1 VMs doesn't allow resolutions greater
> than 64 MB size (eg 7680x4320). Unnecessary PCI check limits Gen1 VRAM
> to legacy PCI BAR size only (ie 64MB). Thus any, resolution requesting
> greater then 64MB (eg 7680x4320) would fail. MMIO region assigning this
> memory shouldn't be limited by PCI bar size.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  drivers/video/fbdev/hyperv_fb.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index c8e0ea2..58c304a 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -1009,7 +1009,6 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  	struct pci_dev *pdev  = NULL;
>  	void __iomem *fb_virt;
>  	int gen2vm = efi_enabled(EFI_BOOT);
> -	resource_size_t pot_start, pot_end;
>  	phys_addr_t paddr;
>  	int ret;
>  
> @@ -1060,23 +1059,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
>  	dio_fb_size =
>  		screen_width * screen_height * screen_depth / 8;
>  
> -	if (gen2vm) {
> -		pot_start = 0;
> -		pot_end = -1;
> -	} else {
> -		if (!(pci_resource_flags(pdev, 0) & IORESOURCE_MEM) ||
> -		    pci_resource_len(pdev, 0) < screen_fb_size) {
> -			pr_err("Resource not available or (0x%lx < 0x%lx)\n",
> -			       (unsigned long) pci_resource_len(pdev, 0),
> -			       (unsigned long) screen_fb_size);
> -			goto err1;

This restriction has been in place since day 1. Haiyang, you wrote this
driver. Can you comment on whether this change here is sensible?

Thanks,
Wei.

> -		}
> -
> -		pot_end = pci_resource_end(pdev, 0);
> -		pot_start = pot_end - screen_fb_size + 1;
> -	}
> -
> -	ret = vmbus_allocate_mmio(&par->mem, hdev, pot_start, pot_end,
> +	ret = vmbus_allocate_mmio(&par->mem, hdev, 0, -1,
>  				  screen_fb_size, 0x100000, true);
>  	if (ret != 0) {
>  		pr_err("Unable to allocate framebuffer memory\n");
> -- 
> 1.8.3.1
> 
