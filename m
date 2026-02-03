Return-Path: <linux-hyperv+bounces-8679-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJJjNfkogmnFPwMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8679-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 17:57:29 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB0CDC610
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 17:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF4163003612
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 16:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAAE3D3307;
	Tue,  3 Feb 2026 16:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OeMRAtqi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591D13B8D5F;
	Tue,  3 Feb 2026 16:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770137840; cv=none; b=V8vAIN4qGg6ZEcAcs3ESKrmFSsYVQymeF9kHFx+AaGk/p/zUwsaIp/pGWkNzImqwusugRBXlubpNMP4HpxaIua1uZ5hmKMkB5lzYTodaThWvSBOEKDQcJ/MUXPLT43tDm5eahhIGCLv7hgZBdE2wH3HkeuSddhzdL0Fi5G2ylmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770137840; c=relaxed/simple;
	bh=3b0mPC1jXP9tOGS75AP9JJML+rfEUpfqOxH2wTmfCi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fw39GyWI9+2WjrOZPUg8+DVlhKzV+0Vzhax0s80HZIQp1gmOUPbgNp91BCH3wKS1acd+jmApTqUYqwGlnLJFrYWL8ZzGp4jYlFyGI5Z5LIR4UnhfgRIhpi0qJRHZ7ZVrix/MaiqVA/Z3laYdiO231wi5h9cppP2gAt9N6L9/Fes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OeMRAtqi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9AB9320B7167;
	Tue,  3 Feb 2026 08:57:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9AB9320B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770137838;
	bh=uq8++yykVSnBs+/6OF/f+tUkZQEnubrIZB4H88ZbAmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeMRAtqiFOeQW7ebOgWw0VIV9Q34xVsrxBhE69YFHoEhcNJuLUatrDLm5jBzrsYz6
	 SPonQbK1XpQp/vy1ARN7casVTgtuGe4ErAc45wgviT5ryi9Ila6fFsvnyQIkvu2oAR
	 o8yBHyQKEWT8u2Tq+3HWlXHfbZ6SfMDhdh2hOKZE=
Date: Tue, 3 Feb 2026 08:57:16 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mshv: refactor synic init and cleanup
Message-ID: <aYIo7Ft25Wy5L4pc@skinsburskii.localdomain>
References: <20260202182706.648192-1-anirudh@anirudhrb.com>
 <20260202182706.648192-2-anirudh@anirudhrb.com>
 <aYD15RxUIoGDJCv5@skinsburskii.localdomain>
 <bja6gpc4y5jhbujljlcv4lcje3zius776o3v6n7gxj6bfj2bfl@a6dwxx424xcb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bja6gpc4y5jhbujljlcv4lcje3zius776o3v6n7gxj6bfj2bfl@a6dwxx424xcb>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-8679-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7CB0CDC610
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:19:10AM +0530, Anirudh Rayabharam wrote:
> On Mon, Feb 02, 2026 at 11:07:17AM -0800, Stanislav Kinsburskii wrote:
> > On Mon, Feb 02, 2026 at 06:27:05PM +0000, Anirudh Rayabharam wrote:
> > > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > > 
> > > Rename mshv_synic_init() to mshv_synic_cpu_init() and
> > > mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
> > > these functions handle per-cpu synic setup and teardown.
> > > 
> > > Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu.
> > > Move all the synic related setup from mshv_parent_partition_init.
> > > 
> > > Move the reboot notifier to mshv_synic.c because it currently only
> > > operates on the synic cpuhp state.
> > > 
> > > Move out synic_pages from the global mshv_root since it's use is now
> > > completely local to mshv_synic.c.
> > > 
> > > This is in preparation for the next patch which will add more stuff to
> > > mshv_synic_init().
> > > 
> > > No functional change.
> > > 
> > > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

<snip>

> > > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > > index f8b0337cdc82..98c58755846d 100644
> > > --- a/drivers/hv/mshv_synic.c
> > > +++ b/drivers/hv/mshv_synic.c
> > > @@ -12,11 +12,16 @@
> > >  #include <linux/mm.h>
> > >  #include <linux/io.h>
> > >  #include <linux/random.h>
> > > +#include <linux/cpuhotplug.h>
> > > +#include <linux/reboot.h>
> > >  #include <asm/mshyperv.h>
> > >  
> > >  #include "mshv_eventfd.h"
> > >  #include "mshv.h"
> > >  
> > > +static int synic_cpuhp_online;
> > > +static struct hv_synic_pages __percpu *synic_pages;
> > > +
> > >  static u32 synic_event_ring_get_queued_port(u32 sint_index)
> > >  {
> > >  	struct hv_synic_event_ring_page **event_ring_page;
> > > @@ -26,7 +31,7 @@ static u32 synic_event_ring_get_queued_port(u32 sint_index)
> > >  	u32 message;
> > >  	u8 tail;
> > >  
> > > -	spages = this_cpu_ptr(mshv_root.synic_pages);
> > > +	spages = this_cpu_ptr(synic_pages);
> > >  	event_ring_page = &spages->synic_event_ring_page;
> > >  	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
> > >  
> > > @@ -393,7 +398,7 @@ mshv_intercept_isr(struct hv_message *msg)
> > >  
> > >  void mshv_isr(void)
> > >  {
> > > -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > > +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> > >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > >  	struct hv_message *msg;
> > >  	bool handled;
> > > @@ -446,7 +451,7 @@ void mshv_isr(void)
> > >  	}
> > >  }
> > >  
> > > -int mshv_synic_init(unsigned int cpu)
> > > +static int mshv_synic_cpu_init(unsigned int cpu)
> > >  {
> > >  	union hv_synic_simp simp;
> > >  	union hv_synic_siefp siefp;
> > > @@ -455,7 +460,7 @@ int mshv_synic_init(unsigned int cpu)
> > >  	union hv_synic_sint sint;
> > >  #endif
> > >  	union hv_synic_scontrol sctrl;
> > > -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > > +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> > >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > >  	struct hv_synic_event_flags_page **event_flags_page =
> > >  			&spages->synic_event_flags_page;
> > > @@ -542,14 +547,14 @@ int mshv_synic_init(unsigned int cpu)
> > >  	return -EFAULT;
> > >  }
> > >  
> > > -int mshv_synic_cleanup(unsigned int cpu)
> > > +static int mshv_synic_cpu_exit(unsigned int cpu)
> > >  {
> > >  	union hv_synic_sint sint;
> > >  	union hv_synic_simp simp;
> > >  	union hv_synic_siefp siefp;
> > >  	union hv_synic_sirbp sirbp;
> > >  	union hv_synic_scontrol sctrl;
> > > -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > > +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> > >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> > >  	struct hv_synic_event_flags_page **event_flags_page =
> > >  		&spages->synic_event_flags_page;
> > > @@ -663,3 +668,57 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
> > >  
> > >  	mshv_portid_free(doorbell_portid);
> > >  }
> > > +
> > > +static int mshv_synic_reboot_notify(struct notifier_block *nb,
> > > +			      unsigned long code, void *unused)
> > > +{
> > > +	cpuhp_remove_state(synic_cpuhp_online);
> > > +	return 0;
> > > +}
> > > +
> > > +static struct notifier_block mshv_synic_reboot_nb = {
> > > +	.notifier_call = mshv_synic_reboot_notify,
> > > +};
> > > +
> > > +int __init mshv_synic_init(struct device *dev)
> > > +{
> > > +	int ret = 0;
> > > +
> > > +	synic_pages = alloc_percpu(struct hv_synic_pages);
> > > +	if (!synic_pages) {
> > > +		dev_err(dev, "Failed to allocate percpu synic page\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > > +				mshv_synic_cpu_init,
> > > +				mshv_synic_cpu_exit);
> > > +	if (ret < 0) {
> > > +		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> > > +		goto free_synic_pages;
> > > +	}
> > > +
> > > +	synic_cpuhp_online = ret;
> > > +
> > > +	if (hv_root_partition()) {
> > 
> > Nit: it's probably better to branch in the notifier itself.
> > It will introduce an additional object, but the branching will be in one
> > palce instead of two and it will also make to code simpler and easier to
> > read.
> 
> Maybe I introduce mshv_synic_root_partition_init/exit() which will have
> branching inside? Similar to what we did in mshv_root_main.c. That will
> avoid introducing the additional object. But I guess the branch will
> still be in both init and exit functions...
> 

This is a matter of taste, but from my POV, in general, less code is
better. The reboot notifier (or device shutdown) hook is not a hot path.
Also, we will need to do work there for L1VH eventually anyway. So
keeping the distinction in the callback makes more sense to me.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > 
> > Thanks
> > Stanislav.
> > 
> > > +		ret = register_reboot_notifier(&mshv_synic_reboot_nb);
> > > +		if (ret)
> > > +			goto remove_cpuhp_state;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +remove_cpuhp_state:
> > > +	cpuhp_remove_state(synic_cpuhp_online);
> > > +free_synic_pages:
> > > +	free_percpu(synic_pages);
> > > +	return ret;
> > > +}
> > > +
> > > +void mshv_synic_cleanup(void)
> > > +{
> > > +	if (hv_root_partition())
> > > +		unregister_reboot_notifier(&mshv_synic_reboot_nb);
> > > +	cpuhp_remove_state(synic_cpuhp_online);
> > > +	free_percpu(synic_pages);
> > > +}
> > > -- 
> > > 2.34.1
> > > 

