Return-Path: <linux-hyperv+bounces-10517-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK9lBL/X8mnIugEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10517-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:17:03 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A4349D412
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 06:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3EB7930158A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 04:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2473630B3;
	Thu, 30 Apr 2026 04:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EydXyQFm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9694B2D47E9;
	Thu, 30 Apr 2026 04:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522488; cv=none; b=a7d+M0gJ0O9ZUbqwdQmd9r/We4kdZZd17DTseo9LM7TjMJlsCTfKpd/d/KkARbTqxBUoNJOKNxtPJp7+AUEtJ9mwNnNWYZWUwB/f+Zo8iBI7We+OM4aE05q8/l7zKnM5+cR3qMD/3VvPjmGcskvZsLWdT9LE6Ddzu18qHkrhM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522488; c=relaxed/simple;
	bh=pY5Z0JU9R0/M9rcc+AfaXh+Txwf10xCNN96WW6JbLmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FD3NpTQfklMZnobkl1JkrTRZM4ppFpbFub7sfNSgnNhrTiFuXUZf2HAcBgLGVabfgCVxs1OPD3yuPY8bFNqGzic43ML7s4rvmqlz1JEGvvIrdFX7QoL50oWK3cC4NOToAS/Ac3yehTdJS/GfR9jSDKSO+GI0CzVuSt5j+zZdSS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EydXyQFm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.164.158] (unknown [167.220.238.30])
	by linux.microsoft.com (Postfix) with ESMTPSA id A113D20B716E;
	Wed, 29 Apr 2026 21:14:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A113D20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777522487;
	bh=f4lvFbqZ1bUHQGIEf1oyNYgP5GTQnnfJHXC/uoz5x10=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=EydXyQFmqdyYQxNSPrqMNvsU33oR0G6vcbvCOuR7T67MOhwkbab5O3DOhr0a4wnUr
	 iessjkR24bvGpuutDpYPwhqVnHTB5sFUKg63FiOfGHFk7NAxZtCbwvJP2YsULAQV0F
	 UEWqB29jY1PtSj9HJojS2v/5EJSUvNuLgh6YnC0o=
Message-ID: <faf63e56-144c-4261-be39-77b93f620159@linux.microsoft.com>
Date: Thu, 30 Apr 2026 09:44:36 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: mana: remove double CQ cleanup in
 mana_create_rxq error path
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stephen@networkplumber.org,
 jacob.e.keller@intel.com, dipayanroy@microsoft.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 yury.norov@gmail.com
References: <20260430035935.1859220-1-dipayanroy@linux.microsoft.com>
 <20260430035935.1859220-4-dipayanroy@linux.microsoft.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20260430035935.1859220-4-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64A4349D412
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10517-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[linux.microsoft.com,microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]

On 30-04-2026 09:27, Dipayaan Roy wrote:
> In mana_create_rxq(), the error cleanup path calls mana_destroy_rxq()
> followed by mana_deinit_cq(). This is incorrect for two reasons:
> 
> 1. mana_destroy_rxq() already calls mana_deinit_cq() internally,
>     so the CQ's GDMA queue is destroyed twice.
> 
> 2. mana_destroy_rxq() frees the rxq via kfree(rxq) before returning.
>     The subsequent mana_deinit_cq(apc, cq) then operates on freed memory
>     since cq points to &rxq->rx_cq, which is embedded in the
>     already-freed rxq structure — a use-after-free.
> 
> Remove the redundant mana_deinit_cq() call from the error path since
> mana_destroy_rxq() already handles CQ cleanup. mana_deinit_cq() is
> itself safe for an uninitialized CQ as it checks for a NULL gdma_cq
> before proceeding.
> 
> Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Signed-off-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index f2a6ea162dc3..9afc786b297a 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2799,9 +2799,6 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>   
>   	mana_destroy_rxq(apc, rxq, false);
>   
> -	if (cq)
> -		mana_deinit_cq(apc, cq);
> -
>   	return NULL;
>   }
>   

Reviewed-by: Aditya Garg <gargaditya@linux.microsoft.com>

