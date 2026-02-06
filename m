Return-Path: <linux-hyperv+bounces-8754-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GF1oJ7mChWnpCgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8754-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 06:57:13 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E473FA807
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 06:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DE0DF302C747
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 05:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B62EB84E;
	Fri,  6 Feb 2026 05:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="jpFAQisP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59292BEC2E;
	Fri,  6 Feb 2026 05:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770357424; cv=pass; b=EAHwgJ5JQXL1sSkpwcVzV4trItJEdJVDGXQcxZ4wN7iALIBpHqA9qnVTpuj7Y06o0cSFRX1fA1b1tKScG5dMnuvf0rAyKJygJE7VZaKo54wvBGZwQfZLyq9Gk3S/ySKG75qb83L2eM/29+J7HMhH0QNFhVlxuppxD2mF5quCT10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770357424; c=relaxed/simple;
	bh=RZoVJvwRFQ7kYlReuwDH6eYHIe0SQxhN3Vrk9WH4t4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVopHxtpugMN/DQbn4/J4PFL9tm0yV5Ewh3l5teM6Y8dw3kdj+hGrPyuVgj94dV+CpXJuH8fJKnwrR0ueMj4owEc2vCbi+zdzbITm/JeTpLKxpCwqaQh6fIJ5hfgGiTIdj4CUC0WciuD+7y1S0YXt1vexFMpZcsPjWWRQDYL5Ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=jpFAQisP; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770357411; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QhAqVu8edVCNNiToP5hxOU/XprEb/LOMxc4dUskKJBGskvK0BTrfb0icOMw6QOVGBxNyNB9PABMmHr/UtRRizYbmS75vPsilCvxTGBT//r3M5lRqCOdapjqOIs/HKe9AM277sSVTEJ58U+J5jhadRfi2miDaAQrgCLtJl7wIyhQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770357411; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1LBB0EUw77TdkmcsK2ar9PEuBsRmPPegsNbiKpM/NOM=; 
	b=KAVeiB/UxjLsQFBswrgPTepLm3TKflC5E4HXRq8b8dmsO8scmJ2czHsFS1ueA4fIyzXvwSbsfiRb8fFOSE8j5zXLryW+VBIelNajpu72QzOFzkE84eOgl66Zv82vP3aZ+fPv2Kp7QzkL0T+zaaiAboAhkwgAe+KkV8lFuSuwB+Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770357411;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=1LBB0EUw77TdkmcsK2ar9PEuBsRmPPegsNbiKpM/NOM=;
	b=jpFAQisPLAP6q9jmdX4g6Djch6/LFDG19Fcez/Xg7D7VGR9IoeffbPMDq9joXZxF
	odXGyWAXKr0Sfyjg7BbjFBAzrnDJoJ66xuKhuIBR0EBZ+23znLbT5nfMwENeJK86QD4
	WY2Xe1xbLGJ9a2VaLarGRoEmKcQ1D/x8Fk9+7MI0=
Received: by mx.zohomail.com with SMTPS id 1770357407457401.04551354577154;
	Thu, 5 Feb 2026 21:56:47 -0800 (PST)
Date: Fri, 6 Feb 2026 05:56:41 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <aYWCmVxnO8R3vsc-@anirudh-surface.localdomain>
References: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8754-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anirudh-surface.localdomain:mid]
X-Rspamd-Queue-Id: 2E473FA807
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 06:42:27PM +0000, Stanislav Kinsburskii wrote:
> When creating guest partition objects, the hypervisor may fail to
> allocate root partition pages and return an insufficient memory status.
> In this case, deposit memory using the root partition ID instead.
> 
> Note: This error should never occur in a guest of L1VH partition context.

I think you should rephrse this to:

"... should never occur in an L1VH partition"

because none of the errors in this patch series occur inside a guest. They
either occur in L1VH or root or both.

> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c      |    2 +
>  drivers/hv/hv_proc.c        |   14 ++++++++++
>  include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
>  3 files changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index f20596276662..6b67ac616789 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -794,6 +794,8 @@ static const struct hv_status_info hv_status_infos[] = {
>  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
>  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
>  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY,	-ENOMEM),
>  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 181f6d02bce3..5f4fd9c3231c 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -121,6 +121,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
>  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
>  		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
>  		break;
> +
> +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +		fallthrough;
> +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:

I have the same comment as on v2 about num_pages being uninitialized when we
reach this case directly.

Thanks,
Anirudh.

