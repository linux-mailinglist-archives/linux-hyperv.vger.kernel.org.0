Return-Path: <linux-hyperv+bounces-411-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5607B5F28
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 04:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 6DD6BB20952
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 02:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FD817;
	Tue,  3 Oct 2023 02:52:24 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2962A
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 02:52:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7F9E;
	Mon,  2 Oct 2023 19:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696301541; x=1727837541;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TkKvNoN2m3qKuguFoIpXxzhKimeY0bARgIpvKk9JdAA=;
  b=e912WU0uBe7Wi/SHDhr2UBfLdD0Qbd3J9sxa8FuKt7MpLpD3+yI/VWGe
   bqvEO5B9WVmC6tUbq7R0vk3eyn1mQZ0v+yNJvNNdeGijvYdDfpHB0UC1b
   i0clwkHHLGSd+cr8lcQXS8sdqhuGlq86sUgjyRQM66PIMQoWWOrxhKYlr
   BAvyzXxOnhSPzIfaaMeLlWwgdlSCHYd+gmy81MYiFtLa/D5yw8i81HbzY
   CHMaezCRcP7JVe/cJfn4aEV2OKE+Qqk46Fq7kTk3JTx70xhBc63V8y1AE
   4iVKQWnW93v+/5CFcKthGuZ+RuZuSvfcqBJEZFvq5JW+WxNTjg/dTEItF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="382693099"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382693099"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 19:52:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1731264"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 02 Oct 2023 19:52:16 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qnVW8-0006gn-0P;
	Tue, 03 Oct 2023 02:52:12 +0000
Date: Tue, 3 Oct 2023 10:51:58 +0800
From: kernel test robot <lkp@intel.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	gregkh@linuxfoundation.org, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v4 07/15] Drivers: hv: Move hv_call_deposit_pages and
 hv_call_create_vp to common code
Message-ID: <202310031047.K8WOyczC-lkp@intel.com>
References: <1696010501-24584-8-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696010501-24584-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Nuno,

kernel test robot noticed the following build errors:

[auto build test ERROR on arnd-asm-generic/master]
[also build test ERROR on arm64/for-next/core linus/master v6.6-rc4 next-20230929]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nuno-Das-Neves/hyperv-tlfs-Change-shared-HV_REGISTER_-defines-to-HV_MSR_/20230930-041305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
patch link:    https://lore.kernel.org/r/1696010501-24584-8-git-send-email-nunodasneves%40linux.microsoft.com
patch subject: [PATCH v4 07/15] Drivers: hv: Move hv_call_deposit_pages and hv_call_create_vp to common code
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20231003/202310031047.K8WOyczC-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310031047.K8WOyczC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310031047.K8WOyczC-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/hv/hv_common.c: In function 'hv_call_create_vp':
>> drivers/hv/hv_common.c:596:29: error: 'hv_current_partition_id' undeclared (first use in this function); did you mean 'hv_get_partition_id'?
     596 |         if (partition_id != hv_current_partition_id) {
         |                             ^~~~~~~~~~~~~~~~~~~~~~~
         |                             hv_get_partition_id
   drivers/hv/hv_common.c:596:29: note: each undeclared identifier is reported only once for each function it appears in


vim +596 drivers/hv/hv_common.c

   587	
   588	int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
   589	{
   590		struct hv_create_vp *input;
   591		u64 status;
   592		unsigned long irq_flags;
   593		int ret = HV_STATUS_SUCCESS;
   594	
   595		/* Root VPs don't seem to need pages deposited */
 > 596		if (partition_id != hv_current_partition_id) {
   597			/* The value 90 is empirically determined. It may change. */
   598			ret = hv_call_deposit_pages(node, partition_id, 90);
   599			if (ret)
   600				return ret;
   601		}
   602	
   603		do {
   604			local_irq_save(irq_flags);
   605	
   606			input = *this_cpu_ptr(hyperv_pcpu_input_arg);
   607	
   608			input->partition_id = partition_id;
   609			input->vp_index = vp_index;
   610			input->flags = flags;
   611			input->subnode_type = HvSubnodeAny;
   612			input->proximity_domain_info =
   613				numa_node_to_proximity_domain_info(node);
   614			status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
   615			local_irq_restore(irq_flags);
   616	
   617			if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
   618				if (!hv_result_success(status)) {
   619					pr_err("%s: vcpu %u, lp %u, %s\n", __func__,
   620					       vp_index, flags, hv_status_to_string(status));
   621					ret = hv_status_to_errno(status);
   622				}
   623				break;
   624			}
   625			ret = hv_call_deposit_pages(node, partition_id, 1);
   626	
   627		} while (!ret);
   628	
   629		return ret;
   630	}
   631	EXPORT_SYMBOL_GPL(hv_call_create_vp);
   632	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

