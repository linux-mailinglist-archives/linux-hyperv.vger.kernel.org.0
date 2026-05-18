Return-Path: <linux-hyperv+bounces-11003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPJxNYjgCmqR8wQAu9opvQ
	(envelope-from <linux-hyperv+bounces-11003-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 11:48:56 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D724F56A0B6
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 11:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1C8F430615A7
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 May 2026 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4513E5573;
	Mon, 18 May 2026 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j119BinO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 174252367D3;
	Mon, 18 May 2026 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097108; cv=none; b=mU73DrJY9MbReOJziXmfHt9ULtuIHXikN1Bvm0PFIKZtX6Dviud6ylk2GBXVlAmkjdglAhFegIXlLjjDx8Z7vFLJ7fnNIUMSBgmWC+KCHFcyZ9X2QHoeNEEIfxdFPNVzGJfVhrSVjAuxyvDunhwqZP0gVCdqL6k3PFo8+xN4Z3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097108; c=relaxed/simple;
	bh=4fPcah8dmnDnuK5ll3l6RFnFjqxv4SXmcFfh6J4rtLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uaiS5FdQ5qBSUl2Iij+hE6YOLLw6GmpXIS+bwGP/6IDP0vnm0L6ETvXsElBlySBeoZq5QTID++NmxokMEwdf1EfS6mA08uu0eB5CZpv9jnzvEg7qflTxJyzr2/jZ9Dxq4yXK4Gc5FshCQjD0/D0IDStnidE3AJOZlLv1fEWVpXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j119BinO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.233.27])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B45020B7166;
	Mon, 18 May 2026 02:38:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B45020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779097100;
	bh=s+YWJYVFWtMEG0xZrCUw5nCzzgDA6ShdPxjhNN8my48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j119BinOxvlRrzkE98QrVKF82TAePguMU9osCRhtQYYu7deolqSpUlplJGmHsNInM
	 oglxeWgyHeWOSWShyvk/iKi3W6jR5X3+jJGJ3uS7S9Mg+kAMxj+5s3xUcvErjC9H6s
	 9X2s+eLyYPvfbXm+dSPLyw9HsZCZMS5TPLxBO+78=
