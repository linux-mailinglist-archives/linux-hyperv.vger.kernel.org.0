Return-Path: <linux-hyperv+bounces-8619-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4f++KywTfWnCQAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8619-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 21:23:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C51A1BE5E8
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 21:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A2C930069B7
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9D8330B04;
	Fri, 30 Jan 2026 20:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="zZ3pXYzU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E162326D53;
	Fri, 30 Jan 2026 20:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769804582; cv=pass; b=Gz+gzOp1DHN8FoEnlY5Eu2egxlcdyYSgklKNI/9yRD7llzgle1/87h0RIUXrIPLEFOSftiyN9HFzKLL62Dn9tMS1zZNWafabINEd2NqVYcSRva//QLmb7RszkIHiOCIk4d+YN4iLgKw5jjD0wUno9mGSULuNl3O8uK6sLIIw/78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769804582; c=relaxed/simple;
	bh=IscK/m91CODprncH4JfhniegZToEinLtCoUn+kql1Gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RaAmaLxKTqrM5oHLDgBhEZFAj+2ABoQ4GwMXyddNjh65AWrh9DgrSrMuyQdGWIckfQgitD1ImLqJXcKKES0wBqrCitYC9c3u2jBnAO84o2DT7ST8LcweXqjpFqXUSguixZx+k/uv4KjcSocBVClTbmOsqiDqt2dLanklOy+Q0ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=zZ3pXYzU; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769804563; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oEXA5OTjixrNsjjidI37px48vHvY2Ci8LT7bsUXKZjotzopIUxcuDlNga+v6bUmYc+wZGRUBh7qHYeF0znzQwxeEcf2zn8QA6juK/iTks7egOqlPGPPfOoCNfdENeGpMmC+hFTFrTifd6ftddDaboLMN5kj5vhPIW/YWP9Q51Hw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769804563; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Wpy0ilMMcB6W+uAX7CL0KD2YtLOlFo5QRc5kYgmyhfc=; 
	b=T460yRXdUpe/pM93ehp43sSMV+ZJGsfBlMVHERPVeC97AsNxxCkL/2p5WC4YNAkk6zL3o6yENfZhA7Gsklw8rVeloGyXTNszb3MOetXzAjY4qTjVOG7QPMnb1aiZWWYjk6ZJEnn0kPylteF3e4+Mww88KuzaAbY+QX23sX+fA+g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769804563;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=Wpy0ilMMcB6W+uAX7CL0KD2YtLOlFo5QRc5kYgmyhfc=;
	b=zZ3pXYzUO6eJln9vI10WZVLDS+bhj6H0MMmAEfrTMc+xkr9gPoykG+X9ILAOMBLO
	MiIdLAR41S6QbGmdH7ZrQnQVWWQC0UuUap2l4e2jpdQJZQsuwShX2zBKFZPs8OwV160
	CWZVO8zeWgrmQyaGveY0gmNXXEl31B8cgUQprdi8=
Received: by mx.zohomail.com with SMTPS id 1769804560787972.2237143671788;
	Fri, 30 Jan 2026 12:22:40 -0800 (PST)
