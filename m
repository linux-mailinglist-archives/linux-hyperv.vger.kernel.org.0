Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54B820BFE7
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jun 2020 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgF0H5C (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 27 Jun 2020 03:57:02 -0400
Received: from verein.lst.de ([213.95.11.211]:53949 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbgF0H5C (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 27 Jun 2020 03:57:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 758DF68B02; Sat, 27 Jun 2020 09:56:59 +0200 (CEST)
Date:   Sat, 27 Jun 2020 09:56:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-hyperv@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        X86 ML <x86@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Jessica Yu <jeyu@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm64: use PAGE_KERNEL_ROX directly in
 alloc_insn_page
Message-ID: <20200627075659.GA12509@lst.de>
References: <20200618064307.32739-1-hch@lst.de> <20200618064307.32739-3-hch@lst.de> <CAMj1kXH985Aqma47yf96N45CYkTGePVpvihrc_TmOAp2f0vN-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH985Aqma47yf96N45CYkTGePVpvihrc_TmOAp2f0vN-g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Sat, Jun 27, 2020 at 09:34:42AM +0200, Ard Biesheuvel wrote:
> > +       return __vmalloc_node_range(PAGE_SIZE, 1, VMALLOC_START, VMALLOC_END,
> > +                       GFP_KERNEL, PAGE_KERNEL_ROX, VM_FLUSH_RESET_PERMS,
> > +                       NUMA_NO_NODE, __func__);
> 
> Why is this passing a string for the 'caller' argument, and not the
> address of the caller?

Dementia.  Fix sent.
