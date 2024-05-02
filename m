Return-Path: <linux-hyperv+bounces-2060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9D88B951D
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 09:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7611C283105
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 May 2024 07:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F339A21A04;
	Thu,  2 May 2024 07:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="froEeZMa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49338224DD
	for <linux-hyperv@vger.kernel.org>; Thu,  2 May 2024 07:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714634234; cv=none; b=sW+fNbALEoL4W4Yhl/RNyrpvfNLSJLAvLHioooo7SeMRfra7DY3Zs1RrOKBjcN9R1XUNCDJxsLTUjC4bS2+VMba1yaqk5D0ssRgo/bEPXcOTDtx6Uq0lsz41+/gmxbigPNio9q3/ikOvPnWxuDXs0njQkU8w20KEvjJAR1z92lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714634234; c=relaxed/simple;
	bh=7TpwHRC8mNhefr1Z9wG9HCEWGdaojPeMn62/wY12xTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HcthqovfpVG/VJmzZaswpK5L6R1/2UKvGFVLXFsloGr/xEsHjQ1lXL1nwWNWq8N9QxD3VtKwhbXlN4tYXxluUM9tYNb6wiMRoL9ONPKWjXsR/BlXhTDZKdrlkBlgqjFGX5GY16K0O7H+CfMy/raH6rd0ZWu19Isfp/NpN+RS+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=froEeZMa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714634232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OIDhyH20/Kg5nJwECZysNFVnVnJydF4EiDXJ0DvvH0A=;
	b=froEeZMa9CXF6Mjoc74pN4NNuAiCzP0CGtfCcdcFP6yJ69IjkNjdYlIK6qKwWSSWsGQ/3j
	+hFuFiAyUEtjm6Qw7EY84E5nYrNMllpRRvT0Kg9/f2E37G4cLt+lzLP7A8TUDEL0wQJlf1
	KYxBzHpHArKwhLYBr+9kWJZ+Zd9U3nI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-IugALIIpP5W0Yj-QGYbwkw-1; Thu, 02 May 2024 03:17:08 -0400
X-MC-Unique: IugALIIpP5W0Yj-QGYbwkw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-418df23b51cso34031645e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 02 May 2024 00:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714634227; x=1715239027;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIDhyH20/Kg5nJwECZysNFVnVnJydF4EiDXJ0DvvH0A=;
        b=L5zmfsc7pSf81ck0ObJrdP4epXL1DsHXcoYgya9cnEaZ/egsSAAnOwWXXG1hKWlVmR
         9dOq1TcZoE8SJ0x4ZL5iCS6kkf7rLTrlijJqk7Xn5+8H1TRBKgbKqW2fUbULDnnVe9zD
         1jnNntA0mn6rReXdp6k4bdmOW+mfvDKCrsypYwYbfF+Nz8X4sXi6U0umBNSeCSTDy+es
         RwGNSsHs5naDrQJcCGWsqTzyT7M5B+Go0Kfuk6FCDb1RgYctGfwIU0kVbepRtqIs48kI
         qUwD0oJF3EWnq65hHHiTVkfvacKQ7ZcFMgXAChIkJXblFU68yheuv0XEOSa29qZLgFUk
         ut2w==
X-Forwarded-Encrypted: i=1; AJvYcCWZfu1VAtj5yiEx0q4MC7G/ujStjos46bPqSbzQRQsa6+gtvyTLZEzLW/o6p1Hb1BG11xLxSlV/sllTA0RjNN03QVjd/bBem7WPP6Zl
X-Gm-Message-State: AOJu0YxQpItYNpbu1hTNUd6Ml41cRBxpqGIzGuIlRLbnBycVYOK4Zbhr
	Jf/KVkILzyOHp59ik/T+3n3HllGu9X5x49CnIoBgY2TZ6IOQ7aClnxFzoIf9HERdRfF2jT3CTS1
	Q4MQuzUteyzoBRFtG88X5YBsBCqDHwlNeBELh17HaHa3cqnIFu6nmGUYrJVPf4A==
X-Received: by 2002:a05:600c:28f:b0:41a:5958:d6ac with SMTP id 15-20020a05600c028f00b0041a5958d6acmr3324886wmk.21.1714634227178;
        Thu, 02 May 2024 00:17:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07gI3S4azoLNp9q3O2vtJeRnV5wS6cxOWEbtkm5Hj9oe2Cb4AiFxdx1hXKm+bYVrxjlVctA==
X-Received: by 2002:a05:600c:28f:b0:41a:5958:d6ac with SMTP id 15-20020a05600c028f00b0041a5958d6acmr3324864wmk.21.1714634226701;
        Thu, 02 May 2024 00:17:06 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676? (p200300cbc71ebf00eba13ab9ab0fd676.dip0.t-ipconnect.de. [2003:cb:c71e:bf00:eba1:3ab9:ab0f:d676])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c311300b0041496734318sm4660626wmo.24.2024.05.02.00.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 00:17:06 -0700 (PDT)
Message-ID: <d320cf89-768f-4ae8-8a32-dff4e5699f0a@redhat.com>
Date: Thu, 2 May 2024 09:17:05 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hv_balloon: Enable hot-add for memblock sizes >
 128 MiB
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org
References: <20240501151458.2807-1-mhklinux@outlook.com>
 <20240501151458.2807-2-mhklinux@outlook.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240501151458.2807-2-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.05.24 17:14, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The Hyper-V balloon driver supports hot-add of memory in addition
