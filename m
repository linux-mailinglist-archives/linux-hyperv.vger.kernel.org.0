Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7336E279491
	for <lists+linux-hyperv@lfdr.de>; Sat, 26 Sep 2020 01:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgIYXOV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Sep 2020 19:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgIYXOV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Sep 2020 19:14:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230BEC0613CE;
        Fri, 25 Sep 2020 16:14:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601075659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hfCJknL7vN5FQ7E5rBJUvr3Ui/JGPGdNK+KMG+iROA=;
        b=O8WigxqARtdurkJ3wZLtFlOVp/IJYLWjDmhmQmul4Jh1+/tu2tcAC1TQqLvZ7X6XtgAJUn
        eOxJOrPLqDp0AFlhrf9ICCES57zKrQJtWeBw+enhlvFsmhVrk/PIHUraubnLUB8YFVD3EU
        aO+sAe/6qmqsJ4/w9ay6UGJ7n4LbTG7vauQWZ+EMoZO0h8etOCXCfxiQH5btgeOiQSreV3
        mVGp6pGYXUixpnIECzjY39qztquc0ZKZJGi+8R9bz6K81QFII/mn3LRxC2GMX7eONSPEt0
        XqZWoOf+IOa80v+JeOxpuuaVtH3FZsqK9XZ5peTSl+Dt7ASOi02SLO6a+QW6sw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601075659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5hfCJknL7vN5FQ7E5rBJUvr3Ui/JGPGdNK+KMG+iROA=;
        b=qe4V7bKcqNpxkkupSUaXGl+NgWRwWilYYeYK3x3W8R47Rqr4/aCDpm5Xt3BubAKjEHc4Tr
        Du8N8X29kfg+K2Ag==
To:     Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [patch V2 00/46] x86, PCI, XEN, genirq ...: Prepare for device MSI
In-Reply-To: <20200925154937.GL29142@worktop.programming.kicks-ass.net>
References: <20200826111628.794979401@linutronix.de> <3c12bdec2c4ecdabcccd9ece3d495d792e9fc231.camel@redhat.com> <20200925154937.GL29142@worktop.programming.kicks-ass.net>
Date:   Sat, 26 Sep 2020 01:14:18 +0200
Message-ID: <87tuvltpo5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Sep 25 2020 at 17:49, Peter Zijlstra wrote:
> Here it looks like this:
>
> [    1.830276] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.838043] #PF: supervisor instruction fetch in kernel mode
> [    1.844357] #PF: error_code(0x0010) - not-present page
> [    1.850090] PGD 0 P4D 0
> [    1.852915] Oops: 0010 [#1] SMP
> [    1.856419] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.9.0-rc6-00700-g0248dedd12d4 #419
> [    1.865447] Hardware name: Intel Corporation S2600GZ/S2600GZ, BIOS SE5C600.86B.02.02.0002.122320131210 12/23/2013
> [    1.876902] RIP: 0010:0x0
> [    1.879824] Code: Bad RIP value.
> [    1.883423] RSP: 0000:ffffffff82803da0 EFLAGS: 00010282
> [    1.889251] RAX: 0000000000000000 RBX: ffffffff8282b980 RCX: ffffffff82803e40
> [    1.897241] RDX: 0000000000000001 RSI: ffffffff82803e40 RDI: ffffffff8282b980
> [    1.905201] RBP: ffff88842f331000 R08: 00000000ffffffff R09: 0000000000000001
> [    1.913162] R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000048
> [    1.921123] R13: ffffffff82803e40 R14: ffffffff8282b9c0 R15: 0000000000000000
> [    1.929085] FS:  0000000000000000(0000) GS:ffff88842f400000(0000) knlGS:0000000000000000
> [    1.938113] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.944524] CR2: ffffffffffffffd6 CR3: 0000000002811001 CR4: 00000000000606b0
> [    1.952484] Call Trace:
> [    1.955214]  msi_domain_alloc+0x36/0x130

Hrm. That looks like a not initialized mandatory callback. Confused.

Is this on -next and if so, does this happen on tip:x86/irq as well?

Can you provide yoru config please?

Thanks,

        tglx
