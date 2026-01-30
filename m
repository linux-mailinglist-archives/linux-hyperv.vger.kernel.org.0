Return-Path: <linux-hyperv+bounces-8612-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHqHBr76fGmGPgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8612-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 19:38:54 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D6FBBDE65
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 19:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D08C3001CD9
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30FB3803C0;
	Fri, 30 Jan 2026 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GEVa7766"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F03D311C0C;
	Fri, 30 Jan 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769798267; cv=none; b=DywbOg+vZdHc9o2S1DjXUD3dQdXsUJBu3RvtSMMCl6n5Lmmum5j8DU98cN+PDc7PNzlM/RFAVyylsslG3laP1rvGPdFdOg+cGQSfnL54ppjhFpZDm6JU/KfUm7z6fqDyNJZyMG4shj1IQZvzKIoScAYUE/BEMgnhTelcqJTyi3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769798267; c=relaxed/simple;
	bh=/26/bmZwpy3cZn91uTMmUACitXMFnKi6Qy0Vi/UCQs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0lKGmCsr5anaLpqZW1zQcaaXHXj7bdHGZRKROYRQRMJpGVJu4MxNLScSR/n46qFmNkZ4PewslxOpD9JlKYRTrWcr3ov4dsnvuUewrh5v3Wb3uxh/3f6B3nK+H+qEWnArVdZQmDOmQUWoxAZKrlG8PbykawacjkaV0dwz1t98x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GEVa7766; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19A2A20B7167;
	Fri, 30 Jan 2026 10:37:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19A2A20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769798260;
	bh=KLszhNfz33Fzd7atTOLyLnFPH3wR5Rom5Dm38xrYazU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEVa7766/oHvx61vpw424YLdTyabX8z27p5HE7OwmOhPH5OXVU5/6DeG1xAtEZBh9
	 Vkvdk9xlKTUgmXEwScH3S12vTKxdF51ue6Bb3S9tW4CZQGPhHjmY2mFeGcVWmmw7Mc
	 RL81pVbT4VahKYCtD5ayIzlkkDBKU/U6B86KrD2w=
Date: Fri, 30 Jan 2026 10:37:38 -0800
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
Message-ID: <aXz6cu8BG1vwiCeb@skinsburskii.localdomain>
References: <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
 <aXzqsfT8-h-g9mex@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXzqsfT8-h-g9mex@anirudh-surface.localdomain>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8612-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,skinsburskii.localdomain:mid]
X-Rspamd-Queue-Id: 6D6FBBDE65
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 05:30:25PM +0000, Anirudh Rayabharam wrote:
> On Thu, Jan 29, 2026 at 11:09:46AM -0800, Stanislav Kinsburskii wrote:
> > On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> > > From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, January 21, 2026 2:36 PM
> > > > 
> > > > From: Andreea Pintilie <anpintil@microsoft.com>
> > > > 
> > > > Query the hypervisor for integrated scheduler support and use it if
> > > > configured.
> > > > 
> > > > Microsoft Hypervisor originally provided two schedulers: root and core. The
> > > > root scheduler allows the root partition to schedule guest vCPUs across
> > > > physical cores, supporting both time slicing and CPU affinity (e.g., via
> > > > cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> > > > scheduling entirely to the hypervisor.
> > > > 
> > > > Direct virtualization introduces a new privileged guest partition type - L1
> > > > Virtual Host (L1VH) — which can create child partitions from its own
> > > > resources. These child partitions are effectively siblings, scheduled by
> > > > the hypervisor's core scheduler. This prevents the L1VH parent from setting
> > > > affinity or time slicing for its own processes or guest VPs. While cgroups,
> > > > CFS, and cpuset controllers can still be used, their effectiveness is
> > > > unpredictable, as the core scheduler swaps vCPUs according to its own logic
> > > > (typically round-robin across all allocated physical CPUs). As a result,
> > > > the system may appear to "steal" time from the L1VH and its children.
> > > > 
> > > > To address this, Microsoft Hypervisor introduces the integrated scheduler.
> > >   This the s allows an L1VH partition to schedule its own vCPUs and those of its
> > > > guests across its "physical" cores, effectively emulating root scheduler
> > > > behavior within the L1VH, while retaining core scheduler behavior for the
> > > > rest of the system.
> > > > 
> > > > The integrated scheduler is controlled by the root partition and gated by
> > > > the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> > > > supports the integrated scheduler. The L1VH partition must then check if it
> > > > is enabled by querying the corresponding extended partition property. If
> > > > this property is true, the L1VH partition must use the root scheduler
> > > > logic; otherwise, it must use the core scheduler.
> > > > 
> > > > Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> > > > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > > > ---
> > > >  drivers/hv/mshv_root_main.c |   79 +++++++++++++++++++++++++++++--------------
> > > >  include/hyperv/hvhdk_mini.h |    6 +++
> > > >  2 files changed, 58 insertions(+), 27 deletions(-)
> > > > 

 <snip>

> > > > -root_sched_deinit:
> > > > -	root_scheduler_deinit();
> > > > -	return err;
> > > >  }
> > > > 
> > > > -static void mshv_init_vmm_caps(struct device *dev)
> > > > +static int mshv_init_vmm_caps(struct device *dev)
> > > >  {
> > > > -	/*
> > > > -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> > > > -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
> > > > -	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
> > > > -	 */
> > > > -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > -					      0, &mshv_root.vmm_caps,
> > > > -					      sizeof(mshv_root.vmm_caps)))
> > > > -		dev_warn(dev, "Unable to get VMM capabilities\n");
> > > > +	int ret;
> > > > +
> > > > +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > > > +					 	HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > > > +						0, &mshv_root.vmm_caps,
> > > > +						sizeof(mshv_root.vmm_caps));
> > > > +	if (ret) {
> > > > +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> > > > +		return ret;
> > > > +	}
> > > 
> > > This is a functional change that isn't mentioned in the commit message.
> > > Why is it now appropriate to fail instead of treating the VMM capabilities
> > > as all disabled? Presumably there are older versions of the hypervisor that
> > > don't support the requirements described in the original comment, but
> > > perhaps they are no longer relevant?
> > > 
> > 
> > To fail is now the only option for the L1VH partition. It must discover
> > the scheduler type. Without this information, the partition cannot
> > operate. The core scheduler logic will not work with an integrated
> > scheduler, and vice versa.
> 
> I don't think we need to fail here. If we don't find vmm caps, that
> means we are on an older hypervisor that supports l1vh but not
> integrated scheduler (yes, such a version exists). In this case since
> integrated scheduler is not supported by the hypervisor, the core
> scheduler logic will work.
> 

