Return-Path: <linux-hyperv+bounces-356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B87B3CEA
	for <lists+linux-hyperv@lfdr.de>; Sat, 30 Sep 2023 01:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 40DA0B2099D
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 23:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F8347369;
	Fri, 29 Sep 2023 23:14:16 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50EE65885
	for <linux-hyperv@vger.kernel.org>; Fri, 29 Sep 2023 23:14:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8ADE6;
	Fri, 29 Sep 2023 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696029253; x=1727565253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GuguJlpMuR4ytblE3REIb1sY7chzBowLTZJy4y360dY=;
  b=AGn2HpF7q/xgtWeA3WV5GR9NL5DU/og6tXJBCMTRcMChmbEptCzvp9ZA
   PEDgXaRykAjK72Iiov6+MVHmOhTwFutL9C1N+shzZTGiTsPrSvDVIrYYe
   Q3olDUGQ3+vh17gfdn2wCmrjSQBh0ug7ttjKGOc3Cl2XAGw5eL4wgQ1+i
   Hj/O9AvWAbG+yzKNlnQXAPH6M0leeubc6QV9amdt1JK/4fxfLpwa3fb6v
   ngT1QLW97SkqWwfRuyQOuKSonDtHYkSnUhB0D04v4nUTvMOVafQ8xNUWf
   fTolUofxWJpeUho27REgTtddkA+D4crUCaEEjqlpn8BWaNEI+A62GZDIw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379682270"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="379682270"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785232918"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="785232918"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 29 Sep 2023 16:14:06 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qmMgO-0003P5-0S;
	Fri, 29 Sep 2023 23:14:04 +0000
Date: Sat, 30 Sep 2023 07:13:06 +0800
From: kernel test robot <lkp@intel.com>
To: Michael Kelley <mikelley@microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, thomas.lendacky@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	kirill.shutemov@linux.intel.com, seanjc@google.com,
	rick.p.edgecombe@intel.com, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, mikelley@microsoft.com
Subject: Re: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while
 changing encrypted state
Message-ID: <202309300620.S7uwOfcg-lkp@intel.com>
References: <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696011549-28036-4-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/master]
[also build test ERROR on tip/auto-latest linus/master v6.6-rc3 next-20230929]
[cannot apply to tip/x86/mm tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Kelley/x86-coco-Use-slow_virt_to_phys-in-page-transition-hypervisor-callbacks/20230930-041800
base:   tip/master
patch link:    https://lore.kernel.org/r/1696011549-28036-4-git-send-email-mikelley%40microsoft.com
patch subject: [PATCH 3/5] x86/mm: Mark CoCo VM pages not present while changing encrypted state
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20230930/202309300620.S7uwOfcg-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230930/202309300620.S7uwOfcg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309300620.S7uwOfcg-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/x86/mm/pat/set_memory.c: In function '__set_memory_enc_pgtable':
>> arch/x86/mm/pat/set_memory.c:2200:16: error: implicit declaration of function 'set_memory_p'; did you mean 'set_memory_np'? [-Werror=implicit-function-declaration]
    2200 |         return set_memory_p(&addr, numpages);
         |                ^~~~~~~~~~~~
         |                set_memory_np
   cc1: some warnings being treated as errors


vim +2200 arch/x86/mm/pat/set_memory.c

  2132	
  2133	/*
  2134	 * __set_memory_enc_pgtable() is used for the hypervisors that get
  2135	 * informed about "encryption" status via page tables.
  2136	 */
  2137	static int __set_memory_enc_pgtable(unsigned long addr, int numpages, bool enc)
  2138	{
  2139		pgprot_t empty = __pgprot(0);
  2140		struct cpa_data cpa;
  2141		int ret;
  2142	
  2143		/* Should not be working on unaligned addresses */
  2144		if (WARN_ONCE(addr & ~PAGE_MASK, "misaligned address: %#lx\n", addr))
  2145			addr &= PAGE_MASK;
  2146	
  2147		memset(&cpa, 0, sizeof(cpa));
  2148		cpa.vaddr = &addr;
  2149		cpa.numpages = numpages;
  2150	
  2151		/*
  2152		 * The caller must ensure that the memory being transitioned between
  2153		 * encrypted and decrypted is not being accessed.  But if
  2154		 * load_unaligned_zeropad() touches the "next" page, it may generate a
  2155		 * read access the caller has no control over. To ensure such accesses
  2156		 * cause a normal page fault for the load_unaligned_zeropad() handler,
  2157		 * mark the pages not present until the transition is complete.  We
  2158		 * don't want a #VE or #VC fault due to a mismatch in the memory
  2159		 * encryption status, since paravisor configurations can't cleanly do
  2160		 * the load_unaligned_zeropad() handling in the paravisor.
  2161		 *
  2162		 * There's no requirement to do so, but for efficiency we can clear
  2163		 * _PAGE_PRESENT and set/clr encryption attr as a single operation.
  2164		 */
  2165		cpa.mask_set = enc ? pgprot_encrypted(empty) : pgprot_decrypted(empty);
  2166		cpa.mask_clr = enc ? pgprot_decrypted(__pgprot(_PAGE_PRESENT)) :
  2167					pgprot_encrypted(__pgprot(_PAGE_PRESENT));
  2168		cpa.pgd = init_mm.pgd;
  2169	
  2170		/* Must avoid aliasing mappings in the highmem code */
  2171		kmap_flush_unused();
  2172		vm_unmap_aliases();
  2173	
  2174		/* Flush the caches as needed before changing the encryption attr. */
  2175		if (x86_platform.guest.enc_cache_flush_required())
  2176			cpa_flush(&cpa, 1);
  2177	
  2178		ret = __change_page_attr_set_clr(&cpa, 1);
  2179		if (ret)
  2180			return ret;
  2181	
  2182		/*
  2183		 * After clearing _PAGE_PRESENT and changing the encryption attribute,
  2184		 * we need to flush TLBs to ensure no further accesses to the memory can
  2185		 * be made with the old encryption attribute (but no need to flush caches
  2186		 * again).  We could just use cpa_flush_all(), but in case TLB flushing
  2187		 * gets optimized in the cpa_flush() path use the same logic as above.
  2188		 */
  2189		cpa_flush(&cpa, 0);
  2190	
  2191		/* Notify hypervisor that we have successfully set/clr encryption attr. */
  2192		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
  2193			return -EIO;
  2194	
  2195		/*
  2196		 * Now that the hypervisor is sync'ed with the page table changes
  2197		 * made here, add back _PAGE_PRESENT. set_memory_p() does not flush
  2198		 * the TLB.
  2199		 */
> 2200		return set_memory_p(&addr, numpages);
  2201	}
  2202	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

