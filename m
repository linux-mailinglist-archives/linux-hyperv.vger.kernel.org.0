Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3673DF71E
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 23:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhHCV4d (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 17:56:33 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:41815 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHCV4c (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 17:56:32 -0400
Received: by mail-wm1-f51.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so68420wms.0;
        Tue, 03 Aug 2021 14:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KEdn0D6XFoulQDVjB2J64O1ReMdifj14YvbOIlyaTQI=;
        b=Psnf+hD37QMtUkYwVoYbNF3B2J2lNlJvIBcXkjSn0GsrAeJoz1ZkZFLPU32fmLuLQy
         FwWbm2CnuUQY58a0kb1pIXBwfIK+IR6LU+CD5SPMStcQzuBe8qaadKudoIROIS17Y1+l
         Y/d+GNeD1GuKWb8DPaV22nUr8pGOHgCaKxDRo8rEuZMxdrPy2qB+BheztVOIsqpRM8SL
         tSuKmWVawdFhHAqa9Fx18Ph+TR/82qYkTf0ZIZZBiQPxnBUgKvpXgSvjw0YkGBX8VydC
         NZaN2M4Ns5ujNMpuxBgWuPk5wqOrDTHe8UCBd46P0Fjltn8fOwKAKeftnFGUpQc01UbX
         VolQ==
X-Gm-Message-State: AOAM530QhcTlgINlIvbSTuYkBVwOmyJaRiir0MHa5RjP8WX1YQfEsIEl
        zrqzE94S8uqsSUJZXfOq2zU=
X-Google-Smtp-Source: ABdhPJxaFrCXrIOhbU717JapIDxRtBRTH2yEvUWqOhnXxo7gqhu79AQIfJi2ryqp/mmez67LySI3rA==
X-Received: by 2002:a05:600c:298:: with SMTP id 24mr24152258wmk.93.1628027779370;
        Tue, 03 Aug 2021 14:56:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g12sm145022wri.49.2021.08.03.14.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:56:18 -0700 (PDT)
Date:   Tue, 3 Aug 2021 21:56:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Praveen Kumar <kumarpraveen@linux.microsoft.com>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC v1 6/8] mshv: command line option to skip devices in
 PV-IOMMU
Message-ID: <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 04, 2021 at 12:20:42AM +0530, Praveen Kumar wrote:
> On 09-07-2021 17:13, Wei Liu wrote:
> > Some devices may have been claimed by the hypervisor already. One such
> > example is a user can assign a NIC for debugging purpose.
> > 
> > Ideally Linux should be able to tell retrieve that information, but
> > there is no way to do that yet. And designing that new mechanism is
> > going to take time.
> > 
> > Provide a command line option for skipping devices. This is a stopgap
> > solution, so it is intentionally undocumented. Hopefully we can retire
> > it in the future.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  drivers/iommu/hyperv-iommu.c | 45 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> > 
> > diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> > index 043dcff06511..353da5036387 100644
> > --- a/drivers/iommu/hyperv-iommu.c
> > +++ b/drivers/iommu/hyperv-iommu.c
> > @@ -349,6 +349,16 @@ static const struct irq_domain_ops hyperv_root_ir_domain_ops = {
> >  
> >  #ifdef CONFIG_HYPERV_ROOT_PVIOMMU
> >  
> > +/* The IOMMU will not claim these PCI devices. */
> > +static char *pci_devs_to_skip;
> > +static int __init mshv_iommu_setup_skip(char *str) {
> > +	pci_devs_to_skip = str;
> > +
> > +	return 0;
> > +}
> > +/* mshv_iommu_skip=(SSSS:BB:DD.F)(SSSS:BB:DD.F) */
> > +__setup("mshv_iommu_skip=", mshv_iommu_setup_skip);
> > +
> >  /* DMA remapping support */
> >  struct hv_iommu_domain {
> >  	struct iommu_domain domain;
> > @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> >  	if (!dev_is_pci(dev))
> >  		return ERR_PTR(-ENODEV);
> >  
> > +	/*
> > +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
> > +	 * temporary solution until we figure out a way to extract information
> > +	 * from the hypervisor what devices it is already using.
> > +	 */
> > +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> > +		int pos = 0;
> > +		int parsed;
> > +		int segment, bus, slot, func;
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +		do {
> > +			parsed = 0;
> > +
> > +			sscanf(pci_devs_to_skip + pos,
> > +				" (%x:%x:%x.%x) %n",
> > +				&segment, &bus, &slot, &func, &parsed);
> > +
> > +			if (parsed <= 0)
> > +				break;
> > +
> > +			if (pci_domain_nr(pdev->bus) == segment &&
> > +				pdev->bus->number == bus &&
> > +				PCI_SLOT(pdev->devfn) == slot &&
> > +				PCI_FUNC(pdev->devfn) == func)
> > +			{
> > +				dev_info(dev, "skipped by MSHV IOMMU\n");
> > +				return ERR_PTR(-ENODEV);
> > +			}
> > +
> > +			pos += parsed;
> > +
> > +		} while (pci_devs_to_skip[pos]);
> 
> Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip)
> and also a valid memory ?

pos should point to the last parsed position. If parsing fails pos does
not get updated and the code breaks out of the loop. If parsing is
success pos should point to either the start of next element of '\0'
(end of string). To me this is good enough.

> I would recommend to have a check of size as well before accessing the
> array content, just to be safer accessing any memory.
> 

What check do you have in mind?

Wei.

> > +	}
> > +
> >  	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
> >  	if (!vdev)
> >  		return ERR_PTR(-ENOMEM);
> > 
> 
> Regards,
> 
> ~Praveen.