> +		if (!hv_root_partition()) {
> +			hv_status_err(hv_status, "Unexpected root memory deposit\n");
> +			return -ENOMEM;
> +		}
> +		partition_id = HV_PARTITION_ID_SELF;
> +		break;
> +
>  	default:
>  		hv_status_err(hv_status, "Unexpected!\n");
>  		return -ENOMEM;
> @@ -134,6 +146,8 @@ bool hv_result_needs_memory(u64 status)
>  	switch (hv_result(status)) {
>  	case HV_STATUS_INSUFFICIENT_MEMORY:
>  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 99ea0d03e657..50f5a1419052 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -14,34 +14,36 @@ struct hv_u128 {
>  } __packed;
>  
>  /* NOTE: when adding below, update hv_result_to_string() */
> -#define HV_STATUS_SUCCESS			    0x0
> -#define HV_STATUS_INVALID_HYPERCALL_CODE	    0x2
> -#define HV_STATUS_INVALID_HYPERCALL_INPUT	    0x3
> -#define HV_STATUS_INVALID_ALIGNMENT		    0x4
> -#define HV_STATUS_INVALID_PARAMETER		    0x5
> -#define HV_STATUS_ACCESS_DENIED			    0x6
> -#define HV_STATUS_INVALID_PARTITION_STATE	    0x7
> -#define HV_STATUS_OPERATION_DENIED		    0x8
> -#define HV_STATUS_UNKNOWN_PROPERTY		    0x9
> -#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE	    0xA
> -#define HV_STATUS_INSUFFICIENT_MEMORY		    0xB
> -#define HV_STATUS_INVALID_PARTITION_ID		    0xD
> -#define HV_STATUS_INVALID_VP_INDEX		    0xE
> -#define HV_STATUS_NOT_FOUND			    0x10
> -#define HV_STATUS_INVALID_PORT_ID		    0x11
> -#define HV_STATUS_INVALID_CONNECTION_ID		    0x12
> -#define HV_STATUS_INSUFFICIENT_BUFFERS		    0x13
> -#define HV_STATUS_NOT_ACKNOWLEDGED		    0x14
> -#define HV_STATUS_INVALID_VP_STATE		    0x15
> -#define HV_STATUS_NO_RESOURCES			    0x1D
> -#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED   0x20
> -#define HV_STATUS_INVALID_LP_INDEX		    0x41
> -#define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
> -#define HV_STATUS_OPERATION_FAILED		    0x71
> -#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
> -#define HV_STATUS_TIME_OUT			    0x78
> -#define HV_STATUS_CALL_PENDING			    0x79
> -#define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
> +#define HV_STATUS_SUCCESS				0x0
> +#define HV_STATUS_INVALID_HYPERCALL_CODE		0x2
> +#define HV_STATUS_INVALID_HYPERCALL_INPUT		0x3
> +#define HV_STATUS_INVALID_ALIGNMENT			0x4
> +#define HV_STATUS_INVALID_PARAMETER			0x5
> +#define HV_STATUS_ACCESS_DENIED				0x6
> +#define HV_STATUS_INVALID_PARTITION_STATE		0x7
> +#define HV_STATUS_OPERATION_DENIED			0x8
> +#define HV_STATUS_UNKNOWN_PROPERTY			0x9
> +#define HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE		0xA
> +#define HV_STATUS_INSUFFICIENT_MEMORY			0xB
> +#define HV_STATUS_INVALID_PARTITION_ID			0xD
> +#define HV_STATUS_INVALID_VP_INDEX			0xE
> +#define HV_STATUS_NOT_FOUND				0x10
> +#define HV_STATUS_INVALID_PORT_ID			0x11
> +#define HV_STATUS_INVALID_CONNECTION_ID			0x12
> +#define HV_STATUS_INSUFFICIENT_BUFFERS			0x13
> +#define HV_STATUS_NOT_ACKNOWLEDGED			0x14
> +#define HV_STATUS_INVALID_VP_STATE			0x15
> +#define HV_STATUS_NO_RESOURCES				0x1D
> +#define HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED	0x20
> +#define HV_STATUS_INVALID_LP_INDEX			0x41
> +#define HV_STATUS_INVALID_REGISTER_VALUE		0x50
> +#define HV_STATUS_OPERATION_FAILED			0x71
> +#define HV_STATUS_INSUFFICIENT_ROOT_MEMORY		0x73
> +#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY	0x75
> +#define HV_STATUS_TIME_OUT				0x78
> +#define HV_STATUS_CALL_PENDING				0x79
> +#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY	0x83
> +#define HV_STATUS_VTL_ALREADY_ENABLED			0x86
>  
>  /*
>   * The Hyper-V TimeRefCount register and the TSC
> 
> 

