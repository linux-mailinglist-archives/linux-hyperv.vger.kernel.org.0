Return-Path: <linux-hyperv+bounces-8705-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEbmJLzygmmWfQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8705-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:18:20 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33425E2990
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 08:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69F0C300D768
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 07:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAAF38B7DB;
	Wed,  4 Feb 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKZXNole"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19529389DEA;
	Wed,  4 Feb 2026 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770189498; cv=none; b=IKVCdmGNfjrc0cyxuBI9S+25RqJck0N8+3gC94v99r+NX/DHp34fepOB+7BtkdrEt7JWxRwxYZZKTpf7J0bEWS1aGlY/2iy3V+rYaOyJgCaDePzH+4z3HlISt1IAte7efhlRqCb8eCB0NoJbJXmM2mv5ALukNR2okSqxVTFDH9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770189498; c=relaxed/simple;
	bh=UQ4YJzLExF0d8Eh0cHPHgItrgKm5eGZVj5OyMIvAnPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzHwKxPes3csfIEaTJtznhzBxX3PY00DF+hE9kbIndMSrqsyhdma0etQiMza7HGr1c0DOPHOEJvGdmIapG6U7//tyc/XmluoT6DG7xQn37ArvmdQArzykBd503GLtYQXHjEb7LlSwlYbuKQvJdgFwWAHWufY0VACy7xMN+5vNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKZXNole; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EAE1C4CEF7;
	Wed,  4 Feb 2026 07:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770189497;
	bh=UQ4YJzLExF0d8Eh0cHPHgItrgKm5eGZVj5OyMIvAnPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FKZXNoleGQhkrUVLdvSl4j4AU7EeoqCLbm491iAsrPtgzHxgNe5GhI6MZLRAYQi+b
	 0O5zS5Za6LJEli1ipl/khFdOaR7chOgewZ+mWX1TcU3GeT6hXtSxtQnsSJJ091MZey
	 mr4ZjY20h3shHs4L4+LEOU0695l+6N3NYar2c9qs9m1L3bHCyaW0UDDppk/8wZ3YPE
	 9QzNqvuTOrtvSPxAcNJTEj3FcP39qhDPPKfRpQMzrXRIXQisjFU9qv/d8lHw0jXFuu
	 pyqnZfhWj8Vi19snCHN9EzAX/+Xu5Al143qpXuAvPvSJK132Zl2V1ohbb8VmNVQ5Zt
	 j+Dujcz1trLsg==
Date: Wed, 4 Feb 2026 07:18:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mshv: Add support for integrated scheduler
Message-ID: <20260204071816.GN79272@liuwe-devbox-debian-v2.local>
References: <177006034399.132128.8748943595417271449.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <177006034399.132128.8748943595417271449.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8705-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 33425E2990
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 07:26:06PM +0000, Stanislav Kinsburskii wrote:
> Query the hypervisor for integrated scheduler support and use it if
> configured.
> 
> Microsoft Hypervisor originally provided two schedulers: root and core. The

Microsoft Hypervisor provides three schedulers: root, classic
(with or without SMT) and core. The latter two are hypervisor based.

> root scheduler allows the root partition to schedule guest vCPUs across
> physical cores, supporting both time slicing and CPU affinity (e.g., via
> cgroups). In contrast, the core scheduler delegates vCPU-to-physical-core
> scheduling entirely to the hypervisor.
> 
> Direct virtualization introduces a new privileged guest partition type - L1

Level-1 Virtualization Host.

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
[...]
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -87,6 +87,9 @@ enum hv_partition_property_code {
>  	HV_PARTITION_PROPERTY_PRIVILEGE_FLAGS			= 0x00010000,
>  	HV_PARTITION_PROPERTY_SYNTHETIC_PROC_FEATURES		= 0x00010001,
>  
> +	/* Integrated scheduling properties */
> +	HV_PARTITION_PROPERTY_INTEGRATED_SCHEDULER_ENABLED	= 0x00020005,

The internal name is "HvPartitionPropertyHierarchicalIntegratedSchedulerEnabled".

You missed the "Hierarchical" part in the property code name.

Wei

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
> 

