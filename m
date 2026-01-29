Return-Path: <linux-hyperv+bounces-8591-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMRpMIGwe2mSHwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8591-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 20:09:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2048CB3CCC
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 20:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B89E3017396
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Jan 2026 19:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1D1314A7A;
	Thu, 29 Jan 2026 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DQtPQ1Ui"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872CC2FBE1C;
	Thu, 29 Jan 2026 19:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713789; cv=none; b=RqisIt9/Lv8DNvMWLcer59/SEstarDPTzytWLtA5duCe1Ea2hKOZ3f3B2gbs7J9OlulyBSkXjzM/QYl+m81kR2R7p4qVUJmx+dyG9FfokLFGrMjbW0aYmvp23jufbcADqTmu8Md43NFqCFmd0+E+9eGZ50WzLiyh/hmL9b+U518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713789; c=relaxed/simple;
	bh=CjOYeUzfl3XUsrk9Yw5bCTPXuv5XRSDFuMt37k2FTjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvkqems9EyYUCvgVaZelJ5rpW1wTvhsTQqetj+hn4zhXqavKA/GQqYMI58T30sSs2l30sntEqP8mY+p9MYXzcgUfkYyV8A7uhT1UDVjovruCCKKBgJcIXq0YkDIfPLrEtV8fM8TkNi1xlaUW4yW1wBlqirspOW8v/fgWM7wNom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DQtPQ1Ui; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id DB65F20B7167;
	Thu, 29 Jan 2026 11:09:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DB65F20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769713787;
	bh=HoBriGqgfbUBsuMeNp6QjMl/+QQZT6/P4b6FtEp1QA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQtPQ1UiANUcn/3gDXtPubCmAN7GN/m8PQnd9INWsvxEN/rK9sThrsgPls1JikzEF
	 jP25Jp1CCvYLtmEW3HxvCKwClhiJWNJrMXqJ5OUpIHlEGrJZiW6QQxP5XEYW/EDgNZ
	 WTI1HH6fQ9wu8g+rHq7yHfR5rLQTCV69GvIXfWhk=
Date: Thu, 29 Jan 2026 11:09:46 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mshv: Add support for integrated scheduler
Message-ID: <aXuwes2HNf4Og8lW@skinsburskii.localdomain>
References: <176903475057.166619.9437539561789960983.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176903495970.166619.12888807009225201668.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB415767BB59E00442812F47B5D49EA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8591-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,skinsburskii.localdomain:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 2048CB3CCC
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:47:02PM +0000, Michael Kelley wrote:
> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com> Sent: Wednesday, January 21, 2026 2:36 PM
> > 
> > From: Andreea Pintilie <anpintil@microsoft.com>
> > 
> > Query the hypervisor for integrated scheduler support and use it if
> > configured.
> > 
> > Microsoft Hypervisor originally provided two schedulers: root and core. The
> > root scheduler allows the root partition to schedule guest vCPUs across
> > physical cores, supporting both time slicing and CPU affinity (e.g., via
> > cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> > scheduling entirely to the hypervisor.
> > 
> > Direct virtualization introduces a new privileged guest partition type - L1
> > Virtual Host (L1VH) — which can create child partitions from its own
> > resources. These child partitions are effectively siblings, scheduled by
> > the hypervisor's core scheduler. This prevents the L1VH parent from setting
> > affinity or time slicing for its own processes or guest VPs. While cgroups,
> > CFS, and cpuset controllers can still be used, their effectiveness is
> > unpredictable, as the core scheduler swaps vCPUs according to its own logic
> > (typically round-robin across all allocated physical CPUs). As a result,
> > the system may appear to "steal" time from the L1VH and its children.
> > 
> > To address this, Microsoft Hypervisor introduces the integrated scheduler.
>   This the s allows an L1VH partition to schedule its own vCPUs and those of its
> > guests across its "physical" cores, effectively emulating root scheduler
> > behavior within the L1VH, while retaining core scheduler behavior for the
> > rest of the system.
> > 
> > The integrated scheduler is controlled by the root partition and gated by
> > the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> > supports the integrated scheduler. The L1VH partition must then check if it
> > is enabled by querying the corresponding extended partition property. If
> > this property is true, the L1VH partition must use the root scheduler
> > logic; otherwise, it must use the core scheduler.
> > 
> > Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/mshv_root_main.c |   79 +++++++++++++++++++++++++++++--------------
> >  include/hyperv/hvhdk_mini.h |    6 +++
> >  2 files changed, 58 insertions(+), 27 deletions(-)
> > 

<snip>

> >  static int __init mshv_root_partition_init(struct device *dev)
> >  {
> >  	int err;
> > 
> > -	err = root_scheduler_init(dev);
> > -	if (err)
> > -		return err;
> > -
> >  	err = register_reboot_notifier(&mshv_reboot_nb);
> >  	if (err)
> > -		goto root_sched_deinit;
> > +		return err;
> > 
> >  	return 0;
> 
> This code is now:
> 
> 	if (err)
> 		return err;
> 	return 0;
> 
> which can be simplified to just:
> 
> 	return err;
> 
> Or drop the local variable 'err' and simplify the entire function to:
> 
> 	return register_reboot_notifier(&mshv_reboot_nb);
> 
> There's a tangential question here: Why is this reboot notifier
> needed in the first place? All it does is remove the cpuhp state
> that allocates/frees the per-cpu root_scheduler_input and
> root_scheduler_output pages. Removing the state will free
> the pages, but if Linux is rebooting, why bother?
> 

This was originally done to support kexec.
Here is the original commit message:

    mshv: perform synic cleanup during kexec

    Register a reboot notifier that performs synic cleanup when a kexec
    is in progress.

    One notable issue this commit fixes is one where after a kexec, virtio
    devices are not functional. Linux root partition receives MMIO doorbell
    events in the ring buffer in the SIRB synic page. The hypervisor maintains
    a head pointer where it writes new events into the ring buffer. The root
    partition maintains a tail pointer to read events from the buffer.

    Upon kexec reboot, all root data structures are re-initialized and thus the
    tail pointer gets reset to zero. The hypervisor on the other hand still
    retains the pre-kexec head pointer which could be non-zero. This means that
    when the hypervisor writes new events to the ring buffer, the root
    partition looks at the wrong place and doesn't find any events. So, future
    doorbell events never get delivered. As a result, virtqueue kicks never get
    delivered to the host.

    When the SIRB page is disabled the hypervisor resets the head pointer.

> > -root_sched_deinit:
> > -	root_scheduler_deinit();
> > -	return err;
> >  }
> > 
> > -static void mshv_init_vmm_caps(struct device *dev)
> > +static int mshv_init_vmm_caps(struct device *dev)
> >  {
> > -	/*
> > -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> > -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
> > -	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
> > -	 */
> > -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > -					      0, &mshv_root.vmm_caps,
> > -					      sizeof(mshv_root.vmm_caps)))
> > -		dev_warn(dev, "Unable to get VMM capabilities\n");
> > +	int ret;
> > +
> > +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> > +					 	HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> > +						0, &mshv_root.vmm_caps,
> > +						sizeof(mshv_root.vmm_caps));
> > +	if (ret) {
> > +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> > +		return ret;
> > +	}
> 
> This is a functional change that isn't mentioned in the commit message.
> Why is it now appropriate to fail instead of treating the VMM capabilities
> as all disabled? Presumably there are older versions of the hypervisor that
> don't support the requirements described in the original comment, but
> perhaps they are no longer relevant?
> 

