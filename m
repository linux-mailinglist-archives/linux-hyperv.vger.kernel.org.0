Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6A43A4C7E
	for <lists+linux-hyperv@lfdr.de>; Sat, 12 Jun 2021 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhFLDoj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 11 Jun 2021 23:44:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229584AbhFLDoj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 11 Jun 2021 23:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1E7961108;
        Sat, 12 Jun 2021 03:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623469360;
        bh=gb5YDYOvR67KYefORIvyuWwnQmWvpnADxdNRYIW4z7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T61fJ3KQwLDAw4paMhyaByWQ9OdLzF15vi2VRm4jd4kW2usxUAqeaRcihCjoEed0P
         xHM8Fk8BA3zj223SEc3kufNiMsoWA2pVf42XgvqeoSqz7Vl0b3o/FEXfr/C8aWfin7
         Y02X9iMfn1IJtFV0HnaMBirAt8Qm0rVIdgDyMQSp1uaQo/ZrB3MmIiyCdbrLT9c9Ym
         0UCKuUi+b+nnw05OUDKJC55VIJDdfiO6ZXqN1b/X0W1NJVs2fypxSFDsiPEyKARwC1
         v9NVPqKyfWq4ao16XFoYPB8PzD6s1zwUiC01Qg3lzWRnGx1KIRRuW8duW4X+maISxV
         6YBPbU9dYhiww==
Date:   Fri, 11 Jun 2021 20:42:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: vmemmap alloc failure in hot_add_req()
Message-ID: <YMQtL/+IbFHbktfu@Ryzen-9-3900X>
References: <YMO+CoYnCgObRtOI@DESKTOP-1V8MEUQ.localdomain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LoiLK64PEoXhGvAz"
Content-Disposition: inline
In-Reply-To: <YMO+CoYnCgObRtOI@DESKTOP-1V8MEUQ.localdomain>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


--LoiLK64PEoXhGvAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 11, 2021 at 12:48:26PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> I am occasionally seeing a kernel warning when running virtual machines
> in Hyper-V, which usually happens a minute or so after boot. It does not
> happen on every boot and it is reproducible on at least v5.10. I think
> it might have something to do with constant reboots, which I do when
> testing various kernels.
> 
> The stack trace is as follows:
> 
> [   49.215291] kworker/0:1: vmemmap alloc failure: order:9, mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL), nodemask=(null),cpuset=/,mems_allowed=0
> [   49.215299] CPU: 0 PID: 18 Comm: kworker/0:1 Not tainted 5.13.0-rc5 #1
> [   49.215301] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
> [   49.215302] Workqueue: events hot_add_req [hv_balloon]
> [   49.215307] Call Trace:
> [   49.215310]  dump_stack+0x76/0x94
> [   49.215314]  warn_alloc.cold+0x78/0xdc
> [   49.215316]  ? __alloc_pages+0x200/0x230
> [   49.215319]  vmemmap_alloc_block+0x86/0xdc
> [   49.215323]  vmemmap_populate+0x10e/0x31c
> [   49.215324]  __populate_section_memmap+0x38/0x4e
> [   49.215326]  sparse_add_section+0x12c/0x1cf
> [   49.215329]  __add_pages+0xa9/0x130
> [   49.215330]  add_pages+0x12/0x60
> [   49.215333]  add_memory_resource+0x180/0x300
> [   49.215335]  __add_memory+0x3b/0x80
> [   49.215336]  add_memory+0x2e/0x50
> [   49.215337]  hot_add_req+0x3fc/0x5a0 [hv_balloon]
> [   49.215340]  process_one_work+0x214/0x3e0
> [   49.215342]  worker_thread+0x4d/0x3d0
> [   49.215344]  ? process_one_work+0x3e0/0x3e0
> [   49.215345]  kthread+0x133/0x150
> [   49.215347]  ? kthread_associate_blkcg+0xc0/0xc0
> [   49.215348]  ret_from_fork+0x22/0x30
> [   49.215351] Mem-Info:
> [   49.215352] active_anon:251 inactive_anon:140868 isolated_anon:0
>                 active_file:47497 inactive_file:88505 isolated_file:0
>                 unevictable:8 dirty:14 writeback:0
>                 slab_reclaimable:12013 slab_unreclaimable:11403
>                 mapped:131701 shmem:12671 pagetables:3140 bounce:0
>                 free:41388 free_pcp:37 free_cma:0
> [   49.215355] Node 0 active_anon:1004kB inactive_anon:563472kB active_file:189988kB inactive_file:354020kB unevictable:32kB isolated(anon):0kB isolated(file):0kB mapped:526804kB dirty:56kB writeback:0kB shmem:50684kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:5904kB pagetables:12560kB all_unreclaimable? no
> [   49.215358] Node 0 DMA free:6496kB min:480kB low:600kB high:720kB reserved_highatomic:0KB active_anon:0kB inactive_anon:3120kB active_file:2584kB inactive_file:2792kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   49.215361] lowmem_reserve[]: 0 1384 1384 1384 1384
> [   49.215364] Node 0 DMA32 free:159056kB min:44572kB low:55712kB high:66852kB reserved_highatomic:0KB active_anon:1004kB inactive_anon:560352kB active_file:187004kB inactive_file:350864kB unevictable:32kB writepending:56kB present:1555760kB managed:1432388kB mlocked:32kB bounce:0kB free_pcp:172kB local_pcp:0kB free_cma:0kB
> [   49.215367] lowmem_reserve[]: 0 0 0 0 0
> [   49.215369] Node 0 DMA: 17*4kB (UM) 13*8kB (M) 10*16kB (M) 3*32kB (ME) 3*64kB (UME) 4*128kB (UME) 1*256kB (E) 2*512kB (UE) 2*1024kB (ME) 1*2048kB (E) 0*4096kB = 6508kB
> [   49.215377] Node 0 DMA32: 8061*4kB (UME) 5892*8kB (UME) 2449*16kB (UME) 604*32kB (UME) 207*64kB (UME) 49*128kB (UM) 7*256kB (M) 1*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 159716kB
> [   49.215388] 148696 total pagecache pages
> [   49.215388] 0 pages in swap cache
> [   49.215389] Swap cache stats: add 0, delete 0, find 0/0
> [   49.215390] Free swap  = 0kB
> [   49.215390] Total swap = 0kB
> [   49.215391] 392939 pages RAM
> [   49.215391] 0 pages HighMem/MovableOnly
> [   49.215391] 31002 pages reserved
> [   49.215392] 0 pages cma reserved
> [   49.215393] 0 pages hwpoisoned
> 
> Is this a known issue and/or am I doing something wrong? I only noticed
> this because there are times when I am compiling something intensive in
> the VM such as LLVM and the VM runs out of memory even though I have
> plenty of free memory on the host but I am not sure if this warning is
> related to that issue.

I had one of these events just happen, journalctl output attached. I
have no idea what the "unhandled message: type:" messages mean, I guess
that corresponds to the switch statement in balloon_onchannelcallback().

> I do not have much experience with Hyper-V so it is possible I do not
> have something configured properly or there is some other issue going
> on. Let me know if there is any further information I can provide or
> help debug in any way.

Cheers,
Nathan

--LoiLK64PEoXhGvAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="journalctl.log"

