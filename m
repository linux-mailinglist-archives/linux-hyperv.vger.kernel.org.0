Return-Path: <linux-hyperv+bounces-8610-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFy3FNjufGndPQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8610-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:48:08 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BADBD6E5
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 18:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AC4A3002301
	for <lists+linux-hyperv@lfdr.de>; Fri, 30 Jan 2026 17:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD52DCC13;
	Fri, 30 Jan 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="eQqT1p8x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545C127A92E;
	Fri, 30 Jan 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769795284; cv=pass; b=erhNQ53F8DOe7bAnCW8AuILa5hVI+KmeSI0Y0/EeqTUqrLNjr1mCB07xYmJIN0meca55zfMbPNWTOVYPT7FCIOrMR1ahDZG12YSqMa+tOZXxoAi3iSVTDwsyhWicSwxCsJuSY/eXIfF1dS2Rme99yAY7Znd78OICQoDZlzpxVOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769795284; c=relaxed/simple;
	bh=QTQ7XFA5XRG8tcwtt6tiJIextTYg8TGEP8f8+qZ9PhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bz4E9c4v5XeYNmdjo0uxl689cU5tfpA16hZ6pp2qoQaSO0nwRAYtrusphzoQKCY6g2xNU2HMM42WAwkttK2nwReujMwjhMj+kkgCQkoMSuSV82eywyBaYbQsGQ7g9h5px5PwYUiffN+uiWaHTmIn8b3yPSOW0pog8Yf7JJ2URR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=eQqT1p8x; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1769795275; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dZuXjRfCTCMqIVJYpXQRIymOOyxhNAoyYWUgJRySzJKitDxdUpFYG8LcDHz2Zm0aW2K5axGybQxRSGq4xGWVE4nzRF34wo0FxEuKfNgCIgG4KncWSUdDlpdNaZBzoVo2wjL3u5jyKGhtqtfc8XqxkwuZlXS5CIdhJ9Fgt3LCfVI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769795275; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lxQcQLTUjK6ww2BTR1trNdzW2oCrPSzlR1CA+fgRuxM=; 
	b=gFUAGV8KEwIb6Y/hPgo4gRBMsuY0fy566l0jxlmc0kOBraQ68X5/Th2jMk3MKCKj26PMUo5xC3bdpZUzwUicf17jEnZWCAfR53Nrn/8w+srpNJIxcdTWMa6eONEWWWruC4NIbebYfduJDsJ7xAWsFKaM6+ZIUqlh7zaZwvcDKJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769795275;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=lxQcQLTUjK6ww2BTR1trNdzW2oCrPSzlR1CA+fgRuxM=;
	b=eQqT1p8xgvnNGBqZiIKTp+MPEiZi6ndkKKQnExtWzKvcQak1zXvlgtngjPK5UNJR
	5EcY6GG8WEoCyNrrOvdnvQ7cL9DnaG76SPf+9jE0n+VwEsiP6w80zB1pJthgG/x4GD0
	umracGhUXDgti4JnARQnci6yQXsTlTsqp01WEymg=
Received: by mx.zohomail.com with SMTPS id 176979527402215.41466216751644;
	Fri, 30 Jan 2026 09:47:54 -0800 (PST)
