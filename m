Return-Path: <linux-hyperv+bounces-8737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CB9vI4nbhGkV6AMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8737-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:03:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CAF64A2
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Feb 2026 19:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D67C1300FEFA
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Feb 2026 18:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77197303CAA;
	Thu,  5 Feb 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="qZ9Tj0Xz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378742FFDFC;
	Thu,  5 Feb 2026 18:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770314609; cv=pass; b=LxORQOk5uV+r0MAfSm8LTbTX9jhk7XeGdFzNfo/klneg9+XeEVeWywZIknus4T8tR81KeV0UNbOCsSCwUeLAzojX6o9Q9iqXktQycyE4qUow15GUs8FDBoms8nvGY4rPZxBfl0BaUuU82R53p6j1vu74B10orbSxZwMUJQMLI84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770314609; c=relaxed/simple;
	bh=LRmMFLxs5TZanKE5ZDZaz05nUedcFoBWoGkgqLBzdQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiwJSH9YyXAptz6Q/4LrCUt8c7K0xKEpw13fEDxrTpwuzfYhYN/xHw6Uzyx/F6kjp235Jy9Kwi7aN9vDoALYiH5dAROrXL1/v2rhdM/hradqdrq2e+LUT2pd6K0/GLJW6yCexAAFBgwWsSuQ6h2r8H2BMPCz4Vc7C010vSL6PIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=qZ9Tj0Xz; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1770314602; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RrBa6Ku+ULdvbIAxM7mjQR/Qc2HtRjNTtIu52B1KFswFwIs0OaGZezplJxm4OF4VpyndALlrtMhbk+L1HV8pE1Sm6inGXA+SZ3tjMhegnue6iw3ssLJtg/EsTYfSlbBBU9YkZRy3bXYlRRXeSvwYzB7a7LbCkhs+EIHZVW4WTKs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770314602; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0OI9O0ttCRQ45U+J8Pyp8vk+hdfkQPiDUcibp197YVk=; 
	b=k5UVss24MHcvF45EDWtNizlUOqgSbCcHoL5QMMoxGzl5aEeoUbqyy4R5AVkkvt54seZquS7JYhX3qO5pjbn49nf0KUIGoMxzcIYdE9lCEl0vtO+lG20P4zaYoWBSng74L7UStlOtCrP/LpXLagMk5pdH0x3EbUzf3FVyF+avVmk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770314602;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=0OI9O0ttCRQ45U+J8Pyp8vk+hdfkQPiDUcibp197YVk=;
	b=qZ9Tj0XzvFCN5abF4UBAK5MYOrA21thQ/FdEHzHp1nVvmQImc2HbULnrpZCbppMc
	/R9adJLJTTVrnjPbyxnDQCu92hu+DDneNR8h6V2IwYW4vHnsMPZFMrZ3zs5Me6cLnFW
	E8wXdcul0O4MXWqZUO1s0p7pPCYJ7ENZEbCLVfmE=
Received: by mx.zohomail.com with SMTPS id 1770314599815683.4939039331401;
	Thu, 5 Feb 2026 10:03:19 -0800 (PST)
Date: Thu, 5 Feb 2026 23:33:13 +0530
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mshv: Handle insufficient contiguous memory
 hypervisor status
Message-ID: <payubtjhc2kxtkkhqudjof4srs64fo4dnwkawslinuwzbrqlcq@sqythyig5r3c>
References: <177005499596.120041.5908089206606113719.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177005514902.120041.13078117373390753930.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177005514902.120041.13078117373390753930.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[anirudhrb.com];
	TAGGED_FROM(0.00)[bounces-8737-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,anirudhrb.com:email,anirudhrb.com:dkim]
X-Rspamd-Queue-Id: D55CAF64A2
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 05:59:09PM +0000, Stanislav Kinsburskii wrote:
> The HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY status indicates that the
> hypervisor lacks sufficient contiguous memory for its internal allocations.
> 
> When this status is encountered, allocate and deposit
> HV_MAX_CONTIGUOUS_ALLOCATION_PAGES contiguous pages to the hypervisor.
> HV_MAX_CONTIGUOUS_ALLOCATION_PAGES is defined in the hypervisor headers, a
> deposit of this size will always satisfy the hypervisor's requirements.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/hv_common.c      |    1 +
>  drivers/hv/hv_proc.c        |    4 ++++
>  include/hyperv/hvgdk_mini.h |    1 +
>  include/hyperv/hvhdk_mini.h |    2 ++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 0a3ab7efed46..c7f63c9de503 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -791,6 +791,7 @@ static const struct hv_status_info hv_status_infos[] = {
>  	_STATUS_INFO(HV_STATUS_UNKNOWN_PROPERTY,		-EIO),
>  	_STATUS_INFO(HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE,	-EIO),
>  	_STATUS_INFO(HV_STATUS_INSUFFICIENT_MEMORY,		-ENOMEM),
> +	_STATUS_INFO(HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY,	-ENOMEM),
>  	_STATUS_INFO(HV_STATUS_INVALID_PARTITION_ID,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_INVALID_VP_INDEX,		-EINVAL),
>  	_STATUS_INFO(HV_STATUS_NOT_FOUND,			-EIO),
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index ffa25cd6e4e9..dfa27be66ff7 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -119,6 +119,9 @@ int hv_deposit_memory_node(int node, u64 partition_id,
>  	case HV_STATUS_INSUFFICIENT_MEMORY:
>  		num_pages = 1;
>  		break;
> +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
> +		num_pages = HV_MAX_CONTIGUOUS_ALLOCATION_PAGES;
> +		break;
>  	default:
>  		hv_status_err(hv_status, "Unexpected!\n");
>  		return -ENOMEM;
> @@ -131,6 +134,7 @@ bool hv_result_needs_memory(u64 status)
>  {
>  	switch (hv_result(status)) {
>  	case HV_STATUS_INSUFFICIENT_MEMORY:
> +	case HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY:
>  		return true;
>  	}
>  	return false;
> diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> index 04b18d0e37af..70f22ef44948 100644
> --- a/include/hyperv/hvgdk_mini.h
> +++ b/include/hyperv/hvgdk_mini.h
> @@ -38,6 +38,7 @@ struct hv_u128 {
>  #define HV_STATUS_INVALID_LP_INDEX		    0x41
>  #define HV_STATUS_INVALID_REGISTER_VALUE	    0x50
>  #define HV_STATUS_OPERATION_FAILED		    0x71
> +#define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY    0x75
>  #define HV_STATUS_TIME_OUT			    0x78
>  #define HV_STATUS_CALL_PENDING			    0x79
>  #define HV_STATUS_VTL_ALREADY_ENABLED		    0x86
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index c0300910808b..091c03e26046 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -7,6 +7,8 @@
>  
>  #include "hvgdk_mini.h"
>  
> +#define HV_MAX_CONTIGUOUS_ALLOCATION_PAGES	8
> +
>  /*
>   * Doorbell connection_info flags.
>   */
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>