-- Journal begins at Thu 2021-06-10 06:17:06 MST, ends at Fri 2021-06-11 20:34:01 MST. --
Jun 11 20:15:39 hyperv kernel: Linux version 5.13.0-rc5-next-20210611-llvm (nathan@hyperv) (ClangBuiltLinux clang version 13.0.0 (https://github.com/llvm/llvm-project 06c3d52aa2fa3b6a9aa019906ad8577813efe32a), LLD 13.0.0 (https://github.com/llvm/llvm-project 06c3d52aa2fa3b6a9aa019906ad8577813efe32a)) #1 SMP PREEMPT Fri Jun 11 20:10:16 MST 2021
Jun 11 20:15:39 hyperv kernel: Command line: initrd=\initramfs-linux-next-llvm.img root=PARTUUID=2660dacb-8872-49d2-8192-394e57557dd7 rw intel_pstate=no_hwp video=hyperv_fb:1920x1080
Jun 11 20:15:39 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
Jun 11 20:15:39 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
Jun 11 20:15:39 hyperv kernel: x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
Jun 11 20:15:39 hyperv kernel: x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
Jun 11 20:15:39 hyperv kernel: x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'compacted' format.
Jun 11 20:15:39 hyperv kernel: signal: max sigframe size: 1776
Jun 11 20:15:39 hyperv kernel: BIOS-provided physical RAM map:
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x00000000000c0000-0x00000000000fffff] reserved
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x0000000000100000-0x000000005ed1cfff] usable
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005ed1d000-0x000000005ed1dfff] ACPI data
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005ed1e000-0x000000005eecbfff] usable
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005eecc000-0x000000005eeeafff] ACPI data
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005eeeb000-0x000000005ef1afff] reserved
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005ef1b000-0x000000005ff9afff] usable
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005ff9b000-0x000000005fff2fff] reserved
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005fff3000-0x000000005fffafff] ACPI data
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005fffb000-0x000000005fffefff] ACPI NVS
Jun 11 20:15:39 hyperv kernel: BIOS-e820: [mem 0x000000005ffff000-0x000000005fffffff] usable
Jun 11 20:15:39 hyperv kernel: intel_pstate: HWP disabled
Jun 11 20:15:39 hyperv kernel: NX (Execute Disable) protection: active
Jun 11 20:15:39 hyperv kernel: efi: EFI v2.70 by Microsoft
Jun 11 20:15:39 hyperv kernel: efi: ACPI=0x5fffa000 ACPI 2.0=0x5fffa014 SMBIOS=0x5ffd8000 SMBIOS 3.0=0x5ffd6000 MEMATTR=0x5e541018 RNG=0x5ffda818 
Jun 11 20:15:39 hyperv kernel: efi: seeding entropy pool
Jun 11 20:15:39 hyperv kernel: SMBIOS 3.1.0 present.
Jun 11 20:15:39 hyperv kernel: DMI: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
Jun 11 20:15:39 hyperv kernel: Hypervisor detected: Microsoft Hyper-V
Jun 11 20:15:39 hyperv kernel: Hyper-V: privilege flags low 0x2e7f, high 0x3b8030, hints 0xc2c, misc 0xbed7b2
Jun 11 20:15:39 hyperv kernel: Hyper-V Host Build:19041-10.0-0-0.985
Jun 11 20:15:39 hyperv kernel: Hyper-V: LAPIC Timer Frequency: 0xa2c2a
Jun 11 20:15:39 hyperv kernel: tsc: Marking TSC unstable due to running on Hyper-V
Jun 11 20:15:39 hyperv kernel: Hyper-V: Using hypercall for remote TLB flush
Jun 11 20:15:39 hyperv kernel: clocksource: hyperv_clocksource_tsc_page: mask: 0xffffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
Jun 11 20:15:39 hyperv kernel: tsc: Detected 3800.016 MHz processor
Jun 11 20:15:39 hyperv kernel: e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
Jun 11 20:15:39 hyperv kernel: e820: remove [mem 0x000a0000-0x000fffff] usable
Jun 11 20:15:39 hyperv kernel: last_pfn = 0x60000 max_arch_pfn = 0x400000000
Jun 11 20:15:39 hyperv kernel: x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
Jun 11 20:15:39 hyperv kernel: Using GB pages for direct mapping
Jun 11 20:15:39 hyperv kernel: Secure boot disabled
Jun 11 20:15:39 hyperv kernel: RAMDISK: [mem 0x5e543000-0x5ecb3fff]
Jun 11 20:15:39 hyperv kernel: ACPI: Early table checksum verification disabled
Jun 11 20:15:39 hyperv kernel: ACPI: RSDP 0x000000005FFFA014 000024 (v02 VRTUAL)
Jun 11 20:15:39 hyperv kernel: ACPI: XSDT 0x000000005FFF90E8 00005C (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: FACP 0x000000005FFF8000 000114 (v06 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: DSDT 0x000000005EECC000 01E184 (v02 MSFTVM DSDT01   00000001 MSFT 05000000)
Jun 11 20:15:39 hyperv kernel: ACPI: FACS 0x000000005FFFE000 000040
Jun 11 20:15:39 hyperv kernel: ACPI: OEM0 0x000000005FFF7000 000064 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: WAET 0x000000005FFF6000 000028 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: APIC 0x000000005FFF5000 0000A8 (v04 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT 0x000000005FFF4000 000230 (v02 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: BGRT 0x000000005FFF3000 000038 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: FPDT 0x000000005ED1D000 000034 (v01 VRTUAL MICROSFT 00000001 MSFT 00000001)
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving FACP table memory at [mem 0x5fff8000-0x5fff8113]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving DSDT table memory at [mem 0x5eecc000-0x5eeea183]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving FACS table memory at [mem 0x5fffe000-0x5fffe03f]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving OEM0 table memory at [mem 0x5fff7000-0x5fff7063]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving WAET table memory at [mem 0x5fff6000-0x5fff6027]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving APIC table memory at [mem 0x5fff5000-0x5fff50a7]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving SRAT table memory at [mem 0x5fff4000-0x5fff422f]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving BGRT table memory at [mem 0x5fff3000-0x5fff3037]
Jun 11 20:15:39 hyperv kernel: ACPI: Reserving FPDT table memory at [mem 0x5ed1d000-0x5ed1d033]
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x00 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x01 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x02 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x03 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x04 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x05 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x06 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x07 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x08 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x09 -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x0a -> Node 0
Jun 11 20:15:39 hyperv kernel: SRAT: PXM 0 -> APIC 0x0b -> Node 0
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x5fffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x60000000-0xf7ffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0xfdfffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x1000000000-0xfcffffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x10000000000-0x1ffffffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x20000000000-0x3ffffffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x40000000000-0x7ffffffffff] hotplug
Jun 11 20:15:39 hyperv kernel: ACPI: SRAT: Node 0 PXM 0 [mem 0x80000000000-0xfffffffffff] hotplug
Jun 11 20:15:39 hyperv kernel: NODE_DATA(0) allocated [mem 0x5ece2000-0x5ece5fff]
Jun 11 20:15:39 hyperv kernel: Zone ranges:
Jun 11 20:15:39 hyperv kernel:   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
Jun 11 20:15:39 hyperv kernel:   DMA32    [mem 0x0000000001000000-0x000000005fffffff]
Jun 11 20:15:39 hyperv kernel:   Normal   empty
Jun 11 20:15:39 hyperv kernel:   Device   empty
Jun 11 20:15:39 hyperv kernel: Movable zone start for each node
Jun 11 20:15:39 hyperv kernel: Early memory node ranges
Jun 11 20:15:39 hyperv kernel:   node   0: [mem 0x0000000000001000-0x000000000009ffff]
Jun 11 20:15:39 hyperv kernel:   node   0: [mem 0x0000000000100000-0x000000005ed1cfff]
Jun 11 20:15:39 hyperv kernel:   node   0: [mem 0x000000005ed1e000-0x000000005eecbfff]
Jun 11 20:15:39 hyperv kernel:   node   0: [mem 0x000000005ef1b000-0x000000005ff9afff]
Jun 11 20:15:39 hyperv kernel:   node   0: [mem 0x000000005ffff000-0x000000005fffffff]
Jun 11 20:15:39 hyperv kernel: Initmem setup node 0 [mem 0x0000000000001000-0x000000005fffffff]
Jun 11 20:15:39 hyperv kernel:   DMA zone: 28769 pages in unavailable ranges
Jun 11 20:15:39 hyperv kernel:   DMA32 zone: 180 pages in unavailable ranges
Jun 11 20:15:39 hyperv kernel: ACPI: PM-Timer IO Port: 0x408
Jun 11 20:15:39 hyperv kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jun 11 20:15:39 hyperv kernel: IOAPIC[0]: apic_id 12, version 17, address 0xfec00000, GSI 0-23
Jun 11 20:15:39 hyperv kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
Jun 11 20:15:39 hyperv kernel: ACPI: Using ACPI (MADT) for SMP configuration information
Jun 11 20:15:39 hyperv kernel: e820: update [mem 0x5ed1e000-0x5ed24fff] usable ==> reserved
Jun 11 20:15:39 hyperv kernel: smpboot: Allowing 12 CPUs, 0 hotplug CPUs
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000bffff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x000c0000-0x000fffff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5ed1d000-0x5ed1dfff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5ed1e000-0x5ed24fff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5eecc000-0x5eeeafff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5eeeb000-0x5ef1afff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5ff9b000-0x5fff2fff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5fff3000-0x5fffafff]
Jun 11 20:15:39 hyperv kernel: PM: hibernation: Registered nosave memory: [mem 0x5fffb000-0x5fffefff]
Jun 11 20:15:39 hyperv kernel: [mem 0x60000000-0xffffffff] available for PCI devices
Jun 11 20:15:39 hyperv kernel: Booting paravirtualized kernel on Hyper-V
Jun 11 20:15:39 hyperv kernel: clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
Jun 11 20:15:39 hyperv kernel: setup_percpu: NR_CPUS:320 nr_cpumask_bits:320 nr_cpu_ids:12 nr_node_ids:1
Jun 11 20:15:39 hyperv kernel: percpu: Embedded 56 pages/cpu s192512 r8192 d28672 u262144
Jun 11 20:15:39 hyperv kernel: pcpu-alloc: s192512 r8192 d28672 u262144 alloc=1*2097152
Jun 11 20:15:39 hyperv kernel: pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 08 09 10 11 -- -- -- -- 
Jun 11 20:15:39 hyperv kernel: Hyper-V: PV spinlocks enabled
Jun 11 20:15:39 hyperv kernel: PV qspinlock hash table entries: 256 (order: 0, 4096 bytes, linear)
Jun 11 20:15:39 hyperv kernel: Built 1 zonelists, mobility grouping on.  Total pages: 385314
Jun 11 20:15:39 hyperv kernel: Policy zone: DMA32
Jun 11 20:15:39 hyperv kernel: Kernel command line: initrd=\initramfs-linux-next-llvm.img root=PARTUUID=2660dacb-8872-49d2-8192-394e57557dd7 rw intel_pstate=no_hwp video=hyperv_fb:1920x1080
Jun 11 20:15:39 hyperv kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes, linear)
Jun 11 20:15:39 hyperv kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
Jun 11 20:15:39 hyperv kernel: mem auto-init: stack:off, heap alloc:on, heap free:off
Jun 11 20:15:39 hyperv kernel: Memory: 1394704K/1571756K available (14344K kernel code, 1921K rwdata, 4584K rodata, 1864K init, 4252K bss, 176792K reserved, 0K cma-reserved)
Jun 11 20:15:39 hyperv kernel: random: get_random_u64 called from kmem_cache_open+0x28/0x6c0 with crng_init=0
Jun 11 20:15:39 hyperv kernel: SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=12, Nodes=1
Jun 11 20:15:39 hyperv kernel: ftrace: allocating 40969 entries in 161 pages
Jun 11 20:15:39 hyperv kernel: ftrace: allocated 161 pages with 3 groups
Jun 11 20:15:39 hyperv kernel: rcu: Preemptible hierarchical RCU implementation.
Jun 11 20:15:39 hyperv kernel: rcu:         RCU dyntick-idle grace-period acceleration is enabled.
Jun 11 20:15:39 hyperv kernel: rcu:         RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=12.
Jun 11 20:15:39 hyperv kernel: rcu:         RCU priority boosting: priority 1 delay 500 ms.
Jun 11 20:15:39 hyperv kernel:         Trampoline variant of Tasks RCU enabled.
Jun 11 20:15:39 hyperv kernel:         Rude variant of Tasks RCU enabled.
Jun 11 20:15:39 hyperv kernel:         Tracing variant of Tasks RCU enabled.
Jun 11 20:15:39 hyperv kernel: rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
Jun 11 20:15:39 hyperv kernel: rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=12
Jun 11 20:15:39 hyperv kernel: Using NULL legacy PIC
Jun 11 20:15:39 hyperv kernel: NR_IRQS: 20736, nr_irqs: 520, preallocated irqs: 0
Jun 11 20:15:39 hyperv kernel: Console: colour dummy device 80x25
Jun 11 20:15:39 hyperv kernel: printk: console [tty0] enabled
Jun 11 20:15:39 hyperv kernel: ACPI: Core revision 20210604
Jun 11 20:15:39 hyperv kernel: Failed to register legacy timer interrupt
Jun 11 20:15:39 hyperv kernel: APIC: Switch to symmetric I/O mode setup
Jun 11 20:15:39 hyperv kernel: Switched APIC routing to physical flat.
Jun 11 20:15:39 hyperv kernel: Hyper-V: Using IPI hypercalls
Jun 11 20:15:39 hyperv kernel: Hyper-V: Using enlightened APIC (xapic mode)
Jun 11 20:15:39 hyperv kernel: Calibrating delay loop (skipped), value calculated using timer frequency.. 7603.70 BogoMIPS (lpj=12666720)
Jun 11 20:15:39 hyperv kernel: pid_max: default: 32768 minimum: 301
Jun 11 20:15:39 hyperv kernel: LSM: Security Framework initializing
Jun 11 20:15:39 hyperv kernel: Yama: becoming mindful.
Jun 11 20:15:39 hyperv kernel: LSM support for eBPF active
Jun 11 20:15:39 hyperv kernel: Mount-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Jun 11 20:15:39 hyperv kernel: Mountpoint-cache hash table entries: 4096 (order: 3, 32768 bytes, linear)
Jun 11 20:15:39 hyperv kernel: Last level iTLB entries: 4KB 1024, 2MB 1024, 4MB 512
Jun 11 20:15:39 hyperv kernel: Last level dTLB entries: 4KB 2048, 2MB 2048, 4MB 1024, 1GB 0
Jun 11 20:15:39 hyperv kernel: Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
Jun 11 20:15:39 hyperv kernel: Spectre V2 : Mitigation: Full AMD retpoline
Jun 11 20:15:39 hyperv kernel: Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
Jun 11 20:15:39 hyperv kernel: Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
Jun 11 20:15:39 hyperv kernel: Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
Jun 11 20:15:39 hyperv kernel: Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl and seccomp
Jun 11 20:15:39 hyperv kernel: Freeing SMP alternatives memory: 40K
Jun 11 20:15:39 hyperv kernel: smpboot: CPU0: AMD Ryzen 9 3900X 12-Core Processor (family: 0x17, model: 0x71, stepping: 0x0)
Jun 11 20:15:39 hyperv kernel: Performance Events: PMU not available due to virtualization, using software events only.
Jun 11 20:15:39 hyperv kernel: rcu: Hierarchical SRCU implementation.
Jun 11 20:15:39 hyperv kernel: NMI watchdog: Perf NMI watchdog permanently disabled
Jun 11 20:15:39 hyperv kernel: smp: Bringing up secondary CPUs ...
Jun 11 20:15:39 hyperv kernel: x86: Booting SMP configuration:
Jun 11 20:15:39 hyperv kernel: .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6
Jun 11 20:15:39 hyperv kernel: random: fast init done
Jun 11 20:15:39 hyperv kernel:   #7  #8  #9 #10 #11
Jun 11 20:15:39 hyperv kernel: smp: Brought up 1 node, 12 CPUs
Jun 11 20:15:39 hyperv kernel: smpboot: Max logical packages: 1
Jun 11 20:15:39 hyperv kernel: smpboot: Total of 12 processors activated (91330.19 BogoMIPS)
Jun 11 20:15:39 hyperv kernel: devtmpfs: initialized
Jun 11 20:15:39 hyperv kernel: x86/mm: Memory block size: 128MB
Jun 11 20:15:39 hyperv kernel: ACPI: PM: Registering ACPI NVS region [mem 0x5fffb000-0x5fffefff] (16384 bytes)
Jun 11 20:15:39 hyperv kernel: clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
Jun 11 20:15:39 hyperv kernel: futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
Jun 11 20:15:39 hyperv kernel: pinctrl core: initialized pinctrl subsystem
Jun 11 20:15:39 hyperv kernel: PM: RTC time: 03:15:38, date: 2021-06-12
Jun 11 20:15:39 hyperv kernel: NET: Registered protocol family 16
Jun 11 20:15:39 hyperv kernel: DMA: preallocated 256 KiB GFP_KERNEL pool for atomic allocations
Jun 11 20:15:39 hyperv kernel: DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
Jun 11 20:15:39 hyperv kernel: DMA: preallocated 256 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
Jun 11 20:15:39 hyperv kernel: audit: initializing netlink subsys (disabled)
Jun 11 20:15:39 hyperv kernel: audit: type=2000 audit(1623467737.916:1): state=initialized audit_enabled=0 res=1
Jun 11 20:15:39 hyperv kernel: thermal_sys: Registered thermal governor 'fair_share'
Jun 11 20:15:39 hyperv kernel: thermal_sys: Registered thermal governor 'bang_bang'
Jun 11 20:15:39 hyperv kernel: thermal_sys: Registered thermal governor 'step_wise'
Jun 11 20:15:39 hyperv kernel: thermal_sys: Registered thermal governor 'user_space'
Jun 11 20:15:39 hyperv kernel: thermal_sys: Registered thermal governor 'power_allocator'
Jun 11 20:15:39 hyperv kernel: cpuidle: using governor ladder
Jun 11 20:15:39 hyperv kernel: cpuidle: using governor menu
Jun 11 20:15:39 hyperv kernel: ACPI: bus type PCI registered
Jun 11 20:15:39 hyperv kernel: acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
Jun 11 20:15:39 hyperv kernel: Kprobes globally optimized
Jun 11 20:15:39 hyperv kernel: HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
Jun 11 20:15:39 hyperv kernel: HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(Module Device)
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(Processor Device)
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(3.0 _SCP Extensions)
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(Processor Aggregator Device)
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(Linux-Dell-Video)
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
Jun 11 20:15:39 hyperv kernel: ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
Jun 11 20:15:39 hyperv kernel: ACPI: 1 ACPI AML tables successfully acquired and loaded
Jun 11 20:15:39 hyperv kernel: ACPI: Interpreter enabled
Jun 11 20:15:39 hyperv kernel: ACPI: PM: (supports S0 S5)
Jun 11 20:15:39 hyperv kernel: ACPI: Using IOAPIC for interrupt routing
Jun 11 20:15:39 hyperv kernel: PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
Jun 11 20:15:39 hyperv kernel: ACPI: Enabled 1 GPEs in block 00 to 0F
Jun 11 20:15:39 hyperv kernel: iommu: Default domain type: Translated 
Jun 11 20:15:39 hyperv kernel: vgaarb: loaded
Jun 11 20:15:39 hyperv kernel: SCSI subsystem initialized
Jun 11 20:15:39 hyperv kernel: libata version 3.00 loaded.
Jun 11 20:15:39 hyperv kernel: ACPI: bus type USB registered
Jun 11 20:15:39 hyperv kernel: usbcore: registered new interface driver usbfs
Jun 11 20:15:39 hyperv kernel: usbcore: registered new interface driver hub
Jun 11 20:15:39 hyperv kernel: usbcore: registered new device driver usb
Jun 11 20:15:39 hyperv kernel: pps_core: LinuxPPS API ver. 1 registered
Jun 11 20:15:39 hyperv kernel: pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
Jun 11 20:15:39 hyperv kernel: PTP clock support registered
Jun 11 20:15:39 hyperv kernel: EDAC MC: Ver: 3.0.0
Jun 11 20:15:39 hyperv kernel: Registered efivars operations
Jun 11 20:15:39 hyperv kernel: NetLabel: Initializing
Jun 11 20:15:39 hyperv kernel: NetLabel:  domain hash size = 128
Jun 11 20:15:39 hyperv kernel: NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
Jun 11 20:15:39 hyperv kernel: NetLabel:  unlabeled traffic allowed by default
Jun 11 20:15:39 hyperv kernel: PCI: Using ACPI for IRQ routing
Jun 11 20:15:39 hyperv kernel: PCI: System does not support PCI
Jun 11 20:15:39 hyperv kernel: clocksource: Switched to clocksource hyperv_clocksource_tsc_page
Jun 11 20:15:39 hyperv kernel: VFS: Disk quotas dquot_6.6.0
Jun 11 20:15:39 hyperv kernel: VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Jun 11 20:15:39 hyperv kernel: pnp: PnP ACPI init
Jun 11 20:15:39 hyperv kernel: pnp: PnP ACPI: found 1 devices
Jun 11 20:15:39 hyperv kernel: clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
Jun 11 20:15:39 hyperv kernel: NET: Registered protocol family 2
Jun 11 20:15:39 hyperv kernel: IP idents hash table entries: 32768 (order: 6, 262144 bytes, linear)
Jun 11 20:15:39 hyperv kernel: tcp_listen_portaddr_hash hash table entries: 1024 (order: 2, 16384 bytes, linear)
Jun 11 20:15:39 hyperv kernel: TCP established hash table entries: 16384 (order: 5, 131072 bytes, linear)
Jun 11 20:15:39 hyperv kernel: TCP bind hash table entries: 16384 (order: 6, 262144 bytes, linear)
Jun 11 20:15:39 hyperv kernel: TCP: Hash tables configured (established 16384 bind 16384)
Jun 11 20:15:39 hyperv kernel: MPTCP token hash table entries: 2048 (order: 3, 49152 bytes, linear)
Jun 11 20:15:39 hyperv kernel: UDP hash table entries: 1024 (order: 3, 32768 bytes, linear)
Jun 11 20:15:39 hyperv kernel: UDP-Lite hash table entries: 1024 (order: 3, 32768 bytes, linear)
Jun 11 20:15:39 hyperv kernel: NET: Registered protocol family 1
Jun 11 20:15:39 hyperv kernel: NET: Registered protocol family 44
Jun 11 20:15:39 hyperv kernel: PCI: CLS 0 bytes, default 64
Jun 11 20:15:39 hyperv kernel: PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Jun 11 20:15:39 hyperv kernel: software IO TLB: mapped [mem 0x0000000057800000-0x000000005b800000] (64MB)
Jun 11 20:15:39 hyperv kernel: Unpacking initramfs...
Jun 11 20:15:39 hyperv kernel: Initialise system trusted keyrings
Jun 11 20:15:39 hyperv kernel: Key type blacklist registered
Jun 11 20:15:39 hyperv kernel: workingset: timestamp_bits=41 max_order=19 bucket_order=0
Jun 11 20:15:39 hyperv kernel: zbud: loaded
Jun 11 20:15:39 hyperv kernel: Key type asymmetric registered
Jun 11 20:15:39 hyperv kernel: Asymmetric key parser 'x509' registered
Jun 11 20:15:39 hyperv kernel: Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
Jun 11 20:15:39 hyperv kernel: io scheduler mq-deadline registered
Jun 11 20:15:39 hyperv kernel: io scheduler kyber registered
Jun 11 20:15:39 hyperv kernel: io scheduler bfq registered
Jun 11 20:15:39 hyperv kernel: shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
Jun 11 20:15:39 hyperv kernel: efifb: probing for efifb
Jun 11 20:15:39 hyperv kernel: efifb: framebuffer at 0xf8000000, using 3072k, total 3072k
Jun 11 20:15:39 hyperv kernel: efifb: mode is 1024x768x32, linelength=4096, pages=1
Jun 11 20:15:39 hyperv kernel: efifb: scrolling: redraw
Jun 11 20:15:39 hyperv kernel: efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Jun 11 20:15:39 hyperv kernel: fbcon: Deferring console take-over
Jun 11 20:15:39 hyperv kernel: fb0: EFI VGA frame buffer device
Jun 11 20:15:39 hyperv kernel: Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
Jun 11 20:15:39 hyperv kernel: Non-volatile memory driver v1.3
Jun 11 20:15:39 hyperv kernel: AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
Jun 11 20:15:39 hyperv kernel: AMD-Vi: AMD IOMMUv2 functionality not available on this system
Jun 11 20:15:39 hyperv kernel: ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
Jun 11 20:15:39 hyperv kernel: ehci-pci: EHCI PCI platform driver
Jun 11 20:15:39 hyperv kernel: ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
Jun 11 20:15:39 hyperv kernel: ohci-pci: OHCI PCI platform driver
Jun 11 20:15:39 hyperv kernel: uhci_hcd: USB Universal Host Controller Interface driver
Jun 11 20:15:39 hyperv kernel: usbcore: registered new interface driver usbserial_generic
Jun 11 20:15:39 hyperv kernel: usbserial: USB Serial support registered for generic
Jun 11 20:15:39 hyperv kernel: rtc_cmos 00:00: RTC can wake from S4
Jun 11 20:15:39 hyperv kernel: rtc_cmos 00:00: registered as rtc0
Jun 11 20:15:39 hyperv kernel: rtc_cmos 00:00: setting system clock to 2021-06-12T03:15:38 UTC (1623467738)
Jun 11 20:15:39 hyperv kernel: rtc_cmos 00:00: alarms up to one month, 114 bytes nvram
Jun 11 20:15:39 hyperv kernel: ledtrig-cpu: registered to indicate activity on CPUs
Jun 11 20:15:39 hyperv kernel: hid: raw HID events driver (C) Jiri Kosina
Jun 11 20:15:39 hyperv kernel: drop_monitor: Initializing network drop monitor service
Jun 11 20:15:39 hyperv kernel: Initializing XFRM netlink socket
Jun 11 20:15:39 hyperv kernel: NET: Registered protocol family 10
Jun 11 20:15:39 hyperv kernel: Freeing initrd memory: 7620K
Jun 11 20:15:39 hyperv kernel: Segment Routing with IPv6
Jun 11 20:15:39 hyperv kernel: RPL Segment Routing with IPv6
Jun 11 20:15:39 hyperv kernel: NET: Registered protocol family 17
Jun 11 20:15:39 hyperv kernel: IPI shorthand broadcast: enabled
Jun 11 20:15:39 hyperv kernel: registered taskstats version 1
Jun 11 20:15:39 hyperv kernel: Loading compiled-in X.509 certificates
Jun 11 20:15:39 hyperv kernel: Loaded X.509 cert 'Build time autogenerated kernel key: f5b021a8b3f2573f50186584c9d698e8723ec3cb'
Jun 11 20:15:39 hyperv kernel: zswap: loaded using pool lz4/z3fold
Jun 11 20:15:39 hyperv kernel: Key type ._fscrypt registered
Jun 11 20:15:39 hyperv kernel: Key type .fscrypt registered
Jun 11 20:15:39 hyperv kernel: Key type fscrypt-provisioning registered
Jun 11 20:15:39 hyperv kernel: PM:   Magic number: 9:934:259
Jun 11 20:15:39 hyperv kernel: RAS: Correctable Errors collector initialized.
Jun 11 20:15:39 hyperv kernel: Unstable clock detected, switching default tracing clock to "global"
                               If you want to keep using the local clock, then add:
                                 "trace_clock=local"
                               on the kernel command line
Jun 11 20:15:39 hyperv kernel: Freeing unused decrypted memory: 2036K
Jun 11 20:15:39 hyperv kernel: Freeing unused kernel image (initmem) memory: 1864K
Jun 11 20:15:39 hyperv kernel: Write protecting the kernel read-only data: 22528k
Jun 11 20:15:39 hyperv kernel: Freeing unused kernel image (text/rodata gap) memory: 2036K
Jun 11 20:15:39 hyperv kernel: Freeing unused kernel image (rodata/data gap) memory: 1560K
Jun 11 20:15:39 hyperv kernel: x86/mm: Checked W+X mappings: passed, no W+X pages found.
Jun 11 20:15:39 hyperv kernel: rodata_test: all tests were successful
Jun 11 20:15:39 hyperv kernel: Run /init as init process
Jun 11 20:15:39 hyperv kernel:   with arguments:
Jun 11 20:15:39 hyperv kernel:     /init
Jun 11 20:15:39 hyperv kernel:   with environment:
Jun 11 20:15:39 hyperv kernel:     HOME=/
Jun 11 20:15:39 hyperv kernel:     TERM=linux
Jun 11 20:15:39 hyperv kernel: fbcon: Taking over console
Jun 11 20:15:39 hyperv kernel: Console: switching to colour frame buffer device 128x48
Jun 11 20:15:39 hyperv kernel: hv_vmbus: Vmbus version:5.2
Jun 11 20:15:39 hyperv kernel: hv_vmbus: registering driver hid_hyperv
Jun 11 20:15:39 hyperv kernel: input: Microsoft Vmbus HID-compliant Mouse as /devices/0006:045E:0621.0001/input/input0
Jun 11 20:15:39 hyperv kernel: hid-generic 0006:045E:0621.0001: input: VIRTUAL HID v0.01 Mouse [Microsoft Vmbus HID-compliant Mouse] on 
Jun 11 20:15:39 hyperv kernel: hv_vmbus: registering driver hyperv_keyboard
Jun 11 20:15:39 hyperv kernel: hv_vmbus: registering driver hv_storvsc
Jun 11 20:15:39 hyperv kernel: scsi host0: storvsc_host_t
Jun 11 20:15:39 hyperv kernel: input: AT Translated Set 2 keyboard as /devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/VMBUS:00/d34b2567-b9b6-42b9-8778-0a4ec0b955bf/serio0/input/input1
Jun 11 20:15:39 hyperv kernel: scsi 0:0:0:0: Direct-Access     Msft     Virtual Disk     1.0  PQ: 0 ANSI: 5
Jun 11 20:15:39 hyperv kernel: scsi 0:0:0:1: CD-ROM            Msft     Virtual DVD-ROM  1.0  PQ: 0 ANSI: 0
Jun 11 20:15:39 hyperv kernel: sd 0:0:0:0: [sda] 314572800 512-byte logical blocks: (161 GB/150 GiB)
Jun 11 20:15:39 hyperv kernel: sd 0:0:0:0: [sda] 4096-byte physical blocks
Jun 11 20:15:39 hyperv kernel: sd 0:0:0:0: [sda] Write Protect is off
Jun 11 20:15:39 hyperv kernel: sd 0:0:0:0: [sda] Mode Sense: 0f 00 00 00
Jun 11 20:15:39 hyperv kernel: sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
Jun 11 20:15:39 hyperv kernel:  sda: sda1 sda2
Jun 11 20:15:39 hyperv kernel: sd 0:0:0:0: [sda] Attached SCSI disk
Jun 11 20:15:39 hyperv kernel: sr 0:0:0:1: [sr0] scsi-1 drive
Jun 11 20:15:39 hyperv kernel: cdrom: Uniform CD-ROM driver Revision: 3.20
Jun 11 20:15:39 hyperv kernel: sr 0:0:0:1: Attached scsi CD-ROM sr0
Jun 11 20:15:39 hyperv kernel: SGI XFS with ACLs, security attributes, realtime, scrub, repair, quota, no debug enabled
Jun 11 20:15:39 hyperv kernel: XFS (sda2): Mounting V5 Filesystem
Jun 11 20:15:39 hyperv kernel: XFS (sda2): Ending clean mount
Jun 11 20:15:39 hyperv kernel: xfs filesystem being mounted at /new_root supports timestamps until 2038 (0x7fffffff)
Jun 11 20:15:39 hyperv systemd[1]: systemd 248.3-2-arch running in system mode. (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBFDISK +PCRE2 -PWQUALITY +P11KIT -QRENCODE +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +XKBCOMMON +UTMP -SYSVINIT default-hierarchy=unified)
Jun 11 20:15:39 hyperv systemd[1]: Detected virtualization microsoft.
Jun 11 20:15:39 hyperv systemd[1]: Detected architecture x86-64.
Jun 11 20:15:39 hyperv systemd[1]: Hostname set to <hyperv>.
Jun 11 20:15:39 hyperv systemd-fstab-generator[250]: Mount point  is not a valid path, ignoring.
Jun 11 20:15:39 hyperv systemd-fstab-generator[250]: Mount point  is not a valid path, ignoring.
Jun 11 20:15:39 hyperv kernel: random: lvmconfig: uninitialized urandom read (4 bytes read)
Jun 11 20:15:39 hyperv systemd[1]: Queued start job for default target Graphical Interface.
Jun 11 20:15:39 hyperv systemd[1]: Created slice system-getty.slice.
Jun 11 20:15:39 hyperv systemd[1]: Created slice system-modprobe.slice.
Jun 11 20:15:39 hyperv systemd[1]: Created slice system-systemd\x2dfsck.slice.
Jun 11 20:15:39 hyperv systemd[1]: Created slice User and Session Slice.
Jun 11 20:15:39 hyperv systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
Jun 11 20:15:39 hyperv systemd[1]: Started Forward Password Requests to Wall Directory Watch.
Jun 11 20:15:39 hyperv systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Local Encrypted Volumes.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Login Prompts.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Paths.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Remote File Systems.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Slices.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Swap.
Jun 11 20:15:39 hyperv systemd[1]: Reached target Local Verity Integrity Protected Volumes.
Jun 11 20:15:39 hyperv systemd[1]: Listening on Device-mapper event daemon FIFOs.
Jun 11 20:15:39 hyperv systemd[1]: Listening on LVM2 poll daemon socket.
Jun 11 20:15:39 hyperv systemd[1]: Listening on Process Core Dump Socket.
Jun 11 20:15:39 hyperv systemd[1]: Listening on Journal Audit Socket.
Jun 11 20:15:39 hyperv systemd[1]: Listening on Journal Socket (/dev/log).
Jun 11 20:15:39 hyperv systemd[1]: Listening on Journal Socket.
Jun 11 20:15:39 hyperv systemd[1]: Listening on Network Service Netlink Socket.
Jun 11 20:15:39 hyperv systemd[1]: Listening on udev Control Socket.
Jun 11 20:15:39 hyperv systemd[1]: Listening on udev Kernel Socket.
Jun 11 20:15:39 hyperv systemd[1]: Mounting Huge Pages File System...
Jun 11 20:15:39 hyperv systemd[1]: Mounting POSIX Message Queue File System...
Jun 11 20:15:39 hyperv systemd[1]: Mounting Kernel Debug File System...
Jun 11 20:15:39 hyperv systemd[1]: Mounting Kernel Trace File System...
Jun 11 20:15:39 hyperv systemd[1]: Starting Create list of static device nodes for the current kernel...
Jun 11 20:15:39 hyperv systemd[1]: Starting Monitoring of LVM2 mirrors, snapshots etc. using dmeventd or progress polling...
Jun 11 20:15:39 hyperv systemd[1]: Starting Load Kernel Module configfs...
Jun 11 20:15:39 hyperv systemd[1]: Starting Load Kernel Module drm...
Jun 11 20:15:39 hyperv kernel: random: lvm: uninitialized urandom read (4 bytes read)
Jun 11 20:15:39 hyperv systemd[1]: Starting Load Kernel Module fuse...
Jun 11 20:15:39 hyperv systemd[1]: Starting Set Up Additional Binary Formats...
Jun 11 20:15:39 hyperv systemd[1]: Condition check resulted in File System Check on Root Device being skipped.
Jun 11 20:15:39 hyperv systemd[1]: Starting Journal Service...
Jun 11 20:15:39 hyperv systemd[1]: Starting Load Kernel Modules...
Jun 11 20:15:39 hyperv systemd[1]: Starting Remount Root and Kernel File Systems...
Jun 11 20:15:39 hyperv systemd[1]: Condition check resulted in Repartition Root Disk being skipped.
Jun 11 20:15:39 hyperv systemd[1]: Starting Coldplug All udev Devices...
Jun 11 20:15:39 hyperv systemd[1]: Mounted Huge Pages File System.
Jun 11 20:15:39 hyperv systemd[1]: Mounted POSIX Message Queue File System.
Jun 11 20:15:39 hyperv systemd[1]: Mounted Kernel Debug File System.
Jun 11 20:15:39 hyperv systemd[1]: Mounted Kernel Trace File System.
Jun 11 20:15:39 hyperv systemd[1]: Finished Create list of static device nodes for the current kernel.
Jun 11 20:15:39 hyperv systemd[1]: modprobe@configfs.service: Deactivated successfully.
Jun 11 20:15:39 hyperv systemd[1]: Finished Load Kernel Module configfs.
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.176:2): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv kernel: audit: type=1131 audit(1623467739.176:3): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@configfs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv systemd[1]: proc-sys-fs-binfmt_misc.automount: Got automount request for /proc/sys/fs/binfmt_misc, triggered by 267 (systemd-binfmt)
Jun 11 20:15:39 hyperv kernel: fuse: init (API version 7.33)
Jun 11 20:15:39 hyperv kernel: xfs filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
Jun 11 20:15:39 hyperv systemd[1]: Mounting Arbitrary Executable File Formats File System...
Jun 11 20:15:39 hyperv systemd[1]: Mounting Kernel Configuration File System...
Jun 11 20:15:39 hyperv kernel: Asymmetric key parser 'pkcs8' registered
Jun 11 20:15:39 hyperv systemd[1]: modprobe@fuse.service: Deactivated successfully.
Jun 11 20:15:39 hyperv systemd[1]: Finished Load Kernel Module fuse.
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.179:4): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv kernel: audit: type=1131 audit(1623467739.179:5): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=modprobe@fuse comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv systemd[1]: Finished Load Kernel Modules.
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.179:6): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-modules-load comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv systemd[1]: Finished Remount Root and Kernel File Systems.
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.179:7): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-remount-fs comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv systemd[1]: Mounted Arbitrary Executable File Formats File System.
Jun 11 20:15:39 hyperv systemd[1]: Mounted Kernel Configuration File System.
Jun 11 20:15:39 hyperv systemd[1]: Mounting FUSE Control File System...
Jun 11 20:15:39 hyperv systemd[1]: Condition check resulted in First Boot Wizard being skipped.
Jun 11 20:15:39 hyperv systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
Jun 11 20:15:39 hyperv systemd[1]: Starting Load/Save Random Seed...
Jun 11 20:15:39 hyperv systemd[1]: Starting Apply Kernel Variables...
Jun 11 20:15:39 hyperv systemd[1]: Starting Create System Users...
Jun 11 20:15:39 hyperv systemd[1]: Started Journal Service.
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.186:8): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-journald comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.186:9): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-binfmt comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv kernel: audit: type=1130 audit(1623467739.189:10): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=systemd-sysctl comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:39 hyperv kernel: input: PC Speaker as /devices/platform/pcspkr/input/input2
Jun 11 20:15:39 hyperv kernel: mousedev: PS/2 mouse device common for all mice
Jun 11 20:15:42 hyperv kernel: hv_vmbus: registering driver hyperv_fb
Jun 11 20:15:42 hyperv kernel: hv_vmbus: registering driver hv_balloon
Jun 11 20:15:42 hyperv kernel: hv_utils: Registering HyperV Utility Driver
Jun 11 20:15:42 hyperv kernel: hv_vmbus: registering driver hv_utils
Jun 11 20:15:42 hyperv kernel: hyperv_fb: Synthvid Version major 3, minor 5
Jun 11 20:15:42 hyperv kernel: hv_balloon: Using Dynamic Memory protocol version 2.0
Jun 11 20:15:42 hyperv kernel: hyperv_fb: Screen resolution: 1920x1080, Color depth: 32
Jun 11 20:15:42 hyperv kernel: hv_utils: Shutdown IC version 3.2
Jun 11 20:15:42 hyperv kernel: hv_utils: TimeSync IC version 4.0
Jun 11 20:15:42 hyperv kernel: hv_utils: VSS IC version 5.0
Jun 11 20:15:42 hyperv kernel: checking generic (f8000000 300000) vs hw (f8000000 300000)
Jun 11 20:15:42 hyperv kernel: fb0: switching to hyperv_fb from EFI VGA
Jun 11 20:15:42 hyperv kernel: Console: switching to colour dummy device 80x25
Jun 11 20:15:42 hyperv kernel: Console: switching to colour frame buffer device 240x67
Jun 11 20:15:42 hyperv kernel: hv_vmbus: registering driver hv_netvsc
Jun 11 20:15:42 hyperv kernel: cryptd: max_cpu_qlen set to 1000
Jun 11 20:15:42 hyperv kernel: AVX2 version of gcm_enc/dec engaged.
Jun 11 20:15:42 hyperv kernel: AES CTR mode by8 optimization enabled
Jun 11 20:15:42 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:42 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:42 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
Jun 11 20:15:43 hyperv kernel: random: dbus-daemon: uninitialized urandom read (12 bytes read)
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:43 hyperv kernel: Decoding supported only on Scalable MCA processors.
Jun 11 20:15:44 hyperv kernel: random: crng init done
Jun 11 20:15:44 hyperv kernel: random: 1 urandom warning(s) missed due to ratelimiting
Jun 11 20:15:44 hyperv kernel: hv_utils: Heartbeat IC version 3.0
Jun 11 20:15:56 hyperv kernel: kauditd_printk_skb: 48 callbacks suppressed
Jun 11 20:15:56 hyperv kernel: audit: type=1100 audit(1623467756.692:55): pid=450 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:authentication grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="nathan" exe="/usr/lib/sddm/sddm-helper" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:56 hyperv kernel: audit: type=1101 audit(1623467756.692:56): pid=450 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="nathan" exe="/usr/lib/sddm/sddm-helper" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:56 hyperv kernel: audit: type=1103 audit(1623467756.692:57): pid=450 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=pam_shells,pam_faillock,pam_permit,pam_faillock acct="nathan" exe="/usr/lib/sddm/sddm-helper" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:56 hyperv kernel: audit: type=1006 audit(1623467756.692:58): pid=450 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=2 res=1
Jun 11 20:15:56 hyperv kernel: audit: type=1300 audit(1623467756.692:58): arch=c000003e syscall=1 success=yes exit=4 a0=8 a1=7ffdeb98b870 a2=4 a3=3e8 items=0 ppid=368 pid=450 auid=1000 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=2 comm="sddm-helper" exe="/usr/lib/sddm/sddm-helper" key=(null)
Jun 11 20:15:56 hyperv kernel: audit: type=1327 audit(1623467756.692:58): proctitle=2F7573722F6C69622F7364646D2F7364646D2D68656C706572002D2D736F636B6574002F746D702F7364646D2D6175746837633433633864352D613933662D346131372D613131302D666363313237363465323963002D2D69640031002D2D7374617274002F7573722F62696E2F7374617274706C61736D612D783131002D2D
Jun 11 20:15:56 hyperv kernel: audit: type=1130 audit(1623467756.702:59): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@1000 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:56 hyperv kernel: audit: type=1101 audit(1623467756.705:60): pid=452 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:accounting grantors=pam_access,pam_unix,pam_permit,pam_time acct="nathan" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:15:56 hyperv kernel: audit: type=1103 audit(1623467756.705:61): pid=452 uid=0 auid=4294967295 ses=4294967295 msg='op=PAM:setcred grantors=? acct="nathan" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=failed'
Jun 11 20:15:56 hyperv kernel: audit: type=1006 audit(1623467756.705:62): pid=452 uid=0 old-auid=4294967295 auid=1000 tty=(none) old-ses=4294967295 ses=3 res=1
Jun 11 20:16:06 hyperv kernel: kauditd_printk_skb: 17 callbacks suppressed
Jun 11 20:16:06 hyperv kernel: audit: type=1131 audit(1623467766.898:76): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user@974 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:16:06 hyperv kernel: audit: type=1131 audit(1623467766.925:77): pid=1 uid=0 auid=4294967295 ses=4294967295 msg='unit=user-runtime-dir@974 comm="systemd" exe="/usr/lib/systemd/systemd" hostname=? addr=? terminal=? res=success'
Jun 11 20:16:12 hyperv kernel: audit: type=1100 audit(1623467772.648:78): pid=997 uid=1000 auid=1000 ses=2 msg='op=PAM:authentication grantors=pam_faillock,pam_permit,pam_faillock acct="nathan" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:12 hyperv kernel: audit: type=1101 audit(1623467772.655:79): pid=997 uid=1000 auid=1000 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="nathan" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:12 hyperv kernel: audit: type=1110 audit(1623467772.655:80): pid=997 uid=1000 auid=1000 ses=2 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:12 hyperv kernel: audit: type=1105 audit(1623467772.655:81): pid=997 uid=1000 auid=1000 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:13 hyperv kernel: audit: type=1106 audit(1623467773.948:82): pid=997 uid=1000 auid=1000 ses=2 msg='op=PAM:session_close grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:13 hyperv kernel: audit: type=1104 audit(1623467773.948:83): pid=997 uid=1000 auid=1000 ses=2 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_faillock acct="root" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:16 hyperv kernel: audit: type=1101 audit(1623467776.955:84): pid=1041 uid=1000 auid=1000 ses=2 msg='op=PAM:accounting grantors=pam_unix,pam_permit,pam_time acct="nathan" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:16 hyperv kernel: audit: type=1110 audit(1623467776.955:85): pid=1041 uid=1000 auid=1000 ses=2 msg='op=PAM:setcred grantors=pam_faillock,pam_permit,pam_env,pam_faillock acct="root" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:17 hyperv kernel: audit: type=1105 audit(1623467776.955:86): pid=1041 uid=1000 auid=1000 ses=2 msg='op=PAM:session_open grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/doas" hostname=hyperv addr=? terminal=pts/1 res=success'
Jun 11 20:16:31 hyperv kernel: hv_balloon: Max. dynamic memory size: 1048576 MB
Jun 11 20:16:32 hyperv kernel: kworker/0:2: vmemmap alloc failure: order:9, mode:0x4cc0(GFP_KERNEL|__GFP_RETRY_MAYFAIL), nodemask=(null),cpuset=/,mems_allowed=0
Jun 11 20:16:32 hyperv kernel: CPU: 0 PID: 201 Comm: kworker/0:2 Not tainted 5.13.0-rc5-next-20210611-llvm #1
Jun 11 20:16:32 hyperv kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
Jun 11 20:16:32 hyperv kernel: Workqueue: events hot_add_req [hv_balloon]
Jun 11 20:16:32 hyperv kernel: Call Trace:
Jun 11 20:16:32 hyperv kernel:  dump_stack_lvl+0x64/0x95
Jun 11 20:16:32 hyperv kernel:  warn_alloc+0x10a/0x170
Jun 11 20:16:32 hyperv kernel:  vmemmap_alloc_block+0xd4/0xe5
Jun 11 20:16:32 hyperv kernel:  vmemmap_populate_hugepages+0x151/0x377
Jun 11 20:16:32 hyperv kernel:  vmemmap_populate+0xa6/0xa8
Jun 11 20:16:32 hyperv kernel:  __populate_section_memmap+0x29/0x41
Jun 11 20:16:32 hyperv kernel:  section_activate+0x136/0x1a8
Jun 11 20:16:32 hyperv kernel:  sparse_add_section+0x65/0x103
Jun 11 20:16:32 hyperv kernel:  __add_pages+0xbf/0x120
Jun 11 20:16:32 hyperv kernel:  arch_add_memory+0x49/0xa0
Jun 11 20:16:32 hyperv kernel:  add_memory_resource+0x145/0x380
Jun 11 20:16:32 hyperv kernel:  __add_memory+0x3c/0x60
Jun 11 20:16:32 hyperv kernel:  add_memory+0x2b/0x40
Jun 11 20:16:32 hyperv kernel:  handle_pg_range+0x1cb/0x2c0 [hv_balloon]
Jun 11 20:16:32 hyperv kernel:  hot_add_req+0x21e/0x340 [hv_balloon]
Jun 11 20:16:32 hyperv kernel:  process_one_work+0x187/0x330
Jun 11 20:16:32 hyperv kernel:  worker_thread+0x26d/0x4a0
Jun 11 20:16:32 hyperv kernel:  kthread+0x154/0x180
Jun 11 20:16:32 hyperv kernel:  ? worker_clr_flags+0x50/0x50
Jun 11 20:16:32 hyperv kernel:  ? kthread_blkcg+0x30/0x30
Jun 11 20:16:32 hyperv kernel:  ret_from_fork+0x22/0x30
Jun 11 20:16:32 hyperv kernel: Mem-Info:
Jun 11 20:16:32 hyperv kernel: active_anon:258 inactive_anon:179985 isolated_anon:0
                                active_file:3169 inactive_file:92358 isolated_file:0
                                unevictable:8 dirty:17 writeback:0
                                slab_reclaimable:24513 slab_unreclaimable:16311
                                mapped:69043 shmem:12642 pagetables:4097 bounce:0
                                free:18819 free_pcp:145 free_cma:0