Date: Fri, 30 Jan 2026 17:47:48 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mshv: Add support for integrated scheduler
Message-ID: <aXzuxHwLofHaW-Xe@anirudh-surface.localdomain>
References: <176978905128.18763.15996443783319253336.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176978905128.18763.15996443783319253336.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8610-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: D8BADBD6E5
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:04:14PM +0000, Stanislav Kinsburskii wrote:
> Query the hypervisor for integrated scheduler support and use it if
> configured.
> 
> Microsoft Hypervisor originally provided two schedulers: root and core. The
> root scheduler allows the root partition to schedule guest vCPUs across
> physical cores, supporting both time slicing and CPU affinity (e.g., via
> cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> scheduling entirely to the hypervisor.
> 
> Direct virtualization introduces a new privileged guest partition type - L1
> Virtual Host (L1VH) — which can create child partitions from its own
> resources. These child partitions are effectively siblings, scheduled by
> the hypervisor's core scheduler. This prevents the L1VH parent from setting
> affinity or time slicing for its own processes or guest VPs. While cgroups,
> CFS, and cpuset controllers can still be used, their effectiveness is
> unpredictable, as the core scheduler swaps vCPUs according to its own logic
> (typically round-robin across all allocated physical CPUs). As a result,
> the system may appear to "steal" time from the L1VH and its children.
> 
> To address this, Microsoft Hypervisor introduces the integrated scheduler.
> This allows an L1VH partition to schedule its own vCPUs and those of its

How could an L1VH partition schedule its own vCPUs?

> guests across its "physical" cores, effectively emulating root scheduler
> behavior within the L1VH, while retaining core scheduler behavior for the
> rest of the system.
> 
> The integrated scheduler is controlled by the root partition and gated by
> the vmm_enable_integrated_scheduler capability bit. If set, the hypervisor
> supports the integrated scheduler. The L1VH partition must then check if it
> is enabled by querying the corresponding extended partition property. If
> this property is true, the L1VH partition must use the root scheduler
> logic; otherwise, it must use the core scheduler. This requirement makes
> reading VMM capabilities in L1VH partition a requirement too.
> 
> Signed-off-by: Andreea Pintilie <anpintil@microsoft.com>
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |   85 +++++++++++++++++++++++++++----------------
>  include/hyperv/hvhdk_mini.h |    7 +++-
>  2 files changed, 59 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 1134a82c7881..6a6bf641b352 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2053,6 +2053,32 @@ static const char *scheduler_type_to_string(enum hv_scheduler_type type)
>  	};
>  }
>  
> +static int __init l1vh_retrive_scheduler_type(enum hv_scheduler_type *out)

typo: retrieve*

> +{
> +	u64 integrated_sched_enabled;
> +	int ret;
> +
> +	*out = HV_SCHEDULER_TYPE_CORE_SMT;
> +
> +	if (!mshv_root.vmm_caps.vmm_enable_integrated_scheduler)
> +		return 0;
> +
> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> +						HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED,
> +						0, &integrated_sched_enabled,
> +						sizeof(integrated_sched_enabled));
> +	if (ret)
> +		return ret;
> +
> +	if (integrated_sched_enabled)
> +		*out = HV_SCHEDULER_TYPE_ROOT;
> +
> +	pr_debug("%s: integrated scheduler property read: ret=%d value=%llu\n",
> +		 __func__, ret, integrated_sched_enabled);

ret is always 0 here, right? We don't need to bother printing then.

