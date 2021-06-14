Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5317E3A5DCB
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Jun 2021 09:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbhFNHk0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Jun 2021 03:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232493AbhFNHkX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Jun 2021 03:40:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623656300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4JweKietmrpHO3kHqxbaCMf9WXh4WBEfPXNjcfKC8o=;
        b=OHt1/KerDLnJ6PXum9jJrj/EMZw/hvVDzypslzy4VTrTPC3E/qgJV20aSoFlT6rtly55Lb
        EcepCqasz64kzKVv4FxlvVeC8IZ73z6bjBmd7M2dMFMT4ymCber1U43vAUtEWaJieFpw8B
        ZqwLGz/G8GT84LDzjqReUStBFkvjnqE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-hbjyRK_ENXqUDi1IKmMOBQ-1; Mon, 14 Jun 2021 03:38:17 -0400
X-MC-Unique: hbjyRK_ENXqUDi1IKmMOBQ-1
Received: by mail-wr1-f72.google.com with SMTP id h104-20020adf90710000b029010de8455a3aso6663922wrh.12
        for <linux-hyperv@vger.kernel.org>; Mon, 14 Jun 2021 00:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R4JweKietmrpHO3kHqxbaCMf9WXh4WBEfPXNjcfKC8o=;
        b=ozYVhML9Ls0rv4kTLvye1mswPxdueOzvaNKIF7l5rCdxJmPJOZxjEgw5wdwMQxj+Gp
         VLkeUe1TMxNYMipJ/Z8ywB0yOCQ346xEbiFYUb2fcacrAFs/Y4C5rWJ3B+pim+ffwLEs
         p74IZJgIVTOMaNxyitl13yYEtIc2GP7/eaea77rdPsq0nhOJScwYiOL7SCNVmBQUbzNY
         HleJmrT0k/QkFwy9YmNlxfQNTipa2zevCL6RCbq0Wi/3G1QszpRU9fj0kNpOqklBon9M
         rUzuQB1q+6/qU8xJRBqbcVAOtF3x8xueYpNpsh9xeCJWOJlTgOtEWYsqjt02jYZkal94
         QudQ==
X-Gm-Message-State: AOAM530RUl1twbhxnSNXSr4mEQ1+DPFPEIIirhfpaErDjMz5e7mht+8K
        fLaE3WOnOKkynh2lKuL5RnVoD571EYbQw494DMNS2+Kf+HpmdWx2E5wlvMG26uFxs3nCmEyCq78
        zv0KYpCBAYXLCMJikDVTL6VcU
X-Received: by 2002:a7b:c193:: with SMTP id y19mr15277290wmi.172.1623656296603;
        Mon, 14 Jun 2021 00:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiDCyK5qKp7sWrxYZFklPpDnGx/uaKSOKDgbTy9j/tF+JnQhm1Y4ZozM2kmm0E0zLgTVtwow==
X-Received: by 2002:a7b:c193:: with SMTP id y19mr15277278wmi.172.1623656296417;
        Mon, 14 Jun 2021 00:38:16 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c66ca.dip0.t-ipconnect.de. [91.12.102.202])
        by smtp.gmail.com with ESMTPSA id q20sm19456718wrf.45.2021.06.14.00.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jun 2021 00:38:16 -0700 (PDT)
To:     Hillf Danton <hdanton@sina.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
References: <YMO+CoYnCgObRtOI@DESKTOP-1V8MEUQ.localdomain>
 <20210612021115.2136-1-hdanton@sina.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: vmemmap alloc failure in hot_add_req()
