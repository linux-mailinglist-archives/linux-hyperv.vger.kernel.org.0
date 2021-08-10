Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C803E57EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Aug 2021 12:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhHJKEp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Aug 2021 06:04:45 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:39661 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232974AbhHJKEp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Aug 2021 06:04:45 -0400
Received: by mail-wm1-f44.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso1517680wmg.4;
        Tue, 10 Aug 2021 03:04:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNPyEQUv6Ji6aWmVMQgSNl5jQ96sNm9i4LSvAWR0eaA=;
        b=ikOb2NFm7xfUtkZSBxmo10hZiy9Wk4/phB8ClonedO1JzB+UuQFu3Rx04OPVA+pK27
         GQLI6v9+1aawo09WWzk+Q6Rpz1/fSii3CjlRlXXzfr/hFbf3esthezsThHN2zjTrUm/S
         R5ffvCUfteKyDuM254msd8SGiVxTSPOEQm2eK16qkrBpzZJtI4T7bRxHU7rgEgcArlpG
         M30gLQBAn8zLmhlb62OfoKgGA5Q/cxn0QcPEEUKwZHH6S9vU7qGpmhB21T2cJOM8I2P9
         N58ETkp9yBGCr0mYYYOIps8HhDqammGzjwunk494kWxAGou1Pp5TWIL6if/tf+Pa48qX
         CKiQ==
X-Gm-Message-State: AOAM5312a9JvG5HV7FAcciUZEMPmntTyRGcOm1fgUDQfkg1vKLZCCRbq
        110mf1rb2H/tGWE17eDNUaM=
X-Google-Smtp-Source: ABdhPJxqwuyMnHbZRg1qBZctOdB5h6Kf4V8NZCJ8ord6bBrxy7xEi7XisJdq+Xmsrl1aGAMEv6+vWg==
X-Received: by 2002:a05:600c:1c11:: with SMTP id j17mr21277438wms.35.1628589862198;
        Tue, 10 Aug 2021 03:04:22 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id e3sm9074443wro.15.2021.08.10.03.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 03:04:21 -0700 (PDT)
Date:   Tue, 10 Aug 2021 10:04:19 +0000
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
Message-ID: <20210810100419.g3rjj3xegydalyz3@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-7-wei.liu@kernel.org>
 <4a6918ea-e3e5-55c9-a12d-bee7261301fd@linux.microsoft.com>
 <20210803215617.fzx2vrzhsabrrolc@liuwe-devbox-debian-v2>
 <8d9b6b9a-62b1-95ea-1bb6-258e72c1800d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d9b6b9a-62b1-95ea-1bb6-258e72c1800d@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 04, 2021 at 12:33:54PM +0530, Praveen Kumar wrote:
> On 04-08-2021 03:26, Wei Liu wrote:
> >>>  	struct iommu_domain domain;
> >>> @@ -774,6 +784,41 @@ static struct iommu_device *hv_iommu_probe_device(struct device *dev)
> >>>  	if (!dev_is_pci(dev))
> >>>  		return ERR_PTR(-ENODEV);
> >>>  
> >>> +	/*
> >>> +	 * Skip the PCI device specified in `pci_devs_to_skip`. This is a
> >>> +	 * temporary solution until we figure out a way to extract information
> >>> +	 * from the hypervisor what devices it is already using.
> >>> +	 */
> >>> +	if (pci_devs_to_skip && *pci_devs_to_skip) {
> >>> +		int pos = 0;
> >>> +		int parsed;
> >>> +		int segment, bus, slot, func;
> >>> +		struct pci_dev *pdev = to_pci_dev(dev);
> >>> +
> >>> +		do {
> >>> +			parsed = 0;
> >>> +
> >>> +			sscanf(pci_devs_to_skip + pos,
> >>> +				" (%x:%x:%x.%x) %n",
> >>> +				&segment, &bus, &slot, &func, &parsed);
> >>> +
> >>> +			if (parsed <= 0)
> >>> +				break;
> >>> +
> >>> +			if (pci_domain_nr(pdev->bus) == segment &&
> >>> +				pdev->bus->number == bus &&
> >>> +				PCI_SLOT(pdev->devfn) == slot &&
> >>> +				PCI_FUNC(pdev->devfn) == func)
> >>> +			{
> >>> +				dev_info(dev, "skipped by MSHV IOMMU\n");
> >>> +				return ERR_PTR(-ENODEV);
> >>> +			}
> >>> +
> >>> +			pos += parsed;
> >>> +
> >>> +		} while (pci_devs_to_skip[pos]);
> >>
> >> Is there a possibility of pci_devs_to_skip + pos > sizeof(pci_devs_to_skip)
> >> and also a valid memory ?
> > 
> > pos should point to the last parsed position. If parsing fails pos does
> > not get updated and the code breaks out of the loop. If parsing is
> > success pos should point to either the start of next element of '\0'
> > (end of string). To me this is good enough.
> 
> The point is, hypothetically the address to pci_devs_to_skip + pos can
> be valid address (later to '\0'), and thus there is a possibility,
> that parsing may not fail.

Have you found an example how at any given point in time
pci_devs_to_skip + pos can point outside of user provided string?

> Another, there is also a possibility of sscanf faulting accessing the
> illegal address, if pci_devs_to_skip[pos] turns out to be not NULL or
> valid address.

That depends on pci_devs_to_skip + pos can point to an invalid address
in the first place, so that goes back to the question above.

> 
> > 
> >> I would recommend to have a check of size as well before accessing the
> >> array content, just to be safer accessing any memory.
> >>
> > 
> > What check do you have in mind?
> 
> Something like,
> size_t len = strlen(pci_devs_to_skip);
> do {
> 
> 	len -= parsed;
> } while (len);
> 
> OR
> 
> do {
> ...
> 	pos += parsed;
> } while (pos < len);
> 
> Further, I'm also fine with the existing code, if you think this won't
> break and already been taken care. Thanks.

But in the loop somewhere you will still need to parse pci_devs_to_skip
+ some_offset. The new code structure does not remove that, right?

Given this is for debugging and is supposed to be temporary, I think the
code is good enough. But I want to make sure if there is anything I
missed.

Wei.

> 
> Regards,
> 
> ~Praveen.