Date: Fri, 30 Jan 2026 20:22:34 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mshv: Add support for integrated scheduler
Message-ID: <aX0TCpXFxI8zVlQ1@anirudh-surface.localdomain>
References: <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
 <aXzqsfT8-h-g9mex@anirudh-surface.localdomain>
 <aXz6cu8BG1vwiCeb@skinsburskii.localdomain>
 <aXz7vYzJOkzkj5V3@anirudh-surface.localdomain>
 <aXz9nssiRC1DUFSU@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXz9nssiRC1DUFSU@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8619-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: C51A1BE5E8
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 10:51:10AM -0800, Stanislav Kinsburskii wrote:
> On Fri, Jan 30, 2026 at 06:43:09PM +0000, Anirudh Rayabharam wrote:
> > On Fri, Jan 30, 2026 at 10:37:38AM -0800, Stanislav Kinsburskii wrote:
> > > On Fri, Jan 30, 2026 at 05:30:25PM +0000, Anirudh Rayabharam wrote:
> > > > On Thu, Jan 29, 2026 at 11:09:46AM -0800, Stanislav Kinsburskii wrote:
> > > > > On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> > > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, January 21, 2026 2:36 PM
> > > > > > > 
> > > > > > > From: Andreea Pintilie <anpintil@microsoft.com>
> > > > > > > 
> > > > > > > Query the hypervisor for integrated scheduler support and use it if
> > > > > > > configured.
> > > > > > > 
> > > > > > > Microsoft Hypervisor originally provided two schedulers: root and core. The
> > > > > > > root scheduler allows the root partition to schedule guest vCPUs across
> > > > > > > physical cores, supporting both time slicing and CPU affinity (e.g., via
> > > > > > > cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> > > > > > > scheduling entirely to the hypervisor.
> > > > > > > 
> > > > > > > Direct virtualization introduces a new privileged guest partition type - L1
> > > > > > > Virtual Host (L1VH) — which can create child partitions from its own
> > > > > > > resources. These child partitions are effectively siblings, scheduled by
> > > > > > > the hypervisor's core scheduler. This prevents the L1VH parent from setting
> > > > > > > affinity or time slicing for its own processes or guest VPs. While cgroups,
> > > > > > > CFS, and cpuset controllers can still be used, their effectiveness is
> > > > > > > unpredictable, as the core scheduler swaps vCPUs according to its own logic
> > > > > > > (typically round-robin across all allocated physical CPUs). As a result,
> > > > > > > the system may appear to "steal" time from the L1VH and its children.
> > > > > > > 
> > > > > > > To address this, Microsoft Hypervisor introduces the integrated scheduler.
> > > > > >   This the s allows an L1VH partition to schedule its own vCPUs and those of its
> > > > > > > guests across its "physical" cores, effectively emulating root scheduler
> > > > > > > behavior within the L1VH, while retaining core scheduler behavior for the
> > > > > > > rest of the system.
> > > > > > > 
> > > > > > > The integrated scheduler is controlled by the root partition and gated by
> > > > > > > the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> > > > > > > supports the integrated scheduler. The L1VH partition must then check if it
> > > > > > > is enabled by querying the corresponding extended partition property. If
> > > > > > > this property is true, the L1VH partition must use the root scheduler
> > > > > > > logic; otherwise, it must use the core scheduler.
> > > > > > > 
> > > > > > > Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > ---
> > > > > > >  drivers/hv/mshv_root_main.c |   79 +++++++++++++++++++++++++++++--------------
> > > > > > >  include/hyperv/hvhdk_mini.h |    6 +++
> > > > > > >  2 files changed, 58 insertions(+), 27 deletions(-)
> > > > > > > 
> > > 
> > >  <snip>
> > > 
> > > > > > > -root_sched_deinit:
> > > > > > > -	root_scheduler_deinit();
> > > > > > > -	return err;
> > > > > > >  }
> > > > > > > 
> > > > > > > -static void mshv_init_vmm_caps(struct device *dev)
> > > > > > > +static int mshv_init_vmm_caps(struct device *dev)
> > > > > > >  {
> > > > > > > -	/*
> > > > > > > -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> > > > > > > -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
> > > > > > > -	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
> > > > > > > -	 */
> > > > > > > -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > > > > -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > > > > -					      0, &mshv_root.vmm_caps,
> > > > > > > -					      sizeof(mshv_root.vmm_caps)))
> > > > > > > -		dev_warn(dev, "Unable to get VMM capabilities\n");
> > > > > > > +	int ret;
> > > > > > > +
> > > > > > > +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > > > > +					 	HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > > > > +						0, &mshv_root.vmm_caps,
> > > > > > > +						sizeof(mshv_root.vmm_caps));
> > > > > > > +	if (ret) {
> > > > > > > +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> > > > > > > +		return ret;
> > > > > > > +	}
> > > > > > 
> > > > > > This is a functional change that isn't mentioned in the commit message.
> > > > > > Why is it now appropriate to fail instead of treating the VMM capabilities
> > > > > > as all disabled? Presumably there are older versions of the hypervisor that
> > > > > > don't support the requirements described in the original comment, but
> > > > > > perhaps they are no longer relevant?
> > > > > > 
> > > > > 
> > > > > To fail is now the only option for the L1VH partition. It must discover
> > > > > the scheduler type. Without this information, the partition cannot
> > > > > operate. The core scheduler logic will not work with an integrated
> > > > > scheduler, and vice versa.
> > > > 
> > > > I don't think we need to fail here. If we don't find vmm caps, that
> > > > means we are on an older hypervisor that supports l1vh but not
> > > > integrated scheduler (yes, such a version exists). In this case since
> > > > integrated scheduler is not supported by the hypervisor, the core
> > > > scheduler logic will work.
> > > > 
> > > 
> > > The older hypervisor version won't have the integrated scheduler
> > > capabity bit.
> > > And we can't operate in core schedule mode if the integrated is enabled
> > > underneath us.
> > 
> > The older hypervisor won't have the integrated scheduler capability bit.
> > This means that the older hypervisor doesn't support integrated
> > scheduler (this is how vmm caps work: if the bit doesn't exist or
> > vmm caps themselves don't exist the feature should be assumed as not
> > available). If the hypervisor doesn't support integrated scheduler in the
> > first place, it can't be enabled underneath us. So, it is safe to
> > operate in core scheduler mode.
> > 
> 
> We can’t tell whether the hypervisor is older and simply doesn’t have
> the VMM caps bit, or whether we just failed to fetch the VMM caps.

If we failed to fetch the VMM caps i.e. the hypervisor doesn't support
the vmm caps property, we must assume that all the bits in vmm caps are
0 (i.e. no features are available). This is how vmm capabilities are
supposed to be interpreted. This is something I checked with the
hypervisor team some time back.

> 
> In other words, we can’t distinguish between “an older hypervisor
> without integrated scheduler support” and “a newer hypervisor with an
> integrated scheduler, but we failed to fetch the VMM caps”.
> 
> But for completeness: are you saying there is an older hypervisor
> version that supports L1VH, but does not support VMM caps?

I don't know how much of the Azure fleet still runs it but yes such a
hypervisor version exists.

Thanks,
Anirudh

> 
> Thanks, Stanislav
> 
> > Thanks,
> > Anirudh.