Message-ID: <951ddbaf-3d74-7043-4866-3809ff991cfd@redhat.com>
Date:   Mon, 14 Jun 2021 09:38:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210612021115.2136-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 12.06.21 04:11, Hillf Danton wrote:
> On Fri, 11 Jun 2021 12:48:26 -0700 Nathan Chancellor wrote:
>> Hi all,
>>
>> I am occasionally seeing a kernel warning when running virtual machines
>> in Hyper-V, which usually happens a minute or so after boot. It does not
>> happen on every boot and it is reproducible on at least v5.10. I think
>> it might have something to do with constant reboots, which I do when
>> testing various kernels.
>>
>> The stack trace is as follows:
>>
>> [   49.215291] kworker/0:1: vmemmap alloc failure: order:9, mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL), nodemask=(null),cpuset=/,mems_allowed=0
>> [   49.215299] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 5.13.0-rc5 #1
>> [   49.215301] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
>> [   49.215302] Workqueue: events hot_add_req [hv_balloon]
> 
> Apart from order:9 (mm Cced), events_unbound is the right workqueue instead
> because the report shows the risk that hot_add_req could block other pending
> events longer than thought. Any special reason for the events wq?
> 
>> [   49.215307] Call Trace:
>> [   49.215310]  dump_stack+0x76/0x94
>> [   49.215314]  warn_alloc.cold+0x78/0xdc
>> [   49.215316]  ? __alloc_pages+0x200/0x230
>> [   49.215319]  vmemmap_alloc_block+0x86/0xdc
>> [   49.215323]  vmemmap_populate+0x10e/0x31c
>> [   49.215324]  __populate_section_memmap+0x38/0x4e
>> [   49.215326]  sparse_add_section+0x12c/0x1cf
>> [   49.215329]  __add_pages+0xa9/0x130
>> [   49.215330]  add_pages+0x12/0x60
>> [   49.215333]  add_memory_resource+0x180/0x300
>> [   49.215335]  __add_memory+0x3b/0x80
>> [   49.215336]  add_memory+0x2e/0x50
>> [   49.215337]  hot_add_req+0x3fc/0x5a0 [hv_balloon]
>> [   49.215340]  process_one_work+0x214/0x3e0
>> [   49.215342]  worker_thread+0x4d/0x3d0
>> [   49.215344]  ? process_one_work+0x3e0/0x3e0
>> [   49.215345]  kthread+0x133/0x150
>> [   49.215347]  ? kthread_associate_blkcg+0xc0/0xc0
>> [   49.215348]  ret_from_fork+0x22/0x30
>> [   49.215351] Mem-Info:
>> [   49.215352] active_anon:251 inactive_anon:140868 isolated_anon:0
>>                  active_file:47497 inactive_file:88505 isolated_file:0
>>                  unevictable:8 dirty:14 writeback:0
>>                  slab_reclaimable:12013 slab_unreclaimable:11403
>>                  mapped:131701 shmem:12671 pagetables:3140 bounce:0
>>                  free:41388 free_pcp:37 free_cma:0
>> [   49.215355] Node 0 active_anon:1004kB inactive_anon:563472kB active_file:189988kB inactive_file:354020kB unevictable:32kB isolated(anon):0kB isolated(file):0kB mapped:526804kB dirty:56kB writeback:0kB shmem:50684kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:5904kB pagetables:12560kB all_unreclaimable? no
>> [   49.215358] Node 0 DMA free:6496kB min:480kB low:600kB high:720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:3120kB active_file:2584kB inactive_file:2792kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
>> [   49.215361] lowmem_reserve[]: 0 1384 1384 1384 1384
>> [   49.215364] Node 0 DMA32 free:159056kB min:44572kB low:55712kB high:66852kB reserved_highatomic:0KB active_anon:1004kB inactive_anon:560352kB active_file:187004kB inactive_file:350864kB unevictable:32kB writepending:56kB present:1555760kB managed:1432388kB mlocked:32kB bounce:0kB free_pcp:172kB local_pcp:0kB free_cma:0kB
>> [   49.215367] lowmem_reserve[]: 0 0 0 0 0
>> [   49.215369] Node 0 DMA: 17*4kB (UM) 13*8kB (M) 10*16kB (M) 3*32kB (ME) 3*64kB (UME) 4*128kB (UME) 1*256kB (E) 2*512kB (UE) 2*1024kB (ME) 1*2048kB (E) 0*4096kB = 6508kB
>> [   49.215377] Node 0 DMA32: 8061*4kB (UME) 5892*8kB (UME) 2449*16kB (UME) 604*32kB (UME) 207*64kB (UME) 49*128kB (UM) 7*256kB (M) 1*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 159716kB
>> [   49.215388] 148696 total pagecache pages
>> [   49.215388] 0 pages in swap cache
>> [   49.215389] Swap cache stats: add 0, delete 0, find 0/0
>> [   49.215390] Free swap  = 0kB
>> [   49.215390] Total swap = 0kB
>> [   49.215391] 392939 pages RAM
>> [   49.215391] 0 pages HighMem/MovableOnly
>> [   49.215391] 31002 pages reserved
>> [   49.215392] 0 pages cma reserved
>> [   49.215393] 0 pages hwpoisoned
>>
>> Is this a known issue and/or am I doing something wrong? I only noticed
>> this because there are times when I am compiling something intensive in
>> the VM such as LLVM and the VM runs out of memory even though I have
>> plenty of free memory on the host but I am not sure if this warning is
>> related to that issue.

Hi,

Is hotplugged memory getting onlined automatically (either from user 
space via a udev script or via the kernel, for example, with 
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE)?

If it's not getting onlined, you easily sport after hotplug e.g., via 
"lsmem" that there are quite some offline memory blocks.

Note that x86_64 code will fallback from populating huge pages to 
populating base pages for the vmemmap; this can happen easily when under 
memory pressure.

If adding memory would fail completely, you'd see another "hot_add 
memory failed error is ..." error message from hyper-v in the kernel 
log. If that doesn't show up, it's simply suboptimal, but hotplugging 
memory still succeeded.


Note: we could support "memmap_on_memory" in some cases (e.g., no memory 
holes in hotadded range) when hotplugging memory blocks via hyper-v, 
which would result in this warning less trigger less frequently.

-- 
Thanks,

David / dhildenb