> +
> +	return 0;
> +}
> +
>  /* TODO move this to hv_common.c when needed outside */
>  static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
>  {
> @@ -2085,13 +2111,12 @@ static int __init hv_retrieve_scheduler_type(enum hv_scheduler_type *out)
>  /* Retrieve and stash the supported scheduler type */
>  static int __init mshv_retrieve_scheduler_type(struct device *dev)
>  {
> -	int ret = 0;
> +	int ret;
>  
>  	if (hv_l1vh_partition())
> -		hv_scheduler_type = HV_SCHEDULER_TYPE_CORE_SMT;
> +		ret = l1vh_retrive_scheduler_type(&hv_scheduler_type);
>  	else
>  		ret = hv_retrieve_scheduler_type(&hv_scheduler_type);
> -
>  	if (ret)
>  		return ret;
>  
> @@ -2211,42 +2236,29 @@ struct notifier_block mshv_reboot_nb = {
>  static void mshv_root_partition_exit(void)
>  {
>  	unregister_reboot_notifier(&mshv_reboot_nb);
> -	root_scheduler_deinit();
>  }
>  
>  static int __init mshv_root_partition_init(struct device *dev)
>  {
> -	int err;
> -
> -	err = root_scheduler_init(dev);
> -	if (err)
> -		return err;
> -
> -	err = register_reboot_notifier(&mshv_reboot_nb);
> -	if (err)
> -		goto root_sched_deinit;
> -
> -	return 0;
> -
> -root_sched_deinit:
> -	root_scheduler_deinit();
> -	return err;
> +	return register_reboot_notifier(&mshv_reboot_nb);
>  }
>  
> -static void mshv_init_vmm_caps(struct device *dev)
> +static int __init mshv_init_vmm_caps(struct device *dev)
>  {
> -	/*
> -	 * This can only fail here if HVCALL_GET_PARTITION_PROPERTY_EX or
> -	 * HV_PARTITION_PROPERTY_VMM_CAPABILITIES are not supported. In that
> -	 * case it's valid to proceed as if all vmm_caps are disabled (zero).
> -	 */
> -	if (hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> -					      HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> -					      0, &mshv_root.vmm_caps,
> -					      sizeof(mshv_root.vmm_caps)))
> -		dev_warn(dev, "Unable to get VMM capabilities\n");
> +	int ret;
> +
> +	ret = hv_call_get_partition_property_ex(HV_PARTITION_ID_SELF,
> +						HV_PARTITION_PROPERTY_VMM_CAPABILITIES,
> +						0, &mshv_root.vmm_caps,
> +						sizeof(mshv_root.vmm_caps));
> +	if (ret && hv_l1vh_partition()) {
> +		dev_err(dev, "Failed to get VMM capabilities: %d\n", ret);
> +		return ret;

I don't think we need to fail here. If there are not VMM caps available,
that means integrated scheduler is not supported by the hypervisor, so
fall back to core scheduler.

Thanks,
Anirudh

> +	}
>  
>  	dev_dbg(dev, "vmm_caps = %#llx\n", mshv_root.vmm_caps.as_uint64[0]);
> +
> +	return 0;
>  }
>  
>  static int __init mshv_parent_partition_init(void)
> @@ -2292,6 +2304,10 @@ static int __init mshv_parent_partition_init(void)
>  
>  	mshv_cpuhp_online = ret;
>  
> +	ret = mshv_init_vmm_caps(dev);
> +	if (ret)
> +		goto remove_cpu_state;
> +
>  	ret = mshv_retrieve_scheduler_type(dev);
>  	if (ret)
>  		goto remove_cpu_state;
> @@ -2301,11 +2317,13 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto remove_cpu_state;
>  
> -	mshv_init_vmm_caps(dev);
> +	ret = root_scheduler_init(dev);
> +	if (ret)
> +		goto exit_partition;
>  
>  	ret = mshv_irqfd_wq_init();
>  	if (ret)
> -		goto exit_partition;
> +		goto deinit_root_scheduler;
>  
>  	spin_lock_init(&mshv_root.pt_ht_lock);
>  	hash_init(mshv_root.pt_htable);
> @@ -2314,6 +2332,8 @@ static int __init mshv_parent_partition_init(void)
>  
>  	return 0;
>  
> +deinit_root_scheduler:
> +	root_scheduler_deinit();
>  exit_partition:
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
> @@ -2332,6 +2352,7 @@ static void __exit mshv_parent_partition_exit(void)
>  	mshv_port_table_fini();
>  	misc_deregister(&mshv_dev);
>  	mshv_irqfd_wq_cleanup();
> +	root_scheduler_deinit();
>  	if (hv_root_partition())
>  		mshv_root_partition_exit();
>  	cpuhp_remove_state(mshv_cpuhp_online);
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 41a29bf8ec14..c0300910808b 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -87,6 +87,9 @@ enum hv_partition_property_code {
>  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
>  	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		= 0x00010001,
>  
> +	/* Integrated scheduling properties */
> +	HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED	= 0x00020005,
> +
>  	/* Resource properties */
>  	HV_PARTITION_PROPERTY_GPA_PAGE_ACCESS_TRACKING		= 0x00050005,
>  	HV_PARTITION_PROPERTY_UNIMPLEMENTED_MSR_ACTION		= 0x00050017,
> @@ -102,7 +105,7 @@ enum hv_partition_property_code {
>  };
>  
>  #define HV_PARTITION_VMM_CAPABILITIES_BANK_COUNT		1
> -#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	59
> +#define HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT	57
>  
>  struct hv_partition_property_vmm_capabilities {
>  	u16 bank_count;
> @@ -119,6 +122,8 @@ struct hv_partition_property_vmm_capabilities {
>  			u64 reservedbit3: 1;
>  #endif
>  			u64 assignable_synthetic_proc_features: 1;
> +			u64 reservedbit5: 1;
> +			u64 vmm_enable_integrated_scheduler : 1;
>  			u64 reserved0: HV_PARTITION_VMM_CAPABILITIES_RESERVED_BITFIELD_COUNT;
>  		} __packed;
>  	};
> 
> 

