Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E1A1FAE27
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFPKki (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgFPKkh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:40:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61C0C08C5C2;
        Tue, 16 Jun 2020 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rR80UlMfCW/sEc1igNxwYy8MqIUhUxy8OEBjw3HSVg8=; b=cTYu7scxjqowUHmGv450LUAoaX
        IYsPxcwz87SK04dj2d0K2Awa/jRLEWooOfjnwEF0XVVW6R5EAlLKpJdoh4VbzNG3BSJtAdpw4CKC3
        LoITBwOX7m4y1KewMMvqdDLayIZEcdsF/U2G+R+PdNMuSLBfu6CHz6N8rSLx8FbyXG5PERN1gMdnq
        RUPFEsCsZmTNxC3uBTnvrQvtKC8S8nmz1drHllnBlArdFxKIc28GkmCXrkjiZahs9OWPKt+gv8UFC
        IYmQsPjaBC3+X68k+RRNupUYJEZrGHTHWxlG5Je3dmb2SwWTYSDHfFMlY8/8eqwFvghT3ck0ESLsw
        yYmXgdOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl918-0004Iu-6o; Tue, 16 Jun 2020 10:40:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66384306089;
        Tue, 16 Jun 2020 12:40:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 52998203EDAAE; Tue, 16 Jun 2020 12:40:32 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:40:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dexuan Cui <decui@microsoft.com>, vkuznets <vkuznets@redhat.com>,
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
Message-ID: <20200616104032.GR2531@hirez.programming.kicks-ass.net>
References: <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87y2ooiv5k.fsf@vitty.brq.redhat.com>
 <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <20200616072318.GA17600@lst.de>
 <20200616101807.GO2531@hirez.programming.kicks-ass.net>
 <20200616102350.GA29684@lst.de>
 <20200616102412.GB29684@lst.de>
 <20200616103137.GQ2531@hirez.programming.kicks-ass.net>
 <20200616103313.GA30833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616103313.GA30833@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:33:13PM +0200, Christoph Hellwig wrote:
> sorry, s/ftrace/kprobes/.  See my updated branch here:
> 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/module_alloc-cleanup

Ah the insn slot page, yes. Didn't you just loose VM_FLUSH_RESET_PERMS
there?
