Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247C43DF70F
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Aug 2021 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhHCVrd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 3 Aug 2021 17:47:33 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52083 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhHCVrd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 3 Aug 2021 17:47:33 -0400
Received: by mail-wm1-f47.google.com with SMTP id u15so33109wmj.1;
        Tue, 03 Aug 2021 14:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NO+JU9UzRMwitUxOBD7sMCGKQLIhbf2Foco5VWOK1Z4=;
        b=nebyBEwPY6bSnXiWGg2AqdRRvbZmwJMuM9Z80WWMpt57dXybTxNdcKmgv9KrcSmO7t
         PH9T5yAHC2ajMSniVCIUJFWpaq+IkVZ8DSozjK7vxpC+RlonTIf/6pxuCkvcaJaTP/Nr
         EHxR5d19gYazWbaLowlIPMpyfjXc9UVNPjZD/NSvmmIXZ4FKEcSCrySfkO8PAWeetHZk
         3E5r1hFR9wwroQpVzsKczJ3wd/4JytpARMuQ1aSqZKB6JaxPehfDI+JjG05vpxc57y9H
         wYM6y06coENOulTowW59Km8V8cXT33zmfuon6/vcBflYrVKTB5DWPGBCQhPNHyDfQTjB
         /hkg==
X-Gm-Message-State: AOAM530+y5HIl/EMuhAkjrAzjT2mPRAA/wlSrkKCUec5VFLA+THNlzgI
        tkBpQFpIPWMX50oA8ZdLjG4=
X-Google-Smtp-Source: ABdhPJxKVZaGEKq0W06B3ndgni2gnDr15UMxeozYYtoe6oJ0dR7qwn8iMp7dsEVgP13d0k8hAPltQQ==
X-Received: by 2002:a05:600c:4f42:: with SMTP id m2mr6587287wmq.47.1628027240884;
        Tue, 03 Aug 2021 14:47:20 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t8sm240744wmj.5.2021.08.03.14.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 14:47:20 -0700 (PDT)
Date:   Tue, 3 Aug 2021 21:47:18 +0000
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
        pasha.tatashin@soleen.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Subject: Re: [RFC v1 5/8] mshv: add paravirtualized IOMMU support
Message-ID: <20210803214718.hnp3ejs35lh455fw@liuwe-devbox-debian-v2>
References: <20210709114339.3467637-1-wei.liu@kernel.org>
 <20210709114339.3467637-6-wei.liu@kernel.org>
 <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77670985-2a1b-7bbd-2ede-4b7810c3e220@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Aug 04, 2021 at 12:10:45AM +0530, Praveen Kumar wrote:
> On 09-07-2021 17:13, Wei Liu wrote:
> > +static void hv_iommu_domain_free(struct iommu_domain *d)
> > +{
> > +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> > +	unsigned long flags;
> > +	u64 status;
> > +	struct hv_input_delete_device_domain *input;
> > +
> > +	if (is_identity_domain(domain) || is_null_domain(domain))
> > +		return;
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +
> > +	input->device_domain= domain->device_domain;
> > +
> > +	status = hv_do_hypercall(HVCALL_DELETE_DEVICE_DOMAIN, input, NULL);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> 
> Is it OK to deallocate the resources, if hypercall has failed ?

It should be fine. We leak some resources in the hypervisor, but Linux
is in a rather wedged state anyway. Refusing to free up resources in
Linux does not much good.

> Do we have any specific error code EBUSY (kind of) which we need to wait upon ?
> 

I have not found a circumstance that can happen.

> > +
> > +	ida_free(&domain->hv_iommu->domain_ids, domain->device_domain.domain_id.id);
> > +
> > +	iommu_put_dma_cookie(d);
> > +
> > +	kfree(domain);
> > +}
> > +
> > +static int hv_iommu_attach_dev(struct iommu_domain *d, struct device *dev)
> > +{
> > +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> > +	u64 status;
> > +	unsigned long flags;
> > +	struct hv_input_attach_device_domain *input;
> > +	struct pci_dev *pdev;
> > +	struct hv_iommu_endpoint *vdev = dev_iommu_priv_get(dev);
> > +
> > +	/* Only allow PCI devices for now */
> > +	if (!dev_is_pci(dev))
> > +		return -EINVAL;
> > +
> > +	pdev = to_pci_dev(dev);
> > +
> > +	dev_dbg(dev, "Attaching (%strusted) to %d\n", pdev->untrusted ? "un" : "",
> > +		domain->device_domain.domain_id.id);
> > +
> > +	local_irq_save(flags);
> > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	memset(input, 0, sizeof(*input));
> > +
> > +	input->device_domain = domain->device_domain;
> > +	input->device_id = hv_build_pci_dev_id(pdev);
> > +
> > +	status = hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> > +	local_irq_restore(flags);
> > +
> > +	if (!hv_result_success(status))
> > +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> 
> Does it make sense to vdev->domain = NULL ?
>

It is already NULL -- there is no other code path that sets it and the
detach path always sets the field to NULL.

> > +	else
> > +		vdev->domain = domain;
> > +
> > +	return hv_status_to_errno(status);
> > +}
> > +
[...]
> > +static size_t hv_iommu_unmap(struct iommu_domain *d, unsigned long iova,
> > +			   size_t size, struct iommu_iotlb_gather *gather)
> > +{
> > +	size_t unmapped;
> > +	struct hv_iommu_domain *domain = to_hv_iommu_domain(d);
> > +	unsigned long flags, npages;
> > +	struct hv_input_unmap_device_gpa_pages *input;
> > +	u64 status;
> > +
> > +	unmapped = hv_iommu_del_mappings(domain, iova, size);
> > +	if (unmapped < size)
> > +		return 0;
> 
> Is there a case where unmapped > 0 && unmapped < size ?
> 

There could be such a case -- hv_iommu_del_mappings' return value is >= 0.
Is there a problem with this predicate?

Wei.
