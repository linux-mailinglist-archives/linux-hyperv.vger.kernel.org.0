Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB3748D03D
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Jan 2022 02:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbiAMBtc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 12 Jan 2022 20:49:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:21826 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231445AbiAMBtb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 12 Jan 2022 20:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642038571; x=1673574571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aV1IRwF7QmGNhF4kQZH+fgmZ1S/kPyy2qaTPidaBol4=;
  b=hlqYqT2ba1yXdWU43cL8TVim5k1NO7leAHFyWLf7MP83xT3BZA+j4LBj
   8d3B+rMeP/5/Js9hOKJCCdDZPt78g7Vk7ZOaW+SOB6b1rursI6dfQf3DX
   sX/bJ7ZjHG6g8D+5Wt0FhQ3tztyf64G/aMSg5PztaF17Fj86FCsMCEtrm
   0qxTyRBPxYLMdu0CrX9iI1hmmf6AVp9Jduux81X2odt3/OVLMzIAgfjzB
   y0sX7vUGYqsPt5hThA+tBR4UZkAbgIMc7BU9AwI4vptMX8OWqSFGdotjh
   B3mUAdA+7lgPQStVewSgch++kKXUChw+BUyWY0OMn+EME5EVw4Laun59E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="243700580"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="243700580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 17:49:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="613791775"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2022 17:49:27 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7pF1-0006hC-An; Thu, 13 Jan 2022 01:49:27 +0000
Date:   Thu, 13 Jan 2022 09:49:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Iouri Tarassov <iourit@linux.microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        linux-hyperv@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v1 1/9] drivers: hv: dxgkrnl: Driver initialization and
 creation of dxgadapter
Message-ID: <202201130941.ZVnyqikS-lkp@intel.com>
References: <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b26482b50832b95a9d8532c493cee6c97323b87.1641937419.git.iourit@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Iouri,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16 next-20220112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Iouri-Tarassov/drivers-hv-dxgkrnl-Driver-overview/20220113-035836
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git e3084ed48fd6b661fe434da0cb36d7d6706cf27f
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220113/202201130941.ZVnyqikS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/00f97c12e2cf0ba4ba1108e2fce9a3d0e287cc8c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Iouri-Tarassov/drivers-hv-dxgkrnl-Driver-overview/20220113-035836
        git checkout 00f97c12e2cf0ba4ba1108e2fce9a3d0e287cc8c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/hv/dxgkrnl/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hv/dxgkrnl/dxgmodule.c:79:20: warning: no previous prototype for 'find_pci_adapter' [-Wmissing-prototypes]
      79 | struct dxgadapter *find_pci_adapter(struct pci_dev *dev)
         |                    ^~~~~~~~~~~~~~~~
>> drivers/hv/dxgkrnl/dxgmodule.c:135:6: warning: no previous prototype for 'signal_host_cpu_event' [-Wmissing-prototypes]
     135 | void signal_host_cpu_event(struct dxghostevent *eventhdr)
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/dxgkrnl/dxgmodule.c:219:5: warning: no previous prototype for 'dxgglobal_create_adapter' [-Wmissing-prototypes]
     219 | int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/hv/dxgkrnl/dxgvmbus.c:116:5: warning: no previous prototype for 'ntstatus2int' [-Wmissing-prototypes]
     116 | int ntstatus2int(struct ntstatus status)
         |     ^~~~~~~~~~~~
