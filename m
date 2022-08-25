Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AE95A15F6
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Aug 2022 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiHYPoL (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Aug 2022 11:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiHYPoK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Aug 2022 11:44:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40085A61DD;
        Thu, 25 Aug 2022 08:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D116A61AA0;
        Thu, 25 Aug 2022 15:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A528C433D6;
        Thu, 25 Aug 2022 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661442249;
        bh=NI6bEWYxT3wUsy1ctPQSrY15pyDD3bTfE83vKL08zDI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gDW9NnyYKg6fq6+foprxelMsgqSx8RSZKHJ9O45rfWPGFJaaUZkUyIHgZry6sgo41
         zBXF87faDMn1a2lm5Lt85WwsybbFpHwPKhhpjr8JD+73269vAmeVB/yqtGXCd3/nCa
         qd9vc6NKxAF1avhIcHwX6VnkwEcWyFUFackn1jaayMNI5WRxt7FW8ldNCHCpQIRdlW
         8tirQsknuDKdJPdcLRj9H5p+AGNPdQfdCOKomT4I2p7Hnz4/KT+RvhhXPQSRDv+pIn
         m2TjjrGcDu0qh44nKRKt6qHIcj5+iM0jEhWRZI9WGg7iGp9yslgoWBcbIjlQfQW1bs
         4o1+ozVqmBuoA==
Date:   Thu, 25 Aug 2022 10:43:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Michael Kelley <mikelley@microsoft.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>
Subject: Re: [PATCH v2 1/3] PCI: Move
 PCI_VENDOR_ID_MICROSOFT/PCI_DEVICE_ID_HYPERV_VIDEO definitions to pci_ids.h
Message-ID: <20220825154345.GA2853885@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825090024.1007883-2-vkuznets@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Aug 25, 2022 at 11:00:22AM +0200, Vitaly Kuznetsov wrote:
> There are already three places in kernel which define PCI_VENDOR_ID_MICROSOFT
> and two for PCI_DEVICE_ID_HYPERV_VIDEO and there's a need to use these
> from core Vmbus code. Move the defines where they belong.
> 
> No functional change.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h

> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c         | 3 ---
>  drivers/net/ethernet/microsoft/mana/gdma_main.c | 4 ----
>  drivers/video/fbdev/hyperv_fb.c                 | 4 ----
>  include/linux/pci_ids.h                         | 3 +++
>  4 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> index 6d11e7938c83..40888e36f91a 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
> @@ -23,9 +23,6 @@
>  #define DRIVER_MAJOR 1
>  #define DRIVER_MINOR 0
>  
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
> -#define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
> -
>  DEFINE_DRM_GEM_FOPS(hv_fops);
>  
>  static struct drm_driver hyperv_driver = {
> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index 5f9240182351..00d8198072ae 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -1465,10 +1465,6 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }
>  
> -#ifndef PCI_VENDOR_ID_MICROSOFT
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
> -#endif
> -
>  static const struct pci_device_id mana_id_table[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_PF_DEVICE_ID) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_MICROSOFT, MANA_VF_DEVICE_ID) },
> diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
> index 886c564787f1..b58b445bb529 100644
> --- a/drivers/video/fbdev/hyperv_fb.c
> +++ b/drivers/video/fbdev/hyperv_fb.c
> @@ -74,10 +74,6 @@
>  #define SYNTHVID_DEPTH_WIN8 32
>  #define SYNTHVID_FB_SIZE_WIN8 (8 * 1024 * 1024)
>  
> -#define PCI_VENDOR_ID_MICROSOFT 0x1414
> -#define PCI_DEVICE_ID_HYPERV_VIDEO 0x5353
> -
> -
>  enum pipe_msg_type {
>  	PIPE_MSG_INVALID,
>  	PIPE_MSG_DATA,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 6feade66efdb..15b49e655ce3 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2079,6 +2079,9 @@
>  #define PCI_DEVICE_ID_ICE_1712		0x1712
>  #define PCI_DEVICE_ID_VT1724		0x1724
>  
> +#define PCI_VENDOR_ID_MICROSOFT		0x1414
> +#define PCI_DEVICE_ID_HYPERV_VIDEO	0x5353
> +
>  #define PCI_VENDOR_ID_OXSEMI		0x1415
>  #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
>  #define PCI_DEVICE_ID_OXSEMI_PCIe840		0xC000
> -- 
> 2.37.1
> 
