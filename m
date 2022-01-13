Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD0C48D31D
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 08:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiAMHot (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 13 Jan 2022 02:44:49 -0500
Received: from mga14.intel.com ([192.55.52.115]:41780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231894AbiAMHos (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 13 Jan 2022 02:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642059888; x=1673595888;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxqGF2XLv2IIKw8rIApzQRHQ85ix43Ninc+YqRe6kF8=;
  b=fTYvgHPK1dzCVVwIKtDKyN7sQzFD82+gZig3d1895YfBTS+43+Ucx8ZD
   IBiYjqtOJ77UB+0xU0exgq5q0xTRTuPLTpD0sKFFJXkkj/hRtijeu2P/5
   fpNp9AxkG90BHN9JWOGuhNnIcHxCdHobbIVLmoEoAefqeK7hmP5t1d04V
   pjoYujpBc9V8vTYHVHOTRQ9gyJqz5ZfjNSt6Kc50IavK1cBxkf+10XKqc
   AKe2H2dekhnRoQvBQ+aNrusat0XldjDJsIXfSJZ9K91bJbWAt8jyWboUb
   JHYOY+TRiOcpQHJef9Bgtx8c06yeturtcmDHe65/V0CDlPtwU6uDOa76f
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="244157146"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="244157146"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 23:44:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="528921417"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jan 2022 23:44:36 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7umh-0006y3-9s; Thu, 13 Jan 2022 07:44:35 +0000
Date:   Thu, 13 Jan 2022 15:44:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 2/9] drivers: hv: dxgkrnl: Open device object, adapter
 enumeration, dxgdevice, dxgcontext creation
Message-ID: <202201131549.w952i85x-lkp@intel.com>
References: <79cf6932161dd52c226c9f7a729b5b3a0a217fc3.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79cf6932161dd52c226c9f7a729b5b3a0a217fc3.1641937419.git.iourit@linux.microsoft.com>
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
config: arm64-randconfig-r032-20220113 (https://download.01.org/0day-ci/archive/20220113/202201131549.w952i85x-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d1021978b8e7e35dcc30201ca1731d64b5a602a8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/91a8d0866d1c0efc52ca8e1cb504e0ec15c979e2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iouri-Tarassov/drivers-hv-dxgkrnl-Driver-overview/20220113-035836
        git checkout 91a8d0866d1c0efc52ca8e1cb504e0ec15c979e2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/hv/dxgkrnl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hv/dxgkrnl/hmgr.c:85:5: warning: no previous prototype for function 'get_instance' [-Wmissing-prototypes]
   u32 get_instance(struct d3dkmthandle h)
       ^
   drivers/hv/dxgkrnl/hmgr.c:85:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 get_instance(struct d3dkmthandle h)
   ^
   static 
>> drivers/hv/dxgkrnl/hmgr.c:172:6: warning: no previous prototype for function 'print_status' [-Wmissing-prototypes]
   void print_status(struct hmgrtable *table)
        ^
   drivers/hv/dxgkrnl/hmgr.c:172:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void print_status(struct hmgrtable *table)
   ^
   static 
>> drivers/hv/dxgkrnl/hmgr.c:551:21: warning: no previous prototype for function 'hmgrtable_get_entry_type' [-Wmissing-prototypes]
   enum hmgrentry_type hmgrtable_get_entry_type(struct hmgrtable *table,
                       ^
   drivers/hv/dxgkrnl/hmgr.c:551:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   enum hmgrentry_type hmgrtable_get_entry_type(struct hmgrtable *table,
   ^
   static 
   drivers/hv/dxgkrnl/hmgr.c:167:20: warning: unused function 'is_empty' [-Wunused-function]
   static inline bool is_empty(struct hmgrtable *table)
                      ^
   4 warnings generated.
--
>> drivers/hv/dxgkrnl/dxgadapter.c:261:6: warning: no previous prototype for function 'dxgdevice_mark_destroyed' [-Wmissing-prototypes]
   void dxgdevice_mark_destroyed(struct dxgdevice *device)
        ^
   drivers/hv/dxgkrnl/dxgadapter.c:261:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dxgdevice_mark_destroyed(struct dxgdevice *device)
   ^
   static 
   1 warning generated.


vim +/get_instance +85 drivers/hv/dxgkrnl/hmgr.c

    84	
  > 85	u32 get_instance(struct d3dkmthandle h)
    86	{
    87		return (h.v & HMGRHANDLE_INSTANCE_MASK) >> HMGRHANDLE_INSTANCE_SHIFT;
    88	}
    89	
    90	static bool is_handle_valid(struct hmgrtable *table, struct d3dkmthandle h,
    91				    bool ignore_destroyed, enum hmgrentry_type t)
    92	{
    93		u32 index = get_index(h);
    94		u32 unique = get_unique(h);
    95		struct hmgrentry *entry;
    96	
    97		if (index >= table->table_size) {
    98			pr_err("%s Invalid index %x %d\n", __func__, h.v, index);
    99			return false;
   100		}
   101	
   102		entry = &table->entry_table[index];
   103		if (unique != entry->unique) {
   104			pr_err("%s Invalid unique %x %d %d %d %p",
   105				   __func__, h.v, unique, entry->unique,
   106				   index, entry->object);
   107			return false;
   108		}
   109	
   110		if (entry->destroyed && !ignore_destroyed) {
   111			pr_err("%s Invalid destroyed", __func__);
   112			return false;
   113		}
   114	
   115		if (entry->type == HMGRENTRY_TYPE_FREE) {
   116			pr_err("%s Entry is freed %x %d", __func__, h.v, index);
   117			return false;
   118		}
   119	
   120		if (t != HMGRENTRY_TYPE_FREE && t != entry->type) {
   121			pr_err("%s type mismatch %x %d %d", __func__, h.v,
   122				   t, entry->type);
   123			return false;
   124		}
   125	
   126		return true;
   127	}
   128	
   129	static struct d3dkmthandle build_handle(u32 index, u32 unique, u32 instance)
   130	{
   131		struct d3dkmthandle handle;
   132	
   133		handle.v = (index << HMGRHANDLE_INDEX_SHIFT) & HMGRHANDLE_INDEX_MASK;
   134		handle.v |= (unique << HMGRHANDLE_UNIQUE_SHIFT) &
   135		    HMGRHANDLE_UNIQUE_MASK;
   136		handle.v |= (instance << HMGRHANDLE_INSTANCE_SHIFT) &
   137		    HMGRHANDLE_INSTANCE_MASK;
   138	
   139		return handle;
   140	}
   141	
   142	inline u32 hmgrtable_get_used_entry_count(struct hmgrtable *table)
   143	{
   144		DXGKRNL_ASSERT(table->table_size >= table->free_count);
   145		return (table->table_size - table->free_count);
   146	}
   147	
   148	bool hmgrtable_mark_destroyed(struct hmgrtable *table, struct d3dkmthandle h)
   149	{
   150		if (!is_handle_valid(table, h, false, HMGRENTRY_TYPE_FREE))
   151			return false;
   152	
   153		table->entry_table[get_index(h)].destroyed = true;
   154		return true;
   155	}
   156	
   157	bool hmgrtable_unmark_destroyed(struct hmgrtable *table, struct d3dkmthandle h)
   158	{
   159		if (!is_handle_valid(table, h, true, HMGRENTRY_TYPE_FREE))
   160			return true;
   161	
   162		DXGKRNL_ASSERT(table->entry_table[get_index(h)].destroyed);
   163		table->entry_table[get_index(h)].destroyed = 0;
   164		return true;
   165	}
   166	
   167	static inline bool is_empty(struct hmgrtable *table)
   168	{
   169		return (table->free_count == table->table_size);
   170	}
   171	
 > 172	void print_status(struct hmgrtable *table)
   173	{
   174		int i;
   175	
   176		dev_dbg(dxgglobaldev, "hmgrtable head, tail %p %d %d\n",
   177			    table, table->free_handle_list_head,
   178			    table->free_handle_list_tail);
   179		if (table->entry_table == NULL)
   180			return;
   181		for (i = 0; i < 3; i++) {
   182			if (table->entry_table[i].type != HMGRENTRY_TYPE_FREE)
   183				dev_dbg(dxgglobaldev, "hmgrtable entry %p %d %p\n",
   184					    table, i, table->entry_table[i].object);
   185			else
   186				dev_dbg(dxgglobaldev, "hmgrtable entry %p %d %d %d\n",
   187					    table, i,
   188					    table->entry_table[i].next_free_index,
   189					    table->entry_table[i].prev_free_index);
   190		}
   191	}
   192	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
