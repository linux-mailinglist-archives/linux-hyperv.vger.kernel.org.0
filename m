Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA47626063
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Nov 2022 18:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiKKR10 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Nov 2022 12:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKR1Z (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Nov 2022 12:27:25 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97811FCFD;
        Fri, 11 Nov 2022 09:27:24 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso3548626wms.4;
        Fri, 11 Nov 2022 09:27:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/3uL0cJaLOTxEva/CGuhHjJZAqpIjvQpF8FNaVhRZ0=;
        b=sIO67htFCPAC9EcfuzSUuB5o/Rl303zCk6n19MGsioep/3/6FPn9P4ENCZ5HZbNKhL
         t1DD1R3QYq6D0QUFQESTQ4Q0EokREBZJNK2EBAhxAfe//eUWe3gCqmPpYG/Bb2eQtqtm
         QiU+MTgbVZFXxb+9Da3ytPQXeU108i9MVB34fbrsOQVJiW8Mp4FdMC6xLoKOVrGqa7+n
         v3BzBKk7pPzvQ8NOi7HZCx11ZSVx/JEl19trL4UbKB60fqpfqEc4XuE1fjuJmeZUP0Bo
         dtsIegIc6a7Cdbd/F0+1iGieel+mcusbXWiDhqCsMrt0Wm7AN1emVFHYnduP9If1tI/j
         hueQ==
X-Gm-Message-State: ANoB5pnJgRNmpo/hokW9mDipfC67ID5A1U7e70rbAg6QruEl0BZkkPSY
        iDbGJpA61LU8PbzkIs1/BIQ=
X-Google-Smtp-Source: AA0mqf61N59y3uigQSGo0Sdln31/wEAfPIim0C9V+TeCi3ptjn5f3SjdN4pgykCfrAfIJ4/FMRV0EA==
X-Received: by 2002:a05:600c:348e:b0:3cf:6e78:e2aa with SMTP id a14-20020a05600c348e00b003cf6e78e2aamr2001990wmq.121.1668187643223;
        Fri, 11 Nov 2022 09:27:23 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id co19-20020a0560000a1300b0022e66749437sm2440234wrb.93.2022.11.11.09.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 09:27:22 -0800 (PST)
Date:   Fri, 11 Nov 2022 17:27:20 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] iommu/hyper-v: Allow hyperv irq remapping without x2apic
Message-ID: <Y26F+H1SuJrad3Ra@liuwe-devbox-debian-v2>
References: <1668020853-23950-1-git-send-email-nunodasneves@linux.microsoft.com>
 <Y255HhDbwbI/z5bJ@liuwe-devbox-debian-v2>
 <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB1688800D35F86D766567C1FAD7009@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Nov 11, 2022 at 04:55:22PM +0000, Michael Kelley (LINUX) wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Friday, November 11, 2022 8:33 AM
> > 
> > Hi Tianyu
> > 
> > On Wed, Nov 09, 2022 at 11:07:33AM -0800, Nuno Das Neves wrote:
> > > If x2apic is not available, hyperv-iommu skips remapping
> > > irqs. This breaks root partition which always needs irqs
> > > remapped.
> > >
> > > Fix this by allowing irq remapping regardless of x2apic,
> > > and change hyperv_enable_irq_remapping() to return
> > > IRQ_REMAP_XAPIC_MODE in case x2apic is missing.
> > >
> > 
> > Do you remember why it was x2apic only?
> > 
> > We tested this patch on different VM SKUs and it worked fine. I'm just
> > wondering if there would be some subtle breakages that we couldn't
> > easily test.
> > 
> > Thanks,
> > Wei.
> 
> My recollection is that originally Hyper-V provided the x2apic in the
> guest only when the number of vCPUs exceeded 255, and that was
> the only case where IRQ remapping was needed.  The intent was to
> not disturb the case where # of vCPUs was < 255 and the xapic is used.
> I don't remember there being any potential for subtle breakages.

Thanks for the information.

> 
> I think more recent versions of Hyper-V now provide the x2apic
> in the guest in some cases when # of vCPUs is < 255.
> 

On Azure the default for AMD SKUs is still xapic unless the number of
VCPUs exceeds 2XX (can't remember the exact number -- maybe it is 255).

Nuno, can you list the tests you've done? They will need to cover Linux
running as a normal guest on Azure and Hyper-V.

Thanks,
Wei.


> Michael
> 
> > 
> > > Tested with root and non-root hyperv partitions.
> > >
> > > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > > ---
> > >  drivers/iommu/Kconfig        | 6 +++---
> > >  drivers/iommu/hyperv-iommu.c | 7 ++++---
> > >  2 files changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > > index dc5f7a156ff5..cf7433652db0 100644
> > > --- a/drivers/iommu/Kconfig
> > > +++ b/drivers/iommu/Kconfig
> > > @@ -474,13 +474,13 @@ config QCOM_IOMMU
> > >  	  Support for IOMMU on certain Qualcomm SoCs.
> > >
> > >  config HYPERV_IOMMU
> > > -	bool "Hyper-V x2APIC IRQ Handling"
> > > +	bool "Hyper-V IRQ Handling"
> > >  	depends on HYPERV && X86
> > >  	select IOMMU_API
> > >  	default HYPERV
> > >  	help
> > > -	  Stub IOMMU driver to handle IRQs as to allow Hyper-V Linux
> > > -	  guests to run with x2APIC mode enabled.
> > > +	  Stub IOMMU driver to handle IRQs to support Hyper-V Linux
> > > +	  guest and root partitions.
> > >
> > >  config VIRTIO_IOMMU
> > >  	tristate "Virtio IOMMU driver"
> > > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > > index e190bb8c225c..abd1826a9e63 100644
> > > --- a/drivers/iommu/hyperv-iommu.c
> > > +++ b/drivers/iommu/hyperv-iommu.c
> > > @@ -123,8 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
> > >  	const struct irq_domain_ops *ops;
> > >
> > >  	if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
> > > -	    x86_init.hyper.msi_ext_dest_id() ||
> > > -	    !x2apic_supported())
> > > +	    x86_init.hyper.msi_ext_dest_id())
> > >  		return -ENODEV;
> > >
> > >  	if (hv_root_partition) {
> > > @@ -170,7 +169,9 @@ static int __init hyperv_prepare_irq_remapping(void)
> > >
> > >  static int __init hyperv_enable_irq_remapping(void)
> > >  {
> > > -	return IRQ_REMAP_X2APIC_MODE;
> > > +	if (x2apic_supported())
> > > +		return IRQ_REMAP_X2APIC_MODE;
> > > +	return IRQ_REMAP_XAPIC_MODE;
> > >  }
> > >
> > >  struct irq_remap_ops hyperv_irq_remap_ops = {
> > > --
> > > 2.25.1
> > >
