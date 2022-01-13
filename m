Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEF448D474
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiAMI5Y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 03:57:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:48317 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233249AbiAMI4l (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 03:56:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642064201; x=1673600201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHLvVjlhQE5kTdaUsCi6eqXByGYxXWxfs81qy3HRFtM=;
  b=aWS0sicWdY5gcfPTaTULS9VtbtpAumwWrJ+7sKUTqoUjZhIe/y1pV348
   XeBIzQVGnBeVyiH1kL+e5TkhlcVIRzynwoC3SmIM+TLRojYxy4FIrN+jW
   E+tOLETP1dnrh13rNu1ieEmSo1VoEc5QqroNdyik6A+1LaKhcnw57635t
   bbWRC+Y2e8e+4Ez82VueDzH0JnShTWbjZF7ECcg1u7wcy4muBLPUlqzGS
   9Ecnf/R/kin+z8UrOVR9cZwWFA+HcZobjJ+/FLvq1hNY4CllvLP+gLuXa
   0iueHYRCYjYoUHJ376N1PDtuANudlM982AbWRK/KH8+vroajnKLddVDNX
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244171443"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244171443"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 00:56:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475238615"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 Jan 2022 00:56:37 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7vuO-00071d-O1; Thu, 13 Jan 2022 08:56:36 +0000
Date:   Thu, 13 Jan 2022 16:56:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 3/9] drivers: hv: dxgkrnl: Implement
 creation/destruction of GPU allocations/resources
Message-ID: <202201131642.1nercfCr-lkp@intel.com>
References: <b64ae0f1fceff68b6fb43331f14062f25f2ba07a.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64ae0f1fceff68b6fb43331f14062f25f2ba07a.1641937419.git.iourit@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16 next-20220113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Iouri-Tarassov/drivers-hv-dxgkrnl-Driver-overview/20220113-035836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e3084ed48fd6b661fe434da0cb36d7d6706cf27f
config: arm64-randconfig-r032-20220113 (https://download.01.org/0day-ci/archive/20220113/202201131642.1nercfCr-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/a2aa8c606c48a4e6bf8a7a51e2e4e5738e35da32
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iouri-Tarassov/drivers-hv-dxgkrnl-Driver-overview/20220113-035836
        git checkout a2aa8c606c48a4e6bf8a7a51e2e4e5738e35da32
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hv/dxgkrnl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/hv/dxgkrnl/ioctl.c:21:
   drivers/hv/dxgkrnl/dxgvmbus.h:867:26: warning: implicit conversion from enumeration type 'enum dxgkvmb_commandtype' to different enumeration type 'enum dxgkvmb_commandtype_global' [-Wenum-conversion]
           command->command_type   = DXGK_VMBCOMMAND_INVALID;
                                   ~ ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/dxgkrnl/ioctl.c:1245:5: warning: no previous prototype for function 'validate_alloc' [-Wmissing-prototypes]
   int validate_alloc(struct dxgallocation *alloc0,
       ^
   drivers/hv/dxgkrnl/ioctl.c:1245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int validate_alloc(struct dxgallocation *alloc0,
   ^
   static 
   2 warnings generated.
--
   In file included from drivers/hv/dxgkrnl/dxgvmbus.c:23:
   drivers/hv/dxgkrnl/dxgvmbus.h:867:26: warning: implicit conversion from enumeration type 'enum dxgkvmb_commandtype' to different enumeration type 'enum dxgkvmb_commandtype_global' [-Wenum-conversion]
           command->command_type   = DXGK_VMBCOMMAND_INVALID;
                                   ~ ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/hv/dxgkrnl/dxgvmbus.c:151:5: warning: no previous prototype for function 'ntstatus2int' [-Wmissing-prototypes]
   int ntstatus2int(struct ntstatus status)
       ^
   drivers/hv/dxgkrnl/dxgvmbus.c:151:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int ntstatus2int(struct ntstatus status)
   ^
   static 
   drivers/hv/dxgkrnl/dxgvmbus.c:254:6: warning: no previous prototype for function 'process_inband_packet' [-Wmissing-prototypes]
   void process_inband_packet(struct dxgvmbuschannel *channel,
        ^
   drivers/hv/dxgkrnl/dxgvmbus.c:254:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void process_inband_packet(struct dxgvmbuschannel *channel,
   ^
   static 
   drivers/hv/dxgkrnl/dxgvmbus.c:272:6: warning: no previous prototype for function 'process_completion_packet' [-Wmissing-prototypes]
   void process_completion_packet(struct dxgvmbuschannel *channel,
        ^
   drivers/hv/dxgkrnl/dxgvmbus.c:272:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void process_completion_packet(struct dxgvmbuschannel *channel,
   ^
   static 
   drivers/hv/dxgkrnl/dxgvmbus.c:398:5: warning: no previous prototype for function 'dxgvmb_send_async_msg' [-Wmissing-prototypes]
   int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
       ^
   drivers/hv/dxgkrnl/dxgvmbus.c:398:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
   ^
   static 
>> drivers/hv/dxgkrnl/dxgvmbus.c:909:5: warning: no previous prototype for function 'create_existing_sysmem' [-Wmissing-prototypes]
   int create_existing_sysmem(struct dxgdevice *device,
       ^
   drivers/hv/dxgkrnl/dxgvmbus.c:909:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int create_existing_sysmem(struct dxgdevice *device,
   ^
   static 
   drivers/hv/dxgkrnl/dxgvmbus.c:234:20: warning: unused function 'command_vm_to_host_init0' [-Wunused-function]
   static inline void command_vm_to_host_init0(struct dxgkvmb_command_vm_to_host
                      ^
   7 warnings generated.


vim +/validate_alloc +1245 drivers/hv/dxgkrnl/ioctl.c

  1244	
> 1245	int validate_alloc(struct dxgallocation *alloc0,
  1246				       struct dxgallocation *alloc,
  1247				       struct dxgdevice *device,
  1248				       struct d3dkmthandle alloc_handle)
  1249	{
  1250		u32 fail_reason;
  1251	
  1252		if (alloc == NULL) {
  1253			fail_reason = 1;
  1254			goto cleanup;
  1255		}
  1256		if (alloc->resource_owner != alloc0->resource_owner) {
  1257			fail_reason = 2;
  1258			goto cleanup;
  1259		}
  1260		if (alloc->resource_owner) {
  1261			if (alloc->owner.resource != alloc0->owner.resource) {
  1262				fail_reason = 3;
  1263				goto cleanup;
  1264			}
  1265			if (alloc->owner.resource->device != device) {
  1266				fail_reason = 4;
  1267				goto cleanup;
  1268			}
  1269			if (alloc->owner.resource->shared_owner) {
  1270				fail_reason = 5;
  1271				goto cleanup;
  1272			}
  1273		} else {
  1274			if (alloc->owner.device != device) {
  1275				fail_reason = 6;
  1276				goto cleanup;
  1277			}
  1278		}
  1279		return 0;
  1280	cleanup:
  1281		pr_err("Alloc validation failed: reason: %d %x",
  1282			   fail_reason, alloc_handle.v);
  1283		return -EINVAL;
  1284	}
  1285	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
