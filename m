Return-Path: <linux-hyperv+bounces-7220-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF46BDD488
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 10:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5838F4E6904
	for <lists+linux-hyperv@lfdr.de>; Wed, 15 Oct 2025 08:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6A3292B4B;
	Wed, 15 Oct 2025 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XTPf2PCQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056E0238176;
	Wed, 15 Oct 2025 08:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760515338; cv=none; b=QsUV+aOAabtZ3pzZvI5CUvc1LarOJ3kfCOdBoMEVfcPox2X5pdoyDMTLuVEVbBZRXML0ULLaWKabhKOUepKUmIVnmhciJZMLnaiN+EdB3RDvSgCe9RmnJwz2x1nQ5EFfMnwwFIzDjGGeNsVQewDk6EkvUSRhf2zDLcqiijVdYc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760515338; c=relaxed/simple;
	bh=J1m4w5Q6RU8g6bCoHNpAX2jBZJpqbckzd8BdID7xu5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urBY7Tdl/SZJP4Nl+fWmMjUoQMK6BEj2tYWo3H0FXECz3V/Lezqu5w18gpfgkVk5Gab/piLugAu39uPxfcrW0nDXtKlDn6BzoSiQX26VMQe7GJd2/GTHSyczzycLToVLe1IkRfRB1H4GCMTaU99Dufv6yNjI8qQ0mRqxzTPVDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XTPf2PCQ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760515337; x=1792051337;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J1m4w5Q6RU8g6bCoHNpAX2jBZJpqbckzd8BdID7xu5w=;
  b=XTPf2PCQy9/fa2Fe3XsUYdEL7olYeL71U4E5e7Nb1hZiIDe1bibuFQsu
   ZWMPPb7/CNdwbmn8Hq7hAzX5CxfGWZhXGNnmqNczu37D6i8PZYtAwkAeP
   g7SQQElwleHiuTo724lgnlFwqYIR5b9zRNgv47Gtjgb22GXa+VNfBNM1N
   ret1b9bX6PqR6z7mLUi6Kip++obsKDrZp4NkBE00miov2Jm5l6VLQhE+r
   QQegIH+SYz5Vt6fkB1ds/cHsJQ6vaBfPoA7gRJKct7OmITKIdT39FzA3h
   ps9Zs+HFF8qPF9IiZckg6qj71iY6tpbri/4i/bAJ3IUJDgvAnMkD2ciWG
   Q==;
X-CSE-ConnectionGUID: zxSPlItSRWO0lk5GJgqI6g==
X-CSE-MsgGUID: GzVeLdKsTT+vtBSaYtUVFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="88149281"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="88149281"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 01:02:12 -0700
X-CSE-ConnectionGUID: M3Ra7s29Qg+9nfnsP7kglQ==
X-CSE-MsgGUID: MbGwwZilT/iSlXhyDe3Xlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="181239162"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 01:02:07 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v8wSQ-0003c7-2W;
	Wed, 15 Oct 2025 08:02:03 +0000
Date: Wed, 15 Oct 2025 16:01:23 +0800
From: kernel test robot <lkp@intel.com>
To: Praveen K Paladugu <prapal@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	tglx@linutronix.de, mingo@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de
Cc: oe-kbuild-all@lists.linux.dev, anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	nunodasneves@linux.microsoft.com, skinsburskii@linux.microsoft.com
Subject: Re: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition
 with MSHV
Message-ID: <202510151539.w9IHg8lU-lkp@intel.com>
References: <20251014164150.6935-3-prapal@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014164150.6935-3-prapal@linux.microsoft.com>

