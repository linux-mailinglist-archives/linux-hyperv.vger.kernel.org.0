Return-Path: <linux-hyperv+bounces-6948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4F6B86716
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 20:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B48194A682B
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 18:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317B42D3745;
	Thu, 18 Sep 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y8e+hL/O"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B648B2C08A2;
	Thu, 18 Sep 2025 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758221042; cv=none; b=GVp+wx3BwjonIt/y1GGkVgjdZVWpQDTD1Mx255CvJVFy6d6nYxdmsS5SBu7yOqmSLaBLij+nXp9yrJlxNu/zKqeQ68PbiYZyULWiEXpGQdKW2rrAA73nOhRRkcBRHa1WNPn2YLqZE9Jiz+88GAwHnYi9Q5xjQXicTcc8jhdH52c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758221042; c=relaxed/simple;
	bh=nZAFkjB3WBw4tEItV/bS+V374WYPiZNl/ReOtdai188=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoURGuG0GJ4ANB23/9sJHJPJVOHujXbNyLhRCRdD3pNoQh7GCGLw1YmeFjW/AT9B2B5PkLGOucJrOAEqresOfWJRQYxkyfOnwQqxi9lRRt+kv3rJRtaW4BLNy3+Ipfr83kyJjEgbbKsGUcmxPsEFiZokOTty38IcoI0vzQuu1rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y8e+hL/O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii.localdomain (unknown [131.107.8.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id ED73320143E2;
	Thu, 18 Sep 2025 11:43:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED73320143E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1758221040;
	bh=c+5fBAyJiHvKjHvkljnNidXFiWFLeagh5Zok8uZDKFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y8e+hL/OWJ2uAF39Al/GO3MtyY/yumrK4YNGEHnscXrrB+xBNly5C/Y/KdzOQPRRC
	 chAtcbg64gfzqWibRNO2gSbrcIqXaLYL177faDNXC69/4bzkqWxzFKzwoj48my0/F+
	 g1qekGxzkLTcduzXLzgs/0kOdCxNfjRXD4VaGepY=
Date: Thu, 18 Sep 2025 11:43:57 -0700
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v3 2/5] mshv: Add the HVCALL_GET_PARTITION_PROPERTY_EX
 hypercall
Message-ID: <aMxS7Wh67SuF4LV2@skinsburskii.localdomain>
References: <1758066262-15477-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1758066262-15477-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758066262-15477-3-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Sep 16, 2025 at 04:44:19PM -0700, Nuno Das Neves wrote:

<snip>

> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index b4067ada02cf..b91358b9c929 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -376,6 +376,46 @@ struct hv_input_set_partition_property {
>  	u64 property_value;
>  } __packed;
>  
> +union hv_partition_property_arg {
> +	u64 as_uint64;
> +	struct {
> +		union {
> +			u32 arg;
> +			u32 vp_index;
> +		};
> +		u16 reserved0;
> +		u8 reserved1;
> +		u8 object_type;
> +	};
> +} __packed;

Shouldn't the struct be "packed" instead?

> +
> +struct hv_input_get_partition_property_ex {
> +	u64 partition_id;
> +	u32 property_code; /* enum hv_partition_property_code */
> +	u32 padding;
> +	union {
> +		union hv_partition_property_arg arg_data;
> +		u64 arg;
> +	};
> +} __packed;
> +
> +/*
> + * NOTE: Should use hv_input_set_partition_property_ex_header to compute this
> + * size, but hv_input_get_partition_property_ex is identical so it suffices
> + */
> +#define HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE \
> +	(HV_HYP_PAGE_SIZE - sizeof(struct hv_input_get_partition_property_ex))
> +
> +union hv_partition_property_ex {
> +	u8 buffer[HV_PARTITION_PROPERTY_EX_MAX_VAR_SIZE];
> +	struct hv_partition_property_vmm_capabilities vmm_capabilities;
> +	/* More fields to be filled in when needed */
> +} __packed;

Packing a union is redundant.

Thanks,
Stanislav


