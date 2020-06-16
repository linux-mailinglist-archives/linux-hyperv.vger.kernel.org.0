Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320481FADC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFPKU7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPKU6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:20:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D1FC08C5C2;
        Tue, 16 Jun 2020 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=De04o2ksjI4LCRuUJymMZyN7SpLPPi/l5AwXKxXPHpw=; b=evAMvYAVePPjChIJ2pN2XCAlWZ
        1O2wsKHasxMhOHyx5TznFldLZCX8vPlBGY60QLWagiJzwoZxhx8CCi9wdY6ZjHwgdG/MZbnJBxhUq
        IeeO2W9J+DD6JzPXvPlBMJSkBLWE/is0yf7N85D5AjGTNQMLcQ9sdbxOTLRN/t3qTbgMBQ+wy7/zr
        DpnPNINxsMR8FgICbMOitGU8JL8VuYZ8BVSfbevT6WYIUXMjZDLPxz+dnwwwCHYofGUm6168FjLGz
        upqVRmpkCPXQBB/OJW9qQ0vbLCQPp9grblncarG6VQgBLjgm2tBcbZwdrdglE/FUnTRh9odWgJTJF
        zPHgoeXg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl8i4-0006g0-9z; Tue, 16 Jun 2020 10:20:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29B2F3017B7;
        Tue, 16 Jun 2020 12:20:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1453C203D5DB1; Tue, 16 Jun 2020 12:20:50 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:20:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Michael Kelley <mikelley@microsoft.com>,
        Ju-Hyoung Lee <juhlee@microsoft.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200616102050.GP2531@hirez.programming.kicks-ass.net>
References: <20200407073830.GA29279@lst.de>
 <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net>
 <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87y2ooiv5k.fsf@vitty.brq.redhat.com>
 <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87blljicjm.fsf@vitty.brq.redhat.com>
 <20200616093341.GA26400@lst.de>
 <20200616095549.GA27917@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616095549.GA27917@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 11:55:49AM +0200, Christoph Hellwig wrote:
> +	hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START,
> +			VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_RX,
> +			VM_FLUSH_RESET_PERMS, NUMA_NO_NODE, __func__);

I think that's wrong, they seem to want to CALL into that page, and that
doesn't unconditionally work for any page in the vmalloc range. This
really ought to use module_alloc() to guarantees it gets a page in the
correct range.