Jun 11 20:16:32 hyperv kernel: Node 0 active_anon:1032kB inactive_anon:719940kB active_file:12676kB inactive_file:369432kB unevictable:32kB isolated(anon):0kB isolated(file):0kB mapped:276172kB dirty:68kB writeback:0kB shmem:50568kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7200kB pagetables:16388kB all_unreclaimable? no
Jun 11 20:16:32 hyperv kernel: Node 0 DMA free:6092kB min:484kB low:604kB high:724kB reserved_highatomic:0KB active_anon:0kB inactive_anon:8676kB active_file:0kB inactive_file:240kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
Jun 11 20:16:32 hyperv kernel: lowmem_reserve[]: 0 1375 1375 1375 1375
Jun 11 20:16:32 hyperv kernel: Node 0 DMA32 free:69184kB min:44568kB low:55708kB high:66848kB reserved_highatomic:0KB active_anon:1032kB inactive_anon:711264kB active_file:12676kB inactive_file:369368kB unevictable:32kB writepending:68kB present:1555760kB managed:1423464kB mlocked:32kB bounce:0kB free_pcp:580kB local_pcp:0kB free_cma:0kB
Jun 11 20:16:32 hyperv kernel: lowmem_reserve[]: 0 0 0 0 0
Jun 11 20:16:32 hyperv kernel: Node 0 DMA: 4*4kB (UM) 6*8kB (UME) 5*16kB (UE) 4*32kB (UM) 3*64kB (ME) 2*128kB (ME) 1*256kB (E) 2*512kB (UE) 2*1024kB (ME) 1*2048kB (E) 0*4096kB = 6096kB
Jun 11 20:16:32 hyperv kernel: Node 0 DMA32: 3676*4kB (UME) 1221*8kB (UME) 776*16kB (UME) 497*32kB (UME) 192*64kB (UME) 41*128kB (UME) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 70328kB
Jun 11 20:16:32 hyperv kernel: Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Jun 11 20:16:32 hyperv kernel: Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Jun 11 20:16:32 hyperv kernel: 108229 total pagecache pages
Jun 11 20:16:32 hyperv kernel: 0 pages in swap cache
Jun 11 20:16:32 hyperv kernel: Swap cache stats: add 0, delete 0, find 0/0
Jun 11 20:16:32 hyperv kernel: Free swap  = 0kB
Jun 11 20:16:32 hyperv kernel: Total swap = 0kB
Jun 11 20:16:32 hyperv kernel: 392939 pages RAM
Jun 11 20:16:32 hyperv kernel: 0 pages HighMem/MovableOnly
Jun 11 20:16:32 hyperv kernel: 33233 pages reserved
Jun 11 20:16:32 hyperv kernel: 0 pages cma reserved
Jun 11 20:16:32 hyperv kernel: 0 pages hwpoisoned
Jun 11 20:16:32 hyperv kernel: Built 1 zonelists, mobility grouping on.  Total pages: 375581
Jun 11 20:16:32 hyperv kernel: Policy zone: Normal
Jun 11 20:16:50 hyperv kernel: TCP: eth0: Driver has suspect GRO implementation, TCP performance may be compromised.
Jun 11 20:17:20 hyperv kernel: llvm-tblgen invoked oom-killer: gfp_mask=0x1100cca(GFP_HIGHUSER_MOVABLE), order=0, oom_score_adj=0
Jun 11 20:17:20 hyperv kernel: CPU: 4 PID: 4749 Comm: llvm-tblgen Not tainted 5.13.0-rc5-next-20210611-llvm #1
Jun 11 20:17:20 hyperv kernel: Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.0 11/01/2019
Jun 11 20:17:20 hyperv kernel: Call Trace:
Jun 11 20:17:20 hyperv kernel:  dump_stack_lvl+0x64/0x95
Jun 11 20:17:20 hyperv kernel:  dump_header+0x50/0x240
Jun 11 20:17:20 hyperv kernel:  oom_kill_process+0x126/0x230
Jun 11 20:17:20 hyperv kernel:  out_of_memory+0x2f7/0x410
Jun 11 20:17:20 hyperv kernel:  __alloc_pages_slowpath+0x6e2/0x930
Jun 11 20:17:20 hyperv kernel:  __alloc_pages+0x25d/0x350
Jun 11 20:17:20 hyperv kernel:  pagecache_get_page+0x2d5/0x530
Jun 11 20:17:20 hyperv kernel:  filemap_fault+0x1d3/0x360
Jun 11 20:17:20 hyperv kernel:  __xfs_filemap_fault+0x174/0x250 [xfs]
Jun 11 20:17:20 hyperv kernel:  __do_fault+0x46/0xa0
Jun 11 20:17:20 hyperv kernel:  do_fault+0x12b/0x440
Jun 11 20:17:20 hyperv kernel:  __handle_mm_fault+0x6db/0x880
Jun 11 20:17:20 hyperv kernel:  handle_mm_fault+0xe5/0x240
Jun 11 20:17:20 hyperv kernel:  do_user_addr_fault+0x25d/0x4f0
Jun 11 20:17:20 hyperv kernel:  ? asm_exc_page_fault+0x8/0x30
Jun 11 20:17:20 hyperv kernel:  exc_page_fault+0x75/0x190
Jun 11 20:17:20 hyperv kernel:  asm_exc_page_fault+0x1e/0x30
Jun 11 20:17:20 hyperv kernel: RIP: 0033:0x7fa6cd5a76c0
Jun 11 20:17:20 hyperv kernel: Code: Unable to access opcode bytes at RIP 0x7fa6cd5a7696.
Jun 11 20:17:20 hyperv kernel: RSP: 002b:00007ffe4cc00c38 EFLAGS: 00010206
Jun 11 20:17:20 hyperv kernel: RAX: 0000000000000400 RBX: 00007fa6cd3b257b RCX: 0000556a667ef13e
Jun 11 20:17:20 hyperv kernel: RDX: 0000556a6652f304 RSI: 0000000000000001 RDI: 0000000000000065
Jun 11 20:17:20 hyperv kernel: RBP: 0000000000000065 R08: 0000556a70c453e0 R09: 0000556a6881f010
Jun 11 20:17:20 hyperv kernel: R10: 00007fa6cd732a00 R11: 0000000000000000 R12: 0000000000000001
Jun 11 20:17:20 hyperv kernel: R13: 00007ffe4cc013c0 R14: 00007ffe4cc013c0 R15: 00007fa6cd3b257a
Jun 11 20:17:20 hyperv kernel: Mem-Info:
Jun 11 20:17:20 hyperv kernel: active_anon:5909 inactive_anon:766016 isolated_anon:0
                                active_file:29 inactive_file:5 isolated_file:0
                                unevictable:8 dirty:0 writeback:0
                                slab_reclaimable:25628 slab_unreclaimable:19193
                                mapped:12421 shmem:18267 pagetables:7166 bounce:0
                                free:20288 free_pcp:407 free_cma:0
