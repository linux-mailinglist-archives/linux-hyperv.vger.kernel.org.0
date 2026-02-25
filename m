Return-Path: <linux-hyperv+bounces-8989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 05y/KP1Hn2kuZwQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8989-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 20:05:33 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3719C868
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 20:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B140A30382B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Feb 2026 19:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB13346BE;
	Wed, 25 Feb 2026 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4Q7sGjp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C65C2BDC0B;
	Wed, 25 Feb 2026 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046331; cv=none; b=Yg1DUH+a//6pnXo+DvnGkVKmM7L3qy+V7hTwc2zPNX4XVw75dfWGniPEaYyaLt5BH8+1tb7qjuwtvT9ywjretswp5X5516WruMh4jI9JVQrcWZqNeii2eWHu34W9cQJYg0vGQfRb6u95oFKan5RyXorDgoId63Pn9T2kwE/ltHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046331; c=relaxed/simple;
	bh=yVmlHcUS2VZtlddWP99TF5Hp0wdau7FcEBGyyFJu3g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZgfXExXeWqBNzb5S2vfLb+k2qrELrYP9fsCefomIYZ9CZKoi6MbP3ptxZkTHx3xH8J9evxuHR//69vOlQVBCndEbG5z0uXFyz6dWLvgYvsR4mC7kJEK3Km48ZE9H84jr5MJzJXMKuGnPz+Ev4MN4zvLGHDRbnIhCdCSNIK+rk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4Q7sGjp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EECEC116D0;
	Wed, 25 Feb 2026 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046330;
	bh=yVmlHcUS2VZtlddWP99TF5Hp0wdau7FcEBGyyFJu3g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f4Q7sGjpW+jKOrLC6s+RVPXWzaqgsuf6zWtmsGAPdLQ66SgUcxbyzwcPbqSj8uN9I
	 7joq/+g9aNjL3Tu4rvYC3XXBvY2FR9BzXR0JqpzgdN/ULdpcrPJubRBOfU0mmpUmfA
	 GO4XuSIC+MPf3l02NB245y8b50YZOgs5sxoJFXNYBlPNtQy6lEkQMeo0nK6/X3Q3zV
	 i70mr1qsYvlYmJ3wpQ1FRbH91mqCul/LrB2QKAcSdTGBk3OxYaUbx801vTOgAaLXdl
	 ibmTCPakhXlUThkwfVafEKhammBSnqZ1oca0TPRD336dsEtRN/R/j5J1ufUj4a3GKO
	 vQUOr4fA9LpSQ==
Date: Wed, 25 Feb 2026 19:05:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v6 1/2] mshv: refactor synic init and cleanup
Message-ID: <20260225190529.GA413976@liuwe-devbox-debian-v2.local>
References: <20260225124403.2187880-1-anirudh@anirudhrb.com>
 <20260225124403.2187880-2-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225124403.2187880-2-anirudh@anirudhrb.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8989-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,vger.kernel.org,outlook.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,anirudhrb.com:email]
X-Rspamd-Queue-Id: 12B3719C868
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 12:44:02PM +0000, Anirudh Rayabharam wrote:
> From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> 
> Rename mshv_synic_init() to mshv_synic_cpu_init() and
> mshv_synic_cleanup() to mshv_synic_cpu_exit() to better reflect that
> these functions handle per-cpu synic setup and teardown.
> 
> Use mshv_synic_init/cleanup() to perform init/cleanup that is not per-cpu.
> Move all the synic related setup from mshv_parent_partition_init.
> 
> Move the reboot notifier to mshv_synic.c because it currently only
> operates on the synic cpuhp state.
> 
> Move out synic_pages from the global mshv_root since its use is now
> completely local to mshv_synic.c.
> 
> This is in preparation for the next patch which will add more stuff to
> mshv_synic_init().

There is no need to say "next patch". No need to resend. I will fix it
when I commit this patch.

Wei

