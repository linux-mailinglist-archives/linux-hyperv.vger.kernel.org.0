Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AAD78B52B
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Aug 2023 18:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbjH1QNS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjH1QNQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 12:13:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A7611A;
        Mon, 28 Aug 2023 09:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693239193; x=1724775193;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCg1Tzv3/cUU5JGg90l/prfzt3naVzQnRhwxaGpFSCQ=;
  b=icnLNE2rKID9PBpo5hBt/NzRjxBnWljpgHUNNUvTL9pweffxzloNpIHH
   i2RqkGiE4pNoT763sIx2onsG0qdDE3DlXbYZluQe16LthChj/VNg2ucuO
   lE0mP8jwnZBTlGFzU0kzK0KeNyHQKW931lNJDps6nJAYLPLY44u27xe4h
   mAfsdnC0hl54v+2spLaFcE0LOZxzSOl+CBz/evDUd+q4qIHhSEFh+ZRFI
   5kcgaMLQ8yfk2IUWfBi9MkW+RuCquo4eY8uefAVjifacPcVyK5bibEK4a
   +OhCY12at2dNjNKvKhd1XGTa8ifmDeZ/Hy4hltv8KT849SODXTZsynKjb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="372551886"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="372551886"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 09:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="715160213"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="715160213"
Received: from slysokob-mobl1.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.47.178])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 09:13:07 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 10DE4109E62; Mon, 28 Aug 2023 19:13:04 +0300 (+03)
Date:   Mon, 28 Aug 2023 19:13:04 +0300
From:   "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 1/1] x86/mm: Mark CoCo VM pages invalid while moving
 between private and shared
Message-ID: <20230828161304.dolvx6bgnxrqilmj@box.shutemov.name>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
 <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB16884D7E004A4544F3EA6314D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16884D7E004A4544F3EA6314D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 28, 2023 at 02:22:11PM +0000, Michael Kelley (LINUX) wrote:
