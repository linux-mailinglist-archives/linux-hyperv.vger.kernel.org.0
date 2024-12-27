Return-Path: <linux-hyperv+bounces-3548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA559FD818
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 23:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB65718823F3
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 22:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C46E156C5E;
	Fri, 27 Dec 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jPSBpZeJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636F113F42F;
	Fri, 27 Dec 2024 22:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735339981; cv=none; b=qj8TJQ0fY6TtCMd7dstYin95sfHe4ixzgJAHT/EYEdM+Z9XZVq9v9c4bn2H4l5YtQZApwuW1LLmDSbLqpIDQ0VfZ+cnxyZ23+atyIEKwzSNZJb1XfV8dDTGDXacgBAftliAjkS8FlEfIxWl+RJzr/VXQMEBoKvvFl8IeCUhq/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735339981; c=relaxed/simple;
	bh=SPvVk9yuZpYBy4J8tDLc2Va0/ymguPSJitWutlGCHXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiPEUv/5yLzicDHl0UgSy304iOGg/2ndBJAFGkPk1eX/MyMWybqx7Wtpa7/3X0k7N+M5EmSCtjdOaE6fI3yiChCWht2/T1GyMKFxowQtY0DHmvLdBXxfV/Fe9NIVoaalHfxLqVYUXQcRX7UvtL7bKwvAbzAKK0reUuAjh/aupKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jPSBpZeJ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735339979; x=1766875979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SPvVk9yuZpYBy4J8tDLc2Va0/ymguPSJitWutlGCHXk=;
  b=jPSBpZeJEsf5mmXHhv74a+eAylI2ndMc8Ld+KzVCSIjRGzZsKqhit2yd
   qwmYwcKLyrIegXBIR1rmfndYcPNOGbhccWEJ31OWvEj5p+oVr+lVbA2ZF
   2gk6p+9Be/rMV2CsA93OknsUoCEzta/kSa2PY1gJNZjUvS0IpQ5cPElBd
   s2QlbpTIsbWq6eqPgMpbDckLCmwnRhUBSArgTUATKaMggab+VCUfFdcxh
   Ue7P2W9IzYUHD/uG0gGOvw+QwlA/43xOyg/h/h04zOvjFVPLr930iHxAo
   qRsStLS6nQwGP81811h+jZxowLU85dUgpLAn2pe7BL8xNiYC0jBVETO/r
   A==;
X-CSE-ConnectionGUID: i4k5ula2SIixMvUfHCQIWQ==
X-CSE-MsgGUID: s6u+CqvrRSOCCQIlZl3Y5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11298"; a="39670206"
X-IronPort-AV: E=Sophos;i="6.12,269,1728975600"; 
   d="scan'208";a="39670206"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 14:52:59 -0800
X-CSE-ConnectionGUID: +wLlhhGISHqex8jTIAmxdA==
X-CSE-MsgGUID: b05W+ofeTYKCF4RLjBcpGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="131217953"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 27 Dec 2024 14:52:54 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tRJCN-0003hg-3B;
	Fri, 27 Dec 2024 22:52:51 +0000
Date: Sat, 28 Dec 2024 06:52:50 +0800
From: kernel test robot <lkp@intel.com>
To: Roman Kisel <romank@linux.microsoft.com>, hpa@zytor.com,
	kys@microsoft.com, bp@alien8.de, dave.hansen@linux.intel.com,
	decui@microsoft.com, eahariha@linux.microsoft.com,
	haiyangz@microsoft.com, mingo@redhat.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, tglx@linutronix.de,
	tiala@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, apais@microsoft.com,
	benhill@microsoft.com, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
Message-ID: <202412280604.2Fvp7M4m-lkp@intel.com>
References: <20241227183155.122827-2-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241227183155.122827-2-romank@linux.microsoft.com>

Hi Roman,

kernel test robot noticed the following build errors:

[auto build test ERROR on 26e1b813fcd02984b1cac5f3decdf4b0bb56fe02]

