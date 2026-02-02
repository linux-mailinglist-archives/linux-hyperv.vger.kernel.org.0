Return-Path: <linux-hyperv+bounces-8638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GL/MxzRgGlBBwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8638-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:30:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF7FCEFF3
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 17:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 415BD3071232
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781CA2798E5;
	Mon,  2 Feb 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KRfw5N8/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7426E6FA;
	Mon,  2 Feb 2026 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049240; cv=none; b=BQxXkzc33C0fYRBqEyJxuOQP3miqpWB5ZuD5/w5Geu0oPGcDulVPiKHSvJho040iCA+Jd7owEc8vWj1nVDsQyIEtSSZsQrArhvHkdd2j5hrKus8c5Pr/YKkR2eQWVd59oUEt4RWvFEMKHGq0Oc/sW6P2CVCM/fNoZKCvHmX+vzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049240; c=relaxed/simple;
	bh=bUuCyUPTcAsCcUf0UxDuRNkkh7lksoj1hSCzT0+E6HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gbp1XhXO+hHBYxkXmlzklpBKoF+Yjs56Md1qlVhWmVki9rmvBYvqV7ws15mINu3rqMvUp//CrdOVYKGsR8/0/257pmVTr0XylA/4hVywn9UkP7ap+dpjQPGjAI/qhUQog1YAsS6yjiMCCzdQ7qSmNj0OX7yLzIyVLFsfj3k1E/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KRfw5N8/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5C9020B7167;
	Mon,  2 Feb 2026 08:20:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5C9020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770049238;
	bh=kmJOTjW25jCERLEzVtuof6EFwFlGRPjslBeg6kwpqRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRfw5N8/WMl6FFewcvTfzhNLYXNyvLXm25xMe3oAUvNxPHExpL8Tva4eg5lOd+m6E
	 6cFaoQ/UM+s0Sd2GUAy4NyH/DKG4PeieMvps0dPNHSkjgiJtrr9F8R3jV4bdLHFiar
	 P9iGy28LlNBvpyXYkdyh3To9yaUoeO7yH6QtHT+A=
Date: Mon, 2 Feb 2026 08:20:37 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, joro@8bytes.org,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	nunodasneves@linux.microsoft.com, mhklinux@outlook.com,
	romank@linux.microsoft.com
