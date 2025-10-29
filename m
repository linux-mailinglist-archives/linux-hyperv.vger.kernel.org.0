Return-Path: <linux-hyperv+bounces-7374-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8F5C1B75F
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 15:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F7E1AA3696
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Oct 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2ADE2DFA4A;
	Wed, 29 Oct 2025 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZAH8GKTj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E22DFF13;
	Wed, 29 Oct 2025 14:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749093; cv=none; b=SezrJxMULz/6JOCfjxuJYu99tCucD+CWKrXs2ZDf3BQAmWTtF07AKDrYnD3NdOs/0ggm6V6AV0Vb4TnYLI3SOn1bsQFdLNhxYwzbAujtBONGfer06p7dVzFp/g3QKEfia0ba6dF5lE2Tsm6Qr8LCEMfSLcKV1UQAjBfVEP3w8U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749093; c=relaxed/simple;
	bh=f04o+2kudaJVs/XLB6HkyXUx5Zuh0WyRwPsFiAddPMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peMN8cpwr7g2DFQVtiHwpS5UebQgQdfDiIye74qMGN1d4oA5gjWI3K9S7T/JfXmRm1yYlpiBgRoa1Uyr4ipF6T/GL3/nJICIARwgnBz0Qz+Zo+eUYknSZ/NwIFUs1AFOFFS/7XKpcfR4OoXSPbScMhU2W49H/BkcsvyWW8UttQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZAH8GKTj; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761749092; x=1793285092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f04o+2kudaJVs/XLB6HkyXUx5Zuh0WyRwPsFiAddPMk=;
  b=ZAH8GKTj2SQT3NbDPQctZtfx+E3SGSAeLOsB/Dss6WBwlXAypXDJRz42
   wiDooXwQxl2Q2gsz8IGa7OPJ+Kd60GwTAzxVv6240msGig82boJZbLEbO
   i1NXWqZrUK57rjrxfFfYSrXO4pgO/MmhtwXv986pEeK4Su6QiSZp9jBI0
   7GcOXwyljmMdJuBAoaQTs8gBKLinntKX1rQ6naYiN9Dy+mu5v9+ndj0cK
   uVYi9t2f48jztddfJJISa+i4SmC8fZGGRFI1lLkJMgxGIWeSBooYOPoas
   qNVDUQOsHGx44f2aoWaHvwOSOonZrb1DQCDif8sXvHMYmL1NdmJ8REkR3
   Q==;
X-CSE-ConnectionGUID: lsVo0G2wRxSB/e9yPIOA2A==
X-CSE-MsgGUID: CcCSu5e5T+6eqSiFsaGRsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="67734909"
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="67734909"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 07:44:51 -0700
X-CSE-ConnectionGUID: Z2nJEacrTxyDublb6HKksg==
X-CSE-MsgGUID: mXqjdIdMTzugyHF1HdwWlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,264,1754982000"; 
   d="scan'208";a="189750113"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Oct 2025 07:44:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vE7Pg-000KhR-0I;
	Wed, 29 Oct 2025 14:44:45 +0000
Date: Wed, 29 Oct 2025 22:43:52 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	muislam@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com, romank@linux.microsoft.com,
	Jinank Jain <jinankjain@microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH] mshv: Extend create partition ioctl to support cpu
 features
