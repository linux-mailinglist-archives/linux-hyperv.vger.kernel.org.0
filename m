Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1004D3C711E
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 15:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbhGMNVd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 09:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhGMNVc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 09:21:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC28C0613DD;
        Tue, 13 Jul 2021 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Svx69QrxBVfy3cdWo9pWIoRZqKkz0hfQNhlcUpOd4L4=; b=TTQmdRCGH9xs+kQs22KwQNUAfP
        3wvBDZWnBT8OXQrVLuMY/O9jF2/JnP06CsbNqAfXzGs8SWhng6/6gl8Ig2I2DU748X717U5bxZN7x
        Jv4Gs089nGHjBvwNVC7x+3PFPJrlalWZ/SgQsjpNMbEr+wP0bjJQTbPum5iNU8uP1DKzzuhDTGOyf
        JOdXtxiW/rRkNW8fFu7tZar5nPWUD/694Xha5JR4x0tWkslDsMt03rKch33gZ7mSsL+TEcCJSnTmm
        a3//T5JYfCR8qwhGAtkWBJu0LwxY0X/kHjX4ch8tE6tet2kzN7UqnAdqpS5MzJckFgwLZVbLCd0PH
        HGSxVa8Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3IIP-00181A-3C; Tue, 13 Jul 2021 13:18:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 62633987782; Tue, 13 Jul 2021 15:17:56 +0200 (CEST)
Date:   Tue, 13 Jul 2021 15:17:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org,
        anirban.sinha@nokia.com, mikelley@microsoft.com,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] Hyper-V: fix for unwanted manipulation of sched_clock
 when TSC marked unstable
Message-ID: <20210713131756.GD4170@worktop.programming.kicks-ass.net>
References: <20210713030522.1714803-1-ani@anisinha.ca>
 <20210713130446.gt7k3cwlmhsxtltw@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713130446.gt7k3cwlmhsxtltw@liuwe-devbox-debian-v2>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 13, 2021 at 01:04:46PM +0000, Wei Liu wrote:
> On Tue, Jul 13, 2021 at 08:35:21AM +0530, Ani Sinha wrote:
> > Marking TSC as unstable has a side effect of marking sched_clock as
> > unstable when TSC is still being used as the sched_clock. This is not
> > desirable. Hyper-V ultimately uses a paravirtualized clock source that
> > provides a stable scheduler clock even on systems without TscInvariant
> > CPU capability. Hence, mark_tsc_unstable() call should be called _after_
> > scheduler clock has been changed to the paravirtualized clocksource. This
> > will prevent any unwanted manipulation of the sched_clock. Only TSC will
> > be correctly marked as unstable.
> 
> Correct me if I'm wrong, what you're trying to address is that
> sched_clock remains marked as unstable even after Linux has switched to
> a stable clock source.
> 
> I think a better approach will be to mark the sched_clock as stable when
> we switch to the paravirtualized clock source.

No.. unstable->stable transitions are unsound. You get to switch to your
paravirt clock earlier.