url:    https://github.com/intel-lab-lkp/linux/commits/Roman-Kisel/hyperv-Define-struct-hv_output_get_vp_registers/20241228-023454
base:   26e1b813fcd02984b1cac5f3decdf4b0bb56fe02
patch link:    https://lore.kernel.org/r/20241227183155.122827-2-romank%40linux.microsoft.com
patch subject: [PATCH v4 1/5] hyperv: Define struct hv_output_get_vp_registers
config: arm64-randconfig-001-20241228 (https://download.01.org/0day-ci/archive/20241228/202412280604.2Fvp7M4m-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241228/202412280604.2Fvp7M4m-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412280604.2Fvp7M4m-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/hyperv/hvhdk_mini.h:8,
                    from include/hyperv/hvhdk.h:10,
                    from arch/arm64/hyperv/hv_core.c:17:
>> include/hyperv/hvgdk_mini.h:828:40: error: field 'cs' has incomplete type
     828 |         struct hv_x64_segment_register cs;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:829:40: error: field 'ds' has incomplete type
     829 |         struct hv_x64_segment_register ds;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:830:40: error: field 'es' has incomplete type
     830 |         struct hv_x64_segment_register es;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:831:40: error: field 'fs' has incomplete type
     831 |         struct hv_x64_segment_register fs;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:832:40: error: field 'gs' has incomplete type
     832 |         struct hv_x64_segment_register gs;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:833:40: error: field 'ss' has incomplete type
     833 |         struct hv_x64_segment_register ss;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:834:40: error: field 'tr' has incomplete type
     834 |         struct hv_x64_segment_register tr;
         |                                        ^~
>> include/hyperv/hvgdk_mini.h:835:40: error: field 'ldtr' has incomplete type
     835 |         struct hv_x64_segment_register ldtr;
         |                                        ^~~~
>> include/hyperv/hvgdk_mini.h:837:38: error: field 'idtr' has incomplete type
     837 |         struct hv_x64_table_register idtr;
         |                                      ^~~~
>> include/hyperv/hvgdk_mini.h:838:38: error: field 'gdtr' has incomplete type
     838 |         struct hv_x64_table_register gdtr;
         |                                      ^~~~
>> include/hyperv/hvhdk.h:78:56: error: field 'es' has incomplete type
      78 |                         struct hv_x64_segment_register es;
         |                                                        ^~
>> include/hyperv/hvhdk.h:79:56: error: field 'cs' has incomplete type
      79 |                         struct hv_x64_segment_register cs;
         |                                                        ^~
>> include/hyperv/hvhdk.h:80:56: error: field 'ss' has incomplete type
      80 |                         struct hv_x64_segment_register ss;
         |                                                        ^~
>> include/hyperv/hvhdk.h:81:56: error: field 'ds' has incomplete type
      81 |                         struct hv_x64_segment_register ds;
         |                                                        ^~
>> include/hyperv/hvhdk.h:82:56: error: field 'fs' has incomplete type
      82 |                         struct hv_x64_segment_register fs;
         |                                                        ^~
>> include/hyperv/hvhdk.h:83:56: error: field 'gs' has incomplete type
      83 |                         struct hv_x64_segment_register gs;
         |                                                        ^~
>> include/hyperv/hvhdk.h:86:48: error: array type has incomplete element type 'struct hv_x64_segment_register'
      86 |                 struct hv_x64_segment_register segment_registers[6];
         |                                                ^~~~~~~~~~~~~~~~~
>> include/hyperv/hvhdk.h:95:52: error: field 'pending_interruption' has incomplete type
      95 |         union hv_x64_pending_interruption_register pending_interruption;
         |                                                    ^~~~~~~~~~~~~~~~~~~~
>> include/hyperv/hvhdk.h:96:47: error: field 'interrupt_state' has incomplete type
      96 |         union hv_x64_interrupt_state_register interrupt_state;
         |                                               ^~~~~~~~~~~~~~~


vim +/cs +828 include/hyperv/hvgdk_mini.h

dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  822  
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  823  struct hv_init_vp_context {
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  824  	u64 rip;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  825  	u64 rsp;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  826  	u64 rflags;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  827  
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @828  	struct hv_x64_segment_register cs;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @829  	struct hv_x64_segment_register ds;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @830  	struct hv_x64_segment_register es;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @831  	struct hv_x64_segment_register fs;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @832  	struct hv_x64_segment_register gs;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @833  	struct hv_x64_segment_register ss;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @834  	struct hv_x64_segment_register tr;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @835  	struct hv_x64_segment_register ldtr;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  836  
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @837  	struct hv_x64_table_register idtr;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25 @838  	struct hv_x64_table_register gdtr;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  839  
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  840  	u64 efer;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  841  	u64 cr0;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  842  	u64 cr3;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  843  	u64 cr4;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  844  	u64 msr_cr_pat;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  845  } __packed;
dd4f3a2b21ac14 Nuno Das Neves 2024-11-25  846  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

