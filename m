Return-Path: <linux-hyperv+bounces-10394-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AhlMUmK72kPCgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10394-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 18:09:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4747606E
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 18:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 523A330764E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Apr 2026 16:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AFD34A3DB;
	Mon, 27 Apr 2026 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="kmnqlfzT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB4346ADC
	for <linux-hyperv@vger.kernel.org>; Mon, 27 Apr 2026 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777305715; cv=none; b=pd5Ish2HBG8FfIkwRuEJn95rvtj1kuOylUoHTai4ohgqPzK4Q/q0Do4ua9bq0ZWZwhfktUYhd2A2ClnJyu3c73YJOeKqKGcQrxde9OPtJA3RHuCkzGmjtCq4IoKncVvRg4jeZHcPsbc+lPeHGVZUwEb6TDMP1LbP9q2cmK9LfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777305715; c=relaxed/simple;
	bh=3nI4jh0qSpjXgDdJgMsEeE+LnWsU7E6SKeCla5t9yI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NkpbdQHEgNP3MAibyXKLBV+QlVFi5fOpl/Q+BnnGnc9iRrlrUHgIE7Z5KOL1Ihozg7tLcXTooQg/Szcbu2SeMrV7uAlwjURqgZkfrMImjF5JqfQDjTN6BJb5X0YARgEJHIls7Gqv0YxfQJ7q1VuQSRSOgslxsn51BIkOzXIZK+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=kmnqlfzT; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so135943305e9.3
        for <linux-hyperv@vger.kernel.org>; Mon, 27 Apr 2026 09:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1777305712; x=1777910512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wUIn/GeHnKQMX3ItFkglQNbpq/QxkRY25o0nGMIbjjc=;
        b=kmnqlfzT+VLa4gehYeZswkCKagxg08sH8GjJYZl2/2/P1VC3/8sMxqAT8tyWytFdp/
         gujNcseGsm4It1DG1yAtSZbt0fAExk07ewBTz0BDE3j/au0wHaRWWCUUesoCh4Nn7gOb
         5+20SiBbryxZ2gYymMKFbEGYq4CZy8nhDYqSFiQzUdLBcdiAv1WjLJ7sCHIF+mlQnBKZ
         hZv9RqMX1bJvPshZXlOChFYQ7DPMThWEvQSYBr/n8df7hpo3L2jcDHbAhUVfscbX0mF7
         33y6L63pADVRMkSZenN80mt6DlUoqZOQj1weSbI3Dc7prHxkrs7US46qS62iXrZaw3mm
         cNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777305712; x=1777910512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUIn/GeHnKQMX3ItFkglQNbpq/QxkRY25o0nGMIbjjc=;
        b=dkQ8wXQcDXN8o2ySK9VIfnZMl47LEOdfJfO4n/HpTw2htLhSKcA1/vt/O0S4X6KHIY
         oKcsSQg9LTPrPTbOCRfW2b3aSGKI19vGP0SlskPC3tjTLEHuiq/LuQLrmwD6fPabcB1r
         NigNSkFxkxrE4ftcpfggJvsyHp9yAV5lHdJrLqHJrGvKk5PMnKN84GsmTXgLLtVadb94
         AT/rUzS0H9jG4BPGFZFe/FWmyrDb0evngDI6yQ57/BBTHYnKf9sD6OHuP2sdBI8+RwHv
         U/Y/Bc9xjU5Q4L3xvquJlMX6gfaNdPuth1OoGrUS0uTF0t80te2FmHEbepiJymkEJiwC
         TjFw==
X-Forwarded-Encrypted: i=1; AFNElJ+YsNLU+pPXgIP8IPVrdlAyNlP7/asdog7nRa3HbJ6DMUIaESAobZQmqLpxXvc3jHmBaA5lamw4+D7GzXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYfTCXqchbxuFnxxAmIEBzR2iXeLFB9AGAbnR6mUbsNk+Pnff
	UJ2mGVs1zYBjUYV/ghC6n/h6Kb968PbNqWPvFj8HJfjR/p6RQeCtnll42dH0y8BrV5A=
