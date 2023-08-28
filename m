Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFB878BBCA
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Aug 2023 01:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbjH1X6b (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 28 Aug 2023 19:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234514AbjH1X6F (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 28 Aug 2023 19:58:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CCF184;
        Mon, 28 Aug 2023 16:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693267078; x=1724803078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R9NKTZJ2zsR8TNWR04Sl9Cei5/JcAi2oMjysHn8au9M=;
  b=YrLeGqs4uIFP0zPcpH01itte6FhIv6KexPntx7AzcWugJ1+dOi/BRGTY
   NLhNljYt5JqXvWCsnjo8B6w6uS6mNHsB7JyZHiJD9E75pIGnDKJw1y9pC
   dHk6Czv8xpcxzuvIgcwcFWwJTb6fgjMqg4o4lNhR2iks+xQwocfP4emsY
   rMFGcCNaCJzUB/w7448zURmkAwT+4NzE+a1NmLG2MI8v5xKM2FFXjK9ED
   D5O5J/nbc6TSPmzpOtERcziyOExtvAoXsQeEjVQBlkGUU7UptRLFvtV7p
   g4y7C/3GuQVW1JkZZdZQWteZpttyQuTrCZSDWZkswPF57tMeQGGI8K6+Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="374128815"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="374128815"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 16:57:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="773442583"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="773442583"
Received: from slysokob-mobl1.ccr.corp.intel.com (HELO box.shutemov.name) ([10.252.47.178])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 16:57:53 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 49741109E62; Tue, 29 Aug 2023 02:57:50 +0300 (+03)
Date:   Tue, 29 Aug 2023 02:57:50 +0300
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
Message-ID: <20230828235750.nbj54llqo7laqmif@box.shutemov.name>
References: <1688661719-60329-1-git-send-email-mikelley@microsoft.com>
 <20230806221949.ckoi6ssomsuaeaab@box.shutemov.name>
 <BYAPR21MB16887FF9CC6DFA6323D10464D715A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <BYAPR21MB16884D7E004A4544F3EA6314D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230828161304.dolvx6bgnxrqilmj@box.shutemov.name>
 <BYAPR21MB16881D49DF82B0432CDFBA44D7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230828221333.5blshosyqafbgwlc@box.shutemov.name>
 <BYAPR21MB16886F58824A36D2FF6428AFD7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB16886F58824A36D2FF6428AFD7E0A@BYAPR21MB1688.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 28, 2023 at 11:23:55PM +0000, Michael Kelley (LINUX) wrote:
> > I guess in this case it is better to use slow_virt_to_phys(), but have a
> > comment somewhere why it is self. Maybe also add comment inside
> > slow_virt_to_phys() to indicate that we don't check present bit for a
> > reason.
> > 
> 
> OK, works for me.  I'll turn my original RFC patch into a small patch
> set that's pretty much as the RFC version is coded, along with the
> appropriate comments in slow_virt_to_phys().  Additional patches
> in the set will remove code that becomes unnecessary or that can
> be simplified.

Oh, I just realized that it conflicts with another patchset that I am
currently working on. This patchset adds kexec support for TDX. One thing
I do in this patchset is revert all shared pages to private during kexec,
so that the next kernel can use them[1]. I determine the shared status by
checking the shared bit in the kernel page tables.

If I understand correctly, your change will work with my patch because
my patch is buggy and does not check the preset bit (irony detected).

Ugh. This gets messy.

[1] https://github.com/intel/tdx/commit/4b63531fc315551c3c42023ea655206c77eef5a1
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
