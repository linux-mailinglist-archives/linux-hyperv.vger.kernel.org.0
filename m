Return-Path: <linux-hyperv+bounces-2101-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFAC8C34E9
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 May 2024 04:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373A2B20EC4
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 May 2024 02:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0812B64B;
	Sun, 12 May 2024 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxM4KoHc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191CC8E1;
	Sun, 12 May 2024 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715482480; cv=none; b=VhnmEFt9VCrtF2wgooM8cJ7K733SwLYSiO80EIV12V7VKnn1VHguGSFC+RIxF+bem7XD4AY4CQvxqQsTssXLKaSeXj+ODVZtKJxG2Alk/Sz5JpYjskLMa9vQqSCxwkt1a5ti3Mu8PVFfknskE1dLuxWXOVizAUBfgystoxxB56U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715482480; c=relaxed/simple;
	bh=nsmtopQAtTAguHVY1JQhAHcxOhd41jt/nPq2IMdyt6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCtGl+9Rz2RlygFRzv7eX3nygU+U1nXg9OjQqEylHNWv/TzQUY4itblPM1ltGtsM2r9FvOn6vfPgxEQRBuiebfVQG763zfOY4apVUkKUf+erIDyD5WifiRJEEBZ05tfFrrhYstlMo7NsJETB44pJzfnyF8DlYhk4gyMD89nmTGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxM4KoHc; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715482479; x=1747018479;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nsmtopQAtTAguHVY1JQhAHcxOhd41jt/nPq2IMdyt6Q=;
  b=nxM4KoHc8BrpGu7yRw4F4EbJGYYAH+0AiYYYlBe58zcJN7fwlvqtBFWd
   omgjZ2es+4us1l71ELHvAvo501B2s8GxNrPqi0zyeWqLBULf5GH00Bdm2
   d/eVeEdzAXVd6sfIthPA+H4Hjru3BtkxOArVVr1OLpPGafGZMSIWnxX7r
   g1X5G0Spgw80ODunjqjBuTBsLTYbfrTK0gkdjTSqJN4uAYOgFjuzPbrJi
   o5YJtvi/9N4JpHP5La4oEvrcSdKD6Rnavs95iPsVbRymTtcqYBzxRTus4
   /bNDdZjlZNKdJGV+2//Z6i7U+nd3btybHDNQYQRcj+yzyKvBF6tgoPmhW
   Q==;
X-CSE-ConnectionGUID: YfNn5vp1RbiB/VpwrLjtWA==
X-CSE-MsgGUID: fN1fnyt9TTixBkoILzUHhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11070"; a="11306751"
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="11306751"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 19:54:38 -0700
X-CSE-ConnectionGUID: VsMHds0oTuOPMkINX2QyGw==
X-CSE-MsgGUID: QXKX32dXQraSS8F1d8eWxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,155,1712646000"; 
   d="scan'208";a="61175094"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 11 May 2024 19:54:35 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5zM8-00085z-2d;
	Sun, 12 May 2024 02:54:32 +0000
Date: Sun, 12 May 2024 10:54:26 +0800
From: kernel test robot <lkp@intel.com>
To: romank@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, ssengar@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH 2/6] drivers/hv: Enable VTL mode for arm64
Message-ID: <202405121034.fVYQIs8h-lkp@intel.com>
References: <20240510160602.1311352-3-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510160602.1311352-3-romank@linux.microsoft.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arnd-asm-generic/master linus/master v6.9-rc7 next-20240510]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/romank-linux-microsoft-com/arm64-hyperv-Support-DeviceTree/20240511-000917
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20240510160602.1311352-3-romank%40linux.microsoft.com
patch subject: [PATCH 2/6] drivers/hv: Enable VTL mode for arm64
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240512/202405121034.fVYQIs8h-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240512/202405121034.fVYQIs8h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405121034.fVYQIs8h-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_system_desc_base':
>> arch/x86/hyperv/hv_vtl.c:54:28: error: 'struct ldttss_desc' has no member named 'base3'; did you mean 'base0'?
      54 |         return ((u64)desc->base3 << 32) | ((u64)desc->base2 << 24) |
         |                            ^~~~~
         |                            base0
   arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_ap_entry':