> 
> No functional change.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>  drivers/hv/mshv_root.h      |  5 ++-
>  drivers/hv/mshv_root_main.c | 64 +++++----------------------------
>  drivers/hv/mshv_synic.c     | 71 +++++++++++++++++++++++++++++++++----
>  3 files changed, 75 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index 04c2a1910a8a..826798f1a8ec 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h
> @@ -190,7 +190,6 @@ struct hv_synic_pages {
>  };
>  
>  struct mshv_root {
> -	struct hv_synic_pages __percpu *synic_pages;
>  	spinlock_t pt_ht_lock;
>  	DECLARE_HASHTABLE(pt_htable, MSHV_PARTITIONS_HASH_BITS);
>  	struct hv_partition_property_vmm_capabilities vmm_caps;
> @@ -249,8 +248,8 @@ int mshv_register_doorbell(u64 partition_id, doorbell_cb_t doorbell_cb,
>  void mshv_unregister_doorbell(u64 partition_id, int doorbell_portid);
>  
>  void mshv_isr(void);
> -int mshv_synic_init(unsigned int cpu);
> -int mshv_synic_cleanup(unsigned int cpu);
> +int mshv_synic_init(struct device *dev);
> +void mshv_synic_exit(void);
>  
>  static inline bool mshv_partition_encrypted(struct mshv_partition *partition)
>  {
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index e6509c980763..7fcde33d3e75 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2064,7 +2064,6 @@ mshv_dev_release(struct inode *inode, struct file *filp)
>  	return 0;
>  }
>  
> -static int mshv_cpuhp_online;
>  static int mshv_root_sched_online;
>  
>  static const char *scheduler_type_to_string(enum hv_scheduler_type type)
> @@ -2249,27 +2248,6 @@ root_scheduler_deinit(void)
>  	free_percpu(root_scheduler_output);
>  }
>  
> -static int mshv_reboot_notify(struct notifier_block *nb,
> -			      unsigned long code, void *unused)
> -{
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -	return 0;
> -}
> -
> -struct notifier_block mshv_reboot_nb = {
> -	.notifier_call = mshv_reboot_notify,
> -};
> -
> -static void mshv_root_partition_exit(void)
> -{
> -	unregister_reboot_notifier(&mshv_reboot_nb);
> -}
> -
> -static int __init mshv_root_partition_init(struct device *dev)
> -{
> -	return register_reboot_notifier(&mshv_reboot_nb);
> -}
> -
>  static int __init mshv_init_vmm_caps(struct device *dev)
>  {
>  	int ret;
> @@ -2314,39 +2292,21 @@ static int __init mshv_parent_partition_init(void)
>  			MSHV_HV_MAX_VERSION);
>  	}
>  
> -	mshv_root.synic_pages = alloc_percpu(struct hv_synic_pages);
> -	if (!mshv_root.synic_pages) {
> -		dev_err(dev, "Failed to allocate percpu synic page\n");
> -		ret = -ENOMEM;
> +	ret = mshv_synic_init(dev);
> +	if (ret)
>  		goto device_deregister;
> -	}
> -
> -	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> -				mshv_synic_init,
> -				mshv_synic_cleanup);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> -		goto free_synic_pages;
> -	}
> -
> -	mshv_cpuhp_online = ret;
>  
>  	ret = mshv_init_vmm_caps(dev);
>  	if (ret)
> -		goto remove_cpu_state;
> +		goto synic_cleanup;
>  
>  	ret = mshv_retrieve_scheduler_type(dev);
>  	if (ret)
> -		goto remove_cpu_state;
> -
> -	if (hv_root_partition())
> -		ret = mshv_root_partition_init(dev);
> -	if (ret)
> -		goto remove_cpu_state;
> +		goto synic_cleanup;
>  
>  	ret = root_scheduler_init(dev);
>  	if (ret)
> -		goto exit_partition;
> +		goto synic_cleanup;
>  
>  	ret = mshv_debugfs_init();
>  	if (ret)
> @@ -2367,13 +2327,8 @@ static int __init mshv_parent_partition_init(void)
>  	mshv_debugfs_exit();
>  deinit_root_scheduler:
>  	root_scheduler_deinit();
> -exit_partition:
> -	if (hv_root_partition())
> -		mshv_root_partition_exit();
> -remove_cpu_state:
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -free_synic_pages:
> -	free_percpu(mshv_root.synic_pages);
> +synic_cleanup:
> +	mshv_synic_exit();
>  device_deregister:
>  	misc_deregister(&mshv_dev);
>  	return ret;
> @@ -2387,10 +2342,7 @@ static void __exit mshv_parent_partition_exit(void)
>  	misc_deregister(&mshv_dev);
>  	mshv_irqfd_wq_cleanup();
>  	root_scheduler_deinit();
> -	if (hv_root_partition())
> -		mshv_root_partition_exit();
> -	cpuhp_remove_state(mshv_cpuhp_online);
> -	free_percpu(mshv_root.synic_pages);
> +	mshv_synic_exit();
>  }
>  
>  module_init(mshv_parent_partition_init);
> diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
> index f8b0337cdc82..f716c2a4952f 100644
> --- a/drivers/hv/mshv_synic.c
> +++ b/drivers/hv/mshv_synic.c
> @@ -12,11 +12,16 @@
>  #include <linux/mm.h>
>  #include <linux/io.h>
>  #include <linux/random.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/reboot.h>
>  #include <asm/mshyperv.h>
>  
>  #include "mshv_eventfd.h"
>  #include "mshv.h"
>  
> +static int synic_cpuhp_online;
> +static struct hv_synic_pages __percpu *synic_pages;
> +
>  static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  {
>  	struct hv_synic_event_ring_page **event_ring_page;
> @@ -26,7 +31,7 @@ static u32 synic_event_ring_get_queued_port(u32 sint_index)
>  	u32 message;
>  	u8 tail;
>  
> -	spages = this_cpu_ptr(mshv_root.synic_pages);
> +	spages = this_cpu_ptr(synic_pages);
>  	event_ring_page = &spages->synic_event_ring_page;
>  	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
>  
> @@ -393,7 +398,7 @@ mshv_intercept_isr(struct hv_message *msg)
>  
>  void mshv_isr(void)
>  {
> -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_message *msg;
>  	bool handled;
> @@ -446,7 +451,7 @@ void mshv_isr(void)
>  	}
>  }
>  
> -int mshv_synic_init(unsigned int cpu)
> +static int mshv_synic_cpu_init(unsigned int cpu)
>  {
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
> @@ -455,7 +460,7 @@ int mshv_synic_init(unsigned int cpu)
>  	union hv_synic_sint sint;
>  #endif
>  	union hv_synic_scontrol sctrl;
> -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  			&spages->synic_event_flags_page;
> @@ -542,14 +547,14 @@ int mshv_synic_init(unsigned int cpu)
>  	return -EFAULT;
>  }
>  
> -int mshv_synic_cleanup(unsigned int cpu)
> +static int mshv_synic_cpu_exit(unsigned int cpu)
>  {
>  	union hv_synic_sint sint;
>  	union hv_synic_simp simp;
>  	union hv_synic_siefp siefp;
>  	union hv_synic_sirbp sirbp;
>  	union hv_synic_scontrol sctrl;
> -	struct hv_synic_pages *spages = this_cpu_ptr(mshv_root.synic_pages);
> +	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
>  	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
>  	struct hv_synic_event_flags_page **event_flags_page =
>  		&spages->synic_event_flags_page;
> @@ -663,3 +668,57 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
>  
>  	mshv_portid_free(doorbell_portid);
>  }
> +
> +static int mshv_synic_reboot_notify(struct notifier_block *nb,
> +			      unsigned long code, void *unused)
> +{
> +	if (!hv_root_partition())
> +		return 0;
> +
> +	cpuhp_remove_state(synic_cpuhp_online);
> +	return 0;
> +}
> +
> +static struct notifier_block mshv_synic_reboot_nb = {
> +	.notifier_call = mshv_synic_reboot_notify,
> +};
> +
> +int __init mshv_synic_init(struct device *dev)
> +{
> +	int ret = 0;
> +
> +	synic_pages = alloc_percpu(struct hv_synic_pages);
> +	if (!synic_pages) {
> +		dev_err(dev, "Failed to allocate percpu synic page\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mshv_synic",
> +				mshv_synic_cpu_init,
> +				mshv_synic_cpu_exit);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to setup cpu hotplug state: %i\n", ret);
> +		goto free_synic_pages;
> +	}
> +
> +	synic_cpuhp_online = ret;
> +
> +	ret = register_reboot_notifier(&mshv_synic_reboot_nb);
> +	if (ret)
> +		goto remove_cpuhp_state;
> +
> +	return 0;
> +
> +remove_cpuhp_state:
> +	cpuhp_remove_state(synic_cpuhp_online);
> +free_synic_pages:
> +	free_percpu(synic_pages);
> +	return ret;
> +}
> +
> +void mshv_synic_exit(void)
> +{
> +	unregister_reboot_notifier(&mshv_synic_reboot_nb);
> +	cpuhp_remove_state(synic_cpuhp_online);
> +	free_percpu(synic_pages);
> +}
> -- 
> 2.34.1
> 