>> drivers/hv/dxgkrnl/dxgvmbus.c:219:6: warning: no previous prototype for 'process_inband_packet' [-Wmissing-prototypes]
     219 | void process_inband_packet(struct dxgvmbuschannel *channel,
         |      ^~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/dxgkrnl/dxgvmbus.c:237:6: warning: no previous prototype for 'process_completion_packet' [-Wmissing-prototypes]
     237 | void process_completion_packet(struct dxgvmbuschannel *channel,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/hv/dxgkrnl/dxgvmbus.c:363:5: warning: no previous prototype for 'dxgvmb_send_async_msg' [-Wmissing-prototypes]
     363 | int dxgvmb_send_async_msg(struct dxgvmbuschannel *channel,
         |     ^~~~~~~~~~~~~~~~~~~~~


vim +/find_pci_adapter +79 drivers/hv/dxgkrnl/dxgmodule.c

    78	
  > 79	struct dxgadapter *find_pci_adapter(struct pci_dev *dev)
    80	{
    81		struct dxgadapter *entry;
    82		struct dxgadapter *adapter = NULL;
    83	
    84		dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
    85	
    86		list_for_each_entry(entry, &dxgglobal->adapter_list_head,
    87				    adapter_list_entry) {
    88			if (dev == entry->pci_dev) {
    89				adapter = entry;
    90				break;
    91			}
    92		}
    93	
    94		dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
    95		return adapter;
    96	}
    97	
    98	static struct dxgadapter *find_adapter(struct winluid *luid)
    99	{
   100		struct dxgadapter *entry;
   101		struct dxgadapter *adapter = NULL;
   102	
   103		dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
   104	
   105		list_for_each_entry(entry, &dxgglobal->adapter_list_head,
   106				    adapter_list_entry) {
   107			if (memcmp(luid, &entry->luid, sizeof(struct winluid)) == 0) {
   108				adapter = entry;
   109				break;
   110			}
   111		}
   112	
   113		dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
   114		return adapter;
   115	}
   116	
   117	void dxgglobal_add_host_event(struct dxghostevent *event)
   118	{
   119		spin_lock_irq(&dxgglobal->host_event_list_mutex);
   120		list_add_tail(&event->host_event_list_entry,
   121			      &dxgglobal->host_event_list_head);
   122		spin_unlock_irq(&dxgglobal->host_event_list_mutex);
   123	}
   124	
   125	void dxgglobal_remove_host_event(struct dxghostevent *event)
   126	{
   127		spin_lock_irq(&dxgglobal->host_event_list_mutex);
   128		if (event->host_event_list_entry.next != NULL) {
   129			list_del(&event->host_event_list_entry);
   130			event->host_event_list_entry.next = NULL;
   131		}
   132		spin_unlock_irq(&dxgglobal->host_event_list_mutex);
   133	}
   134	
 > 135	void signal_host_cpu_event(struct dxghostevent *eventhdr)
   136	{
   137		struct  dxghosteventcpu *event = (struct  dxghosteventcpu *)eventhdr;
   138	
   139		if (event->remove_from_list ||
   140			event->destroy_after_signal) {
   141			list_del(&eventhdr->host_event_list_entry);
   142			eventhdr->host_event_list_entry.next = NULL;
   143		}
   144		if (event->cpu_event) {
   145			dev_dbg(dxgglobaldev, "signal cpu event\n");
   146			eventfd_signal(event->cpu_event, 1);
   147			if (event->destroy_after_signal)
   148				eventfd_ctx_put(event->cpu_event);
   149		} else {
   150			dev_dbg(dxgglobaldev, "signal completion\n");
   151			complete(event->completion_event);
   152		}
   153		if (event->destroy_after_signal) {
   154			dev_dbg(dxgglobaldev, "destroying event %p\n",
   155				event);
   156			vfree(event);
   157		}
   158	}
   159	
   160	void dxgglobal_signal_host_event(u64 event_id)
   161	{
   162		struct dxghostevent *event;
   163		unsigned long flags;
   164	
   165		dev_dbg(dxgglobaldev, "%s %lld\n", __func__, event_id);
   166	
   167		spin_lock_irqsave(&dxgglobal->host_event_list_mutex, flags);
   168		list_for_each_entry(event, &dxgglobal->host_event_list_head,
   169				    host_event_list_entry) {
   170			if (event->event_id == event_id) {
   171				dev_dbg(dxgglobaldev, "found event to signal %lld\n",
   172					    event_id);
   173				if (event->event_type == dxghostevent_cpu_event)
   174					signal_host_cpu_event(event);
   175				else
   176					pr_err("Unknown host event type");
   177				break;
   178			}
   179		}
   180		spin_unlock_irqrestore(&dxgglobal->host_event_list_mutex, flags);
   181		dev_dbg(dxgglobaldev, "dxgglobal_signal_host_event_end %lld\n",
   182			event_id);
   183	}
   184	
   185	struct dxghostevent *dxgglobal_get_host_event(u64 event_id)
   186	{
   187		struct dxghostevent *entry;
   188		struct dxghostevent *event = NULL;
   189	
   190		spin_lock_irq(&dxgglobal->host_event_list_mutex);
   191		list_for_each_entry(entry, &dxgglobal->host_event_list_head,
   192				    host_event_list_entry) {
   193			if (entry->event_id == event_id) {
   194				list_del(&entry->host_event_list_entry);
   195				entry->host_event_list_entry.next = NULL;
   196				event = entry;
   197				break;
   198			}
   199		}
   200		spin_unlock_irq(&dxgglobal->host_event_list_mutex);
   201		return event;
   202	}
   203	
   204	u64 dxgglobal_new_host_event_id(void)
   205	{
   206		return atomic64_inc_return(&dxgglobal->host_event_id);
   207	}
   208	
   209	void dxgglobal_acquire_process_adapter_lock(void)
   210	{
   211		mutex_lock(&dxgglobal->process_adapter_mutex);
   212	}
   213	
   214	void dxgglobal_release_process_adapter_lock(void)
   215	{
   216		mutex_unlock(&dxgglobal->process_adapter_mutex);
   217	}
   218	
 > 219	int dxgglobal_create_adapter(struct pci_dev *dev, guid_t *guid,
   220				     struct winluid host_vgpu_luid)
   221	{
   222		struct dxgadapter *adapter;
   223		int ret = 0;
   224	
   225		adapter = vzalloc(sizeof(struct dxgadapter));
   226		if (adapter == NULL) {
   227			ret = -ENOMEM;
   228			goto cleanup;
   229		}
   230	
   231		adapter->adapter_state = DXGADAPTER_STATE_WAITING_VMBUS;
   232		adapter->host_vgpu_luid = host_vgpu_luid;
   233		kref_init(&adapter->adapter_kref);
   234		init_rwsem(&adapter->core_lock);
   235	
   236		INIT_LIST_HEAD(&adapter->adapter_process_list_head);
   237		INIT_LIST_HEAD(&adapter->shared_resource_list_head);
   238		INIT_LIST_HEAD(&adapter->adapter_shared_syncobj_list_head);
   239		INIT_LIST_HEAD(&adapter->syncobj_list_head);
   240		init_rwsem(&adapter->shared_resource_list_lock);
   241		adapter->pci_dev = dev;
   242		guid_to_luid(guid, &adapter->luid);
   243	
   244		dxgglobal_acquire_adapter_list_lock(DXGLOCK_EXCL);
   245	
   246		list_add_tail(&adapter->adapter_list_entry,
   247			      &dxgglobal->adapter_list_head);
   248		dxgglobal->num_adapters++;
   249		dxgglobal_release_adapter_list_lock(DXGLOCK_EXCL);
   250	
   251		dev_dbg(dxgglobaldev, "new adapter added %p %x-%x\n", adapter,
   252			    adapter->luid.a, adapter->luid.b);
   253	cleanup:
   254		dev_dbg(dxgglobaldev, "%s end: %d", __func__, ret);
   255		return ret;
   256	}
   257	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
