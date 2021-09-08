Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6EF403437
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Sep 2021 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbhIHGWq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 8 Sep 2021 02:22:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235929AbhIHGWp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 8 Sep 2021 02:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631082097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z34UVAiI8Q78/349kHm5g+91ow7Iz9fZ37lSWz6rrwY=;
        b=bQ+v6Dmb9xgb+z3DHjD3DMEsbh2QIDLkPy3f9f2yVLq334PqaP2pfykVbRq9qSatOcfgSF
        Nb2kvAoWhKkRH2m3BRy9Kz8cVohv61VvjFf2Aucuvu+RyqmC+13STp6gV2jvlD9pdp8SWE
        tAS7wk/ADA7j5ALCZ8QYfHEW9nomRSg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-qcWWxBAdPYyg1gJmFwKl2w-1; Wed, 08 Sep 2021 02:21:36 -0400
X-MC-Unique: qcWWxBAdPYyg1gJmFwKl2w-1
Received: by mail-wm1-f71.google.com with SMTP id y24-20020a7bcd98000000b002eb50db2b62so460196wmj.5
        for <linux-hyperv@vger.kernel.org>; Tue, 07 Sep 2021 23:21:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=z34UVAiI8Q78/349kHm5g+91ow7Iz9fZ37lSWz6rrwY=;
        b=IrZP5N7b6BwMJJ2FKMNaGUJE+NGYPTdCO6gRTIR6/wwYKCkQt6irPYamf2MoU+52Uo
         xtO8T/t8ATbeXdxg1EFdWaKtAF2pSAn7IrlRStVO0QMpOYjHgbMyExz+5yF49I+jlucN
         jqsBAP48ILdaMQqyj0r/6gNxsOxjRhtdgmK7OJul91sBVRa7tgWn6LH7IHTUO40yT72g
         yp1WW+QeRlBpGWDaSoeXIvYCN2DhNLwehIhVfec28qi2AfzJkhtPZUlZejx+fGRp5g70
         9g4IP3DOcqSH4xMWdOq77CpcQG9AkPCmjcMxe8XlTqcZhe9NtR0HLBoad2pAn8NGr+Oh
         aFjg==
X-Gm-Message-State: AOAM531EyCIZf7G7GKjnpgGM5ZNVdQDiFkmQdOnTerh5yWsr+NkT8fc9
        WfMOfoo17cuRZ1LhLJp5pNGYPfFXxhJN1UKOU2F6vGjEiwxrcjba5WIuPr421bJiuw8v8RZQPJq
        UOD6qMGr5QgSjnPgbYVDmB/kP
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr1991904wrc.162.1631082094820;
        Tue, 07 Sep 2021 23:21:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVePYl3oJzEgmfpZnrDZETUp0uOCSKVg5L73nfFg5SJFFaAVj5u3fATe4qqvZ9JKp+koI50g==
X-Received: by 2002:adf:9bdb:: with SMTP id e27mr1991865wrc.162.1631082094550;
        Tue, 07 Sep 2021 23:21:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6125.dip0.t-ipconnect.de. [91.12.97.37])
        by smtp.gmail.com with ESMTPSA id l21sm1014143wmh.31.2021.09.07.23.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 23:21:34 -0700 (PDT)
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     akpm@linux-foundation.org, alexander.h.duyck@linux.intel.com,
        dave.hansen@intel.com, haiyangz@microsoft.com, kys@microsoft.com,
        linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, mhocko@kernel.org, mhocko@suse.com,
        osalvador@suse.de, pankaj.gupta.linux@gmail.com,
        richard.weiyang@linux.alibaba.com, rppt@kernel.org,
        sthemmin@microsoft.com, vbabka@suse.cz, wei.liu@kernel.org,
        willy@infradead.org, xen-devel@lists.xenproject.org
References: <20201005121534.15649-5-david@redhat.com>
 <a52dacbe-5649-7245-866f-ceaba44975b5@seco.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 4/5] mm/page_alloc: place pages to tail in
 __free_pages_core()
