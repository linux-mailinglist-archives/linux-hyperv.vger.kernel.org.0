Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3521A0872
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2020 09:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgDGHie (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Apr 2020 03:38:34 -0400
Received: from verein.lst.de ([213.95.11.211]:36825 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgDGHie (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Apr 2020 03:38:34 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D459E68BEB; Tue,  7 Apr 2020 09:38:30 +0200 (CEST)
Date:   Tue, 7 Apr 2020 09:38:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: hv_hypercall_pg page permissios
Message-ID: <20200407073830.GA29279@lst.de>
References: <20200407065500.GA28490@lst.de> <87v9mblpq6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9mblpq6.fsf@vitty.brq.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Apr 07, 2020 at 09:28:01AM +0200, Vitaly Kuznetsov wrote:
> Christoph Hellwig <hch@lst.de> writes:
> 
> > Hi all,
> >
> > The x86 Hyper-V hypercall page (hv_hypercall_pg) is the only allocation
> > in the kernel using __vmalloc with exectutable persmissions, and the
> > only user of PAGE_KERNEL_RX.  Is there any good reason it needs to
> > be readable?  Otherwise we could use vmalloc_exec and kill off
> > PAGE_KERNEL_RX.  Note that before 372b1e91343e6 ("drivers: hv: Turn off
> > write permission on the hypercall page") it was even mapped writable..
> 
> [There is nothing secret in the hypercall page, by reading it you can
> figure out if you're running on Intel or AMD (VMCALL/VMMCALL) but it's
> likely not the only possible way :-)]
> 
> I see no reason for hv_hypercall_pg to remain readable. I just
> smoke-tested

Thanks, I have the same in my WIP tree, but just wanted to confirm this
makes sense.