Jun 11 20:17:20 hyperv kernel: Node 0 active_anon:23636kB inactive_anon:3064064kB active_file:116kB inactive_file:20kB unevictable:32kB isolated(anon):0kB isolated(file):0kB mapped:49684kB dirty:0kB writeback:0kB shmem:73068kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 0kB writeback_tmp:0kB kernel_stack:7568kB pagetables:28664kB all_unreclaimable? no
Jun 11 20:17:20 hyperv kernel: Node 0 DMA free:6344kB min:296kB low:368kB high:440kB reserved_highatomic:0KB active_anon:0kB inactive_anon:8676kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
Jun 11 20:17:20 hyperv kernel: lowmem_reserve[]: 0 1390 3396 3396 3396
Jun 11 20:17:20 hyperv kernel: Node 0 DMA32 free:35512kB min:27540kB low:34424kB high:41308kB reserved_highatomic:0KB active_anon:3744kB inactive_anon:1122792kB active_file:0kB inactive_file:776kB unevictable:32kB writepending:0kB present:1555760kB managed:1423464kB mlocked:32kB bounce:0kB free_pcp:132kB local_pcp:52kB free_cma:0kB
Jun 11 20:17:20 hyperv kernel: lowmem_reserve[]: 0 0 2006 2006 2006
Jun 11 20:17:20 hyperv kernel: Node 0 Normal free:39296kB min:39744kB low:49680kB high:59616kB reserved_highatomic:0KB active_anon:19892kB inactive_anon:1931836kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:2097152kB managed:2054144kB mlocked:0kB bounce:0kB free_pcp:1504kB local_pcp:356kB free_cma:0kB
Jun 11 20:17:20 hyperv kernel: lowmem_reserve[]: 0 0 0 0 0
Jun 11 20:17:20 hyperv kernel: Node 0 DMA: 20*4kB (UM) 11*8kB (UM) 8*16kB (UM) 5*32kB (UME) 2*64kB (ME) 1*128kB (E) 2*256kB (ME) 2*512kB (UE) 2*1024kB (ME) 1*2048kB (E) 0*4096kB = 6344kB
Jun 11 20:17:20 hyperv kernel: Node 0 DMA32: 1415*4kB (UME) 1175*8kB (UME) 754*16kB (UME) 219*32kB (UME) 56*64kB (UM) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 37716kB
Jun 11 20:17:20 hyperv kernel: Node 0 Normal: 1353*4kB (UME) 887*8kB (UME) 520*16kB (UME) 341*32kB (UME) 113*64kB (UM) 20*128kB (UM) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 41532kB
Jun 11 20:17:20 hyperv kernel: Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
Jun 11 20:17:20 hyperv kernel: Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
Jun 11 20:17:20 hyperv kernel: 18401 total pagecache pages
Jun 11 20:17:20 hyperv kernel: 0 pages in swap cache
Jun 11 20:17:20 hyperv kernel: Swap cache stats: add 0, delete 0, find 0/0
Jun 11 20:17:20 hyperv kernel: Free swap  = 0kB
Jun 11 20:17:20 hyperv kernel: Total swap = 0kB
Jun 11 20:17:20 hyperv kernel: 917227 pages RAM
Jun 11 20:17:20 hyperv kernel: 0 pages HighMem/MovableOnly
Jun 11 20:17:20 hyperv kernel: 43985 pages reserved
Jun 11 20:17:20 hyperv kernel: 0 pages cma reserved
Jun 11 20:17:20 hyperv kernel: 0 pages hwpoisoned
Jun 11 20:17:20 hyperv kernel: Tasks state (memory values in pages):
Jun 11 20:17:20 hyperv kernel: [  pid  ]   uid  tgid total_vm      rss pgtables_bytes swapents oom_score_adj name
Jun 11 20:17:20 hyperv kernel: [    268]     0   268    22862      267   208896        0          -250 systemd-journal
Jun 11 20:17:20 hyperv kernel: [    287]     0   287     6817      573    77824        0         -1000 systemd-udevd
Jun 11 20:17:20 hyperv kernel: [    294]   980   294     4920      236    69632        0             0 systemd-network
Jun 11 20:17:20 hyperv kernel: [    342]   978   342     4809      460    73728        0             0 systemd-resolve
Jun 11 20:17:20 hyperv kernel: [    362]    81   362     3364      482    65536        0          -900 dbus-daemon
Jun 11 20:17:20 hyperv kernel: [    363]     0   363     3714      261    69632        0             0 systemd-logind
Jun 11 20:17:20 hyperv kernel: [    368]     0   368    35319      409   135168        0             0 sddm
Jun 11 20:17:20 hyperv kernel: [    369]    87   369    19229      210    65536        0             0 ntpd
Jun 11 20:17:20 hyperv kernel: [    373]     0   373   585290    23858   753664        0             0 Xorg
Jun 11 20:17:20 hyperv kernel: [    450]     0   450    16258      423   114688        0             0 sddm-helper
Jun 11 20:17:20 hyperv kernel: [    452]  1000   452     4323      425    73728        0             0 systemd
Jun 11 20:17:20 hyperv kernel: [    453]  1000   453     5358      678    77824        0             0 (sd-pam)
Jun 11 20:17:20 hyperv kernel: [    464]  1000   464    70579     1387   253952        0             0 kwalletd5
Jun 11 20:17:20 hyperv kernel: [    465]  1000   465    35785      554   135168        0             0 startplasma-x11
Jun 11 20:17:20 hyperv kernel: [    505]  1000   505    38723       69    65536        0             0 gpg-agent
Jun 11 20:17:20 hyperv kernel: [    513]  1000   513     3088      272    69632        0             0 dbus-daemon
Jun 11 20:17:20 hyperv kernel: [    563]  1000   563      570       25    40960        0             0 start_kdeinit
Jun 11 20:17:20 hyperv kernel: [    564]  1000   564    27238      949   192512        0             0 kdeinit5
Jun 11 20:17:20 hyperv kernel: [    565]  1000   565    70072     1333   249856        0             0 klauncher
Jun 11 20:17:20 hyperv kernel: [    578]  1000   578   375839     2964   454656        0             0 kded5
Jun 11 20:17:20 hyperv kernel: [    582]  1000   582   714839    13806   917504        0             0 kwin_x11
Jun 11 20:17:20 hyperv kernel: [    588]  1000   588    38766      127    65536        0             0 dconf-service
Jun 11 20:17:20 hyperv kernel: [    645]  1000   645    71164     1480   266240        0             0 ksmserver
Jun 11 20:17:20 hyperv kernel: [    646]  1000   646    70374     1582   253952        0             0 kglobalaccel5
Jun 11 20:17:20 hyperv kernel: [    654]  1000   654    71089     1413   266240        0             0 kaccess
Jun 11 20:17:20 hyperv kernel: [    656]  1000   656   107956     1433   282624        0             0 polkit-kde-auth
Jun 11 20:17:20 hyperv kernel: [    658]  1000   658   138994     1270   278528        0             0 org_kde_powerde
Jun 11 20:17:20 hyperv kernel: [    660]  1000   660    56537      633   155648        0             0 xembedsniproxy
Jun 11 20:17:20 hyperv kernel: [    662]  1000   662 67256497    71335  5390336        0             0 baloo_file
Jun 11 20:17:20 hyperv kernel: [    664]  1000   664   795205    34461  1159168        0             0 plasmashell
Jun 11 20:17:20 hyperv kernel: [    672]  1000   672   135409     1096   229376        0             0 kactivitymanage
Jun 11 20:17:20 hyperv kernel: [    676]     0   676    98835      498   126976        0             0 udisksd
Jun 11 20:17:20 hyperv kernel: [    687]   102   687   696775     1296   245760        0             0 polkitd
Jun 11 20:17:20 hyperv kernel: [    709]  1000   709    90530     1481   286720        0             0 DiscoverNotifie
Jun 11 20:17:20 hyperv kernel: [    712]  1000   712    56776      639   167936        0             0 gmenudbusmenupr
Jun 11 20:17:20 hyperv kernel: [    785]     0   785    60546      303   102400        0             0 upowerd
Jun 11 20:17:20 hyperv kernel: [    814]  1000   814    54778      564   155648        0             0 kscreen_backend
Jun 11 20:17:20 hyperv kernel: [    817]  1000   817    11595      172    77824        0             0 obexd
Jun 11 20:17:20 hyperv kernel: [    832]  1000   832    45850      999   200704        0             0 desktop.so
Jun 11 20:17:20 hyperv kernel: [    834]  1000   834    27794      984   196608        0             0 file.so
Jun 11 20:17:20 hyperv kernel: [    835]  1000   835    26679      664    77824        0             0 pipewire
Jun 11 20:17:20 hyperv kernel: [    836]  1000   836    22843      389    86016        0             0 pipewire-media-
Jun 11 20:17:20 hyperv kernel: [    837]  1000   837    21717      229    73728        0             0 pipewire-pulse
Jun 11 20:17:20 hyperv kernel: [    841]   133   841    38519       68    65536        0             0 rtkit-daemon
Jun 11 20:17:20 hyperv kernel: [    854]  1000   854    27271      953   192512        0             0 file.so
Jun 11 20:17:20 hyperv kernel: [    856]  1000   856 67251577    65423  6680576        0             0 baloo_file_extr
Jun 11 20:17:20 hyperv kernel: [    862]  1000   862   705374     7931   892928        0             0 konsole
Jun 11 20:17:20 hyperv kernel: [    899]  1000   899    42211      401    86016        0             0 fish
Jun 11 20:17:20 hyperv kernel: [   1041]  1000  1041     2537      187    61440        0             0 sudo
Jun 11 20:17:20 hyperv kernel: [   1042]     0  1042      720       28    45056        0             0 dmesg
Jun 11 20:17:20 hyperv kernel: [   1049]  1000  1049    42186      379    86016        0             0 fish
Jun 11 20:17:20 hyperv kernel: [   1151]  1000  1151     2590      733    61440        0             0 htop
Jun 11 20:17:20 hyperv kernel: [   1152]  1000  1152    40137      380    77824        0             0 fish
Jun 11 20:17:20 hyperv kernel: [   1256]  1000  1256     6795     2710    98304        0             0 python3
Jun 11 20:17:20 hyperv kernel: [   1329]  1000  1329    27271      953   192512        0             0 file.so
Jun 11 20:17:20 hyperv kernel: [   2761]  1000  2761     6686     5087    90112        0             0 ninja
Jun 11 20:17:20 hyperv kernel: [   3564]  1000  3564     2105      135    53248        0             0 ccache
Jun 11 20:17:20 hyperv kernel: [   3610]  1000  3610   100429    52196   786432        0             0 clang++
Jun 11 20:17:20 hyperv kernel: [   4037]  1000  4037     2106      136    65536        0             0 ccache
Jun 11 20:17:20 hyperv kernel: [   4100]  1000  4100    99819    51760   774144        0             0 clang++
Jun 11 20:17:20 hyperv kernel: [   4229]  1000  4229     2116      163    53248        0             0 ccache
Jun 11 20:17:20 hyperv kernel: [   4247]  1000  4247    86088    38126   663552        0             0 clang++
Jun 11 20:17:20 hyperv kernel: [   4359]  1000  4359     2105      133    53248        0             0 ccache
Jun 11 20:17:20 hyperv kernel: [   4393]  1000  4393    76078    28074   577536        0             0 clang++
Jun 11 20:17:20 hyperv kernel: [   4442]  1000  4442     2149      172    53248        0             0 ccache
Jun 11 20:17:20 hyperv kernel: [   4473]  1000  4473     2148      176    53248        0             0 ccache
Jun 11 20:17:20 hyperv kernel: [   4483]  1000  4483    69999    22528   528384        0             0 clang++
Jun 11 20:17:20 hyperv kernel: [   4521]  1000  4521    70849    23427   528384        0             0 clang++
Jun 11 20:17:20 hyperv kernel: [   4738]  1000  4738    35626    32417   327680        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4739]  1000  4739    37487    34256   331776        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4741]  1000  4741    34727    31542   315392        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4742]  1000  4742    41070    37633   368640        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4746]  1000  4746    38537    35229   352256        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4747]  1000  4747    69690    64648   598016        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4749]  1000  4749    37487    34224   339968        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: [   4750]  1000  4750    36071    32873   331776        0             0 llvm-tblgen
Jun 11 20:17:20 hyperv kernel: oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0,global_oom,task_memcg=/user.slice/user-1000.slice/session-2.scope,task=baloo_file,pid=662,uid=1000
Jun 11 20:17:20 hyperv kernel: Out of memory: Killed process 662 (baloo_file) total-vm:269025988kB, anon-rss:285340kB, file-rss:0kB, shmem-rss:0kB, UID:1000 pgtables:5264kB oom_score_adj:0
Jun 11 20:17:20 hyperv kernel: oom_reaper: reaped process 662 (baloo_file), now anon-rss:0kB, file-rss:4kB, shmem-rss:0kB
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 35438
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 11207
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 29934
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 7412
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534
Jun 11 20:24:50 hyperv kernel: hv_balloon: Unhandled message: type: 61534

--LoiLK64PEoXhGvAz--
