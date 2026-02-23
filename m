Return-Path: <linux-hyperv+bounces-8948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH0zGppVnGkAEQQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8948-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 14:26:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 882CD176D1F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 14:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E232303540C
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Feb 2026 13:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC8E3A1D2;
	Mon, 23 Feb 2026 13:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="mCqQaHjF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D1719E968;
	Mon, 23 Feb 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853069; cv=pass; b=TMT3OFEBQkzxMs2rLEI+hjNVJw37pRRWaVMtXnakyanPhqKupvUNtJ/M3rfMTbu8RvKE1zcEyYbQ03jX9/N07WGhb9k6s21YsDuOyofgmpli6DPMmzCnii4iPQlC3W3Esz0JCXXKmrISLDMMrn9QvK0fvv0IDidJ1USEni3dllU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853069; c=relaxed/simple;
	bh=esZINqTyB2VwriPwo1LnCOSiTyrdj3PcCQ28DVxt9HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPBp/YdVp7NPoyzc+XzkmCG0rfzlbfer8mvMQIRPQ4hVbrGHG0eETOcQC6pFNN+h8Uq/HKUOFhoGGL1AZzUaojtqNp3Yd7PfFrFHAUyOzav2ql0vAJ9le2UqZHtOg6Yx6z2bbuOzvk98hJmr/citb1/wRxAzzKzCZT4JfP7miqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=mCqQaHjF; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1771853061; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Nu/6MjBirPcUwSOFSEQyMAUoM1igHjuORQtJW1fDJ+zy4cdHPZ6+tR2+X3h5HYYMF8Znf+fD/lWeX/i3vyZ69QN1xPzrVxBmyVzRCCPpis1cNpIencuM60z7j7VJ90d/RmYK5X5hGXdsJPVNDEZR85YItlW0rAIq0w3yk7JtC8Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771853061; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ByyiEgWdwUlP7EeNAlCEAi0moDSm6poi227momZI43w=; 
	b=iEw2TXCrHa2tbtSozspiThX24zm6AiRK8oMVAiU5T52HdeQ383FwRZTmf4FdwCUse4EuuIJwa/GreuUgEjMGwiBVyYcBdHChnZi5RztPW/awwqTtZ8CNJKr90FV/AZFX53wEYSnVe1dkiTu8PcbX9ck56bcLPVvaYgmOE9+dHJA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771853061;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ByyiEgWdwUlP7EeNAlCEAi0moDSm6poi227momZI43w=;
	b=mCqQaHjFpp1m7M7eC2u/qAat+CdUag+r0mu4Y5p1lNCvuLQnDd2ioVo8ie9Zz4zq
	Md+aZYmDru8u1/kBBYHYf3DYh94atoNXBFk0oU7oZ4y4hWcaXFh1UHP/Yvc4BK7lhAT
	S2qZcWGIkiOQ1dVHPre2wOe9lJaYUWaB00vt/5Ww=
Received: by mx.zohomail.com with SMTPS id 1771853058699519.5229812750937;
	Mon, 23 Feb 2026 05:24:18 -0800 (PST)
Date: Mon, 23 Feb 2026 13:24:14 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] mshv: refactor synic init and cleanup
Message-ID: <aZxU_k84fmrWoRsH@anirudh-surface.localdomain>
References: <20260211170728.3056226-1-anirudh@anirudhrb.com>
 <20260211170728.3056226-2-anirudh@anirudhrb.com>
 <SN6PR02MB415781511D0B2A10FB9BB365D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415781511D0B2A10FB9BB365D46AA@SN6PR02MB4157.namprd02.prod.outlook.com>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8948-lists,linux-hyperv=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: 882CD176D1F
X-Rspamd-Action: no action

On Wed, Feb 18, 2026 at 04:17:23AM +0000, Michael Kelley wrote:
> From: Anirudh Rayabharam <anirudh@anirudhrb.com> Sent: Wednesday, February 11, 2026 9:07 AM
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
> 
> s/it's/its/
> 
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
> > index f8b0337cdc82..074e37c48876 100644
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
> > +	if (!hv_root_partition())
> > +		return 0;
> 
> I'm curious as to why the synic is cleaned up only for the root partition,
> but not for L1VH parents. L1VH parents *do* cleanup their synic in
> mshv_parent_partition_exit(). I probably don't understand all the
> vagaries of L1VH parents ....

I will check this. This cleanup matters mainly for kexec. I will do some
tests to see if L1VH needs it too.

If required, I will fix it in a separate patch. For this series I would
prefer to keep the "No function changes" claim intact.

Thanks,
Anirudh.

> 
> > +
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
> > +	ret = register_reboot_notifier(&mshv_synic_reboot_nb);
> > +	if (ret)
> > +		goto remove_cpuhp_state;
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
> > +	unregister_reboot_notifier(&mshv_synic_reboot_nb);
> > +	cpuhp_remove_state(synic_cpuhp_online);
> > +	free_percpu(synic_pages);
> > +}
> > --
> > 2.34.1
> > 
> 

