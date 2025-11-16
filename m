Return-Path: <linux-hyperv+bounces-7613-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7312EC611B2
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 09:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E954E4E21EC
	for <lists+linux-hyperv@lfdr.de>; Sun, 16 Nov 2025 08:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605AE27FD52;
	Sun, 16 Nov 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evt5yK63"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B214884C;
	Sun, 16 Nov 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763281049; cv=none; b=Hm7XdlqKTBSB9OB94DJ8U+2S8YNjZ3GhHkRv4jK5zPd7HM9RVBbT/34aY/8ijbtEZ5Itdbwq9NOLgmv9yOfU8/yA9YGzhH4ns7hyZ7JROB+wsOd/4SriQEFyOXW/Cs760Bc/G3Mv3vubop3csZZhIZeP3d7uLFxMwVtXCnTOrSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763281049; c=relaxed/simple;
	bh=JX0iwPY3B8f53h18SuWzlM68IcEeYuWN+SQJOegTfF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwZvqhiaQTSoH+sjPtDgonBRjEcKwdSY61MXtHB3CbAwQDT8MeiNQfs6It7zCm7zp9NLQM3DS6iiHihibn3DYZpRN6aq2z8FVGjOK57Rgodd3Tq2j7MkrQhsWF8vmrPGVYZmyvBf/Y+qdRlWeJ6nX24DXgVVbjraElLk4ecCFlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evt5yK63; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763281047; x=1794817047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JX0iwPY3B8f53h18SuWzlM68IcEeYuWN+SQJOegTfF8=;
  b=evt5yK63x2nX0fSvZKZw4kIVQo9Krdyf+UYzlsWHHwPBhkNNRhUpX315
   R8uVAxJY9rGu4APKy2e2hK6Eg7rgp7fUe9p8gXcpn2m8pajRoa55zuKw/
   h6H51Inuj5wQqmy80M/4hycYSBI6SWVQtUXYtzOSoCsd5A8Bt04IIIZcB
   Y8hw0IE8ChBmXG1BVUOH8hAqk3S7+KhiUN6/4ZlYGjHUPfqB1PCcze10D
   WYedyMZkZqt30phm2AfcgnUmbDgk2EvDLrtM/adRMIQY19QMioroM3HCX
   fIXf0OGvIfzie3V9/wqN3/iFlFV+xhpilD4oMVpIkeOhb5On5M1MyvYIt
   g==;
X-CSE-ConnectionGUID: NNrbRxpEQdu1WdaJLyU2dA==
X-CSE-MsgGUID: oxAQCEnfSyC3FaFGLGZHQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11614"; a="76771969"
X-IronPort-AV: E=Sophos;i="6.19,309,1754982000"; 
   d="scan'208";a="76771969"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2025 00:17:27 -0800
X-CSE-ConnectionGUID: IekSeUZmQkCthgKLsoSjpQ==
X-CSE-MsgGUID: pppzODKLSqqXSa/KY7jhpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,309,1754982000"; 
   d="scan'208";a="220832343"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 16 Nov 2025 00:17:24 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vKXwn-0008ch-2R;
	Sun, 16 Nov 2025 08:17:21 +0000
Date: Sun, 16 Nov 2025 16:17:08 +0800
From: kernel test robot <lkp@intel.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	anirudh@anirudhrb.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
Message-ID: <202511161617.KcDzR4sA-lkp@intel.com>
References: <20251114095853.3482596-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114095853.3482596-1-anirudh@anirudhrb.com>

