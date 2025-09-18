Return-Path: <linux-hyperv+bounces-6924-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 761BEB82BD9
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 05:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B3567A3A9B
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Sep 2025 03:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F615219A7E;
	Thu, 18 Sep 2025 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYsk6GQi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525AA1A9FB4;
	Thu, 18 Sep 2025 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165543; cv=none; b=N6ka4jOYM3E5fODazXzlTV2772w5HCTfjAmAWjSwR8zfUhFuNv5MdW7sL3HzU84xNppvOH3Uu4DoZmPDLXJx8yn+/GFTTWSWp/h1fY797VgOgNOZ0NeZDokknB8jRsu2Yv9QfAfyxXcUgccm56nVc7kouaiChPgq7Cm3YINkUzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165543; c=relaxed/simple;
	bh=BXxqhBJxXxvdickLzCyDX1rwS2LGPscfHrBsIJKBFHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcO5DOvcu/XyseWhb4tMPrvHk5PrHurJm0KdpEa3vYuk16tylGPqZTXaYkGeTgh3duhRp7Zl4+z4JzrEbXcMTha+uX20eHBZvOvRSVuUB65W92y6IJxOsOaHnTNTl3wzzS8KdNKBPCEmvbU0oFQpR/hQrKizKjiOEERalrBoJxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYsk6GQi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758165541; x=1789701541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BXxqhBJxXxvdickLzCyDX1rwS2LGPscfHrBsIJKBFHg=;
  b=ZYsk6GQimeEClkTSAJuKnNE90lRNkstRog3rElWPg3O4uDZYuTv2l3dK
   y7ZJf97QvYiABPaWACbmqxiMPeNEkow1kfdqwdq8/d12GaMySV/EmAkK0
   quQCRGyqszcZqfMb7W453jjUU/OzPOkmeWDrafihOm9UumKUatbhNI/Sh
   +5cIAF5mNhfDtixIenIj84qrQZQ8vMlOQFhUxN9/y80f5u4lbRGOqYMGy
   mtyNvKw3uKmjy/N3hyakVGrplDCVKSjjAup909DTvv+SK7coBElcf7Ae9
   JXpE3jFV96fJpo9NGQi0J274hHZQnofHUvHzxCbXAFe5LM+lu1bazSeym
   g==;
X-CSE-ConnectionGUID: zHtofWgrS5SykMbZcNWFyQ==
X-CSE-MsgGUID: Uzi2IYiXTBOzOjEgd62rBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11556"; a="85925411"
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="85925411"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 20:19:00 -0700
X-CSE-ConnectionGUID: lnvzHdwpST6cNElr5TApng==
X-CSE-MsgGUID: LA6PePTrQ6WURP8TceJ/ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,273,1751266800"; 
   d="scan'208";a="179702293"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 17 Sep 2025 20:18:55 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uz5Aa-0002hN-0w;
	Thu, 18 Sep 2025 03:18:52 +0000
Date: Thu, 18 Sep 2025 11:18:00 +0800
From: kernel test robot <lkp@intel.com>
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-hyperv@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>, Jiri Kosina <jikos@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 01/21] x86/paravirt: Remove not needed includes of
 paravirt.h
Message-ID: <202509181151.ja2As5H4-lkp@intel.com>
References: <20250917145220.31064-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917145220.31064-2-jgross@suse.com>

