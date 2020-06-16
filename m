Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8749D1FA9DE
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 09:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgFPHXW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 03:23:22 -0400
Received: from verein.lst.de ([213.95.11.211]:36722 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPHXW (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 03:23:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0F9A368AFE; Tue, 16 Jun 2020 09:23:19 +0200 (CEST)
Date:   Tue, 16 Jun 2020 09:23:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     vkuznets <vkuznets@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616072318.GA17600@lst.de>
References: <20200407073830.GA29279@lst.de> <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net> <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Jun 15, 2020 at 07:49:41PM +0000, Dexuan Cui wrote:
> I did this experiment:
>   1. export vmalloc_exec and ptdump_walk_pgd_level_checkwx.
>   2. write a test module that calls them.
>   3. It turns out that every call of vmalloc_exec() triggers such a warning.
> 
> vmalloc_exec() uses PAGE_KERNEL_EXEC, which is defined as
>    (__PP|__RW|   0|___A|   0|___D|   0|___G)
> 
> It looks the logic in note_page() is: for_each_RW_page, if the NX bit is unset,
> then report the page as an insecure W+X mapping. IMO this explains the
> warning?

It does.  But it also means every other user of PAGE_KERNEL_EXEC
should trigger this, of which there are a few (kexec, tboot, hibernate,
early xen pv mapping, early SEV identity mapping)

We really shouldn't create mappings like this by default.  Either we
need to flip PAGE_KERNEL_EXEC itself based on the needs of the above
users, or add another define to overload vmalloc_exec as there is no
other user of that for x86.
