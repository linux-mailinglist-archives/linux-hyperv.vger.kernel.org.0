Return-Path: <linux-hyperv+bounces-11961-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yMcMAGIWVWpJjwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11961-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:46:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8466A74DB93
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 18:46:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=TYdlTv69;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11961-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11961-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F1806300B1EA
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Jul 2026 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993DA437475;
	Mon, 13 Jul 2026 16:46:22 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C29E281530;
	Mon, 13 Jul 2026 16:46:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961182; cv=none; b=Hn1Y6sodq0GRr6dEmEts8r/BmF8TQnSsU2FK4N2OqQxNKyOCaWeIQX+Be5nibmWKiUe5GPrFTpWnh7wi2ORCJ+dvbY6NzNi6MAGKLTCtw0waMDL2fyxgsCVNDVFXT+T6NlGY5xqwTmLuGFhJIRPpj1849RAkSyDyl5LeNelyDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961182; c=relaxed/simple;
	bh=Sem6KJo6jUTitXm7NbisqjqOR5BQYp0HkiBD76Cxjk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM5q+IzoFBQ3TLo6gy5+8VpSh782YxYkCM3+sBwsVKcB/FOJZiIFB0TmW9RYD1tXjMcxpTaflWDBgEPkOySPEJeiNx1OqmPmboRPkUPXBR2FNjabz6gDnY+43s+hVwBDSAXZmmmSbBMx5jtVNh2H971Wqsa1EzOIT/GwxQhoCBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TYdlTv69; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6718F20B7166;
	Mon, 13 Jul 2026 09:46:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6718F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783961172;
	bh=GW97O9s/FqeNwr7q4Bm2RaJJPumMCy7wcDQxp5UqbLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TYdlTv698y99d+W8mwAyKPyT7FCVp7+pKIW8pi9KkSOfQ4/s6MBvmCfJ5hNf9wwD3
	 OW7Uf+GFIvI3ehv2UGqtaYl0oVCPWUyjR8heS33V+eU0lRqd9XtgREamqIW/DYZ4MK
	 2jc87WSEX7SMB/sGmV6qdzj52oj6TUcL8SMpEbZM=
Date: Tue, 14 Jul 2026 00:46:18 +0800
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
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <3ty6yq6oftsvq52skrngjv5xpyixhsyfo3dndhoujt7emxsb2o@y6ischifpmfn>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
 <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11961-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.microsoft.com:from_mime,linux.microsoft.com:dkim,y6ischifpmfn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8466A74DB93