> From: Michael Kelley (LINUX) <mikelley@microsoft.com> Sent: Tuesday, August 15, 2023 7:54 PM
> > 
> > From: kirill.shutemov@linux.intel.com <kirill.shutemov@linux.intel.com> Sent: Sunday,
> > August 6, 2023 3:20 PM
> > >
> > > On Thu, Jul 06, 2023 at 09:41:59AM -0700, Michael Kelley wrote:
> > > > In a CoCo VM when a page transitions from private to shared, or vice
> > > > versa, attributes in the PTE must be updated *and* the hypervisor must
> > > > be notified of the change. Because there are two separate steps, there's
> > > > a window where the settings are inconsistent.  Normally the code that
> > > > initiates the transition (via set_memory_decrypted() or
> > > > set_memory_encrypted()) ensures that the memory is not being accessed
> > > > during a transition, so the window of inconsistency is not a problem.
> > > > However, the load_unaligned_zeropad() function can read arbitrary memory
> > > > pages at arbitrary times, which could access a transitioning page during
> > > > the window.  In such a case, CoCo VM specific exceptions are taken
> > > > (depending on the CoCo architecture in use).  Current code in those
> > > > exception handlers recovers and does "fixup" on the result returned by
> > > > load_unaligned_zeropad().  Unfortunately, this exception handling and
> > > > fixup code is tricky and somewhat fragile.  At the moment, it is
> > > > broken for both TDX and SEV-SNP.
> > >
> > 
> > Thanks for looking at this.  I'm finally catching up after being out on
> > vacation for a week.
> > 
> > > I believe it is not fixed for TDX. Is it still a problem for SEV-SNP?
> > 
> > I presume you meant "now fixed for TDX", which I agree with.  Tom
> > Lendacky has indicated that there's still a problem with SEV-SNP.   He
> > could fix that problem, but this approach of marking the pages
> > invalid obviates the need for Tom's fix.
> > 
> > >
> > > > There's also a problem with the current code in paravisor scenarios:
> > > > TDX Partitioning and SEV-SNP in vTOM mode. The exceptions need
> > > > to be forwarded from the paravisor to the Linux guest, but there
> > > > are no architectural specs for how to do that.
> > 
> > The TD Partitioning case (and the similar SEV-SNP vTOM mode case) is
> > what doesn't have a solution.  To elaborate, with TD Partitioning, #VE
> > is sent to the containing VM, not the main Linux guest VM.  For
> > everything except an EPT violation, the containing VM can handle
> > the exception on behalf of the main Linux guest by doing the
> > appropriate emulation.  But for an EPT violation, the containing
> > VM can only terminate the guest.  It doesn't have sufficient context
> > to handle a "valid" #VE with EPT violation generated due to
> > load_unaligned_zeropad().  My proposed scheme of marking the
> > pages invalid avoids generating those #VEs and lets TD Partitioning
> > (and similarly for SEV-SNP vTOM) work as intended with a paravisor.
> > 
> > > >
> > > > To avoid these complexities of the CoCo exception handlers, change
> > > > the core transition code in __set_memory_enc_pgtable() to do the
> > > > following:
> > > >
> > > > 1.  Remove aliasing mappings
> > > > 2.  Remove the PRESENT bit from the PTEs of all transitioning pages
> > > > 3.  Flush the TLB globally
> > > > 4.  Flush the data cache if needed
> > > > 5.  Set/clear the encryption attribute as appropriate
> > > > 6.  Notify the hypervisor of the page status change
> > > > 7.  Add back the PRESENT bit
> > >
> > > Okay, looks safe.
> > >
> > > > With this approach, load_unaligned_zeropad() just takes its normal
> > > > page-fault-based fixup path if it touches a page that is transitioning.
> > > > As a result, load_unaligned_zeropad() and CoCo VM page transitioning
> > > > are completely decoupled.  CoCo VM page transitions can proceed
> > > > without needing to handle architecture-specific exceptions and fix
> > > > things up. This decoupling reduces the complexity due to separate
> > > > TDX and SEV-SNP fixup paths, and gives more freedom to revise and
> > > > introduce new capabilities in future versions of the TDX and SEV-SNP
> > > > architectures. Paravisor scenarios work properly without needing
> > > > to forward exceptions.
> > > >
> > > > This approach may make __set_memory_enc_pgtable() slightly slower
> > > > because of touching the PTEs three times instead of just once. But
> > > > the run time of this function is already dominated by the hypercall
> > > > and the need to flush the TLB at least once and maybe twice. In any
> > > > case, this function is only used for CoCo VM page transitions, and
> > > > is already unsuitable for hot paths.
> > > >
> > > > The architecture specific callback function for notifying the
> > > > hypervisor typically must translate guest kernel virtual addresses
> > > > into guest physical addresses to pass to the hypervisor.  Because
> > > > the PTEs are invalid at the time of callback, the code for doing the
> > > > translation needs updating.  virt_to_phys() or equivalent continues
> > > > to work for direct map addresses.  But vmalloc addresses cannot use
> > > > vmalloc_to_page() because that function requires the leaf PTE to be
> > > > valid. Instead, slow_virt_to_phys() must be used. Both functions
> > > > manually walk the page table hierarchy, so performance is the same.
> > >
> > > Uhmm.. But why do we expected slow_virt_to_phys() to work on non-present
> > > page table entries? It seems accident for me that it works now. Somebody
> > > forgot pte_present() check.
> > 
> > I didn't research the history of slow_virt_to_phys(), but I'll do so.
> > 
> 
> The history of slow_virt_to_phys() doesn't show any discussion of
> whether it is expected to work for non-present PTEs.  However, the
> page table walking is done by lookup_address(), which explicitly
> *does* work for non-present PTEs.  For example, lookup_address()
> is used in cpa_flush() to find a PTE.  cpa_flush() then checks to see if
> the PTE is present.

Which is totally fine thing to do. Present bit is the only info you can
always rely to be valid for non-present PTE.

But it is nitpicking on my side. Here you control lifecycle of the PTE, so
you know that PFN will stay valid for the PTE.

I guess the right thing to do is to use lookup_address() and get pfn from
the PTE with the comment why it is valid.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
