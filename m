Return-Path: <linux-hyperv+bounces-8899-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA4SH0HylWlTWwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8899-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 18:09:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCCA1581DD
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 18:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F181230028C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 17:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC103451D7;
	Wed, 18 Feb 2026 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="edHrek/O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7F1343D7B
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434555; cv=none; b=LOUQsp9bKn43/otAwfWgx0RPN26GQTCjSsSNvZHhvlKZF4wzItd/LtHjVlfxTDEhe9O+AF7LOTghVx9i4OopU0tayowxcLJfx+8t9Vwr7YxDN/GKIwUvHpzathSfwaZRMYUXROLezzMAAHlD3fSWiIosdwr2Rwbrb8HDqDMeFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434555; c=relaxed/simple;
	bh=LNR2LLpuM3r+wgmsfwmSTe4BM8HAKjYjULq43lIRlk0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DtNc32Jz6Lk0OdOH9l5oonpUBEf9oHjImD83tfSud+SIuSJ+qgtTpiPZMhDyPN5XR3DSige7KlPhb8A7oXdB3YT7r1Qkvl1zZBEYBSJkG/yEwnraW5G1plm63QOrLTr/S8L4P7wx0iKDUKJQFmZgTam3sbQhfGGkyCII2BToMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=edHrek/O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id C662D20B6F00;
	Wed, 18 Feb 2026 09:09:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C662D20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771434553;
	bh=UeV05wY7ufVXXWj5Q0XxETha1dNdFYgHwLtRFPhcWkk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=edHrek/Oo3CjlXLY2i272LFkT9ektWJ32qPZiS/CWfnAjhmN8XQs1CRbdNmJGxj90
	 9N/DHpE+0ediIcR3Dpf7AqhtOC+SdeDB+95TQH9OZaWd79HtQnsxFWtnTAXFsN8S6W
	 GH3RDIW70vkEmZIHOT6IRwuXk/XTiZ6Z1SCc1PV4=
Message-ID: <570b5760-e657-4816-8e46-f703bc5ca6db@linux.microsoft.com>
Date: Wed, 18 Feb 2026 09:09:07 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, easwar.hariharan@linux.microsoft.com,
 wei.liu@kernel.org, muislam@microsoft.com
Subject: Re: [PATCH 1/4] mshv: Add nested virtualization creation flag
To: Anatol Belski <anbelski@linux.microsoft.com>
References: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8899-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[easwar.hariharan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 9BCCA1581DD
X-Rspamd-Action: no action

On 2/18/2026 6:47 AM, Anatol Belski wrote:
> From: Muminul Islam <muislam@microsoft.com>
> 
> Introduce HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE to
> indicate support for nested virtualization during partition creation.
> 
> This enables clearer configuration and capability checks for nested
> virtualization scenarios.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>
> ---
>  include/hyperv/hvhdk.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 08965970c17d..03afb7d0412b 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -328,6 +328,7 @@ union hv_partition_isolation_properties {
>  #define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
>  
>  /* Note: Exo partition is enabled by default */
> +#define HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE	BIT(1)
>  #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED		BIT(4)
>  #define HV_PARTITION_CREATION_FLAG_EXO_PARTITION			BIT(8)
>  #define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED			BIT(13)

Patches 1, 2, and 3 can all be squashed into 1 patch.

Thanks,
Easwar (he/him)

