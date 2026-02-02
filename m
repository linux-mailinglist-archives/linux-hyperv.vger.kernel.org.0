Return-Path: <linux-hyperv+bounces-8646-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD08AdTegGleCAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8646-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:28:52 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1593CCF98F
	for <lists+linux-hyperv@lfdr.de>; Mon, 02 Feb 2026 18:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71FC63004C88
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Feb 2026 17:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FAE37BE8A;
	Mon,  2 Feb 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dtrnvs7p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28386274B40;
	Mon,  2 Feb 2026 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052781; cv=none; b=pP6ASJbOBv+DCFnJLEFQ00EkgHW8zKd0bv1s4OQPmWMVEga5wSNfTSXdoKHGK5L/LFxj3S3qt4tLx0Zdu4WoXsIY8hVqe8XbMrtNDMaavY8OCg3bsbce7qO3kAoM0xJnpXjDpLk1aFiINBJ24Usw1T1ADPJ0J9wqgKOIYYz9xhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052781; c=relaxed/simple;
	bh=aCOIJYTQd174SNRfNUsunDs/n7g0TCl9VVtvDd14JhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh5O2s4peXLTzH/uPNh99lurI1kdArbUDb3IN+7OXQE97fSlfQur93dRRa5Tw0zL+FfhicaiZoSL1NOHO/SpHqfcH4VRLd4mqnOT4wLEkyBpt3rAIjN5nVz3xuDXD6QrIL5JorZGX5HubvtrNBHUkGYBEKidawG/rdcQc9wIl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dtrnvs7p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8426320B7168;
	Mon,  2 Feb 2026 09:19:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8426320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770052779;
	bh=NeEADrnY1QpFA81zENwCU4rF5G5nTH9prZoq6o5ISY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dtrnvs7pDfhy20O9WaLgY2fYu3b77C3jRqXs6Q28TrnpKpAekn+t+lhW3B07SZ+O4
	 GtHLm1jRSV2NTog39MY8UUhb+ZYaEf5ZGaXq28qbEIG8LLZ/V6KdYT2uzxPjGw884R
	 1aFV1+dpXmbh/E/tpZ4kBJoYwUH+kbz3eSxTshZk=
