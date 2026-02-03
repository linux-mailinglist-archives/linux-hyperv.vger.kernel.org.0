Return-Path: <linux-hyperv+bounces-8670-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFCmJ2R+gWnlGgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8670-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 05:49:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEF9D47C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 05:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05E0430099B5
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 04:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6D91E834B;
	Tue,  3 Feb 2026 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="dsz4Em8R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627E51C6FF5;
	Tue,  3 Feb 2026 04:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770094177; cv=pass; b=LOuFrIsPp0o79fZaEjMCRqi4LRKkZZ+fgiTmlq8bYCKJ8pN5IbobW79Z8Cazj3x1TyCLMiz+L+a6SxDnS91qXZAtIufSYWijpblCZm2Xl5Zkx9PlIKLtTu/G0KghREoo2trYxZNkXv8do6ibxne1EMuh8M0qCfkdJ/C7DiJykY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770094177; c=relaxed/simple;
	bh=Vwdbo43FiEeUKY8zUO2YmZfGX+mppawkT2AbvrtY9Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjFLdI9qHCTeGTfsEovR+5iJGeGwSxLihGOqVMVUtH3+iNasQ1WsriwAUQ6GZ/shwOI7EV7oHHXOYxtPhv5fG51C/+KUN4ibtT50D5cqyxotMp6FrOUFZslfZFCClkytzsV81+Wf23Zv4KuD9bkFHQRbqivTux/vNUdaNtp1xvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=dsz4Em8R; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770094164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=h0/cTw32cP9aHf31GaWKbZjot2x14xpwIGpQgCyOUi6kyQIxNoN1suET1Q1+SGBiPrbvzEyFIP5vnmZ4Yu8faAewcWd1V1YaN2jkBjgBLVS8eWAiMhUBby7nhwvDLexpvBQ7CUgimLHK3AcOhF0fHMzwgJYZtnK8L5Md9JK3I/I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770094164; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=A/Vxe+WwWsXIu+vtX7f8yE9lL+CeFGsd09LCEGUjLZw=; 
	b=JBG1W2X6+n0Oi8Lu1UjDgrUKcpuVzfmRL+PJspjGw6uMEFDa+A+K0Mn054N1dPOVKNcrLmxJi9OMM72VjOoCnJEXgaIQGTz6hvqLHiM6KlB+bYChBeSrdyQcxo91kPRr3ESLz3fWALw1v4RdQLe5Hz3zTIPnlS/IUOWQUyIkt9k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770094164;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=A/Vxe+WwWsXIu+vtX7f8yE9lL+CeFGsd09LCEGUjLZw=;
	b=dsz4Em8RaTUwwJ3VgtlfbeGWaRSwIzqpmAefnij9lHkJ5sW/shEBmaQoOJyDxg/W
	golaZoy/d7yGau6F4YHuBa8JCWY91hVNG1wKMqn5XIrzzEaYX1G/N9hKPyH0vLTZKj9
	UdJSpl/1j7iXrmb017NjFPOUfDypgZ3sEfRIwhqU=
Received: by mx.zohomail.com with SMTPS id 1770094162561131.35042226868018;
	Mon, 2 Feb 2026 20:49:22 -0800 (PST)
