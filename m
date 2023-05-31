Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A447717A2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 May 2023 10:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbjEaIfb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 May 2023 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjEaIfZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 May 2023 04:35:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B818113;
        Wed, 31 May 2023 01:35:15 -0700 (PDT)
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C1511EC0523;
        Wed, 31 May 2023 10:35:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1685522113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=4w2+XBAyUg1x2j+KVLx3U9OB1kNUW8vIMipBpcOS6zM=;
        b=nWIkXbbIcdmWcTh/LgL6nKUHNbCw91oDms3oSSuwKA5bu/rGzR7YiGHA9zKf5ZlVg5bOYS
        yAsweFoFutFAOzbcZ3PTfOMgZLWnhwZnSe/AFgT+heE+1+uSZTBvTJRMVIBeDRnka/p8Ii
        25F3MsaI0w4pUJIvisq6sRpkv74y6fI=
Date:   Wed, 31 May 2023 10:35:08 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
Message-ID: <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, May 31, 2023 at 09:28:57AM +0200, Juergen Gross wrote:
> Can you please boot the system with the MTRR patches and specify "mtrr=debug"
> on the command line? I'd be interested in the raw register values being read
> and the resulting memory type map.

This is exactly why I wanted this option. And you're already putting it
to good use. :-P

Full dmesg below.

