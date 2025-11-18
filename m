Return-Path: <linux-hyperv+bounces-7676-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 07552C68FF1
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 12:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D64B36880D
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E93321B8;
	Tue, 18 Nov 2025 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hUroG0Ti"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D402B2DA76F;
	Tue, 18 Nov 2025 11:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763464111; cv=none; b=h506GB3agPesJt7K3eUn17A6PnxwIEB67DlRZfvrSybAql7043swOp0Xe++f2KxuxkqMeJT7lir9gRnNchwKrjGfDtCNKChyZl5kt99RP0YlE85opYTSY+aQLsgT9iXXnlBi8SYeUsK5TW121MDCkSOdKrqm272Fi1zcy2ZE5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763464111; c=relaxed/simple;
	bh=SLEQlMyT7ru0VVaQBQdfNihYAh6n6dBv4afgIr2ndj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJBGVdYeH2sXeEUghv183gk2rsbBNLrFFEo6BLekWxdOUL+KDF3yMsgOTaM1fdtkbTXfGnWmTZ5AdJmyfJiZnmMqa+NNH7tZrryjxmtH3xLoCtfgjPR5g4R1B2NoyFrgD4S1UqLoiu//H8pt4rxQI8oKwvbpcj0i5TEKP//zt/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hUroG0Ti; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.184.99] (unknown [167.220.238.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id 41C81211629A;
	Tue, 18 Nov 2025 03:08:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41C81211629A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763464108;
	bh=7zJSaE+JzYYi1N8vJh6a4WuGQQAD+L77IFF7iUoK80Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hUroG0TirOgzqYQu6NMF9oAs4KsrwaNhJO/foPhUoXM9CbBJdmxzU76ZILvZLz5A7
	 R8qkmn3FRh4nfjQ8brInNyQEOW9Is6EO/d2pOV5VP9PC4u/JfX8y2wgYukxlSlyqcN
	 JxoufphicoCndQ59J1f3I4T/P6HexuHPzOFYEPso=
Message-ID: <fa78f511-6a66-43fe-a41e-771f97ada21c@linux.microsoft.com>
Date: Tue, 18 Nov 2025 16:38:20 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] net: mana: Handle SKB if TX SGEs exceed
 hardware limit
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, leon@kernel.org,
 mlevitsk@redhat.com, yury.norov@gmail.com, sbhatta@marvell.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 gargaditya@microsoft.com
References: <1763155003-21503-1-git-send-email-gargaditya@linux.microsoft.com>
 <1763155003-21503-2-git-send-email-gargaditya@linux.microsoft.com>
 <20251117194618.33af8e98@kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20251117194618.33af8e98@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18-11-2025 09:16, Jakub Kicinski wrote:
> On Fri, 14 Nov 2025 13:16:42 -0800 Aditya Garg wrote:
>> The MANA hardware supports a maximum of 30 scatter-gather entries (SGEs)
>> per TX WQE. Exceeding this limit can cause TX failures.
>> Add ndo_features_check() callback to validate SKB layout before
>> transmission. For GSO SKBs that would exceed the hardware SGE limit, clear
>> NETIF_F_GSO_MASK to enforce software segmentation in the stack.
>> Add a fallback in mana_start_xmit() to linearize non-GSO SKBs that still
>> exceed the SGE limit.
> 
>> +	BUILD_BUG_ON(MAX_TX_WQE_SGL_ENTRIES != MANA_MAX_TX_WQE_SGL_ENTRIES);
>> +#if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES)
>> +	if (skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> 
> nit: please try to avoid the use of ifdef if you can. This helps to
> avoid build breakage sneaking in as this code will be compiled out
> on default config on all platforms.
> 
> Instead you should be able to simply add the static condition to the
> if statement:
> 
> 	if (MAX_SKB_FRAGS + 2 > MANA_MAX_TX_WQE_SGL_ENTRIES &&
> 	    skb_shinfo(skb)->nr_frags + 2 > MAX_TX_WQE_SGL_ENTRIES) {
> 
> and let the compiler (rather than preprocessor) eliminate this if ()
> block.
> 

Thanks for review and explanation Jakub, I will incorporate this change 
in next revision.

Regards,
Aditya