Date: Tue, 3 Feb 2026 10:19:10 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mshv: refactor synic init and cleanup
Message-ID: <bja6gpc4y5jhbujljlcv4lcje3zius776o3v6n7gxj6bfj2bfl@a6dwxx424xcb>
References: <20260202182706.648192-1-anirudh@anirudhrb.com>
 <20260202182706.648192-2-anirudh@anirudhrb.com>
 <aYD15RxUIoGDJCv5@skinsburskii.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYD15RxUIoGDJCv5@skinsburskii.localdomain>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8670-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CEF9D47C3
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:07:17AM -0800, Stanislav Kinsburskii wrote:
> On Mon, Feb 02, 2026 at 06:27:05PM +0000, Anirudh Rayabharam wrote:
> > From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > 
> > Rename mshv_synic_init() to mshv_synic_cpu_init() and
> > mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
> > these functions handle per-cpu synic setup and teardown.
> > 
> > Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu.
> > Move all the synic related setup from mshv_parent_partition_init.
> > 
> > Move the reboot notifier to mshv_synic.c because it currently only
> > operates on the synic cpuhp state.
> > 
> > Move out synic_pages from the global mshv_root since it's use is now
> > completely local to mshv_synic.c.
> > 
> > This is in preparation for the next patch which will add more stuff to
> > mshv_synic_init().
> > 
> > No functional change.
> > 
> > Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> > ---
> >  drivers/hv/mshv_root.h      |  5 ++-
> >  drivers/hv/mshv_root_main.c | 59 +++++-------------------------
> >  drivers/hv/mshv_synic.c     | 71 +++++++++++++++++++++++++++++++++----
> >  3 files changed, 75 insertions(+), 60 deletions(-)
> > 
> > diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> > index 3c1d88b36741..26e0320c8097 100644
> > --- a/drivers/hv/mshv_root.h
> > +++ b/drivers/hv/mshv_root.h
> > @@ -183,7 +183,6 @@ struct hv_synic_pages {
> >  };
> >  
> >  struct mshv_root {
> > -	struct hv_synic_pages __percpu *synic_pages;
> >  	spinlock_t pt_ht_lock;
> >  	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
> >  	struct hv_partition_property_vmm_capabilities vmm_caps;
> > @@ -242,8 +241,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
> >  void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
> >  
> >  void mshv_isr(void);
> > -int mshv_synic_init(unsigned int cpu);
> > -int mshv_synic_cleanup(unsigned int cpu);
> > +int mshv_synic_init(struct device *dev);
> > +void mshv_synic_cleanup(void);
> >  
> >  static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
> >  {
> > diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> > index 681b58154d5e..7c1666456e78 100644
> > --- a/drivers/hv/mshv_root_main.c
> > +++ b/drivers/hv/mshv_root_main.c
> > @@ -2035,7 +2035,6 @@ mshv_dev_release(struct inode *inode, struct file *filp)
> >  	return 0;
> >  }
> >  
> > -static int mshv_cpuhp_online;
> >  static int mshv_root_sched_online;
> >  
> >  static const char *scheduler_type_to_string(enum hv_scheduler_type type)
> > @@ -2198,40 +2197,14 @@ root_scheduler_deinit(void)
> >  	free_percpu(root_scheduler_output);
> >  }
> >  
> > -static int mshv_reboot_notify(struct notifier_block *nb,
> > -			      unsigned long code, void *unused)
> > -{
> > -	cpuhp_remove_state(mshv_cpuhp_online);
> > -	return 0;
> > -}
> > -
> 
> Unrelated to the change, but it would be great to get rid of this
> notifier altogether and just do the cleanup in the device shutdown hook.
> This is a cleaner approach as this is a device driver and we do have the
> device in hands.
> Do you think you could make this change a part of this series?

That needs to more investigation. The notifier is there because it is
called during kexec. Whether device shutdown hook also works is
something I need to check. I will prefer it to be a separate patch.

Makes it easy to reason that this patch indeed has "No functional
changes".

> 
> > -struct notifier_block mshv_reboot_nb = {
> > -	.notifier_call = mshv_reboot_notify,
> > -};
> > -
> >  static void mshv_root_partition_exit(void)
> >  {
> > -	unregister_reboot_notifier(&mshv_reboot_nb);
> >  	root_scheduler_deinit();
> >  }
> >  
> >  static int __init mshv_root_partition_init(struct device *dev)
> >  {
> > -	int err;
> > -
> > -	err = root_scheduler_init(dev);
> > -	if (err)
> > -		return err;
> > -
> > -	err = register_reboot_notifier(&mshv_reboot_nb);
> > -	if (err)
> > -		goto root_sched_deinit;
> > -
> > -	return 0;
> > -
> > -root_sched_deinit:
> > -	root_scheduler_deinit();
> > -	return err;
> > +	return root_scheduler_init(dev);
> >  }
> >  
> 
> This conflicts with the "mshv: Add support for integrated scheduler"
> patch out there.
> Perhaps we should ask Wei to merge that change first.

