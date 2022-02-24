Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10404C30BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 24 Feb 2022 17:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbiBXQAe (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 24 Feb 2022 11:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbiBXQAc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 24 Feb 2022 11:00:32 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A1E17924C;
        Thu, 24 Feb 2022 07:59:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 88B5268AFE; Thu, 24 Feb 2022 16:58:54 +0100 (CET)
Date:   Thu, 24 Feb 2022 16:58:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        x86@kernel.org, Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        xen-devel@lists.xenproject.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-hyperv@vger.kernel.org, tboot-devel@lists.sourceforge.net,
        linux-pci@vger.kernel.org
Subject: Re: cleanup swiotlb initialization
Message-ID: <20220224155854.GA30938@lst.de>
References: <20220222153514.593231-1-hch@lst.de> <09cb4ad3-88e7-3744-b4b8-a6d745ecea9e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09cb4ad3-88e7-3744-b4b8-a6d745ecea9e@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Thanks.

This looks really strange as early_amd_iommu_init should not interact much
with the changes.  I'll see if I can find a AMD system to test on.

On Wed, Feb 23, 2022 at 07:57:49PM -0500, Boris Ostrovsky wrote:
> [   37.377313] BUG: unable to handle page fault for address: ffffc90042880018
> [   37.378219] #PF: supervisor read access in kernel mode
> [   37.378219] #PF: error_code(0x0000) - not-present page
> [   37.378219] PGD 7c2f2ee067 P4D 7c2f2ee067 PUD 7bf019b067 PMD 105a30067 PTE 0
> [   37.378219] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [   37.378219] CPU: 14 PID: 1 Comm: swapper/0 Not tainted 5.17.0-rc5swiotlb #9
> [   37.378219] Hardware name: Oracle Corporation ORACLE SERVER E1-2c/ASY,Generic,SM,E1-2c, BIOS 49004900 12/23/2020
> [   37.378219] RIP: e030:init_iommu_one+0x248/0x2f0
> [   37.378219] Code: 48 89 43 68 48 85 c0 74 c4 be 00 20 00 00 48 89 df e8 ea ee ff ff 48 89 43 78 48 85 c0 74 ae c6 83 98 00 00 00 00 48 8b 43 38 <48> 8b 40 18 a8 01 74 07 83 8b a8 04 00 00 01 f6 83 a8 04 00 00 01
> [   37.378219] RSP: e02b:ffffc9004044bd18 EFLAGS: 00010286
> [   37.378219] RAX: ffffc90042880000 RBX: ffff888107260800 RCX: 0000000000000000
> [   37.378219] RDX: 0000000080000000 RSI: ffffea00041cab80 RDI: 00000000ffffffff
> [   37.378219] RBP: ffffc9004044bd38 R08: 0000000000000901 R09: ffffea00041cab00
> [   37.378219] R10: 0000000000000002 R11: 0000000000000000 R12: ffffc90040435008
> [   37.378219] R13: 0000000000080000 R14: 00000000efa00000 R15: 0000000000000000
> [   37.378219] FS:  0000000000000000(0000) GS:ffff88fef4180000(0000) knlGS:0000000000000000
> [   37.378219] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   37.378219] CR2: ffffc90042880018 CR3: 000000000260a000 CR4: 0000000000050660
> [   37.378219] Call Trace:
> [   37.378219]  <TASK>
> [   37.378219]  early_amd_iommu_init+0x3c5/0x72d
> [   37.378219]  ? iommu_setup+0x284/0x284
> [   37.378219]  state_next+0x158/0x68f
> [   37.378219]  ? iommu_setup+0x284/0x284
> [   37.378219]  iommu_go_to_state+0x28/0x2d
> [   37.378219]  amd_iommu_init+0x15/0x4b
> [   37.378219]  ? iommu_setup+0x284/0x284
> [   37.378219]  pci_iommu_init+0x12/0x37
> [   37.378219]  do_one_initcall+0x48/0x210
> [   37.378219]  kernel_init_freeable+0x229/0x28c
> [   37.378219]  ? rest_init+0xe0/0xe0
> [   37.963966]  kernel_init+0x1a/0x130
> [   37.979415]  ret_from_fork+0x22/0x30
> [   37.991436]  </TASK>
> [   37.999465] Modules linked in:
> [   38.007413] CR2: ffffc90042880018
> [   38.019416] ---[ end trace 0000000000000000 ]---
> [   38.023418] RIP: e030:init_iommu_one+0x248/0x2f0
> [   38.023418] Code: 48 89 43 68 48 85 c0 74 c4 be 00 20 00 00 48 89 df e8 ea ee ff ff 48 89 43 78 48 85 c0 74 ae c6 83 98 00 00 00 00 48 8b 43 38 <48> 8b 40 18 a8 01 74 07 83 8b a8 04 00 00 01 f6 83 a8 04 00 00 01
> [   38.023418] RSP: e02b:ffffc9004044bd18 EFLAGS: 00010286
> [   38.023418] RAX: ffffc90042880000 RBX: ffff888107260800 RCX: 0000000000000000
> [   38.155413] RDX: 0000000080000000 RSI: ffffea00041cab80 RDI: 00000000ffffffff
> [   38.175965] Freeing initrd memory: 62640K
> [   38.155413] RBP: ffffc9004044bd38 R08: 0000000000000901 R09: ffffea00041cab00
> [   38.155413] R10: 0000000000000002 R11: 0000000000000000 R12: ffffc90040435008
> [   38.155413] R13: 0000000000080000 R14: 00000000efa00000 R15: 0000000000000000
> [   38.155413] FS:  0000000000000000(0000) GS:ffff88fef4180000(0000) knlGS:0000000000000000
> [   38.287414] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   38.309557] CR2: ffffc90042880018 CR3: 000000000260a000 CR4: 0000000000050660
> [   38.332403] Kernel panic - not syncing: Fatal exception
> [   38.351414] Rebooting in 20 seconds..
>
>
>
> -boris
---end quoted text---
