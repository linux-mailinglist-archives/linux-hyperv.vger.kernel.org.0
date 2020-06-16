Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE21FAE43
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgFPKme (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:42:34 -0400
Received: from verein.lst.de ([213.95.11.211]:37526 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgFPKmd (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:42:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 912EF68AEF; Tue, 16 Jun 2020 12:42:30 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:42:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dexuan Cui <decui@microsoft.com>,
        vkuznets <vkuznets@redhat.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616104230.GA31314@lst.de>
References: <87y2ooiv5k.fsf@vitty.brq.redhat.com> <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM> <20200616072318.GA17600@lst.de> <20200616101807.GO2531@hirez.programming.kicks-ass.net> <20200616102350.GA29684@lst.de> <20200616102412.GB29684@lst.de> <20200616103137.GQ2531@hirez.programming.kicks-ass.net> <20200616103313.GA30833@lst.de> <20200616104032.GR2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616104032.GR2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:40:32PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 16, 2020 at 12:33:13PM +0200, Christoph Hellwig wrote:
> > sorry, s/ftrace/kprobes/.  See my updated branch here:
> > 
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/module_alloc-cleanup
> 
> Ah the insn slot page, yes. Didn't you just loose VM_FLUSH_RESET_PERMS
> there?

Yes, we did.  vmalloc_exec had it, but given that module_alloc didn't
allocate executable on x86 it didn't.  I guess we should make sure it
is set by the low-level vmalloc code if exec permissions are set to
sort this mess out.