X-Gm-Gg: AeBDietMp6vTp9gh0CMrRVVzb+PoZ9czBXNZtNPZZVSks/r4gjRAhjyLR58xp6eFpdf
	yHv6cKEZe+9qpvzdl/NY9Y07CsaGsmu2wn+TJ1MTEKbbhr5MjWzKbJ+GW1to5m7BEwvT6ssi15h
	74QEmA6iabRPIgULizPFkeq4WZHjORoO17hAO3U+gnmnM2PND/UPHXWs7AHxm2A0H6FGQw4sBFd
	/Gnh/cXwKM/dSXo6wEgV9NQu/KW/ODKXvr6hrT2JjOOhXNVExP+DosxKz4A1QwmoWGBqoPSQBep
	gZLDWBF8/4LvuGa41Dt0cQkJl6Ll4bHv4hhReYB08SJhVWRVvReFXvFTHZiiSMz/jgwu8SDRDsB
	oZ3eq8EUplhZ+opgm0ccpO4o0mVIzSXU7+v2Vm/pcy8Rup1kKZs4l7ZMvPTQSa98XoR61F5dPvl
	UtMrS4IDyxS9e+AgIwjYFgW2itAmuzvb41/gbvzNVGCorCowibLJaY97bbwOk+FXz4Bw9WFuBzD
	eIIuAH+z5nl98dOHPEOIj+65J/rZP8Xt3vp