Sure, I'm okay with that ordering.

> 
> >  static void mshv_init_vmm_caps(struct device *dev)
> > @@ -2276,31 +2249,18 @@ static int __init mshv_parent_partition_init(void)
> >  			MSHV_HV_MAX_VERSION);
> >  	}
> >  
> > -	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
> > -	if (!mshv_root.synic_pages) {
> > -		dev_err(dev, "Failed to allocate percpu synic page\n");
> > -		ret = -ENOMEM;
> > +	ret = mshv_synic_init(dev);
> > +	if (ret)
> >  		goto device_deregister;
> > -	}
> > -
> > -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > -				mshv_synic_init,
> > -				mshv_synic_cleanup);
> > -	if (ret < 0) {
> > -		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> > -		goto free_synic_pages;
> > -	}
> > -
> > -	mshv_cpuhp_online = ret;
> >  
> >  	ret = mshv_retrieve_scheduler_type(dev);
> >  	if (ret)
> > -		goto remove_cpu_state;
> > +		goto synic_cleanup;
> >  
> >  	if (hv_root_partition())
> >  		ret = mshv_root_partition_init(dev);
> >  	if (ret)
> > -		goto remove_cpu_state;
> > +		goto synic_cleanup;
> >  
> >  	mshv_init_vmm_caps(dev);
> >  
> > @@ -2318,10 +2278,8 @@ static int __init mshv_parent_partition_init(void)
> >  exit_partition:
> >  	if (hv_root_partition())
> >  		mshv_root_partition_exit();
> > -remove_cpu_state:
> > -	cpuhp_remove_state(mshv_cpuhp_online);
> > -free_synic_pages:
> > -	free_percpu(mshv_root.synic_pages);
> > +synic_cleanup:
> > +	mshv_synic_cleanup();
> >  device_deregister:
> >  	misc_deregister(&mshv_dev);
> >  	return ret;
> > @@ -2335,8 +2293,7 @@ static void __exit mshv_parent_partition_exit(void)
> >  	mshv_irqfd_wq_cleanup();
> >  	if (hv_root_partition())
> >  		mshv_root_partition_exit();
> > -	cpuhp_remove_state(mshv_cpuhp_online);
> > -	free_percpu(mshv_root.synic_pages);
> > +	mshv_synic_cleanup();
> >  }
> >  
> >  module_init(mshv_parent_partition_init);
> > diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> > index f8b0337cdc82..98c58755846d 100644
> > --- a/drivers/hv/mshv_synic.c
> > +++ b/drivers/hv/mshv_synic.c
> > @@ -12,11 +12,16 @@
> >  #include <linux/mm.h>
> >  #include <linux/io.h>
> >  #include <linux/random.h>
> > +#include <linux/cpuhotplug.h>
> > +#include <linux/reboot.h>
> >  #include <asm/mshyperv.h>
> >  
> >  #include "mshv_eventfd.h"
> >  #include "mshv.h"
> >  
> > +static int synic_cpuhp_online;
> > +static struct hv_synic_pages __percpu *synic_pages;
> > +
> >  static u32 synic_event_ring_get_queued_port(u32 sint_index)
> >  {
> >  	struct hv_synic_event_ring_page **event_ring_page;
> > @@ -26,7 +31,7 @@ static u32 synic_event_ring_get_queued_port(u32 sint_index)
> >  	u32 message;
> >  	u8 tail;
> >  
> > -	spages = this_cpu_ptr(mshv_root.synic_pages);
> > +	spages = this_cpu_ptr(synic_pages);
> >  	event_ring_page = &spages->synic_event_ring_page;
> >  	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
> >  
> > @@ -393,7 +398,7 @@ mshv_intercept_isr(struct hv_message *msg)
> >  
> >  void mshv_isr(void)
> >  {
> > -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> >  	struct hv_message *msg;
> >  	bool handled;
> > @@ -446,7 +451,7 @@ void mshv_isr(void)
> >  	}
> >  }
> >  
> > -int mshv_synic_init(unsigned int cpu)
> > +static int mshv_synic_cpu_init(unsigned int cpu)
> >  {
> >  	union hv_synic_simp simp;
> >  	union hv_synic_siefp siefp;
> > @@ -455,7 +460,7 @@ int mshv_synic_init(unsigned int cpu)
> >  	union hv_synic_sint sint;
> >  #endif
> >  	union hv_synic_scontrol sctrl;
> > -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> >  	struct hv_synic_event_flags_page **event_flags_page =
> >  			&spages->synic_event_flags_page;
> > @@ -542,14 +547,14 @@ int mshv_synic_init(unsigned int cpu)
> >  	return -EFAULT;
> >  }
> >  
> > -int mshv_synic_cleanup(unsigned int cpu)
> > +static int mshv_synic_cpu_exit(unsigned int cpu)
> >  {
> >  	union hv_synic_sint sint;
> >  	union hv_synic_simp simp;
> >  	union hv_synic_siefp siefp;
> >  	union hv_synic_sirbp sirbp;
> >  	union hv_synic_scontrol sctrl;
> > -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> > +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
> >  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
> >  	struct hv_synic_event_flags_page **event_flags_page =
> >  		&spages->synic_event_flags_page;
> > @@ -663,3 +668,57 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
> >  
> >  	mshv_portid_free(doorbell_portid);
> >  }
> > +
> > +static int mshv_synic_reboot_notify(struct notifier_block *nb,
> > +			      unsigned long code, void *unused)
> > +{
> > +	cpuhp_remove_state(synic_cpuhp_online);
> > +	return 0;
> > +}
> > +
> > +static struct notifier_block mshv_synic_reboot_nb = {
> > +	.notifier_call = mshv_synic_reboot_notify,
> > +};
> > +
> > +int __init mshv_synic_init(struct device *dev)
> > +{
> > +	int ret = 0;
> > +
> > +	synic_pages = alloc_percpu(struct hv_synic_pages);
> > +	if (!synic_pages) {
> > +		dev_err(dev, "Failed to allocate percpu synic page\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> > +				mshv_synic_cpu_init,
> > +				mshv_synic_cpu_exit);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> > +		goto free_synic_pages;
> > +	}
> > +
> > +	synic_cpuhp_online = ret;
> > +
> > +	if (hv_root_partition()) {
> 
> Nit: it's probably better to branch in the notifier itself.
> It will introduce an additional object, but the branching will be in one
> palce instead of two and it will also make to code simpler and easier to
> read.

Maybe I introduce mshv_synic_root_partition_init/exit() which will have
branching inside? Similar to what we did in mshv_root_main.c. That will
avoid introducing the additional object. But I guess the branch will
still be in both init and exit functions...

Thanks,
Anirudh.

> 
> Thanks
> Stanislav.
> 
> > +		ret = register_reboot_notifier(&mshv_synic_reboot_nb);
> > +		if (ret)
> > +			goto remove_cpuhp_state;
> > +	}
> > +
> > +	return 0;
> > +
> > +remove_cpuhp_state:
> > +	cpuhp_remove_state(synic_cpuhp_online);
> > +free_synic_pages:
> > +	free_percpu(synic_pages);
> > +	return ret;
> > +}
> > +
> > +void mshv_synic_cleanup(void)
> > +{
> > +	if (hv_root_partition())
> > +		unregister_reboot_notifier(&mshv_synic_reboot_nb);
> > +	cpuhp_remove_state(synic_cpuhp_online);
> > +	free_percpu(synic_pages);
> > +}
> > -- 
> > 2.34.1
> > 