Date: Mon, 2 Feb 2026 09:19:39 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mshv: Add support for integrated scheduler
Message-ID: <aYDcq3xQKF6cCjwR@skinsburskii.localdomain>
References: <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
 <aXzqsfT8-h-g9mex@anirudh-surface.localdomain>
 <aXz6cu8BG1vwiCeb@skinsburskii.localdomain>
 <aXz7vYzJOkzkj5V3@anirudh-surface.localdomain>
 <aXz9nssiRC1DUFSU@skinsburskii.localdomain>
 <aX0TCpXFxI8zVlQ1@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aX0TCpXFxI8zVlQ1@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8646-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii.localdomain:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 1593CCF98F
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 08:22:34PM +0000, Anirudh Rayabharam wrote:
> On Fri, Jan 30, 2026 at 10:51:10AM -0800, Stanislav Kinsburskii wrote:
> > On Fri, Jan 30, 2026 at 06:43:09PM +0000, Anirudh Rayabharam wrote:
> > > On Fri, Jan 30, 2026 at 10:37:38AM -0800, Stanislav Kinsburskii wrote:
> > > > On Fri, Jan 30, 2026 at 05:30:25PM +0000, Anirudh Rayabharam wrote:
> > > > > On Thu, Jan 29, 2026 at 11:09:46AM -0800, Stanislav Kinsburskii wrote:
> > > > > > On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> > > > > > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, January 21, 2026 2:36 PM
> > > > > > > > 
> > > > > > > > From: Andreea Pintilie <anpintil@microsoft.com>
> > > > > > > > 
> > > > > > > > Query the hypervisor for integrated scheduler support and use it if
> > > > > > > > configured.
> > > > > > > > 
> > > > > > > > Microsoft Hypervisor originally provided two schedulers: root and core. The
> > > > > > > > root scheduler allows the root partition to schedule guest vCPUs across
> > > > > > > > physical cores, supporting both time slicing and CPU affinity (e.g., via
> > > > > > > > cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> > > > > > > > scheduling entirely to the hypervisor.
> > > > > > > > 
> > > > > > > > Direct virtualization introduces a new privileged guest partition type - L1
> > > > > > > > Virtual Host (L1VH) — which can create child partitions from its own
> > > > > > > > resources. These child partitions are effectively siblings, scheduled by
> > > > > > > > the hypervisor's core scheduler. This prevents the L1VH parent from setting
> > > > > > > > affinity or time slicing for its own processes or guest VPs. While cgroups,
> > > > > > > > CFS, and cpuset controllers can still be used, their effectiveness is
> > > > > > > > unpredictable, as the core scheduler swaps vCPUs according to its own logic
> > > > > > > > (typically round-robin across all allocated physical CPUs). As a result,
> > > > > > > > the system may appear to "steal" time from the L1VH and its children.
> > > > > > > > 
> > > > > > > > To address this, Microsoft Hypervisor introduces the integrated scheduler.
> > > > > > >   This the s allows an L1VH partition to schedule its own vCPUs and those of its
> > > > > > > > guests across its "physical" cores, effectively emulating root scheduler
> > > > > > > > behavior within the L1VH, while retaining core scheduler behavior for the
> > > > > > > > rest of the system.
> > > > > > > > 
> > > > > > > > The integrated scheduler is controlled by the root partition and gated by
> > > > > > > > the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> > > > > > > > supports the integrated scheduler. The L1VH partition must then check if it
> > > > > > > > is enabled by querying the corresponding extended partition property. If
> > > > > > > > this property is true, the L1VH partition must use the root scheduler
> > > > > > > > logic; otherwise, it must use the core scheduler.
> > > > > > > > 
> > > > > > > > Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> > > > > > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > > > > > ---
> > > > > > > >  drivers/hv/mshv_root_main.c |   79 +++++++++++++++++++++++++++++--------------
> > > > > > > >  include/hyperv/hvhdk_mini.h |    6 +++
> > > > > > > >  2 files changed, 58 insertions(+), 27 deletions(-)
> > > > > > > > 
> > > > 
> > > >  <snip>
> > > > 
> > > > > > > > -root_sched_deinit:
> > > > > > > > -	root_scheduler_deinit();
> > > > > > > > -	return err;
> > > > > > > >  }
> > > > > > > > 
> > > > > > > > -static void mshv_init_vmm_caps(struct device *dev)
> > > > > > > > +static int mshv_init_vmm_caps(struct device *dev)
> > > > > > > >  {
> > > > > > > > -	/*
> > > > > > > > -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> > > > > > > > -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
> > > > > > > > -	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
> > > > > > > > -	 */
> > > > > > > > -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > > > > > -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > > > > > -					      0, &mshv_root.vmm_caps,
> > > > > > > > -					      sizeof(mshv_root.vmm_caps)))
> > > > > > > > -		dev_warn(dev, "Unable to get VMM capabilities\n");
> > > > > > > > +	int ret;
> > > > > > > > +
> > > > > > > > +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > > > > > +					 	HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > > > > > +						0, &mshv_root.vmm_caps,
> > > > > > > > +						sizeof(mshv_root.vmm_caps));
> > > > > > > > +	if (ret) {
> > > > > > > > +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> > > > > > > > +		return ret;
> > > > > > > > +	}
> > > > > > > 
> > > > > > > This is a functional change that isn't mentioned in the commit message.
> > > > > > > Why is it now appropriate to fail instead of treating the VMM capabilities
> > > > > > > as all disabled? Presumably there are older versions of the hypervisor that
> > > > > > > don't support the requirements described in the original comment, but
> > > > > > > perhaps they are no longer relevant?
> > > > > > > 
> > > > > > 
> > > > > > To fail is now the only option for the L1VH partition. It must discover
> > > > > > the scheduler type. Without this information, the partition cannot
> > > > > > operate. The core scheduler logic will not work with an integrated
> > > > > > scheduler, and vice versa.
> > > > > 
> > > > > I don't think we need to fail here. If we don't find vmm caps, that
> > > > > means we are on an older hypervisor that supports l1vh but not
> > > > > integrated scheduler (yes, such a version exists). In this case since
> > > > > integrated scheduler is not supported by the hypervisor, the core
> > > > > scheduler logic will work.
> > > > > 
> > > > 
> > > > The older hypervisor version won't have the integrated scheduler
> > > > capabity bit.
> > > > And we can't operate in core schedule mode if the integrated is enabled
> > > > underneath us.
> > > 
> > > The older hypervisor won't have the integrated scheduler capability bit.
> > > This means that the older hypervisor doesn't support integrated
> > > scheduler (this is how vmm caps work: if the bit doesn't exist or
> > > vmm caps themselves don't exist the feature should be assumed as not
> > > available). If the hypervisor doesn't support integrated scheduler in the
> > > first place, it can't be enabled underneath us. So, it is safe to
> > > operate in core scheduler mode.
> > > 
> > 
> > We can’t tell whether the hypervisor is older and simply doesn’t have
> > the VMM caps bit, or whether we just failed to fetch the VMM caps.
> 
> If we failed to fetch the VMM caps i.e. the hypervisor doesn't support
> the vmm caps property, we must assume that all the bits in vmm caps are
> 0 (i.e. no features are available). This is how vmm capabilities are
> supposed to be interpreted. This is something I checked with the
> hypervisor team some time back.
> 
> > 
> > In other words, we can’t distinguish between “an older hypervisor
> > without integrated scheduler support” and “a newer hypervisor with an
> > integrated scheduler, but we failed to fetch the VMM caps”.
> > 
> > But for completeness: are you saying there is an older hypervisor
> > version that supports L1VH, but does not support VMM caps?
> 
> I don't know how much of the Azure fleet still runs it but yes such a
> hypervisor version exists.
> 

We don't need to support interim hypervisor versions in the upstream
kernel: these version will go away, and then this logic will become not
only a dead code path but also incorrect.

We can keep the existing logic that treats failure to fetch VMM as
notrmal internally until required.

Thanks,
Stanislav

> Thanks,
> Anirudh
> 
> > 
> > Thanks, Stanislav
> > 
> > > Thanks,
> > > Anirudh.