X-Received: by 2002:a05:600c:6216:b0:48a:52ee:5776 with SMTP id 5b1f17b1804b1-48a76f53b01mr8705e9.11.1777305711990;
        Mon, 27 Apr 2026 09:01:51 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:142d:11f2:435b:9d94? ([2620:10d:c092:500::7:64e5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a59816b71sm230488865e9.1.2026.04.27.09.01.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 09:01:51 -0700 (PDT)
Message-ID: <5d5f74ae-602e-4380-b4d3-442b4dc2ceb4@davidwei.uk>
Date: Mon, 27 Apr 2026 17:01:48 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>, kuba@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org> <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
 <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <685d7bf9-062d-4bd2-8448-f7714bb05302@davidwei.uk>
 <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <aex119OtL8CEGXkb@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 43B4747606E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10394-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 2026-04-25 01:05, Dipayaan Roy wrote:
> On Fri, Apr 24, 2026 at 01:05:24PM -0700, David Wei wrote:
>> On 2026-04-23 05:48, Dipayaan Roy wrote:
>>> On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
>>>> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
>>>>> I still see roughly a 5% overhead from the atomic refcount operation
>>>>> itself, but on that platform there is no throughput drop when using
>>>>> page fragments versus full-page mode.
>>>>
>>>> That seems to contradict your claim that it's a problem with a specific
>>>> platform.. Since we're in the merge window I asked David Wei to try to
>>>> experiment with disabling page fragmentation on the ARM64 platforms we
>>>> have at Meta. If it repros we should use the generic rx-buf-len
>>>> ringparam because more NICs may want to implement this strategy.
>>>
>>> Hi Jakub,
>>>
>>> Thanks. I think I was not precise enough in my previous reply.
>>>
>>> What I meant is that the atomic refcount cost itself does not appear to
>>> be unique to the affected platform. I see a similar ~5% overhead on
>>> another ARM64 platformi (different vendor) as well. However, on that platform
>>> there is no throughput delta between fragment mode and full-page mode; both reach
>>> line rate.
>>>
>>> On the affected platform, fragment mode shows an additional ~15%
>>> throughput drop versus full-page mode. So the current data suggests that
>>> the atomic overhead is common, but the throughput regression is not
>>> explained by that overhead alone and likely depends on an additional
>>> platform-specific factor.
>>>
>>> Separately, the hardware team collected PCIe traces on the affected
>>> platform and reported stalls in the fragment-mode case that are not seen
>>> in full-page mode. They are still investigating the root cause, but
>>> their current hypothesis is that this is related to that platform’s
>>> PCIe/root-port microarchitecture rather than to page_pool refcounting
>>> alone.
>>>
>>> That said, I agree the right direction depends on whether this
>>> reproduces on other ARM64 platforms. If David is able to reproduce the
>>> same behavior, then using the generic rx-buf-len ringparam sounds like
>>> the better direction.
>>>
>>> Please let me know what David finds, and I can rework the patch
>>> accordingly.
>>
>> I ran a test on Grace, 4 KB pages, 72 cores, 1 NUMA node.
>>
>> Broadcom NIC, bnxt driver, 50 Gbps bandwidth. Hacked it up to either
>> give me 1 or 2 frags per page. No agg ring, no HDS, no HW GRO.
>>
>> Use 1 combined queue only for the server. Affinitized its net rx softirq
>> to run on core 4.
>>
>> Ran iperf3 server, taskset onto cpu cores 32-47. The iperf3 client is
>> running on a host w/ same hw in the same region. Using 32 queues, no
>> softirq affinities. The idea is to hammer page->pp_ref_count from
>> different cores.
>>
>> * 1 frag/page  -> 32.3 Gbps
>> * 2 frags/page -> 36.0 Gbps
>>
>> Comparing perf, for 2 frags/page the cost of skb_release_data() hitting
>> pp_ref_count goes up, as expected. Is this what you see? When you say
>> there's a +5% overhead, what function?
>>
>> Overall tput is higher with multiple frags. That's to be expected w/
>> page pool.
> 
> Hi David,
> 
> Thanks for running this. Your results are consistent with mine.
> 
> I have tested this on 2 ARM64 platforms from different vendors,
> running ntttcp and iperf3 using 4k as base page size.
> In my observation I see both platforms show a 5% overhead in
> napi_pp_put_page (~3.9%) and page_pool_alloc_frag_netmem (~1.9%)
> when running in fragment mode, both stalling on the LSE ldaddal
> atomic that maintains pp_ref_count.
> This seems to be same as your observation as well. However in my
> observation one of the platform shows 15% drop in throughput when
> in fragment mode vs page mode. The other platform I ran the test on
> infact performs slighty better in fragment mode than in full page
> mode (simillar observation as yours).

That's not what I observe. I don't see napi_pp_put_page at all, and
page_pool_alloc_frag_netmem is actually lower with 2 frags/page (4.06%)
than 1 frag/page (5.73%).

The main difference is in skb_release_data which goes from
0.85% (1 frag/page) to 3.32% (2 frags/page).

> 
> So the atomic refcount overhead appears to be common across ARM64
> platforms, but it does not cause a throughput regression.
> The throughput regression seems specific to one platform only for which
> we want to have the full page work around, also the HW team has
> identified PCIe stalls in fragment mode that are absent in full-page mode.
> Their investigation points to a suspected microarchitectural
> issue in the PCIe root port. IMO, there seems to be no issue with
> page_pool itself.
> 
> Given that:
>   - Grace shows fragments are faster (your data)
>   - A second ARM64 platform shows no regression (my data)
>   - Only the affected platform shows a throughput drop
>   - The HW team suspects this to a platform-specific PCIe issue,
>     also form our experiment data the drop in throughput seems to
>     be platform specific only.
> 
> I believe this remains a platform-specific workaround rather than
> a generic issue. Would a private flag still be acceptable for this
> case?
> 
> 
>>
>> There are some 200 Gbps NICs but they're mlx5 so I'd have to redo the
>> driver hack. Are you going to re-implement this change with rx-buf-len
>> instead of a private flag? If so, I won't spend more time running this
>> test.
>>
> I can go either way depending on what Jakub prefers.
> Hi Jakub,
> with this new data from David, is it convincing enough for a mana driver
> specific private flag, which can be set from user space by a udev rule
> by detecting the underlying platform? If not then I will send the next
> version with the other rxbuflen approach.
>>>
>>>
>>> Regards
>>> Dipayaan Roy
> 
> 
> Thanks and Regards
> Dipayaan Roy