Message-ID: <202510292227.lgcNjlQ5-lkp@intel.com>
References: <1761685562-6272-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1761685562-6272-1-git-send-email-nunodasneves@linux.microsoft.com>

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc3 next-20251029]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/mshv-Extend-create-partition-ioctl-to-support-cpu-features/20251029-050748
base:   linus/master
patch link:    https://lore.kernel.org/r/1761685562-6272-1-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH] mshv: Extend create partition ioctl to support cpu features
config: arm64-randconfig-r072-20251029 (https://download.01.org/0day-ci/archive/20251029/202510292227.lgcNjlQ5-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project d1c086e82af239b245fe8d7832f2753436634990)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251029/202510292227.lgcNjlQ5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510292227.lgcNjlQ5-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/hv/mshv_root_main.c:1996:18: error: expected ';' after return statement
    1996 |                         return -EINVAL
         |                                       ^
         |                                       ;
   1 error generated.


vim +1996 drivers/hv/mshv_root_main.c

  1864	
  1865	static_assert(MSHV_NUM_CPU_FEATURES_BANKS <=
  1866		      HV_PARTITION_PROCESSOR_FEATURES_BANKS);
  1867	
  1868	static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
  1869						struct hv_partition_creation_properties *cr_props,
  1870						union hv_partition_isolation_properties *isol_props)
  1871	{
  1872		int i;
  1873		struct mshv_create_partition_v2 args;
  1874		union hv_partition_processor_features *disabled_procs;
  1875		union hv_partition_processor_xsave_features *disabled_xsave;
  1876	
  1877		/* First, copy orig struct in case user is on previous versions */
  1878		if (copy_from_user(&args, user_arg,
  1879				   sizeof(struct mshv_create_partition)))
  1880			return -EFAULT;
  1881	
  1882		if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
  1883		     args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
  1884			return -EINVAL;
  1885	
  1886		disabled_procs = &cr_props->disabled_processor_features;
  1887	
  1888		/* Disable all processor features first */
  1889		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
  1890			disabled_procs->as_uint64[i] = -1;
  1891	
  1892	#if IS_ENABLED(CONFIG_X86_64)
  1893		/* Enable default features that are known to be supported */
  1894		disabled_procs->cet_ibt_support = 0;
  1895		disabled_procs->cet_ss_support = 0;
  1896		disabled_procs->smep_support = 0;
  1897		disabled_procs->rdtscp_support = 0;
  1898		disabled_procs->tsc_invariant_support = 0;
  1899		disabled_procs->sse3_support = 0;
  1900		disabled_procs->lahf_sahf_support = 0;
  1901		disabled_procs->ssse3_support = 0;
  1902		disabled_procs->sse4_1_support = 0;
  1903		disabled_procs->sse4_2_support = 0;
  1904		disabled_procs->sse4a_support = 0;
  1905		disabled_procs->xop_support = 0;
  1906		disabled_procs->pop_cnt_support = 0;
  1907		disabled_procs->cmpxchg16b_support = 0;
  1908		disabled_procs->altmovcr8_support = 0;
  1909		disabled_procs->lzcnt_support = 0;
  1910		disabled_procs->mis_align_sse_support = 0;
  1911		disabled_procs->mmx_ext_support = 0;
  1912		disabled_procs->amd3dnow_support = 0;
  1913		disabled_procs->extended_amd3dnow_support = 0;
  1914		disabled_procs->aes_support = 0;
  1915		disabled_procs->pclmulqdq_support = 0;
  1916		disabled_procs->pcid_support = 0;
  1917		disabled_procs->fma4_support = 0;
  1918		disabled_procs->f16c_support = 0;
  1919		disabled_procs->rd_rand_support = 0;
  1920		disabled_procs->rd_wr_fs_gs_support = 0;
  1921		disabled_procs->enhanced_fast_string_support = 0;
  1922		disabled_procs->bmi1_support = 0;
  1923		disabled_procs->bmi2_support = 0;
  1924		disabled_procs->hle_support_deprecated = 0;
  1925		disabled_procs->rtm_support_deprecated = 0;
  1926		disabled_procs->movbe_support = 0;
  1927		disabled_procs->npiep1_support = 0;
  1928		disabled_procs->dep_x87_fpu_save_support = 0;
  1929		disabled_procs->rd_seed_support = 0;
  1930		disabled_procs->adx_support = 0;
  1931		disabled_procs->intel_prefetch_support = 0;
  1932		disabled_procs->smap_support = 0;
  1933		disabled_procs->hle_support = 0;
  1934		disabled_procs->rtm_support = 0;
  1935		disabled_procs->invpcid_support = 0;
  1936		disabled_procs->ibrs_support = 0;
  1937		disabled_procs->stibp_support = 0;
  1938		disabled_procs->mdd_support = 0;
  1939		disabled_procs->ibpb_support = 0;
  1940		disabled_procs->l1dcache_flush_support = 0;
  1941		disabled_procs->virt_spec_ctrl_support = 0;
  1942		disabled_procs->mb_clear_support = 0;
  1943		disabled_procs->tsx_ctrl_support = 0;
  1944		disabled_procs->clflushopt_support = 0;
  1945		disabled_procs->rdcl_no_support = 0;
  1946		disabled_procs->ibrs_all_support = 0;
  1947		disabled_procs->page_1gb_support = 0;
  1948		disabled_procs->skip_l1df_support = 0;
  1949		disabled_procs->ssb_no_support = 0;
  1950		disabled_procs->mbs_no_support = 0;
  1951		disabled_procs->taa_no_support = 0;
  1952		disabled_procs->fb_clear_support = 0;
  1953		disabled_procs->gds_no_support = 0;
  1954		disabled_procs->bhi_no_support = 0;
  1955		disabled_procs->bhi_dis_support = 0;
  1956		disabled_procs->btc_no_support = 0;
  1957		disabled_procs->mitigation_ctrl_support = 0;
  1958		disabled_procs->rfds_no_support = 0;
  1959		disabled_procs->rfds_clear_support = 0;
  1960		disabled_procs->unrestricted_guest_support = 0;
  1961		disabled_procs->fast_short_rep_mov_support = 0;
  1962		disabled_procs->rsb_a_no_support = 0;
  1963		disabled_procs->rd_pid_support = 0;
  1964		disabled_procs->umip_support = 0;
  1965		disabled_procs->vmx_exception_inject_support = 0;
  1966		disabled_procs->rdpru_support = 0;
  1967		disabled_procs->mbec_support = 0;
  1968		disabled_procs->psfd_support = 0;
  1969	
  1970		/* Enable default XSave features that are known to be supported*/
  1971		disabled_xsave = &cr_props->disabled_processor_xsave_features;
  1972		disabled_xsave->as_uint64 = -1;
  1973		disabled_xsave->xsave_support = 0;
  1974		disabled_xsave->xsaveopt_support = 0;
  1975		disabled_xsave->avx_support = 0;
  1976		disabled_xsave->xsave_supervisor_support = 0;
  1977		disabled_xsave->xsave_comp_support = 0;
  1978	#endif
  1979		/* Check if user provided newer struct with feature fields */
  1980		if (args.pt_flags & BIT(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
  1981			if (copy_from_user(&args, user_arg, sizeof(args)))
  1982				return -EFAULT;
  1983	
  1984			if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
  1985			    mshv_field_nonzero(args, pt_rsvd) ||
  1986			    mshv_field_nonzero(args, pt_rsvd1))
  1987				return -EINVAL;
  1988	
  1989			for (i = 0; i < args.pt_num_cpu_fbanks; i++)
  1990				disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
  1991	
  1992	#if IS_ENABLED(CONFIG_X86_64)
  1993			disabled_xsave->as_uint64 = args.pt_disabled_xsave;
  1994	#else
  1995			if (mshv_field_nonzero(args, pt_rsvd2))
> 1996				return -EINVAL
  1997	#endif
  1998		}
  1999	
  2000		/* Only support EXO partitions */
  2001		*pt_flags = HV_PARTITION_CREATION_FLAG_EXO_PARTITION |
  2002			    HV_PARTITION_CREATION_FLAG_INTERCEPT_MESSAGE_PAGE_ENABLED;
  2003	
  2004		if (args.pt_flags & BIT(MSHV_PT_BIT_LAPIC))
  2005			*pt_flags |= HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED;
  2006		if (args.pt_flags & BIT(MSHV_PT_BIT_X2APIC))
  2007			*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
  2008		if (args.pt_flags & BIT(MSHV_PT_BIT_GPA_SUPER_PAGES))
  2009			*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
  2010	
  2011		switch (args.pt_isolation) {
  2012		case MSHV_PT_ISOLATION_NONE:
  2013			isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_NONE;
  2014			break;
  2015		case MSHV_PT_ISOLATION_SNP:
  2016			isol_props->isolation_type = HV_PARTITION_ISOLATION_TYPE_SNP;
  2017			break;
  2018		}
  2019	
  2020		return 0;
  2021	}
  2022	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