The older hypervisor version won't have the integrated scheduler
capabity bit.
And we can't operate in core schedule mode if the integrated is enabled
underneath us.

Thanks,
Stanislav


> Thanks,
> Anirudh.
> 
> > 
> > And yes, older hypervisor versions do not support L1VH.
> > 
> > Thanks,
> > Stanislav
> > 
> > > > 
> > > >  	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
> > > > +
> > > > +	return 0;
> > > >  }
> > > > 
> > > >  static int __init mshv_parent_partition_init(void)
> > > > @@ -2292,6 +2310,10 @@ static int __init mshv_parent_partition_init(void)
> > > > 
> > > >  	mshv_cpuhp_online = ret;
> > > > 
> > > > +	ret = mshv_init_vmm_caps(dev);
> > > > +	if (ret)
> > > > +		goto remove_cpu_state;
> > > > +
> > > >  	ret = mshv_retrieve_scheduler_type(dev);
> > > >  	if (ret)
> > > >  		goto remove_cpu_state;
> > > > @@ -2301,11 +2323,13 @@ static int __init mshv_parent_partition_init(void)
> > > >  	if (ret)
> > > >  		goto remove_cpu_state;
> > > > 
> > > > -	mshv_init_vmm_caps(dev);
> > > > +	ret = root_scheduler_init(dev);
> > > > +	if (ret)
> > > > +		goto exit_partition;
> > > > 
> > > >  	ret = mshv_irqfd_wq_init();
> > > >  	if (ret)
> > > > -		goto exit_partition;
> > > > +		goto deinit_root_scheduler;
> > > > 
> > > >  	spin_lock_init(&mshv_root.pt_ht_lock);
> > > >  	hash_init(mshv_root.pt_htable);
> > > > @@ -2314,6 +2338,8 @@ static int __init mshv_parent_partition_init(void)
> > > > 
> > > >  	return 0;
> > > > 
> > > > +deinit_root_scheduler:
> > > > +	root_scheduler_deinit();
> > > >  exit_partition:
> > > >  	if (hv_root_partition())
> > > >  		mshv_root_partition_exit();
> > > > @@ -2332,6 +2358,7 @@ static void __exit mshv_parent_partition_exit(void)
> > > >  	mshv_port_table_fini();
> > > >  	misc_deregister(&mshv_dev);
> > > >  	mshv_irqfd_wq_cleanup();
> > > > +	root_scheduler_deinit();
> > > >  	if (hv_root_partition())
> > > >  		mshv_root_partition_exit();
> > > >  	cpuhp_remove_state(mshv_cpuhp_online);
> > > > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > > > index aa03616f965b..0f7178fa88a8 100644
> > > > --- a/include/hyperv/hvhdk_mini.h
> > > > +++ b/include/hyperv/hvhdk_mini.h
> > > > @@ -87,6 +87,9 @@ enum hv_partition_property_code {
> > > >  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
> > > >  	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		= 0x00010001,
> > > > 
> > > > +	/* Integrated scheduling properties */
> > > > +	HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED	= 0x00020005,
> > > > +
> > > >  	/* Resource properties */
> > > >  	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING		= 0x00050005,
> > > >  	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION		= 0x00050017,
> > > > @@ -102,7 +105,7 @@ enum hv_partition_property_code {
> > > >  };
> > > > 
> > > >  #define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
> > > > -#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	58
> > > > +#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	57
> > > > 
> > > >  struct hv_partition_property_vmm_capabilities {
> > > >  	u16 bank_count;
> > > > @@ -120,6 +123,7 @@ struct hv_partition_property_vmm_capabilities {
> > > >  #endif
> > > >  			u64 assignable_synthetic_proc_features: 1;
> > > >  			u64 tag_hv_message_from_child: 1;
> > > > +			u64 vmm_enable_integrated_scheduler : 1;
> > > >  			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
> > > >  		} __packed;
> > > >  	};
> > > > 
> > > > 
> > > 