Hi Anirudh,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc5]
[cannot apply to next-20251114]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anirudh-Rayabharam/Drivers-hv-ioctl-for-self-targeted-passthrough-hvcalls/20251114-182039
base:   linus/master
patch link:    https://lore.kernel.org/r/20251114095853.3482596-1-anirudh%40anirudhrb.com
patch subject: [PATCH] Drivers: hv: ioctl for self targeted passthrough hvcalls
config: x86_64-buildonly-randconfig-005-20251116 (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251116/202511161617.KcDzR4sA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511161617.KcDzR4sA-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:125:2: error: use of undeclared identifier 'HVCALL_GET_PARTITION_PROPERTY_EX'
     125 |         HVCALL_GET_PARTITION_PROPERTY_EX,
         |         ^
>> drivers/hv/mshv_root_main.c:175:18: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
     175 |         for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^~~~~
   drivers/hv/mshv_root_main.c:179:11: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
     179 |         if (i >= ARRAY_SIZE(mshv_passthru_hvcalls))
         |         ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
   drivers/hv/mshv_root_main.c:179:11: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
     179 |         if (i >= ARRAY_SIZE(mshv_passthru_hvcalls))
         |         ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:61: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                             ^~~~
   drivers/hv/mshv_root_main.c:179:11: error: invalid application of 'sizeof' to an incomplete type 'u16[]' (aka 'unsigned short[]')
     179 |         if (i >= ARRAY_SIZE(mshv_passthru_hvcalls))
         |         ~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/array_size.h:11:32: note: expanded from macro 'ARRAY_SIZE'
      11 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                ^
   include/linux/compiler.h:55:47: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                            ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                     ~~~~~~~~~~~~~~~~~^~~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   5 errors generated.


vim +/HVCALL_GET_PARTITION_PROPERTY_EX +125 drivers/hv/mshv_root_main.c

   117	
   118	/*
   119	 * Only allow hypercalls that have a u64 partition id as the first member of
   120	 * the input structure.
   121	 * These are sorted by value.
   122	 */
   123	static u16 mshv_passthru_hvcalls[] = {
   124		HVCALL_GET_PARTITION_PROPERTY,
 > 125		HVCALL_GET_PARTITION_PROPERTY_EX,
   126		HVCALL_SET_PARTITION_PROPERTY,
   127		HVCALL_INSTALL_INTERCEPT,
   128		HVCALL_GET_VP_REGISTERS,
   129		HVCALL_SET_VP_REGISTERS,
   130		HVCALL_TRANSLATE_VIRTUAL_ADDRESS,
   131		HVCALL_CLEAR_VIRTUAL_INTERRUPT,
   132		HVCALL_REGISTER_INTERCEPT_RESULT,
   133		HVCALL_ASSERT_VIRTUAL_INTERRUPT,
   134		HVCALL_GET_GPA_PAGES_ACCESS_STATES,
   135		HVCALL_SIGNAL_EVENT_DIRECT,
   136		HVCALL_POST_MESSAGE_DIRECT,
   137		HVCALL_GET_VP_CPUID_VALUES,
   138	};
   139	
   140	static bool mshv_hvcall_is_async(u16 code)
   141	{
   142		switch (code) {
   143		case HVCALL_SET_PARTITION_PROPERTY:
   144			return true;
   145		default:
   146			break;
   147		}
   148		return false;
   149	}
   150	
   151	static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
   152					      bool partition_locked,
   153					      void __user *user_args)
   154	{
   155		u64 status;
   156		int ret = 0, i;
   157		bool is_async;
   158		struct mshv_root_hvcall args;
   159		struct page *page;
   160		unsigned int pages_order;
   161		void *input_pg = NULL;
   162		void *output_pg = NULL;
   163		u64 pt_id = partition ? partition->pt_id : HV_PARTITION_ID_SELF;
   164	
   165		if (copy_from_user(&args, user_args, sizeof(args)))
   166			return -EFAULT;
   167	
   168		if (args.status || !args.in_ptr || args.in_sz < sizeof(u64) ||
   169		    mshv_field_nonzero(args, rsvd) || args.in_sz > HV_HYP_PAGE_SIZE)
   170			return -EINVAL;
   171	
   172		if (args.out_ptr && (!args.out_sz || args.out_sz > HV_HYP_PAGE_SIZE))
   173			return -EINVAL;
   174	
 > 175		for (i = 0; i < ARRAY_SIZE(mshv_passthru_hvcalls); ++i)
   176			if (args.code == mshv_passthru_hvcalls[i])
   177				break;
   178	
   179		if (i >= ARRAY_SIZE(mshv_passthru_hvcalls))
   180			return -EINVAL;
   181	
   182		is_async = mshv_hvcall_is_async(args.code);
   183		if (is_async) {
   184			/* async hypercalls can only be called from partition fd */
   185			if (!partition || !partition_locked)
   186				return -EINVAL;
   187			ret = mshv_init_async_handler(partition);
   188			if (ret)
   189				return ret;
   190		}
   191	
   192		pages_order = args.out_ptr ? 1 : 0;
   193		page = alloc_pages(GFP_KERNEL, pages_order);
   194		if (!page)
   195			return -ENOMEM;
   196		input_pg = page_address(page);
   197	
   198		if (args.out_ptr)
   199			output_pg = (char *)input_pg + PAGE_SIZE;
   200		else
   201			output_pg = NULL;
   202	
   203		if (copy_from_user(input_pg, (void __user *)args.in_ptr,
   204				   args.in_sz)) {
   205			ret = -EFAULT;
   206			goto free_pages_out;
   207		}
   208	
   209		/*
   210		 * NOTE: This only works because all the allowed hypercalls' input
   211		 * structs begin with a u64 partition_id field.
   212		 */
   213		*(u64 *)input_pg = pt_id;
   214	
   215		if (args.reps)
   216			status = hv_do_rep_hypercall(args.code, args.reps, 0,
   217						     input_pg, output_pg);
   218		else
   219			status = hv_do_hypercall(args.code, input_pg, output_pg);
   220	
   221		if (hv_result(status) == HV_STATUS_CALL_PENDING) {
   222			if (is_async) {
   223				mshv_async_hvcall_handler(partition, &status);
   224			} else { /* Paranoia check. This shouldn't happen! */
   225				ret = -EBADFD;
   226				goto free_pages_out;
   227			}
   228		}
   229	
   230		if (hv_result(status) == HV_STATUS_INSUFFICIENT_MEMORY) {
   231			ret = hv_call_deposit_pages(NUMA_NO_NODE, pt_id, 1);
   232			if (!ret)
   233				ret = -EAGAIN;
   234		} else if (!hv_result_success(status)) {
   235			ret = hv_result_to_errno(status);
   236		}
   237	
   238		/*
   239		 * Always return the status and output data regardless of result.
   240		 * The VMM may need it to determine how to proceed. E.g. the status may
   241		 * contain the number of reps completed if a rep hypercall partially
   242		 * succeeded.
   243		 */
   244		args.status = hv_result(status);
   245		args.reps = args.reps ? hv_repcomp(status) : 0;
   246		if (copy_to_user(user_args, &args, sizeof(args)))
   247			ret = -EFAULT;
   248	
   249		if (output_pg &&
   250		    copy_to_user((void __user *)args.out_ptr, output_pg, args.out_sz))
   251			ret = -EFAULT;
   252	
   253	free_pages_out:
   254		free_pages((unsigned long)input_pg, pages_order);
   255	
   256		return ret;
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