> to ballooning. Current code hot-adds in fixed size chunks of
> 128 MiB (fixed constant HA_CHUNK in the code). While this works
> in Hyper-V VMs with 64 GiB or less or memory where the Linux
> memblock size is 128 MiB, the hot-add fails for larger memblock
> sizes because add_memory() expects memory to be added in chunks
> that match the memblock size. Messages like the following are
> reported when Linux has a 256 MiB memblock size:
> 
> [  312.668859] Block size [0x10000000] unaligned hotplug range:
>                 start 0x310000000, size 0x8000000
> [  312.668880] hv_balloon: hot_add memory failed error is -22
> [  312.668984] hv_balloon: Memory hot add failed
> 
> Larger memblock sizes are usually used in VMs with more than
> 64 GiB of memory, depending on the alignment of the VM's
> physical address space.
> 
> Fix this problem by having the Hyper-V balloon driver determine
> the Linux memblock size, and process hot-add requests in that
> chunk size instead of a fixed 128 MiB. Also update the hot-add
> alignment requested of the Hyper-V host to match the memblock
> size.
> 
> The code changes look significant, but in fact are just a
> simple text substitution of a new global variable for the
> previous HA_CHUNK constant. No algorithms are changed except
> to initialize the new global variable and to calculate the
> alignment value to pass to Hyper-V. Testing with memblock
> sizes of 256 MiB and 2 GiB shows correct operation.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2:
> * Change new global variable name from ha_chunk_pgs to
>    ha_pages_in_chunk [David Hildenbrand]
> * Use kernel macros ALIGN(), ALIGN_DOWN(), and umin()
>    to simplify code and reduce references to HA_CHUNK. For
>    ease of review, this is done in a new patch preceeding
>    this one. [David Hildenbrand]
> 
>   drivers/hv/hv_balloon.c | 55 +++++++++++++++++++++++++----------------
>   1 file changed, 34 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 9f45b8a6762c..e0a1a18041ca 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -425,11 +425,11 @@ struct dm_info_msg {
>    * The range start_pfn : end_pfn specifies the range
>    * that the host has asked us to hot add. The range
>    * start_pfn : ha_end_pfn specifies the range that we have
> - * currently hot added. We hot add in multiples of 128M
> - * chunks; it is possible that we may not be able to bring
> - * online all the pages in the region. The range
> + * currently hot added. We hot add in chunks equal to the
> + * memory block size; it is possible that we may not be able
> + * to bring online all the pages in the region. The range
>    * covered_start_pfn:covered_end_pfn defines the pages that can
> - * be brough online.
> + * be brought online.
>    */
>   
>   struct hv_hotadd_state {
> @@ -505,8 +505,9 @@ enum hv_dm_state {
>   
>   static __u8 recv_buffer[HV_HYP_PAGE_SIZE];
>   static __u8 balloon_up_send_buffer[HV_HYP_PAGE_SIZE];
> +static unsigned long ha_pages_in_chunk;
> +
>   #define PAGES_IN_2M (2 * 1024 * 1024 / PAGE_SIZE)
> -#define HA_CHUNK (128 * 1024 * 1024 / PAGE_SIZE)
>   
>   struct hv_dynmem_device {
>   	struct hv_device *dev;
> @@ -724,21 +725,21 @@ static void hv_mem_hot_add(unsigned long start, unsigned long size,
>   	unsigned long processed_pfn;
>   	unsigned long total_pfn = pfn_count;
>   
> -	for (i = 0; i < (size/HA_CHUNK); i++) {
> -		start_pfn = start + (i * HA_CHUNK);
> +	for (i = 0; i < (size/ha_pages_in_chunk); i++) {
> +		start_pfn = start + (i * ha_pages_in_chunk);
>   
>   		scoped_guard(spinlock_irqsave, &dm_device.ha_lock) {
> -			has->ha_end_pfn +=  HA_CHUNK;
> -			processed_pfn = umin(total_pfn, HA_CHUNK);
> +			has->ha_end_pfn += ha_pages_in_chunk;
> +			processed_pfn = umin(total_pfn, ha_pages_in_chunk);
>   			total_pfn -= processed_pfn;
> -			has->covered_end_pfn +=  processed_pfn;
> +			has->covered_end_pfn += processed_pfn;
>   		}
>   
>   		reinit_completion(&dm_device.ol_waitevent);
>   
>   		nid = memory_add_physaddr_to_nid(PFN_PHYS(start_pfn));
>   		ret = add_memory(nid, PFN_PHYS((start_pfn)),
> -				(HA_CHUNK << PAGE_SHIFT), MHP_MERGE_RESOURCE);
> +				(ha_pages_in_chunk << PAGE_SHIFT), MHP_MERGE_RESOURCE);
>   

HA_BYTES_IN_CHUNK might be reasonable to have (see below)

>   	if (do_hot_add)
> @@ -1807,10 +1808,13 @@ static int balloon_connect_vsp(struct hv_device *dev)
>   	cap_msg.caps.cap_bits.hot_add = hot_add_enabled();
>   
>   	/*
> -	 * Specify our alignment requirements as it relates
> -	 * memory hot-add. Specify 128MB alignment.
> +	 * Specify our alignment requirements for memory hot-add. The value is
> +	 * the log base 2 of the number of megabytes in a chunk. For example,
> +	 * with 256 MiB chunks, the value is 8. The number of MiB in a chunk
> +	 * must be a power of 2.
>   	 */
> -	cap_msg.caps.cap_bits.hot_add_alignment = 7;
> +	cap_msg.caps.cap_bits.hot_add_alignment =
> +			ilog2(ha_pages_in_chunk >> (20 - PAGE_SHIFT));

I was wondering if we can remove some of the magic here. Something along 
the lines of:

ilog2(ha_pages_in_chunk / (SZ_1M >> PAGE_SHIFT))

or simply

#define HA_BYTES_IN_CHUNK (ha_pages_in_chunk << PAGE_SHIFT)

ilog2(HA_BYTES_IN_CHUNK / SZ_1M)


Apart from that nothing jumped at me; looks much cleaner.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