On Sat, Jul 11, 2026 at 06:31:15PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, July 10, 2026 12:34 AM
> > 
> > On Thu, Jul 09, 2026 at 07:08:26PM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Thursday, July 2, 2026 9:05 AM
> > > >
> > > > Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
> > > > This driver implements stage-1 IO translation within the guest OS.
> > > > It integrates with the Linux IOMMU core, utilizing Hyper-V hypercalls
> > > > for:
> > > >  - Capability discovery
> > > >  - Domain allocation, configuration, and deallocation
> > > >  - Device attachment and detachment
> > > >  - IOTLB invalidation
> > > >
> > > > The driver constructs x86-compatible stage-1 IO page tables in the
> > > > guest memory using consolidated IO page table helpers. This allows
> > > > the guest to manage stage-1 translations independently of vendor-
> > > > specific drivers (like Intel VT-d or AMD IOMMU).
> > > >
> > > > Hyper-V consumes this stage-1 IO page table when a device domain is
> > > > created and configured, and nests it with the host's stage-2 IO page
> > > > tables, therefore eliminating the VM exits for guest IOMMU mapping
> > > > operations. For unmapping operations, VM exits to perform the IOTLB
> > > > flush are still unavoidable.
> > > >
> > > > To identify a device in its hypercall interface, the driver looks up the
> > > > logical device ID prefix registered for the device's PCI domain (see the
> > > > logical device ID registry in hv_common.c) and combines it with the PCI
> > > > function number of the endpoint device.
> > > >
> > > > Co-developed-by: Wei Liu <wei.liu@kernel.org>
> > > > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > > > Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > > > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > > > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > > > ---
> > > >  arch/x86/hyperv/hv_init.c       |   4 +
> > > >  arch/x86/include/asm/mshyperv.h |   4 +
> > > >  drivers/iommu/Kconfig           |   1 +
> > > >  drivers/iommu/hyperv/Kconfig    |  16 +
> > > >  drivers/iommu/hyperv/Makefile   |   1 +
> > > >  drivers/iommu/hyperv/iommu.c    | 620 ++++++++++++++++++++++++++++++++
> > > >  drivers/iommu/hyperv/iommu.h    |  51 +++
> > > >  7 files changed, 697 insertions(+)
> > > >  create mode 100644 drivers/iommu/hyperv/Kconfig
> > > >  create mode 100644 drivers/iommu/hyperv/iommu.c
> > > >  create mode 100644 drivers/iommu/hyperv/iommu.h
> > > >
> > > > diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> > > > index 55a8b6de2865..094f9f7ddb72 100644
> > > > --- a/arch/x86/hyperv/hv_init.c
> > > > +++ b/arch/x86/hyperv/hv_init.c
> > > > @@ -578,6 +578,10 @@ void __init hyperv_init(void)
> > > >  	old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
> > > >  	x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
> > > >
> > > > +#ifdef CONFIG_HYPERV_PVIOMMU
> > > > +	x86_init.iommu.iommu_init = hv_iommu_init;
> > > > +#endif
> > > > +
> > >
> > > This approach to .iommu_init is a bit different from the Intel VT-d and
> > > AMD IOMMU initialization. Those cases detect the existence of the
> > > IOMMU first via a "detect" function that is called in pci_iommu_alloc().
> > > If the detect function finds an IOMMU, it sets .iommu_init. Any
> > > reason not to use the same approach for the Hyper-V pvIOMMU?
> > > One problem with exactly the same approach is that Hyper-V
> > > hypercalls aren't set up at the time pci_iommu_alloc() runs.
> > 
> > Yes. That's why I did not follow Intel VT-d and AMD IOMMU's approach -
> > the hv_hypercall_pg is not ready yet.
> > 
> > > So you'd have to call the "detect" function here in hyperv_init(),
> > > and have the detect function set .iommu_init if pvIOMMU
> > > support is present.
> > >
> > 
> > The detecion of the presense and capabilities of the pvIOMMU are done
> > in one hypercall. But I guess we can:
> > - do the HVCALL_GET_IOMMU_CAPABILITIES in hyperv_init();
> > - check the presense and only set .iommu_init to hyperv_iommu_init()
> >   if pvIOMMU is present;
> > - and then do other capalibities check in hv_iommu_init();
> > - only give the error log if an pvIOMMU is present yet its capabilities
> >   are not legal.
> > So below errors will not be printed for guest kernels built with
> > CONFIG_HYPERV_PVIOMMU and running on a host w/o one.
> 
> I see your point about detection and capabilities coming from
> single hypercall, and that separating those two functions
> would duplicate code. My biggest concern is about errors in the
> dmesg log for a valid configuration where the host doesn't
> supply a pvIOMMU. Fixing that problem in the context of the
> current code structure would be acceptable.
> 
> A minor concern is arguably misusing the .iommu_init function
> to do detection. But that function is only called once at boot
> time, so leaving it set to hv_iommu_init() even if there isn't
> a Hyper-V pvIOMMU is probably more a conceptual issue
> than a real issue. I wouldn't object if you prefer to leave that
> "as is" to avoid duplicating the hypercall.
> 
> One new thought:  Have you considered the hibernate/resume
> cycle? Does anything need to be done with the pvIOMMU to
> make it functional again after resume? I see that the Intel and
> AMD IOMMU drivers have suspend and resume functions. I
> don't know enough about the Hyper-V pvIOMMU to know if it
> might also need suspend and resume functions.
> 

Thanks for raising this, Michael. We have not considered such support.

My understanding is that the Intel and AMD drivers only disable the
IOMMU translation, flush the IOTLB during the suspend and re-enable/
reload the preserved root tables and other HW state during in the
resueme.

But for pvIOMMU, I guess such job shall be done by the hypervisor? 
For a device resumed on the same VM, its logical device ID should
also remain unchanged?  And the corresponding Hyper-V domain objects,
configuration, and device attachments shall be preserved and restored
by hypervisor? I don't think the current Hyper-V ABI explicitly defines
this. But maybe if we want such feature, it could be done by the
hypervisor transparently?


B.R.
Yu

> Michael
> 
> > 
> > > While the code currently in this patch works, it generates boot
> > > time errors if the kernel is built with CONFIG_HYPERV_PVIOMMU
> > > but run in a guest on a host without pvIOMMU support:
> > >
> > > [    0.101673] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed, status 2
> > > [    0.101675] Hyper-V pvIOMMU: HVCALL_GET_IOMMU_CAPABILITIES failed: -22
> > >
> > > We really don't want errors if it's just the case that there's no
> > > pvIOMMU support. A less alarming message (at INFO level instead
> > > of ERROR level) about running without an IOMMU might be OK, but
> > > perhaps is unnecessary since you have an INFO message if the
> > > pvIOMMU is found and successfully initialized.
> > >
> 