>> arch/x86/hyperv/hv_vtl.c:66:35: error: 'secondary_startup_64' undeclared (first use in this function); did you mean 'secondary_startup_64_fn'?
      66 |         ((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
         |                                   ^~~~~~~~~~~~~~~~~~~~
         |                                   secondary_startup_64_fn
   arch/x86/hyperv/hv_vtl.c:66:35: note: each undeclared identifier is reported only once for each function it appears in
   arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_bringup_vcpu':
>> arch/x86/hyperv/hv_vtl.c:86:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
      86 |         u64 rip = (u64)&hv_vtl_ap_entry;
         |                   ^
   arch/x86/hyperv/hv_vtl.c: In function 'hv_vtl_system_desc_base':
>> arch/x86/hyperv/hv_vtl.c:56:1: warning: control reaches end of non-void function [-Wreturn-type]
      56 | }
         | ^


vim +54 arch/x86/hyperv/hv_vtl.c

3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   51  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   52  static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   53  {
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  @54  	return ((u64)desc->base3 << 32) | ((u64)desc->base2 << 24) |
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   55  		(desc->base1 << 16) | desc->base0;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  @56  }
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   57  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   58  static inline u32 hv_vtl_system_desc_limit(struct ldttss_desc *desc)
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   59  {
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   60  	return ((u32)desc->limit1 << 16) | (u32)desc->limit0;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   61  }
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   62  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   63  typedef void (*secondary_startup_64_fn)(void*, void*);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   64  static void hv_vtl_ap_entry(void)
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   65  {
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  @66  	((secondary_startup_64_fn)secondary_startup_64)(&boot_params, &boot_params);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   67  }
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   68  
2b4b90e053a290 Saurabh Sengar 2024-03-03   69  static int hv_vtl_bringup_vcpu(u32 target_vp_index, int cpu, u64 eip_ignored)
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   70  {
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   71  	u64 status;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   72  	int ret = 0;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   73  	struct hv_enable_vp_vtl *input;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   74  	unsigned long irq_flags;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   75  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   76  	struct desc_ptr gdt_ptr;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   77  	struct desc_ptr idt_ptr;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   78  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   79  	struct ldttss_desc *tss;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   80  	struct ldttss_desc *ldt;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   81  	struct desc_struct *gdt;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   82  
2b4b90e053a290 Saurabh Sengar 2024-03-03   83  	struct task_struct *idle = idle_thread_get(cpu);
2b4b90e053a290 Saurabh Sengar 2024-03-03   84  	u64 rsp = (unsigned long)idle->thread.sp;
2b4b90e053a290 Saurabh Sengar 2024-03-03   85  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  @86  	u64 rip = (u64)&hv_vtl_ap_entry;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   87  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   88  	native_store_gdt(&gdt_ptr);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   89  	store_idt(&idt_ptr);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   90  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   91  	gdt = (struct desc_struct *)((void *)(gdt_ptr.address));
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   92  	tss = (struct ldttss_desc *)(gdt + GDT_ENTRY_TSS);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   93  	ldt = (struct ldttss_desc *)(gdt + GDT_ENTRY_LDT);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   94  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   95  	local_irq_save(irq_flags);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   96  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   97  	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   98  	memset(input, 0, sizeof(*input));
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10   99  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  100  	input->partition_id = HV_PARTITION_ID_SELF;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  101  	input->vp_index = target_vp_index;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  102  	input->target_vtl.target_vtl = HV_VTL_MGMT;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  103  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  104  	/*
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  105  	 * The x86_64 Linux kernel follows the 16-bit -> 32-bit -> 64-bit
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  106  	 * mode transition sequence after waking up an AP with SIPI whose
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  107  	 * vector points to the 16-bit AP startup trampoline code. Here in
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  108  	 * VTL2, we can't perform that sequence as the AP has to start in
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  109  	 * the 64-bit mode.
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  110  	 *
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  111  	 * To make this happen, we tell the hypervisor to load a valid 64-bit
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  112  	 * context (most of which is just magic numbers from the CPU manual)
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  113  	 * so that AP jumps right to the 64-bit entry of the kernel, and the
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  114  	 * control registers are loaded with values that let the AP fetch the
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  115  	 * code and data and carry on with work it gets assigned.
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  116  	 */
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  117  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  118  	input->vp_context.rip = rip;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  119  	input->vp_context.rsp = rsp;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  120  	input->vp_context.rflags = 0x0000000000000002;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  121  	input->vp_context.efer = __rdmsr(MSR_EFER);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  122  	input->vp_context.cr0 = native_read_cr0();
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  123  	input->vp_context.cr3 = __native_read_cr3();
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  124  	input->vp_context.cr4 = native_read_cr4();
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  125  	input->vp_context.msr_cr_pat = __rdmsr(MSR_IA32_CR_PAT);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  126  	input->vp_context.idtr.limit = idt_ptr.size;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  127  	input->vp_context.idtr.base = idt_ptr.address;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  128  	input->vp_context.gdtr.limit = gdt_ptr.size;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  129  	input->vp_context.gdtr.base = gdt_ptr.address;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  130  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  131  	/* Non-system desc (64bit), long, code, present */
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  132  	input->vp_context.cs.selector = __KERNEL_CS;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  133  	input->vp_context.cs.base = 0;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  134  	input->vp_context.cs.limit = 0xffffffff;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  135  	input->vp_context.cs.attributes = 0xa09b;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  136  	/* Non-system desc (64bit), data, present, granularity, default */
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  137  	input->vp_context.ss.selector = __KERNEL_DS;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  138  	input->vp_context.ss.base = 0;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  139  	input->vp_context.ss.limit = 0xffffffff;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  140  	input->vp_context.ss.attributes = 0xc093;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  141  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  142  	/* System desc (128bit), present, LDT */
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  143  	input->vp_context.ldtr.selector = GDT_ENTRY_LDT * 8;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  144  	input->vp_context.ldtr.base = hv_vtl_system_desc_base(ldt);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  145  	input->vp_context.ldtr.limit = hv_vtl_system_desc_limit(ldt);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  146  	input->vp_context.ldtr.attributes = 0x82;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  147  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  148  	/* System desc (128bit), present, TSS, 0x8b - busy, 0x89 -- default */
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  149  	input->vp_context.tr.selector = GDT_ENTRY_TSS * 8;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  150  	input->vp_context.tr.base = hv_vtl_system_desc_base(tss);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  151  	input->vp_context.tr.limit = hv_vtl_system_desc_limit(tss);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  152  	input->vp_context.tr.attributes = 0x8b;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  153  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  154  	status = hv_do_hypercall(HVCALL_ENABLE_VP_VTL, input, NULL);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  155  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  156  	if (!hv_result_success(status) &&
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  157  	    hv_result(status) != HV_STATUS_VTL_ALREADY_ENABLED) {
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  158  		pr_err("HVCALL_ENABLE_VP_VTL failed for VP : %d ! [Err: %#llx\n]",
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  159  		       target_vp_index, status);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  160  		ret = -EINVAL;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  161  		goto free_lock;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  162  	}
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  163  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  164  	status = hv_do_hypercall(HVCALL_START_VP, input, NULL);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  165  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  166  	if (!hv_result_success(status)) {
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  167  		pr_err("HVCALL_START_VP failed for VP : %d ! [Err: %#llx]\n",
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  168  		       target_vp_index, status);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  169  		ret = -EINVAL;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  170  	}
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  171  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  172  free_lock:
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  173  	local_irq_restore(irq_flags);
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  174  
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  175  	return ret;
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  176  }
3be1bc2fe9d2e4 Saurabh Sengar 2023-04-10  177  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