Message-ID: <528e8d9c-b148-30ec-d8cc-3dd072eaa7f2@redhat.com>
Date:   Wed, 8 Sep 2021 08:21:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a52dacbe-5649-7245-866f-ceaba44975b5@seco.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 08.09.21 00:40, Sean Anderson wrote:
> Hi David,
> 
> This patch breaks booting on my custom Xilinx ZynqMP board. Booting
> fails just after/during GIC initialization:
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd034]
> [    0.000000] Linux version 5.14.0 (sean@plantagenet) (aarch64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #251 SMP Tue Sep 7 18:11:50 EDT 2021
> [    0.000000] Machine model: xlnx,zynqmp
> [    0.000000] earlycon: cdns0 at MMIO 0x00000000ff010000 (options '115200n8')
> [    0.000000] printk: bootconsole [cdns0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000000000000-0x00000000ffffffff]
> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000087fffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000000000000-0x000000007fefffff]
> [    0.000000]   node   0: [mem 0x0000000800000000-0x000000087fffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000000000000-0x000000087fffffff]
> [    0.000000] On node 0, zone Normal: 256 pages in unavailable ranges
> [    0.000000] cma: Reserved 1000 MiB at 0x0000000041400000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.1
> [    0.000000] percpu: Embedded 19 pages/cpu s46752 r0 d31072 u77824
> [    0.000000] Detected VIPT I-cache on CPU0
> [    0.000000] CPU features: detected: ARM erratum 845719
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1033987
> [    0.000000] Kernel command line: earlycon clk_ignore_unused root=/dev/mmcblk0p2 rootwait rw cma=1000M
> [    0.000000] Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] software IO TLB: mapped [mem 0x000000003d400000-0x0000000041400000] (64MB)
> [    0.000000] Memory: 3023384K/4193280K available (4288K kernel code, 514K rwdata, 1200K rodata, 896K init, 187K bss, 145896K reserved, 1024000K cma-reserved)
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu: 	RCU event tracing is enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] GIC: Adjusting CPU interface base to 0x00000000f902f000
> [    0.000000] Root IRQ handler: gic_handle_irq
> [    0.000000] GIC: Using split EOI/Deactivate mode
> 
> and I bisected it to this patch. Applying the following patch (for 5.14)
> fixes booting again:

Hi Sean,

unfortunately that patch most likely (with 99.9999% confidence) revealed 
another latent BUG in your setup.

Some memory that shouldn't be handed to the buddy as free memory is 
getting now allocated earlier than later, resulting in that issue.


I had all different kinds of reports, but they were mostly

a) Firmware bugs that result in uncached memory getting exposed to the 
buddy, resulting in severe performance degradation such that the system 
will no longer boot. [3]

I wrote kstream [1] to be run under the old kernel, to identify these.

b) BUGs that result in unsuitable memory getting exposed to either the 
buddy or devices, resulting in errors during device initialization. [6]

c) Use after free BUGs.

Exposing memory, such as used for ACPI tables, to the buddy as free 
memory although it's still in use. [4]

d) Hypervisor BUGs

The last report (heavy performance degradation) was due to a BUG in 
dpdk. [2]


What the exact symptoms you're experiencing? Really slow boot/stall? 
Then it could be a) and kstream might help.


[1] https://github.com/davidhildenbrand/kstream
[2] 
https://lore.kernel.org/dpdk-dev/20210827161231.579968-1-eperezma@redhat.com/T/#u
[3] 
https://lore.kernel.org/r/MW3PR12MB4537C3C6EFD9CA3A4B32084DF36B9@MW3PR12MB4537.namprd12.prod.outlook.com
[4] https://lkml.kernel.org/r/4650320.31r3eYUQgx@kreacher
[5] https://lkml.kernel.org/r/87361onphy.fsf_-_@codeaurora.org
[6] 
https://lore.kernel.org/r/20201213225517.3838501-1-linus.walleij@linaro.org


-- 
Thanks,

David / dhildenb

