Return-Path: <linux-hyperv+bounces-11057-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Fw9OnnaDWoo4QUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11057-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:59:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F45915FE
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7BC6300F5C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54F335BBB;
	Wed, 20 May 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OGojhXHV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0B22D738F;
	Wed, 20 May 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292256; cv=none; b=f/jsfuI0oOYSubNs12+og/CvBc+qIo4eYtXMMLZ3+Ca03QvFI+SbHWxAUHOqW5da4DpyhO82fsYgiNAv8GxxUMnQLmRFWGcw+9+mQ2dYjhKQ9LXOCM1sZit35ZA4RQEOwfd76K6eUraIenwHkEMF5KlBNFIUSwmXkZANZ+l0CkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292256; c=relaxed/simple;
	bh=RpaoUo25ECjWtwHsRvzBvqMTEK8AB1cJGeouPwGSCwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nQO99YW9fWU1QacLxI18f49gPdsjLf6NILAcXZC1FThB093r2smyOkshVHAstiSF0bWQI/vfZA9zbPb/YwZ5hKFsehfy0h+LWicojahuTN8f6vu4EzpKWulPNqxoFpRci1UPBklbW41Ac4blljY1XfXgr7SHImLijgRiHWaPq6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OGojhXHV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id DA57220B7168;
	Wed, 20 May 2026 08:50:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DA57220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779292246;
	bh=l1D/wHEJEIsOiA8Sd48g6TEyzc1+Z3D0jNjjvbWptc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OGojhXHVLWqkRhIFoYuzDbMc85gCV3hkBREx+q4jcJ8gIwe1tRrC4HFbA8ZUQ7jXm
	 oYOH6TxjGbswbYwCca/6dzs6hIkUarwEZjrt/yLTvM/DWT4QyUpapwfMLyOV3nxx/T
	 sZ7WDa0AhSMNvoLUeIaf6gjVUfOe9FeVBJiFbzwM=
Date: Wed, 20 May 2026 23:50:50 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <cecgndun5p7k53krzh2ffc7h3dl4o3br2s5dafc5qe7n7e7dbm@s5ovlevvle7s>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
 <SN6PR02MB415734108A86BDFB66AEE4CED4042@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fw2pruvjgo7yigtcxssf3xv27soibsj6hmw2ls5wj4rylfhdha@e63f32cwu2x5>
 <SN6PR02MB4157A1B2D9B56062A0917BC5D4042@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157A1B2D9B56062A0917BC5D4042@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	TAGGED_FROM(0.00)[bounces-11057-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 887F45915FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 15, 2026 at 05:36:40PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 9:54 AM
> > 
> > On Fri, May 15, 2026 at 02:51:38PM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 7:00 AM
> > > >
> > > > On Thu, May 14, 2026 at 06:13:24PM +0000, Michael Kelley wrote:
> > > > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:24 AM
> 
> [....]
> 
> > > > >
> > > > > Previous versions of this function did hv_iommu_detach_dev(). With that call
> > > > > removed from here, hv_iommu_detach_dev() is only called when attaching a
> > > > > domain to a device that already has a domain attached. Is it the case that
> > > > > Hyper-V doesn't require the detach as a cleanup step?
> > > > >
> > > >
> > > > The IOMMU core attaches the device to release_domain (our blocking domain)
> > > > before calling release_device(), so I believe the explicit detach in the RFC
> > > > was redundant. I simply didn't realize that at the time.
> > > >
> > >
> > > Got it. But after the IOMMU core attaches the device to the blocking
> > > domain, there's the possibility that the vPCI device is rescinded by
> > > Hyper-V and it goes away entirely. Or the device might be subjected
> > > to an "unbind/bind" cycle in Linux. Does the detach need to be done
> > > on the blocking domain in such cases? In this version of the patches, the
> > > Hyper-V "attach" and "detach" hypercalls still end up unbalanced. That
> > > seems a bit untidy at best, and I wonder if there are scenarios where
> > > Hyper-V will complain about the lack of balance.
> > >
> > 
> > Thank you, Michael. May I ask what "the vPCI device is rescinded by
> > Hyper-V and it goes away entirely" mean?
> > 
> 
> See the documentation at Documentation/virt/hyperv/vpci.rst in a
> kernel source code tree, and particularly the section entitled "PCI Device
> Removal". Such removals can and do happen in running Azure guest
> VMs. Start with that info and then I'll do my best to answer follow-up
> questions you may have.
> 
> The unbind/bind case is separate, but has some of the same effects in
> that Linux should be removing all setup of the PCI device. There's actually
> two unbind steps -- one to unbind the device-specific driver (e.g., the
> Mellanox MLX5 driver or the NMVe driver) driver from the device, and
> potentially a second to unbind the VMBus vPCI driver from the device.
> These unbind/bind sequences can be done in the Linux guest without
> the Hyper-V host rescinding the device.

Thanks for pointing me to the vpci.rst doc, Michael!

IIUC, for the vPCI rescind case and the VMBus vPCI driver unbind
case, both will trigger iommu_deinit_device(), in which IOMMU core
attaches the device to our blocking domain. And hypervisor will
handle such attaching to the blocking domain by essentially disable
the DMA translation and IOPF for the device. Since the device is
already in a safe state after that, I don't think an additional
detach is necessary.

For the device-specific driver unbind (e.g., unbind nvme then
bind back, or bind to vfio-pci), that is transparent to the IOMMU
layer.

Also, while looking at Jason's comments on the detach/attach
semantics, I'm now thinking that making the attach hypercall
atomic (having the hypervisor handle the domain switch
internally) might be a cleaner approach. That also eliminates
the attach/detach imbalance issue entirely. I need to do some
verification on the hypervisor side first, but will keep you
posted. Thanks!

B.R.
Yu

> 
> Michael
> 

