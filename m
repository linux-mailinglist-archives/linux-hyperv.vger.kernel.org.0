Return-Path: <linux-hyperv+bounces-8501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMJABPYSdGkX2AAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8501-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:31:50 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 586347BAD2
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 01:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 353E63012CAA
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Jan 2026 00:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4667263B;
	Sat, 24 Jan 2026 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y6vqnb4w"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E7811CAF;
	Sat, 24 Jan 2026 00:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769214706; cv=none; b=tiaZf4YixrBElfZLEGXFrMIRzjpGEaO9riMIzm2/XmhEL4iKubJZntF9lfyG1LYdyN4MSAM8BGvnF6uxVPw2wrFZpdnEI8DX9FX8zxmmSPy7CZKulpymKtN7Z8ZihrSkccFnrrtuplg+jYb2/rgwqCRGtDTpMP9Ln7WWXx78thM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769214706; c=relaxed/simple;
	bh=bp7W1LluwPTvO993c8YXztTV176NNCh/Yqs/zYvO2Tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDAXZjM5T5QyNJHDkFx68xUxZQDKnN5+++A0AyUi83wNMNu69H5lTZ16lyuNJ8jFdENyjZkX4jzrwS9C2iFA8PmaEa3+lp94F2tgeYkarcWp9OzKOn41zPx/sIA5Q4iSS2SA1EmhcPFmYkzvsEqx+qt8dE11Dj4KQhXyP7gMvGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y6vqnb4w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.75.32.59] (unknown [40.78.12.246])
	by linux.microsoft.com (Postfix) with ESMTPSA id 48D3620B7167;
	Fri, 23 Jan 2026 16:31:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48D3620B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769214704;
	bh=FYKAGYoWAEaU2oyCkGdagiYy+0oD4ZgKAkaWOpjpW3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y6vqnb4weeOHgo/KIXLwHNWc1gvEFFggaQg3nBO7mcZTK5GeUDSWPiimn07c2i+vN
	 50rgSM/BXnmHsq0ez0tYIR9wLWKbDG+zC66b0KuuGX54TJZzEKUDtSRJ4gdV7pbGqx
	 1/G4CpTj96Etlc5F3T8dmkcNke/Bj7sKoXN80KsU=
Message-ID: <6bca523f-4133-948c-71bf-24475e7292a7@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:31:43 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/4] mshv: Introduce hv_result_oom() helper function
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176913164914.89165.5792608454600292463.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <176913211358.89165.15502151782362191256.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <176913211358.89165.15502151782362191256.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-8501-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 586347BAD2
X-Rspamd-Action: no action

On 1/22/26 17:35, Stanislav Kinsburskii wrote:
> Replace direct comparisons of hv_result(status) against
> HV_STATUS_INSUFFICIENT_MEMORY with a new hv_result_oom() helper function.
> This improves code readability and provides a consistent and extendable
> interface for checking out-of-memory conditions in hypercall results.
> 
> No functional changes intended.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>   drivers/hv/hv_proc.c           |   14 ++++++++++++--
>   drivers/hv/mshv_root_hv_call.c |   20 ++++++++++----------
>   drivers/hv/mshv_root_main.c    |    2 +-
>   include/asm-generic/mshyperv.h |    3 +++
>   4 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index fbb4eb3901bb..80c66d1c74d5 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -110,6 +110,16 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>   }
>   EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
>   
> +bool hv_result_oom(u64 status)
> +{
> +	switch (hv_result(status)) {
> +	case HV_STATUS_INSUFFICIENT_MEMORY:
> +		return true;
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(hv_result_oom);

I had mentioned this during internal review previously, so forgive me
for repeating. I don't think using _oom suffix is a good idea. Firstly,
system is not out of memory, hypervisor will continue to work perfectly,
just the particalur hypercall needs a bit more ram to succeed. Secondly
and more importantly, "oom" has come to mean a very specific event
in linux, and as such reusing it for something totally different is
unnecessary. For example, if another maintainer working on oom happens
to see this, and not being familiar with HyperV may get totally confused
and waste time unnecessarily.

It can easily be renamed: hv_result_insuff_mem, or hv_result_enomem,
or hv_result_deposit_ram etc... there are many options.

Thanks,
-Mukesh

.... deleted ...