Date: Mon, 18 May 2026 17:38:23 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>, 
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com" <longli@microsoft.com>, 
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>, 
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>
Subject: Re: [PATCH v1 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <f74lbhq66bya4s44mhghc63wckctysvreuxfr6vkysvuj3nloh@axkuugfiati2>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157FB81CC9B6347DCCC8C56D4072@SN6PR02MB4157.namprd02.prod.outlook.com>
 <qeyycsdnejwrqle4zwrvkjvkvrpjifeanwxjaa7i7y2ab7rnt2@b6gvugqayarg>
 <SN6PR02MB415734108A86BDFB66AEE4CED4042@SN6PR02MB4157.namprd02.prod.outlook.com>
 <fw2pruvjgo7yigtcxssf3xv27soibsj6hmw2ls5wj4rylfhdha@e63f32cwu2x5>
 <53754e0b-2af8-edd2-dfc0-293fac002a52@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53754e0b-2af8-edd2-dfc0-293fac002a52@linux.microsoft.com>
X-Rspamd-Queue-Id: D724F56A0B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11003-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_CC(0.00)[outlook.com,vger.kernel.org,lists.linux.dev,kernel.org,microsoft.com,8bytes.org,arm.com,google.com,arndb.de,ziepe.ca,linux.microsoft.com];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,domain_id.id:url]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 05:11:19PM -0700, Mukesh R wrote:
> On 5/15/26 09:53, Yu Zhang wrote:
> > On Fri, May 15, 2026 at 02:51:38PM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, May 15, 2026 7:00 AM
> > > > 
> > > > On Thu, May 14, 2026 at 06:13:24PM +0000, Michael Kelley wrote:
> > > > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 9:24 AM
> > > > > > 
> > > > > > Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> > > > > > This driver implements stage-1 IO translation within the guest OS.
> > > > > > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > > > > > for:
> > > > > >   - Capability discovery
> > > > > >   - Domain allocation, configuration, and deallocation
> > > > > >   - Device attachment and detachment
> > > > > >   - IOTLB invalidation
> > > > > > 
> > > > > > The driver constructs x86-compatible stage-1 IO page tables in the
> > > > > > guest memory using consolidated IO page table helpers. This allows
> > > > > > the guest to manage stage-1 translations independently of vendor-
> > > > > > specific drivers (like Intel VT-d or AMD IOMMU).
> > > > > > 
> > > > > > Hyper-V consumes this stage-1 IO page table when a device domain is
> > > > > > created and configured, and nests it with the host's stage-2 IO page
> > > > > > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > > > > > operations. For unmapping operations, VM exits to perform the IOTLB
> > > > > > flush are still unavoidable.
> > > > > > 
> > > > > > Hyper-V identifies each PCI pass-thru device by a logical device ID
> > > > > > in its hypercall interface. The vPCI driver (pci-hyperv) registers the
> > > > > > per-bus portion of this ID with the pvIOMMU driver during bus probe.
> > > > > > The pvIOMMU driver stores this mapping and combines it with the function
> > > > > > number of the endpoint PCI device to form the complete ID for hypercalls.
> > > > > 
> > > > > As you are probably aware, Mukesh's patch series to support PCI
> > > > > pass-thru devices also needs to get the logical device ID. Maybe the
> > > > > registration mechanism needs to move somewhere that can be shared
> > > > > with his code.
> > > > > 
> > > > 
> > > > Thank you so much for the review, Michael!
> > > > 
> > > > Yes, I looked at Mukesh's series and noticed his hv_pci_vmbus_device_id()
> > > > in pci-hyperv.c has the same dev_instance byte manipulation. We do need
> > > > a common registration mechanism.
> > > > 
> > > > Any suggestion on where to put it? drivers/hv/hv_common.c seems like a
> > > > natural place, but the register/lookup functions are currently only
> > > > meaningful when CONFIG_HYPERV_PVIOMMU is set. If Mukesh's pass-thru
> > > > code also needs them, we might need a new shared Kconfig option that
> > > > both can select. Open to better ideas.
> > > 
> > > Unfortunately, I have not looked at Mukesh's series in detail yet, so
> > > I don't have enough knowledge of the full situation to offer a good
> > > recommendation.
> > > 
> > 
> > Sorry I forgot to Cc Mukesh in the previous reply. :(
> > @Mukesh, any thoughts on sharing the logical device ID registration mechanism?
> 
> Yeah, I went round and round trying to find the best place. I almost
> created virt/hyperv/hv_utils.c file. Maybe that is the best place?

Thanks for thinking about this, Mukesh!

I'm a bit hesitant about introducing virt/hyperv/. Currently virt/ 
only hosts KVM's architecture-neutral hypervisor core. And it feels
like the wrong layer for driver-level utility code. And drivers/hv/
seems like a more natural fit?

I'm also thinking about the config to gating these new interfaces(
register/lookup etc.), I am using CONFIG_HYPERV_PVIOMMU, and I guess
you may propably propose another one for the host side change(or just 
CONFIG_MSHV_ROOT)?

B.R.
Yu

> 
> Thanks,
> -Mukesh
> 
> 
> > > > 
> > > > [...]
> > > > 
> > > > > > +static void hv_flush_device_domain(struct hv_iommu_domain *hv_domain)
> > > > > > +{
> > > > > > +	u64 status;
> > > > > > +	unsigned long flags;
> > > > > > +	struct hv_input_flush_device_domain *input;
> > > > > > +
> > > > > > +	local_irq_save(flags);
> > > > > > +
> > > > > > +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> > > > > > +	memset(input, 0, sizeof(*input));
> > > > > > +	input->device_domain = hv_domain->device_domain;
> > > > > 
> > > > > The previous version of this patch had code to set several other fields in
> > > > > the input. I wanted to confirm that not setting them in this version is
> > > > > intentional. Were they not needed?
> > > > > 
> > > > 
> > > > Oh. The RFC v1 set partition_id, owner_vtl, domain_id.type, and domain_id.id
> > > > individually. In this version, I just simplified it to a struct assignment.
> > > > No functional change.
> > > 
> > > Of course! I should have looked more closely at the details before making
> > > this comment. :-(
> > > 
> > > [...]
> > > 
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
> > I realized it's a bit untidy. But I want to understand this issue more
> > clearly first. :)
> > 
> > B.R.
> > Yu
> 

