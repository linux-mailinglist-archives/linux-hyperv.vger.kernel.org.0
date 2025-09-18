Return-Path: <linux-hyperv+bounces-6951-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A3B86C77
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 21:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50BF01CC3D6A
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 19:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800B2ECD2E;
	Thu, 18 Sep 2025 19:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oZMjgVXd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8DF8248B;
	Thu, 18 Sep 2025 19:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758225214; cv=none; b=TbdPiJ4+bHZyFvouKIa0pCR/DpueyNtkYxhTrzvKCTrTDB1N4dRpq85Cli0gXHXEe6hrhL1ofVucHSfrAX77b7SS7lEqUCvR9qTHOrQ6Fr4HL/vBgK9sJ3DEThfMGu/eCersbaRyFnEb2aKAy0KiHXZI6ZxT5As1JYcsw33B+lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758225214; c=relaxed/simple;
	bh=FsTS771qmajxKIoPXQQhykAjDdwznnJrQItdBliRQdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMnTioV1vJ82vnSIybctBEiMzIKN7/IErtgP4vZrOKlUCiX+tcKEqJNjVZx/3RODbyrhPt60r9y+raWAx4wnNrE748wc7rwqNFaWjKBmraBHn9U9q7MhuD1tGUF5Ww8XlAuWnfzC/P6dGcFPDqIleaTB253w1gKJqZeQtE2M7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oZMjgVXd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [131.107.8.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 302A620143E7;
	Thu, 18 Sep 2025 12:53:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 302A620143E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758225211;
	bh=H/J/maYMK2PBMYm6r6Gh4c+PoS9AoQq/PfLu++NobMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZMjgVXdCwL35bz+2Uxb5BAPhHrd6HOkobThluexTy9B7/Th1fQ02raJGrXcEE4qC
	 GtHQrJoUMuwd+cjwZyKqN8uFZwOAeejlhm5liNEkHMKaprSH/SGXbnkVpQBP7s4BHU
	 eKw1LcN/SbNLZ+oauPLqC8NchcbhuRi4Djtg73j8=
Date: Thu, 18 Sep 2025 12:53:29 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	Jinank Jain <jinankjain@linux.microsoft.com>
Subject: Re: [PATCH v3 5/5] mshv: Introduce new hypercall to map stats page
 for L1VH partitions
Message-ID: <aMxjORzTO0DgWq9q@skinsburskii.localdomain>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-6-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758066262-15477-6-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Sep 16, 2025 at 04:44:22PM -0700, Nuno Das Neves wrote:
> From: Jinank Jain <jinankjain@linux.microsoft.com>
> 

<snip>

> +static int hv_call_map_stats_page2(enum hv_stats_object_type type,
> +				   const union hv_stats_object_identity *identity,
> +				   u64 map_location)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_stats_page2 *input;
> +	u64 status;
> +	int ret;
> +
> +	if (!map_location || !mshv_use_overlay_gpfn())
> +		return -EINVAL;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +		memset(input, 0, sizeof(*input));
> +		input->type = type;
> +		input->identity = *identity;
> +		input->map_location = map_location;
> +
> +		status = hv_do_hypercall(HVCALL_MAP_STATS_PAGE2, input, NULL);
> +
> +		local_irq_restore(flags);
> +		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			if (hv_result_success(status))
> +				break;
> +			hv_status_debug(status, "\n");

It looks more natural to check for success first and break the loop, and
only then handle errors.
Maybe even set ret for both success and error messages and break and
handle only the unsufficient memory status.

> @@ -865,6 +931,19 @@ int hv_call_unmap_stat_page(enum hv_stats_object_type type,
>  	return hv_result_to_errno(status);
>  }
>  
> +int hv_unmap_stats_page(enum hv_stats_object_type type, void *page_addr,
> +			const union hv_stats_object_identity *identity)
> +{

Should this function be type of void?

Thanks,
Stanislav