[    0.000000] microcode: updated early: 0x710 -> 0x718, date = 2019-05-21
[    0.000000] Linux version 6.4.0-rc1+ (boris@zn) (gcc (Debian 12.2.0-9) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC Tue May 30 15:54:17 CEST 2023
[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+ root=/dev/sda7 ro earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 ras=cec_disable root=/dev/sda7 log_buf_len=10M resume=/dev/sda5 no_console_suspend ignore_loglevel mtrr=debug
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   Centaur CentaurHauls
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.
[    0.000000] signal: max sigframe size: 1776
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000018ebafff] usable
[    0.000000] BIOS-e820: [mem 0x0000000018ebb000-0x0000000018fe7fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000018fe8000-0x0000000018fe8fff] usable
[    0.000000] BIOS-e820: [mem 0x0000000018fe9000-0x0000000018ffffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000019000000-0x000000001dffcfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001dffd000-0x000000001dffffff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000001e000000-0x00000000ac77cfff] usable
[    0.000000] BIOS-e820: [mem 0x00000000ac77d000-0x00000000ac77ffff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac780000-0x00000000ac780fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac781000-0x00000000ac782fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac783000-0x00000000ac7d9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7da000-0x00000000ac7dafff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7db000-0x00000000ac7dcfff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7dd000-0x00000000ac7e7fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7e8000-0x00000000ac7f1fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7f2000-0x00000000ac7f5fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7f6000-0x00000000ac7f9fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac7fa000-0x00000000ac7fafff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac7fb000-0x00000000ac803fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac804000-0x00000000ac810fff] type 20
[    0.000000] BIOS-e820: [mem 0x00000000ac811000-0x00000000ac813fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ac814000-0x00000000ad7fffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000b0000000-0x00000000b3ffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed50000-0x00000000fed8ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ffa00000-0x00000000ffa3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000044fffffff] usable
[    0.000000] printk: bootconsole [earlyser0] enabled
[    0.000000] printk: debug: ignoring loglevel setting.
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] efi: EFI v2.0 by American Megatrends
[    0.000000] efi: ACPI 2.0=0x1dffff98 SMBIOS=0xac811018 
[    0.000000] efi: Remove mem57: MMIO range=[0xb0000000-0xb3ffffff] (64MB) from e820 map
[    0.000000] e820: remove [mem 0xb0000000-0xb3ffffff] reserved
[    0.000000] efi: Not removing mem58: MMIO range=[0xfed20000-0xfed3ffff] (128KB) from e820 map
[    0.000000] efi: Remove mem59: MMIO range=[0xfed50000-0xfed8ffff] (0MB) from e820 map
[    0.000000] e820: remove [mem 0xfed50000-0xfed8ffff] reserved
[    0.000000] efi: Remove mem60: MMIO range=[0xffa00000-0xffa3ffff] (0MB) from e820 map
[    0.000000] e820: remove [mem 0xffa00000-0xffa3ffff] reserved
[    0.000000] SMBIOS 2.6 present.
[    0.000000] DMI: Dell Inc. Precision T3600/0PTTT9, BIOS A13 05/11/2014
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 3591.377 MHz processor
[    0.000767] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.007307] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.012878] last_pfn = 0x450000 max_arch_pfn = 0x400000000
[    0.018357] MTRR default type: uncachable
[    0.022347] MTRR fixed ranges enabled:
[    0.026085]   00000-9FFFF write-back
[    0.029650]   A0000-BFFFF uncachable
[    0.033214]   C0000-FFFFF write-protect
[    0.037039] MTRR variable ranges enabled:
[    0.041038]   0 base 000000000000000 mask 0003FFC00000000 write-back
[    0.047383]   1 base 000000400000000 mask 0003FFFC0000000 write-back
[    0.053730]   2 base 000000440000000 mask 0003FFFF0000000 write-back
[    0.060076]   3 base 0000000AE000000 mask 0003FFFFE000000 uncachable
[    0.066421]   4 base 0000000B0000000 mask 0003FFFF0000000 uncachable
[    0.072768]   5 base 0000000C0000000 mask 0003FFFC0000000 uncachable
[    0.079114]   6 disabled
[    0.081635]   7 disabled
[    0.084156]   8 disabled
[    0.086677]   9 disabled
[    0.089203] total RAM covered: 16352M
[    0.093023] Found optimal setting for mtrr clean up
[    0.097734]  gran_size: 64K 	chunk_size: 64M 	num_reg: 8  	lose cover RAM: 0G
[    0.104864] MTRR map: 6 entries (3 fixed + 3 variable; max 23), built from 10 variable MTRRs
[    0.113294]   0: 0000000000000000-000000000009ffff write-back
[    0.119033]   1: 00000000000a0000-00000000000bffff uncachable
[    0.124771]   2: 00000000000c0000-00000000000fffff write-protect
[    0.130769]   3: 0000000000100000-00000000adffffff write-back
[    0.136508]   4: 00000000ae000000-00000000afffffff uncachable
[    0.142246]   5: 0000000100000000-000000044fffffff write-back
[    0.147992] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.155122] e820: update [mem 0xae000000-0xafffffff] usable ==> reserved
[    0.161663] e820: update [mem 0xc0000000-0xffffffff] usable ==> reserved
[    0.168358] e820: update [mem 0x110000000-0x1ffffffff] usable ==> reserved
[    0.175227] WARNING: BIOS bug: CPU MTRRs don't cover all of memory, losing 3840MB of RAM.
[    0.183397] update e820 for mtrr
[    0.186621] modified physical RAM map:
[    0.190351] modified: [mem 0x0000000000000000-0x0000000000000fff] reserved
[    0.197219] modified: [mem 0x0000000000001000-0x000000000009ffff] usable
[    0.203914] modified: [mem 0x0000000000100000-0x0000000018ebafff] usable
[    0.210608] modified: [mem 0x0000000018ebb000-0x0000000018fe7fff] ACPI NVS
[    0.217475] modified: [mem 0x0000000018fe8000-0x0000000018fe8fff] usable
[    0.224170] modified: [mem 0x0000000018fe9000-0x0000000018ffffff] ACPI NVS
[    0.231037] modified: [mem 0x0000000019000000-0x000000001dffcfff] usable
[    0.237732] modified: [mem 0x000000001dffd000-0x000000001dffffff] ACPI data
[    0.244687] modified: [mem 0x000000001e000000-0x00000000ac77cfff] usable
[    0.251381] modified: [mem 0x00000000ac77d000-0x00000000ac77ffff] type 20
[    0.258162] modified: [mem 0x00000000ac780000-0x00000000ac780fff] reserved
[    0.265031] modified: [mem 0x00000000ac781000-0x00000000ac782fff] type 20
[    0.271812] modified: [mem 0x00000000ac783000-0x00000000ac7d9fff] reserved
[    0.278679] modified: [mem 0x00000000ac7da000-0x00000000ac7dafff] type 20
[    0.285460] modified: [mem 0x00000000ac7db000-0x00000000ac7dcfff] reserved
[    0.292329] modified: [mem 0x00000000ac7dd000-0x00000000ac7e7fff] type 20
[    0.299109] modified: [mem 0x00000000ac7e8000-0x00000000ac7f1fff] reserved
[    0.305977] modified: [mem 0x00000000ac7f2000-0x00000000ac7f5fff] type 20
[    0.312757] modified: [mem 0x00000000ac7f6000-0x00000000ac7f9fff] reserved
[    0.319627] modified: [mem 0x00000000ac7fa000-0x00000000ac7fafff] type 20
[    0.326408] modified: [mem 0x00000000ac7fb000-0x00000000ac803fff] reserved
[    0.333275] modified: [mem 0x00000000ac804000-0x00000000ac810fff] type 20
[    0.340058] modified: [mem 0x00000000ac811000-0x00000000ac813fff] reserved
[    0.346927] modified: [mem 0x00000000ac814000-0x00000000ad7fffff] usable
[    0.353620] modified: [mem 0x00000000fed20000-0x00000000fed3ffff] reserved
[    0.360489] modified: [mem 0x0000000100000000-0x000000010fffffff] usable
[    0.367183] modified: [mem 0x0000000110000000-0x00000001ffffffff] reserved
[    0.374051] modified: [mem 0x0000000200000000-0x000000044fffffff] usable
[    0.380745] last_pfn = 0x450000 max_arch_pfn = 0x400000000
[    0.386223] last_pfn = 0xad800 max_arch_pfn = 0x400000000
[    0.393245] found SMP MP-table at [mem 0x000f1dd0-0x000f1ddf]
[    0.398838] Using GB pages for direct mapping
[    0.415353] printk: log_buf_len: 16777216 bytes
[    0.419724] printk: early log buf free: 253832(96%)
[    0.424592] Secure boot could not be determined
[    0.429112] RAMDISK: [mem 0x372c7000-0x3795afff]
[    0.433723] ACPI: Early table checksum verification disabled
[    0.439377] ACPI: RSDP 0x000000001DFFFF98 000024 (v02 DELL  )
[    0.445112] ACPI: XSDT 0x000000001DFFEE18 00006C (v01 DELL   CBX3     06222004 MSFT 00010013)
[    0.453632] ACPI: FACP 0x0000000018FF0C18 0000F4 (v04 DELL   CBX3     06222004 MSFT 00010013)
[    0.462153] ACPI: DSDT 0x0000000018FA9018 006373 (v01 DELL   CBX3     00000000 INTL 20091112)
[    0.470671] ACPI: FACS 0x0000000018FFDF40 000040
[    0.475278] ACPI: FACS 0x0000000018FF1F40 000040
[    0.479887] ACPI: APIC 0x000000001DFFDC18 000158 (v02 DELL   CBX3     06222004 MSFT 00010013)
[    0.488406] ACPI: MCFG 0x0000000018FFED18 00003C (v01 A M I  OEMMCFG. 06222004 MSFT 00000097)
[    0.496927] ACPI: TCPA 0x0000000018FFEC98 000032 (v02                 00000000      00000000)
[    0.505447] ACPI: SSDT 0x0000000018FEFA98 000306 (v01 DELLTP TPM      00003000 INTL 20091112)
[    0.513967] ACPI: HPET 0x0000000018FFEC18 000038 (v01 A M I   PCHHPET 06222004 AMI. 00000003)
[    0.522487] ACPI: BOOT 0x0000000018FFEB98 000028 (v01 DELL   CBX3     06222004 AMI  00010013)
[    0.531008] ACPI: SSDT 0x0000000018FB0018 037106 (v02 INTEL  CpuPm    00004000 INTL 20091112)
[    0.539526] ACPI: SLIC 0x0000000018FEEC18 000176 (v03 DELL   CBX3     06222004 MSFT 00010013)
[    0.548046] ACPI: Reserving FACP table memory at [mem 0x18ff0c18-0x18ff0d0b]
[    0.555088] ACPI: Reserving DSDT table memory at [mem 0x18fa9018-0x18faf38a]
[    0.562130] ACPI: Reserving FACS table memory at [mem 0x18ffdf40-0x18ffdf7f]
[    0.569172] ACPI: Reserving FACS table memory at [mem 0x18ff1f40-0x18ff1f7f]
[    0.576213] ACPI: Reserving APIC table memory at [mem 0x1dffdc18-0x1dffdd6f]
[    0.583254] ACPI: Reserving MCFG table memory at [mem 0x18ffed18-0x18ffed53]
[    0.590295] ACPI: Reserving TCPA table memory at [mem 0x18ffec98-0x18ffecc9]
[    0.597336] ACPI: Reserving SSDT table memory at [mem 0x18fefa98-0x18fefd9d]
[    0.604378] ACPI: Reserving HPET table memory at [mem 0x18ffec18-0x18ffec4f]
[    0.611418] ACPI: Reserving BOOT table memory at [mem 0x18ffeb98-0x18ffebbf]
[    0.618665] ACPI: Reserving SSDT table memory at [mem 0x18fb0018-0x18fe711d]
[    0.625706] ACPI: Reserving SLIC table memory at [mem 0x18feec18-0x18feed8d]
[    0.632792] No NUMA configuration found
[    0.636572] Faking a node at [mem 0x0000000000000000-0x000000044fffffff]
[    0.643268] NODE_DATA(0) allocated [mem 0x44b7f8000-0x44b7fbfff]
[    0.649305] Zone ranges:
[    0.651786]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.657959]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.664132]   Normal   [mem 0x0000000100000000-0x000000044fffffff]
[    0.670304] Movable zone start for each node
[    0.674564] Early memory node ranges
[    0.678128]   node   0: [mem 0x0000000000001000-0x000000000009ffff]
[    0.684388]   node   0: [mem 0x0000000000100000-0x0000000018ebafff]
[    0.690647]   node   0: [mem 0x0000000018fe8000-0x0000000018fe8fff]
[    0.696908]   node   0: [mem 0x0000000019000000-0x000000001dffcfff]
[    0.703168]   node   0: [mem 0x000000001e000000-0x00000000ac77cfff]
[    0.709427]   node   0: [mem 0x00000000ac814000-0x00000000ad7fffff]
[    0.715686]   node   0: [mem 0x0000000100000000-0x000000010fffffff]
[    0.721946]   node   0: [mem 0x0000000200000000-0x000000044fffffff]
[    0.728206] Initmem setup node 0 [mem 0x0000000000001000-0x000000044fffffff]
[    0.735250] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.735274] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.741596] On node 0, zone DMA32: 301 pages in unavailable ranges
[    0.747459] On node 0, zone DMA32: 23 pages in unavailable ranges
[    0.756635] On node 0, zone DMA32: 3 pages in unavailable ranges
[    0.762596] On node 0, zone DMA32: 151 pages in unavailable ranges
[    0.768986] On node 0, zone Normal: 10240 pages in unavailable ranges
[    0.788009] ACPI: PM-Timer IO Port: 0x408
[    0.798317] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.805164] IOAPIC[1]: apic_id 2, version 32, address 0xfec3f000, GSI 24-47
[    0.812116] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.818461] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.825071] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.831501] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.836633] TSC deadline timer available
[    0.840544] smpboot: Allowing 32 CPUs, 24 hotplug CPUs
[    0.845700] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.853236] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.860800] PM: hibernation: Registered nosave memory: [mem 0x18ebb000-0x18fe7fff]
[    0.868363] PM: hibernation: Registered nosave memory: [mem 0x18fe9000-0x18ffffff]
[    0.875926] PM: hibernation: Registered nosave memory: [mem 0x1dffd000-0x1dffffff]
[    0.883490] PM: hibernation: Registered nosave memory: [mem 0xac77d000-0xac77ffff]
[    0.891051] PM: hibernation: Registered nosave memory: [mem 0xac780000-0xac780fff]
[    0.898614] PM: hibernation: Registered nosave memory: [mem 0xac781000-0xac782fff]
[    0.906178] PM: hibernation: Registered nosave memory: [mem 0xac783000-0xac7d9fff]
[    0.913742] PM: hibernation: Registered nosave memory: [mem 0xac7da000-0xac7dafff]
[    0.921306] PM: hibernation: Registered nosave memory: [mem 0xac7db000-0xac7dcfff]
[    0.928869] PM: hibernation: Registered nosave memory: [mem 0xac7dd000-0xac7e7fff]
[    0.936433] PM: hibernation: Registered nosave memory: [mem 0xac7e8000-0xac7f1fff]
[    0.943996] PM: hibernation: Registered nosave memory: [mem 0xac7f2000-0xac7f5fff]
[    0.951559] PM: hibernation: Registered nosave memory: [mem 0xac7f6000-0xac7f9fff]
[    0.959122] PM: hibernation: Registered nosave memory: [mem 0xac7fa000-0xac7fafff]
[    0.966686] PM: hibernation: Registered nosave memory: [mem 0xac7fb000-0xac803fff]
[    0.974248] PM: hibernation: Registered nosave memory: [mem 0xac804000-0xac810fff]
[    0.981809] PM: hibernation: Registered nosave memory: [mem 0xac811000-0xac813fff]
[    0.989372] PM: hibernation: Registered nosave memory: [mem 0xad800000-0xfed1ffff]
[    0.996933] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed3ffff]
[    1.004495] PM: hibernation: Registered nosave memory: [mem 0xfed40000-0xffffffff]
[    1.012060] PM: hibernation: Registered nosave memory: [mem 0x110000000-0x1ffffffff]
[    1.019797] [mem 0xad800000-0xfed1ffff] available for PCI devices
[    1.025880] Booting paravirtualized kernel on bare hardware
[    1.031444] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1910969940391419 ns
[    1.046295] setup_percpu: NR_CPUS:256 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:1
[    1.056271] percpu: Embedded 78 pages/cpu s282624 r8192 d28672 u524288
[    1.062650] pcpu-alloc: s282624 r8192 d28672 u524288 alloc=1*2097152
[    1.068988] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    1.074292] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    1.079594] pcpu-alloc: [0] 16 17 18 19 [0] 20 21 22 23 
[    1.084897] pcpu-alloc: [0] 24 25 26 27 [0] 28 29 30 31 
[    1.090219] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+ root=/dev/sda7 ro earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0 ras=cec_disable root=/dev/sda7 log_buf_len=10M resume=/dev/sda5 no_console_suspend ignore_loglevel mtrr=debug
[    1.112884] Unknown kernel command line parameters "BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+", will be passed to user space.
[    1.125058] Dentry cache hash table entries: 2097152 (order: 12, 16777216 bytes, linear)
[    1.133712] Inode-cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
[    1.141770] Fallback order for Node 0: 0 
[    1.141776] Built 1 zonelists, mobility grouping on.  Total pages: 3150281
[    1.152485] Policy zone: Normal
[    1.155624] mem auto-init: stack:off, heap alloc:off, heap free:off
[    1.161881] software IO TLB: area num 32.
[    1.201697] Memory: 12308624K/12801796K available (14336K kernel code, 2459K rwdata, 5712K rodata, 3044K init, 14704K bss, 492916K reserved, 0K cma-reserved)
[    1.215760] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=32, Nodes=1
[    1.222260] Kernel/User page tables isolation: enabled
[    1.227461] ftrace: allocating 40092 entries in 157 pages
[    1.238827] ftrace: allocated 157 pages with 5 groups
[    1.243844] Dynamic Preempt: full
[    1.247217] Running RCU self tests
[    1.250451] Running RCU synchronous self tests
[    1.254895] rcu: Preemptible hierarchical RCU implementation.
[    1.260621] rcu: 	RCU lockdep checking is enabled.
[    1.265402] rcu: 	RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=32.
[    1.272184] 	Trampoline variant of Tasks RCU enabled.
[    1.277225] 	Rude variant of Tasks RCU enabled.
[    1.281746] rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
[    1.289395] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=32
[    1.296244] Running RCU synchronous self tests
[    1.303525] NR_IRQS: 16640, nr_irqs: 1088, preallocated irqs: 16
[    1.309579] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    1.316463] Console: colour dummy device 80x25
[    1.320753] printk: console [tty0] enabled
[    1.324829] printk: bootconsole [earlyser0] disabled
[    1.329828] printk: console [ttyS0] enabled
[    2.969459] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    2.977231] ... MAX_LOCKDEP_SUBCLASSES:  8
[    2.981340] ... MAX_LOCK_DEPTH:          48
[    2.985536] ... MAX_LOCKDEP_KEYS:        8192
[    2.989908] ... CLASSHASH_SIZE:          4096
[    2.994279] ... MAX_LOCKDEP_ENTRIES:     32768
[    2.998738] ... MAX_LOCKDEP_CHAINS:      65536
[    3.003195] ... CHAINHASH_SIZE:          32768
[    3.007653]  memory used by lock dependency info: 6365 kB
[    3.013071]  memory used for stack traces: 4224 kB
[    3.017878]  per task-struct memory footprint: 1920 bytes
[    3.023329] ACPI: Core revision 20230331
[    3.027502] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    3.036706] APIC: Switch to symmetric I/O mode setup
[    3.041907] x2apic: IRQ remapping doesn't support X2APIC mode
[    3.047731] Switched APIC routing to physical flat.
[    3.053202] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    3.063699] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x33c4821c4fd, max_idle_ns: 440795387422 ns
[    3.074284] Calibrating delay loop (skipped), value calculated using timer frequency.. 7182.75 BogoMIPS (lpj=3591377)
[    3.075272] pid_max: default: 32768 minimum: 301
[    3.083375] Mount-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    3.084297] Mountpoint-cache hash table entries: 32768 (order: 6, 262144 bytes, linear)
[    3.086699] CPU0: Thermal monitoring enabled (TM1)
[    3.087321] process: using mwait in idle threads
[    3.088279] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    3.089272] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    3.090276] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    3.091273] Spectre V2 : Mitigation: Retpolines
[    3.092272] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    3.093271] Spectre V2 : Spectre v2 / SpectreRSB : Filling RSB on VMEXIT
[    3.094271] Spectre V2 : Enabling Restricted Speculation for firmware calls
[    3.095274] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    3.096272] Spectre V2 : User space: Mitigation: STIBP via prctl
[    3.097273] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    3.098275] MDS: Mitigation: Clear CPU buffers
[    3.099272] MMIO Stale Data: Unknown: No mitigations
[    3.113896] Freeing SMP alternatives memory: 36K
[    3.114674] Running RCU synchronous self tests
[    3.115277] Running RCU synchronous self tests
[    3.116462] smpboot: CPU0: Intel(R) Xeon(R) CPU E5-1620 0 @ 3.60GHz (family: 0x6, model: 0x2d, stepping: 0x7)
[    3.117725] cblist_init_generic: Setting adjustable number of callback queues.
[    3.118272] cblist_init_generic: Setting shift to 5 and lim to 1.
[    3.119344] cblist_init_generic: Setting shift to 5 and lim to 1.
[    3.120328] Running RCU-tasks wait API self tests
[    3.232390] Performance Events: PEBS fmt1+, SandyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    3.233292] ... version:                3
[    3.234272] ... bit width:              48
[    3.235276] ... generic registers:      4
[    3.236280] ... value mask:             0000ffffffffffff
[    3.237279] ... max period:             00007fffffffffff
[    3.238277] ... fixed-purpose events:   3
[    3.239277] ... event mask:             000000070000000f
[    3.240594] Estimated ratio of average max frequency by base frequency (times 1024): 1052
[    3.241365] rcu: Hierarchical SRCU implementation.
[    3.242273] rcu: 	Max phase no-delay instances is 400.
[    3.245869] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    3.247411] smp: Bringing up secondary CPUs ...
[    3.248655] x86: Booting SMP configuration:
[    3.249274] .... node  #0, CPUs:        #1  #2  #3  #4
[    3.260747] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
[    3.262583]   #5  #6  #7
[    3.268545] smp: Brought up 1 node, 8 CPUs
[    3.270285] smpboot: Max logical packages: 4
[    3.271315] smpboot: Total of 8 processors activated (57462.03 BogoMIPS)
[    3.274775] devtmpfs: initialized
[    3.276302] ACPI: PM: Registering ACPI NVS region [mem 0x18ebb000-0x18fe7fff] (1232896 bytes)
[    3.277409] ACPI: PM: Registering ACPI NVS region [mem 0x18fe9000-0x18ffffff] (94208 bytes)
[    3.278460] Running RCU synchronous self tests
[    3.279304] Running RCU synchronous self tests
[    3.280402] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000 ns
[    3.281300] futex hash table entries: 8192 (order: 8, 1048576 bytes, linear)
[    3.283791] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    3.284713] DMA: preallocated 2048 KiB GFP_KERNEL pool for atomic allocations
[    3.285286] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    3.286284] DMA: preallocated 2048 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    3.287578] thermal_sys: Registered thermal governor 'step_wise'
[    3.287581] thermal_sys: Registered thermal governor 'user_space'
[    3.288347] cpuidle: using governor ladder
[    3.290314] cpuidle: using governor menu
[    3.291323] Simple Boot Flag at 0xf3 set to 0x1
[    3.292331] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
[    3.293435] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xb0000000-0xb3ffffff] (base 0xb0000000)
[    3.294276] PCI: not using MMCONFIG
[    3.295279] PCI: Using configuration type 1 for base access
[    3.296327] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    3.298427] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    3.300295] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    3.301276] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    3.302276] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    3.303279] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    3.305532] ACPI: Added _OSI(Module Device)
[    3.306274] ACPI: Added _OSI(Processor Device)
[    3.307273] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.308273] ACPI: Added _OSI(Processor Aggregator Device)
[    3.344417] Callback from call_rcu_tasks_rude() invoked.
[    3.439738] ACPI: 3 ACPI AML tables successfully acquired and loaded
[    3.468367] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    3.475332] ACPI: Interpreter enabled
[    3.476350] ACPI: PM: (supports S0 S1 S3 S4 S5)
[    3.477289] ACPI: Using IOAPIC for interrupt routing
[    3.478339] PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xb0000000-0xb3ffffff] (base 0xb0000000)
[    3.482798] [Firmware Info]: PCI: MMCONFIG at [mem 0xb0000000-0xb3ffffff] not reserved in ACPI motherboard resources
[    3.483287] PCI: MMCONFIG at [mem 0xb0000000-0xb3ffffff] reserved as EfiMemoryMappedIO
[    3.484290] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.485272] PCI: Using E820 reservations for host bridge windows
[    3.486876] ACPI: Enabled 7 GPEs in block 00 to 3F
[    3.526310] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-1f])
[    3.527292] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.528506] acpi PNP0A08:00: _OSC: platform does not support [AER PCIeCapability LTR]
[    3.529483] acpi PNP0A08:00: _OSC: not requesting control; platform does not support [PCIeCapability]
[    3.530280] acpi PNP0A08:00: _OSC: OS requested [PME AER PCIeCapability LTR]
[    3.531279] acpi PNP0A08:00: _OSC: platform willing to grant [PME]
[    3.532279] acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_SUPPORT)
[    3.534553] PCI host bridge to bus 0000:00
[    3.535281] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    3.536273] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    3.537273] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    3.538273] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    3.539277] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000dffff window]
[    3.540279] pci_bus 0000:00: root bus resource [mem 0xb0000000-0xfbffffff window]
[    3.541285] pci_bus 0000:00: root bus resource [bus 00-1f]
[    3.542375] pci 0000:00:00.0: [8086:3c00] type 00 class 0x060000
[    3.543395] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    3.544527] pci 0000:00:01.0: [8086:3c02] type 01 class 0x060400
[    3.545399] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    3.546742] pci 0000:00:01.1: [8086:3c03] type 01 class 0x060400
[    3.547387] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    3.548643] pci 0000:00:02.0: [8086:3c04] type 01 class 0x060400
[    3.549387] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    3.550636] pci 0000:00:03.0: [8086:3c08] type 01 class 0x060400
[    3.551318] pci 0000:00:03.0: enabling Extended Tags
[    3.552355] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    3.553603] pci 0000:00:05.0: [8086:3c28] type 00 class 0x088000
[    3.554490] pci 0000:00:05.2: [8086:3c2a] type 00 class 0x088000
[    3.555481] pci 0000:00:05.4: [8086:3c2c] type 00 class 0x080020
[    3.556287] pci 0000:00:05.4: reg 0x10: [mem 0xf332d000-0xf332dfff]
[    3.557488] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    3.558410] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    3.559592] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[    3.560300] pci 0000:00:16.0: reg 0x10: [mem 0xf332c000-0xf332c00f 64bit]
[    3.561367] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    3.562423] pci 0000:00:16.3: [8086:1d3d] type 00 class 0x070002
[    3.563293] pci 0000:00:16.3: reg 0x10: [io  0xf0a0-0xf0a7]
[    3.564279] pci 0000:00:16.3: reg 0x14: [mem 0xf332a000-0xf332afff]
[    3.565486] pci 0000:00:19.0: [8086:1502] type 00 class 0x020000
[    3.566287] pci 0000:00:19.0: reg 0x10: [mem 0xf3300000-0xf331ffff]
[    3.567280] pci 0000:00:19.0: reg 0x14: [mem 0xf3329000-0xf3329fff]
[    3.568280] pci 0000:00:19.0: reg 0x18: [io  0xf040-0xf05f]
[    3.569344] pci 0000:00:19.0: PME# supported from D0 D3hot D3cold
[    3.570532] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    3.571295] pci 0000:00:1a.0: reg 0x10: [mem 0xf3328000-0xf33283ff]
[    3.572371] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    3.573569] pci 0000:00:1b.0: [8086:1d20] type 00 class 0x040300
[    3.574298] pci 0000:00:1b.0: reg 0x10: [mem 0xf3320000-0xf3323fff 64bit]
[    3.575381] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
[    3.576621] pci 0000:00:1c.0: [8086:1d16] type 01 class 0x060400
[    3.577387] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.578560] pci 0000:00:1c.2: [8086:1d14] type 01 class 0x060400
[    3.579387] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
[    3.580565] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    3.581295] pci 0000:00:1d.0: reg 0x10: [mem 0xf3327000-0xf33273ff]
[    3.582378] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    3.583567] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    3.584597] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    3.585702] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[    3.586292] pci 0000:00:1f.2: reg 0x10: [io  0xf090-0xf097]
[    3.587279] pci 0000:00:1f.2: reg 0x14: [io  0xf080-0xf083]
[    3.588282] pci 0000:00:1f.2: reg 0x18: [io  0xf070-0xf077]
[    3.589279] pci 0000:00:1f.2: reg 0x1c: [io  0xf060-0xf063]
[    3.590279] pci 0000:00:1f.2: reg 0x20: [io  0xf020-0xf03f]
[    3.591283] pci 0000:00:1f.2: reg 0x24: [mem 0xf3326000-0xf33267ff]
[    3.592323] pci 0000:00:1f.2: PME# supported from D3hot
[    3.593521] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    3.594295] pci 0000:00:1f.3: reg 0x10: [mem 0xf3325000-0xf33250ff 64bit]
[    3.595288] pci 0000:00:1f.3: reg 0x20: [io  0xf000-0xf01f]
[    3.596568] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.597374] pci 0000:00:01.1: PCI bridge to [bus 02]
[    3.598375] pci 0000:03:00.0: [10de:10d8] type 00 class 0x030000
[    3.599283] pci 0000:03:00.0: reg 0x10: [mem 0xf2000000-0xf2ffffff]
[    3.600281] pci 0000:03:00.0: reg 0x14: [mem 0xf4000000-0xf7ffffff 64bit pref]
[    3.601281] pci 0000:03:00.0: reg 0x1c: [mem 0xf8000000-0xf9ffffff 64bit pref]
[    3.602283] pci 0000:03:00.0: reg 0x24: [io  0xe000-0xe07f]
[    3.603282] pci 0000:03:00.0: reg 0x30: [mem 0xf3000000-0xf307ffff pref]
[    3.604288] pci 0000:03:00.0: enabling Extended Tags
[    3.605310] pci 0000:03:00.0: BAR 3: assigned to efifb
[    3.606290] pci 0000:03:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    3.607460] pci 0000:03:00.1: [10de:0be3] type 00 class 0x040300
[    3.608281] pci 0000:03:00.1: reg 0x10: [mem 0xf3080000-0xf3083fff]
[    3.609300] pci 0000:03:00.1: enabling Extended Tags
[    3.610484] pci 0000:00:02.0: PCI bridge to [bus 03]
[    3.611281] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    3.612274] pci 0000:00:02.0:   bridge window [mem 0xf2000000-0xf30fffff]
[    3.613276] pci 0000:00:02.0:   bridge window [mem 0xf4000000-0xf9ffffff 64bit pref]
[    3.614357] pci 0000:00:03.0: PCI bridge to [bus 04]
[    3.615394] pci 0000:05:00.0: [8086:1d6b] type 00 class 0x010700
[    3.616296] pci 0000:05:00.0: reg 0x10: [mem 0xfa800000-0xfa803fff 64bit pref]
[    3.617287] pci 0000:05:00.0: reg 0x18: [mem 0xfa400000-0xfa7fffff 64bit pref]
[    3.618282] pci 0000:05:00.0: reg 0x20: [io  0xd000-0xd0ff]
[    3.619304] pci 0000:05:00.0: enabling Extended Tags
[    3.620400] pci 0000:05:00.0: reg 0x164: [mem 0x00000000-0x00003fff 64bit pref]
[    3.621273] pci 0000:05:00.0: VF(n) BAR0 space: [mem 0x00000000-0x0007bfff 64bit pref] (contains BAR0 for 31 VFs)
[    3.622629] pci 0000:00:11.0: PCI bridge to [bus 05]
[    3.623276] pci 0000:00:11.0:   bridge window [io  0xd000-0xdfff]
[    3.624275] pci 0000:00:11.0:   bridge window [mem 0xf3200000-0xf32fffff]
[    3.625283] pci 0000:00:11.0:   bridge window [mem 0xfa400000-0xfa8fffff 64bit pref]
[    3.626365] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    3.627396] pci 0000:07:00.0: [1033:0194] type 00 class 0x0c0330
[    3.628301] pci 0000:07:00.0: reg 0x10: [mem 0xf3100000-0xf3101fff 64bit]
[    3.629439] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    3.630630] pci 0000:00:1c.2: PCI bridge to [bus 07]
[    3.631284] pci 0000:00:1c.2:   bridge window [mem 0xf3100000-0xf31fffff]
[    3.632304] pci_bus 0000:08: extended config space not accessible
[    3.633369] pci 0000:00:1e.0: PCI bridge to [bus 08] (subtractive decode)
[    3.634288] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    3.635273] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    3.636279] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    3.637273] pci 0000:00:1e.0:   bridge window [io  0x0d00-0xffff window] (subtractive decode)
[    3.638280] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000dffff window] (subtractive decode)
[    3.639278] pci 0000:00:1e.0:   bridge window [mem 0xb0000000-0xfbffffff window] (subtractive decode)
[    3.641847] ACPI: PCI: Interrupt link LNKA configured for IRQ 11
[    3.642428] ACPI: PCI: Interrupt link LNKB configured for IRQ 10
[    3.643427] ACPI: PCI: Interrupt link LNKC configured for IRQ 5
[    3.644416] ACPI: PCI: Interrupt link LNKD configured for IRQ 10
[    3.645416] ACPI: PCI: Interrupt link LNKE configured for IRQ 3
[    3.646415] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    3.647280] ACPI: PCI: Interrupt link LNKF disabled
[    3.648415] ACPI: PCI: Interrupt link LNKG configured for IRQ 11
[    3.649433] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    3.650273] ACPI: PCI: Interrupt link LNKH disabled
[    3.651665] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 20-ff])
[    3.652276] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
[    3.653490] acpi PNP0A08:01: _OSC: platform does not support [AER PCIeCapability LTR]
[    3.654475] acpi PNP0A08:01: _OSC: not requesting control; platform does not support [PCIeCapability]
[    3.655273] acpi PNP0A08:01: _OSC: OS requested [PME AER PCIeCapability LTR]
[    3.656272] acpi PNP0A08:01: _OSC: platform willing to grant [PME]
[    3.657272] acpi PNP0A08:01: _OSC: platform retains control of PCIe features (AE_SUPPORT)
[    3.658290] acpi PNP0A08:01: [Firmware Info]: MMCONFIG for domain 0000 [bus 00-3f] only partially covers this bridge
[    3.659754] PCI host bridge to bus 0000:20
[    3.660274] pci_bus 0000:20: root bus resource [io  0x03b0-0x03df window]
[    3.661273] pci_bus 0000:20: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.662273] pci_bus 0000:20: root bus resource [bus 20-ff]
[    3.663806] iommu: Default domain type: Translated 
[    3.664273] iommu: DMA domain TLB invalidation policy: lazy mode 
[    3.665578] SCSI subsystem initialized
[    3.666344] libata version 3.00 loaded.
[    3.667293] ACPI: bus type USB registered
[    3.668322] usbcore: registered new interface driver usbfs
[    3.669311] usbcore: registered new interface driver hub
[    3.670327] usbcore: registered new device driver usb
[    3.671325] pps_core: LinuxPPS API ver. 1 registered
[    3.672272] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.673290] PTP clock support registered
[    3.675286] efivars: Registered efivars operations
[    3.676804] PCI: Using ACPI for IRQ routing
[    3.679485] PCI: Discovered peer bus 3f
[    3.680280] PCI: root bus 3f: using default resources
[    3.681273] PCI: Probing PCI hardware (bus 3f)
[    3.682350] PCI host bridge to bus 0000:3f
[    3.683273] pci_bus 0000:3f: root bus resource [io  0x0000-0xffff]
[    3.684273] pci_bus 0000:3f: root bus resource [mem 0x00000000-0x3fffffffffff]
[    3.685287] pci_bus 0000:3f: No busn resource found for root bus, will use [bus 3f-ff]
[    3.686280] pci_bus 0000:3f: busn_res: can not insert [bus 3f-ff] under domain [bus 00-ff] (conflicts with (null) [bus 20-ff])
[    3.687305] pci 0000:3f:08.0: [8086:3c80] type 00 class 0x088000
[    3.688417] pci 0000:3f:08.3: [8086:3c83] type 00 class 0x088000
[    3.689415] pci 0000:3f:08.4: [8086:3c84] type 00 class 0x088000
[    3.690437] pci 0000:3f:09.0: [8086:3c90] type 00 class 0x088000
[    3.691403] pci 0000:3f:09.3: [8086:3c93] type 00 class 0x088000
[    3.692412] pci 0000:3f:09.4: [8086:3c94] type 00 class 0x088000
[    3.693418] pci 0000:3f:0a.0: [8086:3cc0] type 00 class 0x088000
[    3.694377] pci 0000:3f:0a.1: [8086:3cc1] type 00 class 0x088000
[    3.695382] pci 0000:3f:0a.2: [8086:3cc2] type 00 class 0x088000
[    3.696376] pci 0000:3f:0a.3: [8086:3cd0] type 00 class 0x088000
[    3.697386] pci 0000:3f:0b.0: [8086:3ce0] type 00 class 0x088000
[    3.698383] pci 0000:3f:0b.3: [8086:3ce3] type 00 class 0x088000
[    3.699376] pci 0000:3f:0c.0: [8086:3ce8] type 00 class 0x088000
[    3.700374] pci 0000:3f:0c.1: [8086:3ce8] type 00 class 0x088000
[    3.701381] pci 0000:3f:0c.6: [8086:3cf4] type 00 class 0x088000
[    3.702376] pci 0000:3f:0c.7: [8086:3cf6] type 00 class 0x088000
[    3.703374] pci 0000:3f:0d.0: [8086:3ce8] type 00 class 0x088000
[    3.704385] pci 0000:3f:0d.1: [8086:3ce8] type 00 class 0x088000
[    3.705383] pci 0000:3f:0d.6: [8086:3cf5] type 00 class 0x088000
[    3.706382] pci 0000:3f:0e.0: [8086:3ca0] type 00 class 0x088000
[    3.707388] pci 0000:3f:0e.1: [8086:3c46] type 00 class 0x110100
[    3.708398] pci 0000:3f:0f.0: [8086:3ca8] type 00 class 0x088000
[    3.709417] pci 0000:3f:0f.1: [8086:3c71] type 00 class 0x088000
[    3.710410] pci 0000:3f:0f.2: [8086:3caa] type 00 class 0x088000
[    3.711409] pci 0000:3f:0f.3: [8086:3cab] type 00 class 0x088000
[    3.712410] pci 0000:3f:0f.4: [8086:3cac] type 00 class 0x088000
[    3.713409] pci 0000:3f:0f.5: [8086:3cad] type 00 class 0x088000
[    3.714411] pci 0000:3f:0f.6: [8086:3cae] type 00 class 0x088000
[    3.715383] pci 0000:3f:10.0: [8086:3cb0] type 00 class 0x088000
[    3.716410] pci 0000:3f:10.1: [8086:3cb1] type 00 class 0x088000
[    3.717411] pci 0000:3f:10.2: [8086:3cb2] type 00 class 0x088000
[    3.718409] pci 0000:3f:10.3: [8086:3cb3] type 00 class 0x088000
[    3.719414] pci 0000:3f:10.4: [8086:3cb4] type 00 class 0x088000
[    3.720411] pci 0000:3f:10.5: [8086:3cb5] type 00 class 0x088000
[    3.721409] pci 0000:3f:10.6: [8086:3cb6] type 00 class 0x088000
[    3.722411] pci 0000:3f:10.7: [8086:3cb7] type 00 class 0x088000
[    3.723406] pci 0000:3f:11.0: [8086:3cb8] type 00 class 0x088000
[    3.724394] pci 0000:3f:13.0: [8086:3ce4] type 00 class 0x088000
[    3.725382] pci 0000:3f:13.1: [8086:3c43] type 00 class 0x110100
[    3.726393] pci 0000:3f:13.4: [8086:3ce6] type 00 class 0x110100
[    3.727381] pci 0000:3f:13.5: [8086:3c44] type 00 class 0x110100
[    3.728383] pci 0000:3f:13.6: [8086:3c45] type 00 class 0x088000
[    3.729389] pci_bus 0000:3f: busn_res: [bus 3f-ff] end is updated to 3f
[    3.730276] pci_bus 0000:3f: busn_res: can not insert [bus 3f] under domain [bus 00-ff] (conflicts with (null) [bus 20-ff])
[    3.731350] PCI: pci_cache_line_size set to 64 bytes
[    3.732395] e820: reserve RAM buffer [mem 0x18ebb000-0x1bffffff]
[    3.733287] e820: reserve RAM buffer [mem 0x18fe9000-0x1bffffff]
[    3.734272] e820: reserve RAM buffer [mem 0x1dffd000-0x1fffffff]
[    3.735278] e820: reserve RAM buffer [mem 0xac77d000-0xafffffff]
[    3.736287] e820: reserve RAM buffer [mem 0xad800000-0xafffffff]
[    3.737589] pci 0000:03:00.0: vgaarb: setting as boot VGA device
[    3.738270] pci 0000:03:00.0: vgaarb: bridge control possible
[    3.738270] pci 0000:03:00.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    3.738301] vgaarb: loaded
[    3.739432] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    3.740276] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    3.743436] clocksource: Switched to clocksource tsc-early
[    3.749474] pnp: PnP ACPI init
[    3.752794] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    3.759457] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    3.766110] system 00:00: [mem 0xfe000000-0xfeafffff] has been reserved
[    3.772764] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[    3.779416] system 00:00: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    3.786420] system 00:00: [mem 0xfed45000-0xfedfffff] has been reserved
[    3.793487] system 00:01: [io  0x0680-0x069f] has been reserved
[    3.799454] system 00:01: [io  0x0800-0x080f] has been reserved
[    3.799467] Callback from call_rcu_tasks() invoked.
[    3.799478] system 00:01: [io  0xffff] has been reserved
[    3.815677] system 00:01: [io  0xffff] has been reserved
[    3.821028] system 00:01: [io  0x0400-0x0453] has been reserved
[    3.826980] system 00:01: [io  0x0458-0x047f] has been reserved
[    3.832934] system 00:01: [io  0x0500-0x057f] has been reserved
[    3.838897] system 00:01: [io  0x164e-0x164f] has been reserved
[    3.845146] system 00:03: [io  0x0454-0x0457] has been reserved
[    3.852337] pnp: PnP ACPI: found 8 devices
[    3.867387] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    3.876377] NET: Registered PF_INET protocol family
[    3.881552] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    3.892583] tcp_listen_portaddr_hash hash table entries: 8192 (order: 7, 589824 bytes, linear)
[    3.901469] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    3.909262] TCP established hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    3.917531] TCP bind hash table entries: 65536 (order: 11, 9437184 bytes, vmalloc hugepage)
[    3.928450] TCP: Hash tables configured (established 131072 bind 65536)
[    3.935325] UDP hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[    3.942619] UDP-Lite hash table entries: 8192 (order: 8, 1310720 bytes, linear)
[    3.950426] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    3.956166] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.961170] pci 0000:00:01.1: PCI bridge to [bus 02]
[    3.966168] pci 0000:00:02.0: PCI bridge to [bus 03]
[    3.971157] pci 0000:00:02.0:   bridge window [io  0xe000-0xefff]
[    3.977286] pci 0000:00:02.0:   bridge window [mem 0xf2000000-0xf30fffff]
[    3.984123] pci 0000:00:02.0:   bridge window [mem 0xf4000000-0xf9ffffff 64bit pref]
[    3.991912] pci 0000:00:03.0: PCI bridge to [bus 04]
[    3.996914] pci 0000:05:00.0: BAR 7: assigned [mem 0xfa804000-0xfa87ffff 64bit pref]
[    4.004701] pci 0000:00:11.0: PCI bridge to [bus 05]
[    4.009696] pci 0000:00:11.0:   bridge window [io  0xd000-0xdfff]
[    4.015824] pci 0000:00:11.0:   bridge window [mem 0xf3200000-0xf32fffff]
[    4.022656] pci 0000:00:11.0:   bridge window [mem 0xfa400000-0xfa8fffff 64bit pref]
[    4.030448] pci 0000:00:1c.0: PCI bridge to [bus 06]
[    4.035468] pci 0000:00:1c.2: PCI bridge to [bus 07]
[    4.040459] pci 0000:00:1c.2:   bridge window [mem 0xf3100000-0xf31fffff]
[    4.047287] pci 0000:00:1e.0: PCI bridge to [bus 08]
[    4.052297] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    4.058507] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    4.064715] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    4.070942] pci_bus 0000:00: resource 7 [io  0x0d00-0xffff window]
[    4.077158] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000dffff window]
[    4.084066] pci_bus 0000:00: resource 9 [mem 0xb0000000-0xfbffffff window]
[    4.090976] pci_bus 0000:03: resource 0 [io  0xe000-0xefff]
[    4.096579] pci_bus 0000:03: resource 1 [mem 0xf2000000-0xf30fffff]
[    4.102879] pci_bus 0000:03: resource 2 [mem 0xf4000000-0xf9ffffff 64bit pref]
[    4.110143] pci_bus 0000:05: resource 0 [io  0xd000-0xdfff]
[    4.115744] pci_bus 0000:05: resource 1 [mem 0xf3200000-0xf32fffff]
[    4.122045] pci_bus 0000:05: resource 2 [mem 0xfa400000-0xfa8fffff 64bit pref]
[    4.129313] pci_bus 0000:07: resource 1 [mem 0xf3100000-0xf31fffff]
[    4.135611] pci_bus 0000:08: resource 4 [io  0x0000-0x03af window]
[    4.141821] pci_bus 0000:08: resource 5 [io  0x03e0-0x0cf7 window]
[    4.148030] pci_bus 0000:08: resource 6 [io  0x03b0-0x03df window]
[    4.154249] pci_bus 0000:08: resource 7 [io  0x0d00-0xffff window]
[    4.160462] pci_bus 0000:08: resource 8 [mem 0x000a0000-0x000dffff window]
[    4.167369] pci_bus 0000:08: resource 9 [mem 0xb0000000-0xfbffffff window]
[    4.174436] pci_bus 0000:20: resource 4 [io  0x03b0-0x03df window]
[    4.180661] pci_bus 0000:20: resource 5 [mem 0x000a0000-0x000bffff window]
[    4.187630] pci_bus 0000:3f: resource 4 [io  0x0000-0xffff]
[    4.193232] pci_bus 0000:3f: resource 5 [mem 0x00000000-0x3fffffffffff]
[    4.199918] pci 0000:00:05.0: disabled boot interrupts on device [8086:3c28]
[    4.208571] pci 0000:03:00.1: extending delay after power-on from D3hot to 20 msec
[    4.216333] pci 0000:03:00.1: D0 power state depends on 0000:03:00.0
[    4.223191] pci 0000:07:00.0: enabling device (0000 -> 0002)
[    4.229117] PCI: CLS 64 bytes, default 64
[    4.233195] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.233433] Unpacking initramfs...
[    4.239672] software IO TLB: mapped [mem 0x00000000a877d000-0x00000000ac77d000] (64MB)
[    4.252983] Initialise system trusted keyrings
[    4.257679] workingset: timestamp_bits=56 max_order=22 bucket_order=0
[    4.264459] ntfs: driver 2.1.32 [Flags: R/W].
[    4.268854] fuse: init (API version 7.38)
[    4.273139] 9p: Installing v9fs 9p2000 file system support
[    4.278836] Key type asymmetric registered
[    4.282980] Asymmetric key parser 'x509' registered
[    4.287925] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
[    4.316498] ACPI: \_PR_.CP00: Found 4 idle states
[    4.322022] ACPI: \_PR_.CP01: Found 4 idle states
[    4.326883] ACPI: \_PR_.CP02: Found 4 idle states
[    4.331741] ACPI: \_PR_.CP03: Found 4 idle states
[    4.336594] ACPI: \_PR_.CP04: Found 4 idle states
[    4.341447] ACPI: \_PR_.CP05: Found 4 idle states
[    4.346299] ACPI: \_PR_.CP06: Found 4 idle states
[    4.351151] ACPI: \_PR_.CP07: Found 4 idle states
[    4.358021] Freeing initrd memory: 6736K
[    4.500661] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    4.507336] 00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    4.517352] serial 0000:00:16.3: enabling device (0000 -> 0003)
[    4.525626] 0000:00:16.3: ttyS1 at I/O 0xf0a0 (irq = 17, base_baud = 115200) is a 16550A
[    4.534736] Linux agpgart interface v0.103
[    4.539182] ACPI: bus type drm_connector registered
[    4.545067] nouveau 0000:03:00.0: vgaarb: deactivate vga console
[    4.551292] nouveau 0000:03:00.0: NVIDIA GT218 (0a8c00b1)
[    4.673972] nouveau 0000:03:00.0: bios: version 70.18.83.00.08
[    4.684664] nouveau 0000:03:00.0: fb: 512 MiB DDR3
[    4.889076] tsc: Refined TSC clocksource calibration: 3591.345 MHz
[    4.895354] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33c4635c383, max_idle_ns: 440795314831 ns
[    4.905501] clocksource: Switched to clocksource tsc
[    4.999816] nouveau 0000:03:00.0: DRM: VRAM: 512 MiB
[    5.004901] nouveau 0000:03:00.0: DRM: GART: 1048576 MiB
[    5.010322] nouveau 0000:03:00.0: DRM: TMDS table version 2.0
[    5.016157] nouveau 0000:03:00.0: DRM: DCB version 4.0
[    5.021383] nouveau 0000:03:00.0: DRM: DCB outp 00: 02000360 00000000
[    5.027926] nouveau 0000:03:00.0: DRM: DCB outp 01: 02000362 00020010
[    5.034476] nouveau 0000:03:00.0: DRM: DCB outp 02: 028003a6 0f220010
[    5.041016] nouveau 0000:03:00.0: DRM: DCB outp 03: 01011380 00000000
[    5.047544] nouveau 0000:03:00.0: DRM: DCB outp 04: 08011382 00020010
[    5.054071] nouveau 0000:03:00.0: DRM: DCB outp 05: 088113c6 0f220010
[    5.060599] nouveau 0000:03:00.0: DRM: DCB conn 00: 00101064
[    5.066341] nouveau 0000:03:00.0: DRM: DCB conn 01: 00202165
[    5.077323] nouveau 0000:03:00.0: DRM: MM: using COPY for buffer copies
[    5.084095] stackdepot: allocating hash table of 1048576 entries via kvcalloc
[    5.100189] [drm] Initialized nouveau 1.3.1 20120801 for 0000:03:00.0 on minor 0
[    5.155486] fbcon: nouveaudrmfb (fb0) is primary device
[    5.299223] Console: switching to colour frame buffer device 210x65
[    5.318062] nouveau 0000:03:00.0: [drm] fb0: nouveaudrmfb frame buffer device
[    5.361998] megasas: 07.725.01.00-rc1
[    5.366287] st: Version 20160209, fixed bufsize 32768, s/g segs 256
[    5.373365] ahci 0000:00:1f.2: version 3.0
[    5.379420] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3 impl SATA mode
[    5.387923] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    5.404110] scsi host0: ahci
[    5.408666] scsi host1: ahci
[    5.413155] scsi host2: ahci
[    5.417474] scsi host3: ahci
[    5.421656] scsi host4: ahci
[    5.425773] scsi host5: ahci
[    5.429388] ata1: SATA max UDMA/133 abar m2048@0xf3326000 port 0xf3326100 irq 32
[    5.437202] ata2: SATA max UDMA/133 abar m2048@0xf3326000 port 0xf3326180 irq 32
[    5.445018] ata3: DUMMY
[    5.447726] ata4: DUMMY
[    5.450467] ata5: DUMMY
[    5.453194] ata6: DUMMY
[    5.456324] e1000e: Intel(R) PRO/1000 Network Driver
[    5.461640] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    5.469230] e1000e 0000:00:19.0: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
[    5.563007] e1000e 0000:00:19.0 0000:00:19.0 (uninitialized): registered PHC clock
[    5.656045] e1000e 0000:00:19.0 eth0: (PCI Express:2.5GT/s:Width x1) 90:b1:1c:7b:da:e7
[    5.664463] e1000e 0000:00:19.0 eth0: Intel(R) PRO/1000 Network Connection
[    5.671760] e1000e 0000:00:19.0 eth0: MAC: 10, PHY: 11, PBA No: 7041FF-0FF
[    5.679792] xhci_hcd 0000:07:00.0: xHCI Host Controller
[    5.685750] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 1
[    5.693916] xhci_hcd 0000:07:00.0: hcc params 0x014042cb hci version 0x96 quirks 0x0000000000000004
[    5.704373] xhci_hcd 0000:07:00.0: xHCI Host Controller
[    5.704410] ehci-pci 0000:00:1a.0: EHCI Host Controller
[    5.709698] xhci_hcd 0000:07:00.0: new USB bus registered, assigned bus number 2
[    5.709775] ehci-pci 0000:00:1a.0: new USB bus registered, assigned bus number 3
[    5.715032] xhci_hcd 0000:07:00.0: Host supports USB 3.0 SuperSpeed
[    5.715758] ehci-pci 0000:00:1a.0: debug port 2
[    5.723137] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    5.734874] ehci-pci 0000:00:1a.0: irq 16, io mem 0xf3328000
[    5.736537] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.744079] ehci-pci 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    5.749532] usb usb1: Product: xHCI Host Controller
[    5.766884] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    5.769664] usb usb1: Manufacturer: Linux 6.4.0-rc1+ xhci-hcd
[    5.769674] usb usb1: SerialNumber: 0000:07:00.0
[    5.771453] hub 1-0:1.0: USB hub found
[    5.776217] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[    5.777062] hub 1-0:1.0: 2 ports detected
[    5.778266] ata1.00: ATA-8: ST2000DM001-1CH164, CC24, max UDMA/133
[    5.779735] usb usb2: We don't know the algorithms for LPM for this host, disabling LPM.
[    5.785413] ata2.00: ATAPI: PLDS DVD+/-RW DS-8A9SH, ED11, max UDMA/100
[    5.787281] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.04
[    5.792950] ata1.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    5.794080] ata1.00: configured for UDMA/133
[    5.794996] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.800420] scsi 0:0:0:0: Direct-Access     ATA      ST2000DM001-1CH1 CC24 PQ: 0 ANSI: 5
[    5.802303] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    5.802517] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[    5.802524] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    5.802565] sd 0:0:0:0: [sda] Write Protect is off
[    5.802585] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.802639] ata2.00: configured for UDMA/100
[    5.802735] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.802909] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    5.804515] usb usb2: Product: xHCI Host Controller
[    5.810877] scsi 1:0:0:0: CD-ROM            PLDS     DVD+-RW DS-8A9SH ED11 PQ: 0 ANSI: 5
[    5.813110] usb usb2: Manufacturer: Linux 6.4.0-rc1+ xhci-hcd
[    5.813118] usb usb2: SerialNumber: 0000:07:00.0
[    5.814218] hub 2-0:1.0: USB hub found
[    5.930498]  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15 >
[    5.937639] hub 2-0:1.0: 2 ports detected
[    5.947027] sd 0:0:0:0: [sda] Attached SCSI disk
[    5.952925] usbcore: registered new interface driver usb-storage
[    5.953320] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    5.953346] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.953358] usb usb3: Product: EHCI Host Controller
[    5.953368] usb usb3: Manufacturer: Linux 6.4.0-rc1+ ehci_hcd
[    5.953377] usb usb3: SerialNumber: 0000:00:1a.0
[    5.955657] hub 3-0:1.0: USB hub found
[    5.963290] usbcore: registered new interface driver usbserial_generic
[    5.966351] hub 3-0:1.0: 3 ports detected
[    5.968987] ehci-pci 0000:00:1d.0: EHCI Host Controller
[    5.972243] usbserial: USB Serial support registered for generic
[    5.975991] ehci-pci 0000:00:1d.0: new USB bus registered, assigned bus number 4
[    5.978016] i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    5.978781] ehci-pci 0000:00:1d.0: debug port 2
[    5.979252] i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    5.979563] i8042: Warning: Keylock active
[    5.984165] ehci-pci 0000:00:1d.0: irq 17, io mem 0xf3327000
[    5.984694] serio: i8042 KBD port at 0x60,0x64 irq 1
[    5.991990] ehci-pci 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    5.996780] mousedev: PS/2 mouse device common for all mice
[    5.997064] usb usb4: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.04
[    5.997764] usbcore: registered new interface driver synaptics_usb
[    5.998371] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.999033] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    5.999865] usb usb4: Product: EHCI Host Controller
[    6.000732] rtc_cmos 00:02: RTC can wake from S4
[    6.001380] usb usb4: Manufacturer: Linux 6.4.0-rc1+ ehci_hcd
[    6.002438] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
[    6.002682] rtc_cmos 00:02: registered as rtc0
[    6.002754] rtc_cmos 00:02: setting system clock to 2023-05-31T08:13:04 UTC (1685520784)
[    6.002869] rtc_cmos 00:02: alarms up to one year, y3k, 242 bytes nvram, hpet irqs
[    6.002890] usb usb4: SerialNumber: 0000:00:1d.0
[    6.002897] fail to initialize ptp_kvm
[    6.003504] cdrom: Uniform CD-ROM driver Revision: 3.20
[    6.005377] hub 4-0:1.0: USB hub found
[    6.009843] intel_pstate: Intel P-state driver initializing
[    6.020196] hub 4-0:1.0: 3 ports detected
[    6.038068] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    6.042372] hid: raw HID events driver (C) Jiri Kosina
[    6.256352] NET: Registered PF_INET6 protocol family
[    6.263200] Segment Routing with IPv6
[    6.268012] In-situ OAM (IOAM) with IPv6
[    6.268465] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    6.268573] mip6: Mobile IPv6
[    6.269349] sr 1:0:0:0: Attached scsi generic sg1 type 5
[    6.269870] NET: Registered PF_PACKET protocol family
[    6.282986] usb 4-1: new high-speed USB device number 2 using ehci-pci
[    6.288314] 9pnet: Installing 9P2000 support
[    6.309283] microcode: Microcode Update Driver: v2.2.
[    6.309291] IPI shorthand broadcast: enabled
[    6.327011] sched_clock: Marking stable (4579003425, 1747946202)->(7838879238, -1511929611)
[    6.337407] registered taskstats version 1
[    6.342047] Loading compiled-in X.509 certificates
[    6.368624] printk: console [netcon0] enabled
[    6.373971] netconsole: network logging started
[    6.375966] usb 3-1: new high-speed USB device number 2 using ehci-pci
[    6.380413] clk: Disabling unused clocks
[    6.395067] Freeing unused decrypted memory: 2036K
[    6.401430] Freeing unused kernel image (initmem) memory: 3044K
[    6.414063] Write protecting the kernel read-only data: 20480k
[    6.417477] usb 4-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    6.429238] usb 4-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.437113] Freeing unused kernel image (rodata/data gap) memory: 432K
[    6.442848] hub 4-1:1.0: USB hub found
[    6.448521] Run /init as init process
[    6.452699]   with arguments:
[    6.456182]     /init
[    6.458958]   with environment:
[    6.460973] hub 4-1:1.0: 8 ports detected
[    6.462586]     HOME=/
[    6.470011]     TERM=linux
[    6.473991]     BOOT_IMAGE=/boot/vmlinuz-6.4.0-rc1+
[    6.520754] usb 3-1: New USB device found, idVendor=8087, idProduct=0024, bcdDevice= 0.00
[    6.529566] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    6.543836] hub 3-1:1.0: USB hub found
[    6.551163] hub 3-1:1.0: 6 ports detected
[    7.716407] random: crng init done
[    8.320622] process '/usr/bin/fstype' started with executable stack
[    8.678656] EXT4-fs (sda7): mounted filesystem 6aef0462-c7e4-45ca-9a68-4e435300595e with ordered data mode. Quota mode: disabled.
[   10.589450] acpi-cpufreq: probe of acpi-cpufreq failed with error -17
[   10.591550] i801_smbus 0000:00:1f.3: enabling device (0000 -> 0003)
[   10.592674] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[   10.593618] ACPI: button: Power Button [PWRB]
[   10.593840] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[   10.599604] ACPI: button: Power Button [PWRF]
[   10.605121] i801_smbus 0000:00:1f.3: SMBus using PCI interrupt
[   10.647504] i2c i2c-14: 4/4 memory slots populated (from DMI)
[   10.684712] iTCO_vendor_support: vendor-support=0
[   10.715708] RAPL PMU: API unit is 2^-32 Joules, 2 fixed counters, 163840 ms ovfl timer
[   10.724357] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[   10.730682] RAPL PMU: hw unit of domain package 2^-16 Joules
[   10.731713] iTCO_wdt iTCO_wdt.1.auto: Found a Patsburg TCO device (Version=2, TCOBASE=0x0460)
[   10.747468] iTCO_wdt iTCO_wdt.1.auto: initialized. heartbeat=30 sec (nowayout=0)
[   10.866628] cryptd: max_cpu_qlen set to 1000
[   10.970050] AVX version of gcm_enc/dec engaged.
[   10.975735] AES CTR mode by8 optimization enabled
[   12.063715] EDAC MC: Ver: 3.0.0
[   12.069807] EDAC DEBUG: edac_mc_sysfs_init: device mc created
[   12.129012] EDAC DEBUG: sbridge_init: 
[   12.134337] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
[   12.142034] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3ca0
[   12.149709] EDAC sbridge: Seeking for: PCI ID 8086:3ca0
[   12.156866] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
[   12.163530] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3ca8
[   12.171528] EDAC sbridge: Seeking for: PCI ID 8086:3ca8
[   12.178310] EDAC sbridge: Seeking for: PCI ID 8086:3c71
[   12.185032] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3c71
[   12.191963] EDAC sbridge: Seeking for: PCI ID 8086:3c71
[   12.197977] EDAC sbridge: Seeking for: PCI ID 8086:3caa
[   12.203914] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3caa
[   12.210999] EDAC sbridge: Seeking for: PCI ID 8086:3caa
[   12.218000] EDAC sbridge: Seeking for: PCI ID 8086:3cab
[   12.224070] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cab
[   12.230697] EDAC sbridge: Seeking for: PCI ID 8086:3cab
[   12.233955] raid6: sse2x4   gen() 14825 MB/s
[   12.236475] EDAC sbridge: Seeking for: PCI ID 8086:3cac
[   12.247017] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cac
[   12.253817] EDAC sbridge: Seeking for: PCI ID 8086:3cac
[   12.253955] raid6: sse2x2   gen() 17600 MB/s
[   12.254629] EDAC sbridge: Seeking for: PCI ID 8086:3cad
[   12.270653] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cad
[   12.271953] raid6: sse2x1   gen() 13406 MB/s
[   12.277273] EDAC sbridge: Seeking for: PCI ID 8086:3cad
[   12.277736] raid6: using algorithm sse2x2 gen() 17600 MB/s
[   12.278521] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
[   12.295956] raid6: .... xor() 9295 MB/s, rmw enabled
[   12.300040] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cb8
[   12.300970] raid6: using ssse3x2 recovery algorithm
[   12.301022] EDAC sbridge: Seeking for: PCI ID 8086:3cb8
[   12.323539] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
[   12.329993] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cf4
[   12.336849] EDAC sbridge: Seeking for: PCI ID 8086:3cf4
[   12.342617] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
[   12.348749] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cf6
[   12.355352] EDAC sbridge: Seeking for: PCI ID 8086:3cf6
[   12.361335] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
[   12.367035] EDAC DEBUG: sbridge_get_onedevice: Detected 8086:3cf5
[   12.373588] EDAC sbridge: Seeking for: PCI ID 8086:3cf5
[   12.379462] EDAC DEBUG: sbridge_probe: Registering MC#0 (1 of 1)
[   12.386249] EDAC DEBUG: sbridge_register_mci: MC: mci = 000000009a9d559b, dev = 00000000fe166939
[   12.396975] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3ca0, bus 63 with dev = 0000000083b9c14f
[   12.407225] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3ca8, bus 63 with dev = 000000007daf49c8
[   12.417462] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3c71, bus 63 with dev = 0000000095b74c5a
[   12.427993] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3caa, bus 63 with dev = 00000000ed519f97
[   12.428196] xor: automatically using best checksumming function   avx       
[   12.428973] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cab, bus 63 with dev = 000000001a05e474
[   12.456556] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cac, bus 63 with dev = 0000000052d1f1e6
[   12.466979] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cad, bus 63 with dev = 00000000a771d86a
[   12.477455] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cb8, bus 63 with dev = 0000000045fb76d7
[   12.487676] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cf4, bus 63 with dev = 00000000f39a9d0f
[   12.498143] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cf6, bus 63 with dev = 00000000046233b4
[   12.508373] EDAC DEBUG: sbridge_mci_bind_devs: Associated PCI 8086:3cf5, bus 63 with dev = 00000000cc484fec
[   12.518869] EDAC DEBUG: get_dimm_config: mc#0: Node ID: 0, source ID: 0
[   12.525991] EDAC DEBUG: get_dimm_config: Memory mirroring is disabled
[   12.532939] EDAC DEBUG: get_dimm_config: Lockstep is disabled
[   12.539965] EDAC DEBUG: get_dimm_config: address map is on open page mode
[   12.547182] EDAC DEBUG: __populate_dimms: Memory is registered
[   12.553568] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 0, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   12.566753] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 1, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   12.581000] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 2, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   12.593896] EDAC DEBUG: __populate_dimms: mc#0: ha 0 channel 3, dimm 0, 4096 MiB (1048576 pages) bank: 8, rank: 2, row: 0x8000, col: 0x400
[   12.606793] EDAC DEBUG: get_memory_layout: TOLM: 2.812 GB (0x00000000b3ffffff)
[   12.614478] EDAC DEBUG: get_memory_layout: TOHM: 17.312 GB (0x0000000453ffffff)
[   12.622828] EDAC DEBUG: get_memory_layout: SAD#0 DRAM up to 17.250 GB (0x0000000450000000) Interleave: [8:6] reg=0x000044c3
[   12.634683] EDAC DEBUG: get_memory_layout: SAD#0, interleave #0: 0
[   12.641935] EDAC DEBUG: get_memory_layout: TAD#0: up to 2.750 GB (0x00000000b0000000), socket interleave 1, memory interleave 4, TGT: 0, 1, 2, 3, reg=0x0002b3e4
[   12.656832] EDAC DEBUG: get_memory_layout: TAD#1: up to 17.250 GB (0x0000000450000000), socket interleave 1, memory interleave 4, TGT: 0, 1, 2, 3, reg=0x001133e4
[   12.671799] EDAC DEBUG: get_memory_layout: TAD CH#0, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   12.682510] EDAC DEBUG: get_memory_layout: TAD CH#0, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   12.692916] EDAC DEBUG: get_memory_layout: TAD CH#1, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   12.703355] EDAC DEBUG: get_memory_layout: TAD CH#1, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   12.713775] EDAC DEBUG: get_memory_layout: TAD CH#2, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   12.724532] EDAC DEBUG: get_memory_layout: TAD CH#2, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   12.735918] EDAC DEBUG: get_memory_layout: TAD CH#3, offset #0: 0.000 GB (0x0000000000000000), reg=0x00000000
[   12.746340] EDAC DEBUG: get_memory_layout: TAD CH#3, offset #1: 1.250 GB (0x0000000050000000), reg=0x00000500
[   12.756756] EDAC DEBUG: get_memory_layout: CH#0 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   12.767958] EDAC DEBUG: get_memory_layout: CH#0 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   12.780009] EDAC DEBUG: get_memory_layout: CH#0 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   12.791549] EDAC DEBUG: get_memory_layout: CH#1 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   12.802491] EDAC DEBUG: get_memory_layout: CH#1 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   12.814420] EDAC DEBUG: get_memory_layout: CH#1 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   12.826866] EDAC DEBUG: get_memory_layout: CH#2 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   12.837904] EDAC DEBUG: get_memory_layout: CH#2 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   12.849484] EDAC DEBUG: get_memory_layout: CH#2 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   12.861348] EDAC DEBUG: get_memory_layout: CH#3 RIR#0, limit: 3.999 GB (0x00000000fff00000), way: 2, reg=0x9000000e
[   12.872320] EDAC DEBUG: get_memory_layout: CH#3 RIR#0 INTL#0, offset 0.000 GB (0x0000000000000000), tgt: 0, reg=0x00000000
[   12.883887] EDAC DEBUG: get_memory_layout: CH#3 RIR#0 INTL#1, offset 0.000 GB (0x0000000000000000), tgt: 1, reg=0x00010000
[   12.895731] EDAC DEBUG: edac_mc_add_mc_with_groups: 
[   12.901723] EDAC DEBUG: edac_create_sysfs_mci_device: device mc0 created
[   12.910049] EDAC DEBUG: edac_create_dimm_object: device dimm0 created at location channel 0 slot 0 
[   12.919929] EDAC DEBUG: edac_create_dimm_object: device dimm3 created at location channel 1 slot 0 
[   12.931048] EDAC DEBUG: edac_create_dimm_object: device dimm6 created at location channel 2 slot 0 
[   12.940648] EDAC DEBUG: edac_create_dimm_object: device dimm9 created at location channel 3 slot 0 
[   12.952077] EDAC DEBUG: edac_create_csrow_object: device csrow0 created
[   12.959596] EDAC MC0: Giving out device to module sb_edac controller Sandy Bridge SrcID#0_Ha#0: DEV 0000:3f:0e.0 (INTERRUPT)
[   12.972975] EDAC sbridge:  Ver: 1.1.2 
[   14.009312] Adding 33554428k swap on /dev/sda5.  Priority:-2 extents:1 across:33554428k 
[   14.123544] EXT4-fs (sda7): re-mounted 6aef0462-c7e4-45ca-9a68-4e435300595e. Quota mode: disabled.
[   14.842033] e1000e 0000:00:19.0 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   14.855626] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   15.284697] EXT4-fs (sda6): mounting ext3 file system using the ext4 subsystem
[   15.571525] EXT4-fs (sda6): mounted filesystem 6b02369b-7362-4920-b703-8ba36125139f with ordered data mode. Quota mode: disabled.
[   15.650183] FAT-fs (sda1): Volume was not properly unmounted. Some data may be corrupt. Please run fsck.
[   15.679894] BTRFS info (device sda9): using crc32c (crc32c-intel) checksum algorithm
[   15.689918] BTRFS info (device sda9): disk space caching is enabled
[   16.222303] SGI XFS with ACLs, security attributes, quota, no debug enabled
[   16.260915] XFS (sda10): Deprecated V4 format (crc=0) will not be supported after September 2030.
[   16.281460] XFS (sda10): Mounting V4 Filesystem b62c870e-d204-498e-999b-5a0ea7c560cd
[   16.415636] XFS (sda10): Ending clean mount
[   16.423369] xfs filesystem being mounted at /mnt/kernel supports timestamps until 2038-01-19 (0x7fffffff)
[   16.623738] EXT4-fs (sda11): mounted filesystem a1428eb4-29da-4a1f-bbde-e9dc1081fb27 with ordered data mode. Quota mode: disabled.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