Subject: Re: [PATCH v0 12/15] x86/hyperv: Implement hyperv virtual iommu
Message-ID: <aYDO1S3DdUSHNkEY@skinsburskii.localdomain>
References: <20260120064230.3602565-1-mrathor@linux.microsoft.com>
 <20260120064230.3602565-13-mrathor@linux.microsoft.com>
 <aXAZ-r1PeUBAHwaK@skinsburskii.localdomain>
 <54fd73b9-ade6-f1bb-08fc-17571aeadb20@linux.microsoft.com>
 <aXeO7wh7bpacJ1Sk@skinsburskii.localdomain>
 <c40e6dc8-8e42-b0f3-f8e5-3c637adb7f13@linux.microsoft.com>
 <aXkIGfos4l0kv_lF@skinsburskii.localdomain>
 <8298de1d-648c-bbc6-b3c9-1cbc9b5d7e72@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8298de1d-648c-bbc6-b3c9-1cbc9b5d7e72@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8638-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.linux.dev,microsoft.com,kernel.org,arm.com,linutronix.de,redhat.com,alien8.de,linux.intel.com,zytor.com,8bytes.org,google.com,arndb.de,linux.microsoft.com,outlook.com];
	RCPT_COUNT_TWELVE(0.00)[29];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 2EF7FCEFF3
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 02:51:19PM -0800, Mukesh R wrote:
> On 1/27/26 10:46, Stanislav Kinsburskii wrote:
> > On Mon, Jan 26, 2026 at 07:02:29PM -0800, Mukesh R wrote:
> > > On 1/26/26 07:57, Stanislav Kinsburskii wrote:
> > > > On Fri, Jan 23, 2026 at 05:26:19PM -0800, Mukesh R wrote:
> > > > > On 1/20/26 16:12, Stanislav Kinsburskii wrote:
> > > > > > On Mon, Jan 19, 2026 at 10:42:27PM -0800, Mukesh R wrote:
> > > > > > > From: Mukesh Rathor <mrathor@linux.microsoft.com>
> > > > > > > 
> > > > > > > Add a new file to implement management of device domains, mapping and
> > > > > > > unmapping of iommu memory, and other iommu_ops to fit within the VFIO
> > > > > > > framework for PCI passthru on Hyper-V running Linux as root or L1VH
> > > > > > > parent. This also implements direct attach mechanism for PCI passthru,
> > > > > > > and it is also made to work within the VFIO framework.
> > > > > > > 
> > > > > > > At a high level, during boot the hypervisor creates a default identity
> > > > > > > domain and attaches all devices to it. This nicely maps to Linux iommu
> > > > > > > subsystem IOMMU_DOMAIN_IDENTITY domain. As a result, Linux does not
> > > > > > > need to explicitly ask Hyper-V to attach devices and do maps/unmaps
> > > > > > > during boot. As mentioned previously, Hyper-V supports two ways to do
> > > > > > > PCI passthru:
> > > > > > > 
> > > > > > >      1. Device Domain: root must create a device domain in the hypervisor,
> > > > > > >         and do map/unmap hypercalls for mapping and unmapping guest RAM.
> > > > > > >         All hypervisor communications use device id of type PCI for
> > > > > > >         identifying and referencing the device.
> > > > > > > 
> > > > > > >      2. Direct Attach: the hypervisor will simply use the guest's HW
> > > > > > >         page table for mappings, thus the host need not do map/unmap
> > > > > > >         device memory hypercalls. As such, direct attach passthru setup
> > > > > > >         during guest boot is extremely fast. A direct attached device
> > > > > > >         must be referenced via logical device id and not via the PCI
> > > > > > >         device id.
> > > > > > > 
> > > > > > > At present, L1VH root/parent only supports direct attaches. Also direct
> > > > > > > attach is default in non-L1VH cases because there are some significant
> > > > > > > performance issues with device domain implementation currently for guests
> > > > > > > with higher RAM (say more than 8GB), and that unfortunately cannot be
> > > > > > > addressed in the short term.
> > > > > > > 
> > > > > > 
> > > > > > <snip>
> > > > > > 
> > > > 
> > > > <snip>
> > > > 
> > > > > > > +static void hv_iommu_detach_dev(struct iommu_domain *immdom, struct device *dev)
> > > > > > > +{
> > > > > > > +	struct pci_dev *pdev;
> > > > > > > +	struct hv_domain *hvdom = to_hv_domain(immdom);
> > > > > > > +
> > > > > > > +	/* See the attach function, only PCI devices for now */
> > > > > > > +	if (!dev_is_pci(dev))
> > > > > > > +		return;
> > > > > > > +
> > > > > > > +	if (hvdom->num_attchd == 0)
> > > > > > > +		pr_warn("Hyper-V: num_attchd is zero (%s)\n", dev_name(dev));
> > > > > > > +
> > > > > > > +	pdev = to_pci_dev(dev);
> > > > > > > +
> > > > > > > +	if (hvdom->attached_dom) {
> > > > > > > +		hv_iommu_det_dev_from_guest(hvdom, pdev);
> > > > > > > +
> > > > > > > +		/* Do not reset attached_dom, hv_iommu_unmap_pages happens
> > > > > > > +		 * next.
> > > > > > > +		 */
> > > > > > > +	} else {
> > > > > > > +		hv_iommu_det_dev_from_dom(hvdom, pdev);
> > > > > > > +	}
> > > > > > > +
> > > > > > > +	hvdom->num_attchd--;
> > > > > > 
> > > > > > Shouldn't this be modified iff the detach succeeded?
> > > > > 
> > > > > We want to still free the domain and not let it get stuck. The purpose
> > > > > is more to make sure detach was called before domain free.
> > > > > 
> > > > 
> > > > How can one debug subseqent errors if num_attchd is decremented
> > > > unconditionally? In reality the device is left attached, but the related
> > > > kernel metadata is gone.
> > > 
> > > Error is printed in case of failed detach. If there is panic, at least
> > > you can get some info about the device. Metadata in hypervisor is
> > > around if failed.
> > > 
> > 
> > With this approach the only thing left is a kernel message.
> > But if the state is kept intact, one could collect a kernel core and
> > analyze it.
> 
> Again, most of linux stuff is cleaned up, the only state is in
> hypervisor, and hypervisor can totally protect itself and devices.
> So there is not much in kernel core as it got cleaned up already.
> Think of this as additional check, we can remove in future after
> it stands the test of time, until then, every debugging bit helps.
> 

Again, the hypervisor state is not accessible from the kernel core in
L1VH.

> > And note, that there won't be a hypervisor core by default: our main
> > context with the usptreamed version of the driver is L1VH and a kernel
> > core is the only thing a third party customer can provide for our
> > analysis.
> 
> Wei can correct me, but we are not only l1vh focused here. There is
> work going on on all fronts.
> 

In upstream, it does not matter what the work is focused on. The only
thing that matters is that the functionality is merged and available.
Once the code is merged upstream, it becomes available to third-party
customers. They can use it in any way they see fit.
The only product we support with upstream code is L1VH. We should keep
it crisp, clear, and easy to debug.
This change does not help debugging. It only sweeps the issue under the
carpet, with no justification.

Thanks,
Stanislav

> Thanks,
> -Mukesh
> 
> > Thanks,
> > Stanislav

