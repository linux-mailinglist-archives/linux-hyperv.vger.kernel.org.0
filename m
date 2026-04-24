Return-Path: <linux-hyperv+bounces-10362-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJ+DF6eE62lBNwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10362-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 16:56:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F22B246068C
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 16:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4915A300616A
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2026 14:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA44C3DDDBC;
	Fri, 24 Apr 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="EIdv0C+K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27063CF66B;
	Fri, 24 Apr 2026 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777042596; cv=pass; b=HN/XjiGGoDKefoC3BPKpwXSK22CYM9yyLFa0bL7Oq5/HunnXG0ZcOfwarKYdeKziETZQEYd8mjvtVrinzTcjNRyYCsfGlMhfKB212ccPCi63elKi2FTheM0tME50BLjNM2HYJF0yAGwgNZyCMB6kQQEToqvHgwN0ytQpdgzVtJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777042596; c=relaxed/simple;
	bh=XIboCUOqX1MwJvT44BSQ1l5Up9lRA42iFhJuzcHppPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0Mwn70Vi39U4zwK1qyykLvGpYUB1BadFcNzyv8tlScOyeu4+FMzi7e+cfFeZmGANdzSRO+YcmqjfU9/74MosSaU4w95iSwzDGTi/aM/SuJ/6v5/lC0R7c+ta4MhvbiAWX8Ea2wE+fzk1CQIahqENeAhBq7Iy2T5PSj29vmK5M4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=EIdv0C+K; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1777042558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BrFFf85hehGdw2XKPFeZwPMDURVfheQs4dC8bMyuEX7QxGvl5fCjqXy2UwSOmr6LonD1iNGZdBC3JOAbZQKLjv05LvFiBpqzWI5+5QAFkhl9j+rWxcdl33L/c49qdX21U00TdhxQt1hJ3uGPMfNFZ3MMKTcdy2BMy3SKXHSaJ88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1777042558; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=mfqSqPUoxMBVCRtDCy7Ii6TvpUSj01bGGYteC+Ygh9E=; 
	b=ADVpA/7oVFkkBtSGxszzWREq64J4eVWtyArwzLB87KAQXf57jDz96Qlby4+Dhbxv+S9xZqg1p6cXuuZLjAOelkdjTEh4r0raX8CZDHqrp3rWeN5ZpwiXiFwIAnhkzdx2ZUHPEWEJ0zXygATrbDtLn/RTahEZ9l38GPeQI3R3HZg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777042558;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=mfqSqPUoxMBVCRtDCy7Ii6TvpUSj01bGGYteC+Ygh9E=;
	b=EIdv0C+KkNTvVzxTnYNobl+h7f4xSxWTUGe3v8fCVtdPbV5MVNJRSuvzhraXGbz3
	y8+53IW+Wd5s6h8h1uhP/5JwQlO3YjFU36oQa/XCUGmdIbt40hUxOx0+utpX5/InHhA
	LQu+oM9NLO6gRXTgfLCXwsA31lwrhpYR//e38VzE=
Received: by mx.zohomail.com with SMTPS id 1777042554688308.8891839177646;
	Fri, 24 Apr 2026 07:55:54 -0700 (PDT)
Date: Fri, 24 Apr 2026 14:55:43 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
	wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
	namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, tglx@kernel.org, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de
Subject: Re: [PATCH V1 03/13] x86/hyperv: add insufficient memory support in
 irqdomain.c
Message-ID: <20260424-inquisitive-versatile-cuckoo-6bc36b@anirudhrb>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
 <20260422023239.1171963-4-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422023239.1171963-4-mrathor@linux.microsoft.com>
X-ZohoMailClient: External
X-Rspamd-Queue-Id: F22B246068C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[anirudhrb.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[anirudhrb.com:s=zoho];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10362-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FREEMAIL_CC(0.00)[zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anirudh@anirudhrb.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[anirudhrb.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[anirudhrb.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, Apr 21, 2026 at 07:32:29PM -0700, Mukesh R wrote:
> Intermittent insufficient memory hypercall failure have been observed in
> the current map device interrupt hypercall. In case of such a failure,
> we must deposit more memory and redo the hypercall. Add support for
> that. Deposit memory needs partition id, make that a parameter to the
> map interrupt function.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c | 38 +++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index b3ad50a874dc..229f986e08ea 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -13,8 +13,9 @@
>  #include <linux/irqchip/irq-msi-lib.h>
>  #include <asm/mshyperv.h>
>  
> -static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
> -		int cpu, int vector, struct hv_interrupt_entry *ret_entry)
> +static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
> +				  bool level, int cpu, int vector,
> +				  struct hv_interrupt_entry *ret_entry)
>  {
>  	struct hv_input_map_device_interrupt *input;
>  	struct hv_output_map_device_interrupt *output;
> @@ -30,8 +31,10 @@ static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
>  
>  	intr_desc = &input->interrupt_descriptor;
>  	memset(input, 0, sizeof(*input));
> -	input->partition_id = hv_current_partition_id;
> +
> +	input->partition_id = ptid;
>  	input->device_id = hv_devid.as_uint64;
> +
>  	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
>  	intr_desc->vector_count = 1;
>  	intr_desc->target.vector = vector;
> @@ -64,6 +67,28 @@ static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
>  
>  	local_irq_restore(flags);
>  
> +	return status;
> +}
> +
> +static int hv_map_interrupt(u64 ptid, union hv_device_id device_id, bool level,
> +			    int cpu, int vector,
> +			    struct hv_interrupt_entry *ret_entry)
> +{
> +	u64 status;
> +	int rc, deposit_pgs = 16;		/* don't loop forever */
> +
> +	while (deposit_pgs--) {
> +		status = hv_map_interrupt_hcall(ptid, device_id, level, cpu,
> +						vector, ret_entry);
> +
> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
> +			break;
> +
> +		rc = hv_call_deposit_pages(NUMA_NO_NODE, ptid, 1);

This code should use the hv_result_needs_memory() and hv_deposit_memory()
helpers instead.

Thanks,
Anirudh


