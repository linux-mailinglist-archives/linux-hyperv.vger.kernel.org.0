Return-Path: <linux-hyperv+bounces-11083-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGyaEUMcDmpT6AUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11083-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:40:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E18599E91
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 22:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B83F30237C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DFC372B59;
	Wed, 20 May 2026 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LgB2g2xU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322553644C6;
	Wed, 20 May 2026 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779309631; cv=none; b=rRGf3PXmY6zQlRxGbcHh3JOr7ctcBAX5m22p/cx7OX4iWF0qkuFa/bhnhqruH0f8dsPtxjowRBvimnyHAAZB/uzLTadL6olKZlcnUhxh4TZlp51tbYgaUmMBh710HO8LOPm1O8XqAuhV3RrrYJJz737eyWMWzAOUT6O4FdK4zbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779309631; c=relaxed/simple;
	bh=k1MhuIqMKRFoGyuIgP7PjOWaRJFBAZTibl9OKQnlf78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cxoNfvYiBiiGtWI0nRww1bpcdxSp7h3CgbQQCsqCkMfFSmRnDD3X4DUzD1Rn0jyty2OSjXy/wOR84/z242a3SMyXJaghNYwYdV6DpVCZ+k4LSgrkxUuBMNfRyVcJkp30pCUCqpLoAFnk8WMFZml8EBGSAKIMJ+TkOZmdLhGplIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LgB2g2xU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.191.74.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0CD8720B7167;
	Wed, 20 May 2026 13:40:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0CD8720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779309622;
	bh=ZTcvWeiCLY8IQJ6ozqWjHg1nBJ4h24wKde+9AGbNAWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LgB2g2xUxWwPRCYo0dfn50NfBs9rQcctYdX2NKlwi8S708qQXh//Kl7Qma58jdfwL
	 s4GYYl9C9ic55fsaTn4zXGpt7NDFotd8qit6wWEQBHkKHxEfG8kGXKPjPDlngl3yZm
	 q++zSPLg4aIxJcOM1/FEBIGQH0EyJVoipRgnSYf8=
Date: Wed, 20 May 2026 13:40:27 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Yu Zhang <zhangyu1@linux.microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
 <kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
 <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
 "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
 <robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
 <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
 "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>,
 "easwar.hariharan@linux.microsoft.com"
 <easwar.hariharan@linux.microsoft.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260520134027.00005e91@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
	<20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
	<20260515223545.GL7702@ziepe.ca>
	<lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
	<SN6PR02MB4157C1EC7F5F69C5ABDA9C7FD4012@SN6PR02MB4157.namprd02.prod.outlook.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[outlook.com];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-11083-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B1E18599E91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, 20 May 2026 19:26:24 +0000
Michael Kelley <mhklinux@outlook.com> wrote:

> From: Michael Kelley <mhklinux@outlook.com>
> To: Yu Zhang <zhangyu1@linux.microsoft.com>, Jason Gunthorpe
> <jgg@ziepe.ca> CC: "linux-kernel@vger.kernel.org"
> <linux-kernel@vger.kernel.org>,  "linux-hyperv@vger.kernel.org"
> <linux-hyperv@vger.kernel.org>,  "iommu@lists.linux.dev"
> <iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
> <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
> <linux-arch@vger.kernel.org>, "wei.liu@kernel.org"
> <wei.liu@kernel.org>,  "kys@microsoft.com" <kys@microsoft.com>,
> "haiyangz@microsoft.com"  <haiyangz@microsoft.com>,
> "decui@microsoft.com" <decui@microsoft.com>,  "longli@microsoft.com"
> <longli@microsoft.com>, "joro@8bytes.org"  <joro@8bytes.org>,
> "will@kernel.org" <will@kernel.org>,  "robin.murphy@arm.com"
> <robin.murphy@arm.com>, "bhelgaas@google.com"  <bhelgaas@google.com>,
> "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
> "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org"
> <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
> "arnd@arndb.de"  <arnd@arndb.de>, "jacob.pan@linux.microsoft.com"
> <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com"
> <tgopinath@linux.microsoft.com>,
> "easwar.hariharan@linux.microsoft.com"
> <easwar.hariharan@linux.microsoft.com> Subject: RE: [PATCH v1 4/4]
> iommu/hyperv: Add page-selective IOTLB flush  support Date: Wed, 20
> May 2026 19:26:24 +0000
>=20
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Wednesday, May
> 20, 2026 10:15 AM
> >=20
> > On Fri, May 15, 2026 at 07:35:45PM -0300, Jason Gunthorpe wrote: =20
> > > On Tue, May 12, 2026 at 12:24:08AM +0800, Yu Zhang wrote: =20
> > > > +static inline u16 hv_iommu_fill_iova_list(union
> > > > hv_iommu_flush_va *iova_list,
> > > > +					  unsigned long start,
> > > > +					  unsigned long end)
> > > > +{
> > > > +	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > > > +	unsigned long end_pfn =3D PAGE_ALIGN(end) >> PAGE_SHIFT;
> > > > +	unsigned long nr_pages =3D end_pfn - start_pfn;
> > > > +	u16 count =3D 0;
> > > > +
> > > > +	while (nr_pages > 0) {
> > > > +		unsigned long flush_pages;
> > > > +		int order;
> > > > +		unsigned long pfn_align;
> > > > +		unsigned long size_align;
> > > > +
> > > > +		if (count >=3D HV_IOMMU_MAX_FLUSH_VA_COUNT) {
> > > > +			count =3D HV_IOMMU_FLUSH_VA_OVERFLOW;
> > > > +			break;
> > > > +		}
> > > > +
> > > > +		if (start_pfn)
> > > > +			pfn_align =3D __ffs(start_pfn);
> > > > +		else
> > > > +			pfn_align =3D BITS_PER_LONG - 1;
> > > > +
> > > > +		size_align =3D __fls(nr_pages);
> > > > +		order =3D min(pfn_align, size_align);
> > > > +		iova_list[count].page_mask_shift =3D order;
> > > > +		iova_list[count].page_number =3D start_pfn;
> > > > +
> > > > +		flush_pages =3D 1UL << order;
> > > > +		start_pfn +=3D flush_pages;
> > > > +		nr_pages -=3D flush_pages;
> > > > +		count++;
> > > > +	} =20
> > >
> > > This seems like a really silly hypervisor interface. Why doesn't
> > > it just accept a normal range? Splitting it into power of two
> > > aligned ranges is very inefficient. =20
> >=20
> > Fair point. I'm not sure how much flexibility we have to change
> > this hypercall interface at the moment - it predates the pvIOMMU
> > work and may have other consumers beyond Linux guest. On the other
> > hand, having the guest specify 2^N-aligned blocks does save the
> > hypervisor from having to decompose ranges itself before issuing
> > hardware invalidation commands - the guest-provided entries can be
> > fed to the HW more or less directly.
> >=20
> > That said, the way I'm currently using this interface may be
> > more precise than necessary. Maybe we have 2 options:
> >=20
> > 1) Current approach: decompose the range into multiple exact
> >    2^N-aligned blocks with no over-flush, but at the cost of
> >    more complex calculations and more entries.
> >=20
> > 2) Follow what Intel/AMD drivers do: find a single minimal
> >    2^N-aligned block that covers the entire range, but may
> >    over-flush.
> >=20
> > Any preference?
> >=20
> > @Michael, since you've also been reviewing this patch, I'd
> > appreciate your thoughts on the above as well. :)
> >  =20
>=20
> I'm just guessing, but perhaps flushing an aligned power-of-2
> range can be processed by the hypervisor at a relatively fixed
> cost, regardless of the size. Having the guest do the decomposing
> of an arbitrary range allows the hypervisor to make use of the
> existing "rep" hypercall mechanism if the hypercall is taking
> "too long". The hypervisor can pause its processing, return to
> the guest temporarily, and then continue the hypercall. If the
> arbitrary range were passed into the hypercall for the hypervisor
> to do the decomposing, that pause-and-restart mechanism
> wouldn't be available.
>=20
> Of course, Linux doesn't really take advantage of the pause to
> reduce guest interrupt latency because the Hyper-V code in
> Linux typically disable interrupts around a hypercall due to the
> way the hypercall input page is allocated. But other guest
> operating systems might benefit from such a pause. And we could
> probably fix the Hyper-V code in Linux to allow interrupts during a
> hypercall pause/restart if long-running hypercalls turn out to be
> a problem.
I am not sure if this pause feature is suitable for IOTLB flush at all
since it is inherently synchronous =E2=80=94 the caller must block until all
invalidations complete. Pausing mid-flush to return to the guest
doesn't help if the guest can't make forward progress anyway.