To fail is now the only option for the L1VH partition. It must discover
the scheduler type. Without this information, the partition cannot
operate. The core scheduler logic will not work with an integrated
scheduler, and vice versa.

And yes, older hypervisor versions do not support L1VH.

Thanks,
Stanislav

> > 
> >  	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
> > +
> > +	return 0;
> >  }
> > 
> >  static int __init mshv_parent_partition_init(void)
> > @@ -2292,6 +2310,10 @@ static int __init mshv_parent_partition_init(void)
> > 
> >  	mshv_cpuhp_online = ret;
> > 
> > +	ret = mshv_init_vmm_caps(dev);
> > +	if (ret)
> > +		goto remove_cpu_state;
> > +
> >  	ret = mshv_retrieve_scheduler_type(dev);
> >  	if (ret)
> >  		goto remove_cpu_state;
> > @@ -2301,11 +2323,13 @@ static int __init mshv_parent_partition_init(void)
> >  	if (ret)
> >  		goto remove_cpu_state;
> > 
> > -	mshv_init_vmm_caps(dev);
> > +	ret = root_scheduler_init(dev);
> > +	if (ret)
> > +		goto exit_partition;
> > 
> >  	ret = mshv_irqfd_wq_init();
> >  	if (ret)
> > -		goto exit_partition;
> > +		goto deinit_root_scheduler;
> > 
> >  	spin_lock_init(&mshv_root.pt_ht_lock);
> >  	hash_init(mshv_root.pt_htable);
> > @@ -2314,6 +2338,8 @@ static int __init mshv_parent_partition_init(void)
> > 
> >  	return 0;
> > 
> > +deinit_root_scheduler:
> > +	root_scheduler_deinit();
> >  exit_partition:
> >  	if (hv_root_partition())
> >  		mshv_root_partition_exit();
> > @@ -2332,6 +2358,7 @@ static void __exit mshv_parent_partition_exit(void)
> >  	mshv_port_table_fini();
> >  	misc_deregister(&mshv_dev);
> >  	mshv_irqfd_wq_cleanup();
> > +	root_scheduler_deinit();
> >  	if (hv_root_partition())
> >  		mshv_root_partition_exit();
> >  	cpuhp_remove_state(mshv_cpuhp_online);
> > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index aa03616f965b..0f7178fa88a8 100644
> > --- a/include/hyperv/hvhdk_mini.h
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -87,6 +87,9 @@ enum hv_partition_property_code {
> >  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
> >  	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		= 0x00010001,
> > 
> > +	/* Integrated scheduling properties */
> > +	HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED	= 0x00020005,
> > +
> >  	/* Resource properties */
> >  	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING		= 0x00050005,
> >  	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION		= 0x00050017,
> > @@ -102,7 +105,7 @@ enum hv_partition_property_code {
> >  };
> > 
> >  #define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
> > -#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	58
> > +#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	57
> > 
> >  struct hv_partition_property_vmm_capabilities {
> >  	u16 bank_count;
> > @@ -120,6 +123,7 @@ struct hv_partition_property_vmm_capabilities {
> >  #endif
> >  			u64 assignable_synthetic_proc_features: 1;
> >  			u64 tag_hv_message_from_child: 1;
> > +			u64 vmm_enable_integrated_scheduler : 1;
> >  			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
> >  		} __packed;
> >  	};
> > 
> > 
> 

