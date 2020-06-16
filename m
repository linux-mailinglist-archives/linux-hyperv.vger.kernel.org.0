Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76B91FAE04
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jun 2020 12:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFPKby (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Jun 2020 06:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPKbp (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Jun 2020 06:31:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E83C08C5C2;
        Tue, 16 Jun 2020 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gh7RFTXOWWEwXkqUOJF0XcAnRZHVHCKl/wuld2I2MhA=; b=oOVDATDTspIuLa58Sihodo+6rS
        8l3QSIsv3BJTw5olTRniYjVZvBpLQmpDhVXlrN4ZndTR5hoxhJoejBG2gVTtYKxRcxKC7etvmwlEb
        gWLQIz17AakGEAJXJfZc2PhbtoNaWKnPm0HWow/HwIXlJu7JQBZsTrNAoAgDNEG5TJfsYAoXUm9/M
        62htO08TiKopeDwpiNEeBIIVAmsGB+CYQw+MoGV6AYrvkeRFD4NdoQd56m8KQy4uLMWpQuVlrY6Bo
        FjB8o1+FzGmmO8KsmISS4Roarxc5kGzvT2BNZG9vxxxbLAKq2Vsm3Xp0/s8IR1VLKVZYDV0sC0jM2
        2Q1VTIpQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl8sV-0004v2-AK; Tue, 16 Jun 2020 10:31:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 971833017B7;
        Tue, 16 Jun 2020 12:31:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 822E22022DEBD; Tue, 16 Jun 2020 12:31:37 +0200 (CEST)
Date:   Tue, 16 Jun 2020 12:31:37 +0200
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
Message-ID: <20200616103137.GQ2531@hirez.programming.kicks-ass.net>
References: <20200407073830.GA29279@lst.de>
 <C311EB52-A796-4B94-AADD-CCABD19B377E@amacapital.net>
 <HK0P153MB0322D52F61E540CA7515CC4BBF810@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <87y2ooiv5k.fsf@vitty.brq.redhat.com>
 <HK0P153MB0322DE798AA39BCCD4A208E4BF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <HK0P153MB0322EB3EE51073CC021D4AEABF9C0@HK0P153MB0322.APCP153.PROD.OUTLOOK.COM>
 <20200616072318.GA17600@lst.de>
 <20200616101807.GO2531@hirez.programming.kicks-ass.net>
 <20200616102350.GA29684@lst.de>
 <20200616102412.GB29684@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616102412.GB29684@lst.de>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jun 16, 2020 at 12:24:12PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 16, 2020 at 12:23:50PM +0200, Christoph Hellwig wrote:

> > > +	hv_hypercall_pg = module_alloc(PAGE_SIZE);
> > >  	if (hv_hypercall_pg == NULL) {
> > >  		wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
> > >  		goto remove_cpuhp_state;
> > >  	}
> > >  
> > > +	set_memory_ro((unsigned long)hv_hypercall_pg, 1);
> > > +	set_memory_x((unsigned long)hv_hypercall_pg, 1);
> > 
> > The changing of the permissions sucks.  I thought about adding
> > a module_alloc_prot with an explicit pgprot_t argument.  On x86
> > alone at least ftrace would also benefit from that.

How would ftrace benefit from a RX permission? We need to actually write
to the page first. This HV thing is special in that it lets the host
write.

> The above is also missing a set_vm_flush_reset_perms.

Ah, indeed. Otherwise we don't clean up properly.
