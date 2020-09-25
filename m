Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B804278D29
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Sep 2020 17:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbgIYPu1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Sep 2020 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbgIYPu1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Sep 2020 11:50:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C93BC0613CE;
        Fri, 25 Sep 2020 08:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vetmaFlRbxjG1gdDdh98OoTp5N216Sm8DYU37hXmY/4=; b=jsCuR452EgU0sos8kOsxSDr7R3
        +WnE00/9rj4OSw7HiifYWzMSz2zCXDKSUbj6zfwWTttYV1qOL4NJ7f5lcASVzcTd5ei+SEDvdISkd
        7R87MMZAzYQMltLhqaAbg9lfweLZSGGYhkQUycDhiQMudOoCFc5Sc4Hv+bRvfmWW583ncfRKpGi4d
        pkVo7M/zFgkSpXPR2Qtvwe6TRceX8ehOHPs2SB63y8/Tny+ju3buF7EDRpQAP2dNR9M6VCpZ8LTnI
        uZSijMScB44GmbgqKAHg07k2n+ktUQpuaHgqXOQ8do64DP8NSLMDvzFg46Pel/9/eRlCTefHa0uA+
        XnrXREfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLpyf-000281-Sm; Fri, 25 Sep 2020 15:49:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 046FF980DC7; Fri, 25 Sep 2020 17:49:37 +0200 (CEST)
Date:   Fri, 25 Sep 2020 17:49:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-hyperv@vger.kernel.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <rja@hpe.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Megha Dey <megha.dey@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Baolu Lu <baolu.lu@intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device
 MSI
Message-ID: <20200925154937.GL29142@worktop.programming.kicks-ass.net>
References: <20200826111628.794979401@linutronix.de>
 <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 25, 2020 at 11:29:13AM -0400, Qian Cai wrote:

> It looks like the crashes happen in the interrupt remapping code where they are
> only able to to generate partial call traces.

> [    8.466614][    T0] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    8.474295][    T0] #PF: supervisor instruction fetch in kernel mode
> [    8.480669][    T0] #PF: error_code(0x0010) - not-present page
> [    8.486518][    T0] PGD 0 P4D 0 
> [    8.489757][    T0] Oops: 0010 [#1] SMP KASAN PTI
> [    8.494476][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G          I       5.9.0-rc6-next-20200925 #2
> [    8.503987][    T0] Hardware name: HPE ProLiant DL560 Gen10/ProLiant DL560 Gen10, BIOS U34 11/13/2019
> [    8.513238][    T0] RIP: 0010:0x0
> [    8.516562][    T0] Code: Bad RIP v

Here it looks like this:

[    1.830276] BUG: kernel NULL pointer dereference, address: 0000000000000000
[    1.838043] #PF: supervisor instruction fetch in kernel mode
[    1.844357] #PF: error_code(0x0010) - not-present page
[    1.850090] PGD 0 P4D 0
[    1.852915] Oops: 0010 [#1] SMP
[    1.856419] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc6-00700-g0248dedd12d4 #419
[    1.865447] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
[    1.876902] RIP: 0010:0x0
[    1.879824] Code: Bad RIP value.
[    1.883423] RSP: 0000:ffffffff82803da0 EFLAGS: 00010282
[    1.889251] RAX: 0000000000000000 RBX: ffffffff8282b980 RCX: ffffffff82803e40
[    1.897241] RDX: 0000000000000001 RSI: ffffffff82803e40 RDI: ffffffff8282b980
[    1.905201] RBP: ffff88842f331000 R08: 00000000ffffffff R09: 0000000000000001
[    1.913162] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000048
[    1.921123] R13: ffffffff82803e40 R14: ffffffff8282b9c0 R15: 0000000000000000
[    1.929085] FS:  0000000000000000(0000) GS:ffff88842f400000(0000) knlGS:0000000000000000
[    1.938113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.944524] CR2: ffffffffffffffd6 CR3: 0000000002811001 CR4: 00000000000606b0
[    1.952484] Call Trace:
[    1.955214]  msi_domain_alloc+0x36/0x130
[    1.959594]  __irq_domain_alloc_irqs+0x165/0x380
[    1.964748]  dmar_alloc_hwirq+0x9a/0x120
[    1.969127]  dmar_set_interrupt.part.0+0x1c/0x60
[    1.974281]  enable_drhd_fault_handling+0x2c/0x6c
[    1.979532]  apic_intr_mode_init+0xfa/0x100
[    1.984191]  x86_late_time_init+0x20/0x30
[    1.988662]  start_kernel+0x723/0x7e6
[    1.992748]  secondary_startup_64_no_verify+0xa6/0xab
[    1.998386] Modules linked in:
[    2.001794] CR2: 0000000000000000
[    2.005510] ---[ end trace 837dc60d7c66efa2 ]---