Hi Praveen,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on linus/master v6.18-rc1 next-20251014]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Praveen-K-Paladugu/hyperv-Add-definitions-for-MSHV-sleep-state-configuration/20251015-004650
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20251014164150.6935-3-prapal%40linux.microsoft.com
patch subject: [PATCH v2 2/2] hyperv: Enable clean shutdown for root partition with MSHV
config: i386-buildonly-randconfig-002-20251015 (https://download.01.org/0day-ci/archive/20251015/202510151539.w9IHg8lU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251015/202510151539.w9IHg8lU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510151539.w9IHg8lU-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/x86/hyperv/hv_init.c: In function 'hyperv_init':
>> arch/x86/hyperv/hv_init.c:556:23: error: implicit declaration of function 'hv_sleep_notifiers_register'; did you mean 'preempt_notifier_register'? [-Wimplicit-function-declaration]
     556 |                 (void)hv_sleep_notifiers_register();
         |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                       preempt_notifier_register
--
>> drivers/hv/hv_common.c:944:5: warning: no previous prototype for 'hv_sleep_notifiers_register' [-Wmissing-prototypes]
     944 | int hv_sleep_notifiers_register(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +556 arch/x86/hyperv/hv_init.c

   431	
   432	/*
   433	 * This function is to be invoked early in the boot sequence after the
   434	 * hypervisor has been detected.
   435	 *
   436	 * 1. Setup the hypercall page.
   437	 * 2. Register Hyper-V specific clocksource.
   438	 * 3. Setup Hyper-V specific APIC entry points.
   439	 */
   440	void __init hyperv_init(void)
   441	{
   442		u64 guest_id;
   443		union hv_x64_msr_hypercall_contents hypercall_msr;
   444		int cpuhp;
   445	
   446		if (x86_hyper_type != X86_HYPER_MS_HYPERV)
   447			return;
   448	
   449		if (hv_common_init())
   450			return;
   451	
   452		/*
   453		 * The VP assist page is useless to a TDX guest: the only use we
   454		 * would have for it is lazy EOI, which can not be used with TDX.
   455		 */
   456		if (hv_isolation_type_tdx())
   457			hv_vp_assist_page = NULL;
   458		else
   459			hv_vp_assist_page = kcalloc(nr_cpu_ids,
   460						    sizeof(*hv_vp_assist_page),
   461						    GFP_KERNEL);
   462		if (!hv_vp_assist_page) {
   463			ms_hyperv.hints &= ~HV_X64_ENLIGHTENED_VMCS_RECOMMENDED;
   464	
   465			if (!hv_isolation_type_tdx())
   466				goto common_free;
   467		}
   468	
   469		if (ms_hyperv.paravisor_present && hv_isolation_type_snp()) {
   470			/* Negotiate GHCB Version. */
   471			if (!hv_ghcb_negotiate_protocol())
   472				hv_ghcb_terminate(SEV_TERM_SET_GEN,
   473						  GHCB_SEV_ES_PROT_UNSUPPORTED);
   474	
   475			hv_ghcb_pg = alloc_percpu(union hv_ghcb *);
   476			if (!hv_ghcb_pg)
   477				goto free_vp_assist_page;
   478		}
   479	
   480		cpuhp = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "x86/hyperv_init:online",
   481					  hv_cpu_init, hv_cpu_die);
   482		if (cpuhp < 0)
   483			goto free_ghcb_page;
   484	
   485		/*
   486		 * Setup the hypercall page and enable hypercalls.
   487		 * 1. Register the guest ID
   488		 * 2. Enable the hypercall and register the hypercall page
   489		 *
   490		 * A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg:
   491		 * when the hypercall input is a page, such a VM must pass a decrypted
   492		 * page to Hyper-V, e.g. hv_post_message() uses the per-CPU page
   493		 * hyperv_pcpu_input_arg, which is decrypted if no paravisor is present.
   494		 *
   495		 * A TDX VM with the paravisor uses hv_hypercall_pg for most hypercalls,
   496		 * which are handled by the paravisor and the VM must use an encrypted
   497		 * input page: in such a VM, the hyperv_pcpu_input_arg is encrypted and
   498		 * used in the hypercalls, e.g. see hv_mark_gpa_visibility() and
   499		 * hv_arch_irq_unmask(). Such a VM uses TDX GHCI for two hypercalls:
   500		 * 1. HVCALL_SIGNAL_EVENT: see vmbus_set_event() and _hv_do_fast_hypercall8().
   501		 * 2. HVCALL_POST_MESSAGE: the input page must be a decrypted page, i.e.
   502		 * hv_post_message() in such a VM can't use the encrypted hyperv_pcpu_input_arg;
   503		 * instead, hv_post_message() uses the post_msg_page, which is decrypted
   504		 * in such a VM and is only used in such a VM.
   505		 */
   506		guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
   507		wrmsrq(HV_X64_MSR_GUEST_OS_ID, guest_id);
   508	
   509		/* With the paravisor, the VM must also write the ID via GHCB/GHCI */
   510		hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, guest_id);
   511	
   512		/* A TDX VM with no paravisor only uses TDX GHCI rather than hv_hypercall_pg */
   513		if (hv_isolation_type_tdx() && !ms_hyperv.paravisor_present)
   514			goto skip_hypercall_pg_init;
   515	
   516		hv_hypercall_pg = __vmalloc_node_range(PAGE_SIZE, 1, MODULES_VADDR,
   517				MODULES_END, GFP_KERNEL, PAGE_KERNEL_ROX,
   518				VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
   519				__builtin_return_address(0));
   520		if (hv_hypercall_pg == NULL)
   521			goto clean_guest_os_id;
   522	
   523		rdmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   524		hypercall_msr.enable = 1;
   525	
   526		if (hv_root_partition()) {
   527			struct page *pg;
   528			void *src;
   529	
   530			/*
   531			 * For the root partition, the hypervisor will set up its
   532			 * hypercall page. The hypervisor guarantees it will not show
   533			 * up in the root's address space. The root can't change the
   534			 * location of the hypercall page.
   535			 *
   536			 * Order is important here. We must enable the hypercall page
   537			 * so it is populated with code, then copy the code to an
   538			 * executable page.
   539			 */
   540			wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   541	
   542			pg = vmalloc_to_page(hv_hypercall_pg);
   543			src = memremap(hypercall_msr.guest_physical_address << PAGE_SHIFT, PAGE_SIZE,
   544					MEMREMAP_WB);
   545			BUG_ON(!src);
   546			memcpy_to_page(pg, 0, src, HV_HYP_PAGE_SIZE);
   547			memunmap(src);
   548	
   549			hv_remap_tsc_clocksource();
   550			/*
   551			 * The notifier registration might fail at various hops.
   552			 * Corresponding error messages will land in dmesg. There is
   553			 * otherwise nothing that can be specifically done to handle
   554			 * failures here.
   555			 */
 > 556			(void)hv_sleep_notifiers_register();
   557		} else {
   558			hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
   559			wrmsrq(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
   560		}
   561	
   562		hv_set_hypercall_pg(hv_hypercall_pg);
   563	
   564	skip_hypercall_pg_init:
   565		/*
   566		 * hyperv_init() is called before LAPIC is initialized: see
   567		 * apic_intr_mode_init() -> x86_platform.apic_post_init() and
   568		 * apic_bsp_setup() -> setup_local_APIC(). The direct-mode STIMER
   569		 * depends on LAPIC, so hv_stimer_alloc() should be called from
   570		 * x86_init.timers.setup_percpu_clockev.
   571		 */
   572		old_setup_percpu_clockev = x86_init.timers.setup_percpu_clockev;
   573		x86_init.timers.setup_percpu_clockev = hv_stimer_setup_percpu_clockev;
   574	
   575		hv_apic_init();
   576	
   577		x86_init.pci.arch_init = hv_pci_init;
   578	
   579		register_syscore_ops(&hv_syscore_ops);
   580	
   581		if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
   582			hv_get_partition_id();
   583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