Hi Juergen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on kvm/queue kvm/next linus/master v6.17-rc6 next-20250917]
[cannot apply to tip/x86/core kvm/linux-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Juergen-Gross/x86-paravirt-Remove-not-needed-includes-of-paravirt-h/20250917-230321
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20250917145220.31064-2-jgross%40suse.com
patch subject: [PATCH v2 01/21] x86/paravirt: Remove not needed includes of paravirt.h
config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20250918/202509181151.ja2As5H4-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250918/202509181151.ja2As5H4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509181151.ja2As5H4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/cpu.c:13:
   In file included from include/linux/sched/isolation.h:5:
   In file included from include/linux/cpuset.h:18:
   In file included from include/linux/mmu_context.h:5:
>> arch/x86/include/asm/mmu_context.h:225:2: error: call to undeclared function 'paravirt_enter_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     225 |         paravirt_enter_mmap(mm);
         |         ^
>> arch/x86/include/asm/mmu_context.h:232:2: error: call to undeclared function 'paravirt_arch_exit_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     232 |         paravirt_arch_exit_mmap(mm);
         |         ^
   arch/x86/include/asm/mmu_context.h:232:2: note: did you mean 'ldt_arch_exit_mmap'?
   arch/x86/include/asm/mmu_context.h:61:6: note: 'ldt_arch_exit_mmap' declared here
      61 | void ldt_arch_exit_mmap(struct mm_struct *mm);
         |      ^
   In file included from kernel/cpu.c:42:
   In file included from include/trace/events/power.h:12:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:53:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:33:
   In file included from arch/x86/include/asm/rqspinlock.h:5:
   arch/x86/include/asm/paravirt.h:736:20: error: static declaration of 'paravirt_enter_mmap' follows non-static declaration
     736 | static inline void paravirt_enter_mmap(struct mm_struct *mm)
         |                    ^
   arch/x86/include/asm/mmu_context.h:225:2: note: previous implicit declaration is here
     225 |         paravirt_enter_mmap(mm);
         |         ^
   In file included from kernel/cpu.c:42:
   In file included from include/trace/events/power.h:12:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:53:
   In file included from include/linux/security.h:35:
   In file included from include/linux/bpf.h:33:
   In file included from arch/x86/include/asm/rqspinlock.h:5:
   arch/x86/include/asm/paravirt.h:742:20: error: static declaration of 'paravirt_arch_exit_mmap' follows non-static declaration
     742 | static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
         |                    ^
   arch/x86/include/asm/mmu_context.h:232:2: note: previous implicit declaration is here
     232 |         paravirt_arch_exit_mmap(mm);
         |         ^
   4 errors generated.
--
   In file included from kernel/workqueue.c:52:
   In file included from include/linux/sched/isolation.h:5:
   In file included from include/linux/cpuset.h:18:
   In file included from include/linux/mmu_context.h:5:
>> arch/x86/include/asm/mmu_context.h:225:2: error: call to undeclared function 'paravirt_enter_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     225 |         paravirt_enter_mmap(mm);
         |         ^
>> arch/x86/include/asm/mmu_context.h:232:2: error: call to undeclared function 'paravirt_arch_exit_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     232 |         paravirt_arch_exit_mmap(mm);
         |         ^
   arch/x86/include/asm/mmu_context.h:232:2: note: did you mean 'ldt_arch_exit_mmap'?
   arch/x86/include/asm/mmu_context.h:61:6: note: 'ldt_arch_exit_mmap' declared here
      61 | void ldt_arch_exit_mmap(struct mm_struct *mm);
         |      ^
   2 errors generated.
--
>> arch/x86/kernel/x86_init.c:90:15: error: use of undeclared identifier 'default_banner'
      90 |                 .banner                 = default_banner,
         |                                           ^
   1 error generated.
--
   In file included from arch/x86/mm/init.c:30:
>> arch/x86/include/asm/mmu_context.h:225:2: error: call to undeclared function 'paravirt_enter_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     225 |         paravirt_enter_mmap(mm);
         |         ^
>> arch/x86/include/asm/mmu_context.h:232:2: error: call to undeclared function 'paravirt_arch_exit_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     232 |         paravirt_arch_exit_mmap(mm);
         |         ^
   arch/x86/include/asm/mmu_context.h:232:2: note: did you mean 'ldt_arch_exit_mmap'?
   arch/x86/include/asm/mmu_context.h:61:6: note: 'ldt_arch_exit_mmap' declared here
      61 | void ldt_arch_exit_mmap(struct mm_struct *mm);
         |      ^
>> arch/x86/mm/init.c:827:2: error: call to undeclared function 'paravirt_enter_mmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     827 |         paravirt_enter_mmap(text_poke_mm);
         |         ^
   3 errors generated.


vim +/paravirt_enter_mmap +225 arch/x86/include/asm/mmu_context.h

a31e184e4f6996 Dave Hansen        2019-01-02  221  
c10e83f598d080 Thomas Gleixner    2017-12-14  222  static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
a1ea1c032b8f8c Dave Hansen        2014-11-18  223  {
a31e184e4f6996 Dave Hansen        2019-01-02  224  	arch_dup_pkeys(oldmm, mm);
c9ae1b10d95610 Juergen Gross      2023-02-07 @225  	paravirt_enter_mmap(mm);
82721d8b25d76c Kirill A. Shutemov 2023-03-12  226  	dup_lam(oldmm, mm);
a4828f81037f49 Thomas Gleixner    2017-12-14  227  	return ldt_dup_context(oldmm, mm);
a1ea1c032b8f8c Dave Hansen        2014-11-18  228  }
a1ea1c032b8f8c Dave Hansen        2014-11-18  229  
a1ea1c032b8f8c Dave Hansen        2014-11-18  230  static inline void arch_exit_mmap(struct mm_struct *mm)
a1ea1c032b8f8c Dave Hansen        2014-11-18  231  {
a1ea1c032b8f8c Dave Hansen        2014-11-18 @232  	paravirt_arch_exit_mmap(mm);
f55f0501cbf65e Andy Lutomirski    2017-12-12  233  	ldt_arch_exit_mmap(mm);
a1ea1c032b8f8c Dave Hansen        2014-11-18  234  }
a1ea1c032b8f8c Dave Hansen        2014-11-18  235  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

