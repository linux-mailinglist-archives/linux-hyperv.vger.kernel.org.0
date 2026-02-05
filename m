Return-Path: <linux-hyperv+bounces-8738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ke4GY7chGkV6AMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8738-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:08:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C522EF652B
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 838CA300DA6F
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EC7306B11;
	Thu,  5 Feb 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="VPkg89oG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24E303A07;
	Thu,  5 Feb 2026 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314891; cv=pass; b=sGXxazA3/c3Qv1b3ddrxR11FktpRc8aQk6bErgqmhUS7TTg9sRB7LUbe9wi92ZhSyFTH4xwQxU0J1r9N8drBNGc9RuwDj1S7ajdXdXcrPy8ryxEQBJByv5/gWt2BOupwWW0HwPIaNrgAhTOdLx1hbV6ZibBLOzsQilln1IlVojw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314891; c=relaxed/simple;
	bh=OWegzoO8Xkk1Tn/dtNmnkWvXBIj6WuICzCz/rOdfXsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HhqjJX7P7KOi/Yxi1aU50Sog5ELwmMXO7kXzix3YXOQ7QMhncwS+9BNdNieKFh8t8l/y5WvJ4no077Jgg8CHmxwsLvM9/RBbl+dtnH1fMMS0MR0bt3g5ou+hS1Vc4cBlb0xO8NJbQw/KVLtTTZKaVUscl0v8a7L7Fa/krqSdEN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=VPkg89oG; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770314879; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Uyzv4ji217X+AfclqRZzFUPcCg4Q5nVjSJf6cQXmYfDh6PZm6dQHFZ+h6cuRxrblEQuH0QpVfAHbVOxaM0k85nRJt5g4OACeI3XZ3oqXd3antTtm3hxj8ykYsnqvrlqElGZC6JJhLvjWuTI8liIDHntGir21GvCEmMNGfjqRGtI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770314879; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EyeMWjJod5F9aKCrCk+lcFcJzxdYrOX9zdwVEezZM1M=; 
	b=GrpoR+muIHxcwojrVxeOw2tn2pmtK/sOLDpkusN7PE1IgVV3KBTJcp2kvOAZQJUQs3K3HN65B8YXgXL4bNiODWFYgpMPflxFbgZb7BLqD9aGMtAqZ3EGBl9VAqBNAXw+cQetM8WiA3k2LwyyOyYon05M/WYaBg3M+hIBTwkvKIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770314879;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=EyeMWjJod5F9aKCrCk+lcFcJzxdYrOX9zdwVEezZM1M=;
	b=VPkg89oGx6ogiyCsEC8uoEbwjJCyk/qR0e/U+E6PRTuGULcH9JyYlckUAGPOJXN/
	m2EjyMh+yO+c/p4peU5xMsJyahpjrssa1BdmudB1scxkIYslD0ieQpBM3CSYLHk1A/2
	czIVsBVt8fiu6oGyAmxtAozJYdrPOYhW4CqKoVD8=
Received: by mx.zohomail.com with SMTPS id 1770314877039341.2095739986323;
	Thu, 5 Feb 2026 10:07:57 -0800 (PST)
Date: Thu, 5 Feb 2026 23:37:49 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <s6orh5waw2djyiv5w6yzwiaxv7rcja6iua6kbzldthsmceelqv@dnf2zr2m74we>
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177005515446.120041.8169777750859263202.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177005515446.120041.8169777750859263202.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	TAGGED_FROM(0.00)[bounces-8738-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C522EF652B
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:59:14PM +0000, Stanislav Kinsburskii wrote:
> When creating guest partition objects, the hypervisor may fail to
> allocate root partition pages and return an insufficient memory status.
> In this case, deposit memory using the root partition ID instead.
> 
> Note: This error should never occur in a guest of L1VH partition context.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c      |    2 +
>  drivers/hv/hv_proc.c        |   14 ++++++++++
>  include/hyperv/hvgdk_mini.h |   58 ++++++++++++++++++++++---------------------
>  3 files changed, 46 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index c7f63c9de503..cab0d1733607 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -792,6 +792,8 @@ static const struct hv_status_info hv_status_infos[] = {
>  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
>  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
>  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_ROOT_MEMORY,	-ENOMEM),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY,	-ENOMEM),
>  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index dfa27be66ff7..935129e0b39d 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -122,6 +122,18 @@ int hv_deposit_memory_node(int node, u64 partition_id,
>  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
>  		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
>  		break;
> +
> +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
> +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +		fallthrough;
> +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:

Is num_pages uninitialized when we reach this case directly?

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
> @@ -135,6 +147,8 @@ bool hv_result_needs_memory(u64 status)
>  	switch (hv_result(status)) {
>  	case HV_STATUS_INSUFFICIENT_MEMORY:
>  	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> +	case HV_STATUS_INSUFFICIENT_ROOT_MEMORY:
> +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 70f22ef44948..5b74a857ef43 100644
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

