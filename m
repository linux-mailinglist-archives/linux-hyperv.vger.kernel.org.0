Return-Path: <linux-hyperv+bounces-4298-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A00A57F02
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Mar 2025 22:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6AFC7A4B27
	for <lists+linux-hyperv@lfdr.de>; Sat,  8 Mar 2025 21:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016991F5856;
	Sat,  8 Mar 2025 21:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gw+iAH3r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394549620;
	Sat,  8 Mar 2025 21:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741470556; cv=none; b=dYonMs77+J72zow/jqWrMojVQ8ZJyuWKc/AACkeVnc3zBO/uouOlwjusQsbOUDoVG13a2Lrn6N3Po97u1EfcDQiWi4kLYbHICEzYaz2afT5NrMRfU/LwlUTCp4s6sB6j2D9cIbxNAkRu0KEoYZCbUbdFwXBjAgiuBfNS2HU9Ito=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741470556; c=relaxed/simple;
	bh=ogZX1Fgf0emz5/XgrE7Jdv5XjH7+aPutVc/+AUG8ok4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZck+DK0UCssg75aP1GpIZbM3f/ugABpwKEO+UnuPqm1HDMJZRF9kNMuU3jzvtha02z8V+J6NlZBXsTWYKMT6yYngehsHoWEVxfQQEdvLGi7pT241ApP1Sr8F+w7uiuSUDkd4GpGq0csz9w/g6GkT2OLFXTgDq2xLfpS6bphB8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gw+iAH3r; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741470555; x=1773006555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogZX1Fgf0emz5/XgrE7Jdv5XjH7+aPutVc/+AUG8ok4=;
  b=Gw+iAH3raUMyQy7OAKWtJ8Ka9tZ/Z2KkBf68tcX94RIePeGdUN9njJc3
   exc02j2jvEPbJ3rozwJiWOlispnIIIxKpKVhAx0uU1qFvPprvCjlx+j4k
   +NWNkQ7/FZG9GF9tGBUQwUO5btdx4lEeSijg/2LFOVg6DBNs02UMXf4aP
   JvSeW+yMK0KSYzrdwKnLMG40c2YdQuKJkLPSgdEVShTyEmeBqRtQ2acGp
   kOK2aiWLfa5XNEXE4idV8/wlrLkBc04Km0JnNwG7DFokfmkxuFDjWEmZ4
   E23BvIgl3KcPfNrSXHBVgXKSp2aUhoNqUVYVoOn9kL7NEeZkW5SC1IaEU
   g==;
X-CSE-ConnectionGUID: sCJ57nLET3+3LYKzuTSg7w==
X-CSE-MsgGUID: OIvyMOrPTSqmfgSpaCFlrQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42638753"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42638753"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:49:14 -0800
X-CSE-ConnectionGUID: TZmFUD+/TReB/RTeelOYBQ==
X-CSE-MsgGUID: L14Hls9FQ+yTxKkK2KpU5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="142863193"
Received: from lkp-server02.sh.intel.com (HELO a4747d147074) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 08 Mar 2025 13:49:11 -0800
Received: from kbuild by a4747d147074 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tr22e-0002Mw-0F;
	Sat, 08 Mar 2025 21:49:08 +0000
Date: Sun, 9 Mar 2025 05:49:02 +0800
From: kernel test robot <lkp@intel.com>
To: Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Terry Junge <linuxhid@cosmicgizmosystems.com>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alan Stern <stern@rowland.harvard.edu>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-input@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	lvc-project@linuxtesting.org,
	syzbot+c52569baf0c843f35495@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] HID: usbhid: Eliminate recurrent out-of-bounds bug in
 usbhid_parse()
Message-ID: <202503090701.715nV1DW-lkp@intel.com>
References: <20250307045449.745634-1-linuxhid@cosmicgizmosystems.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307045449.745634-1-linuxhid@cosmicgizmosystems.com>

Hi Terry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 58c9bf3363e596d744f56616d407278ef5f97f5a]

url:    https://github.com/intel-lab-lkp/linux/commits/Terry-Junge/HID-usbhid-Eliminate-recurrent-out-of-bounds-bug-in-usbhid_parse/20250307-130514
base:   58c9bf3363e596d744f56616d407278ef5f97f5a
patch link:    https://lore.kernel.org/r/20250307045449.745634-1-linuxhid%40cosmicgizmosystems.com
patch subject: [PATCH v1] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
config: s390-randconfig-r133-20250308 (https://download.01.org/0day-ci/archive/20250309/202503090701.715nV1DW-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20250309/202503090701.715nV1DW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202503090701.715nV1DW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/hid/usbhid/hid-core.c:1055:4: warning: format specifies type 'unsigned char' but the argument has type 'int' [-Wformat]
                           hdesc->bNumDescriptors - 1);
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/hid.h:1239:31: note: expanded from macro 'hid_warn'
           dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
                                 ~~~    ^~~~~~~~~~~
   include/linux/dev_printk.h:156:70: note: expanded from macro 'dev_warn'
           dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
                                                                       ~~~     ^~~~~~~~~~~
   include/linux/dev_printk.h:110:23: note: expanded from macro 'dev_printk_index_wrap'
                   _p_func(dev, fmt, ##__VA_ARGS__);                       \
                                ~~~    ^~~~~~~~~~~
   1 warning generated.


vim +1055 drivers/hid/usbhid/hid-core.c

   979	
   980	static int usbhid_parse(struct hid_device *hid)
   981	{
   982		struct usb_interface *intf = to_usb_interface(hid->dev.parent);
   983		struct usb_host_interface *interface = intf->cur_altsetting;
   984		struct usb_device *dev = interface_to_usbdev (intf);
   985		struct hid_descriptor *hdesc;
   986		struct hid_class_descriptor *hcdesc;
   987		u32 quirks = 0;
   988		unsigned int rsize = 0;
   989		char *rdesc;
   990		int ret;
   991	
   992		quirks = hid_lookup_quirk(hid);
   993	
   994		if (quirks & HID_QUIRK_IGNORE)
   995			return -ENODEV;
   996	
   997		/* Many keyboards and mice don't like to be polled for reports,
   998		 * so we will always set the HID_QUIRK_NOGET flag for them. */
   999		if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT) {
  1000			if (interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_KEYBOARD ||
  1001				interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
  1002					quirks |= HID_QUIRK_NOGET;
  1003		}
  1004	
  1005		if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
  1006		    (!interface->desc.bNumEndpoints ||
  1007		     usb_get_extra_descriptor(&interface->endpoint[0], HID_DT_HID, &hdesc))) {
  1008			dbg_hid("class descriptor not present\n");
  1009			return -ENODEV;
  1010		}
  1011	
  1012		if (!hdesc->bNumDescriptors ||
  1013		    hdesc->bLength != sizeof(*hdesc) +
  1014				      (hdesc->bNumDescriptors - 1) * sizeof(*hcdesc)) {
  1015			dbg_hid("hid descriptor invalid, bLen=%hhu bNum=%hhu\n",
  1016				hdesc->bLength, hdesc->bNumDescriptors);
  1017			return -EINVAL;
  1018		}
  1019	
  1020		hid->version = le16_to_cpu(hdesc->bcdHID);
  1021		hid->country = hdesc->bCountryCode;
  1022	
  1023		if (hdesc->rpt_desc.bDescriptorType == HID_DT_REPORT)
  1024			rsize = le16_to_cpu(hdesc->rpt_desc.wDescriptorLength);
  1025	
  1026		if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
  1027			dbg_hid("weird size of report descriptor (%u)\n", rsize);
  1028			return -EINVAL;
  1029		}
  1030	
  1031		rdesc = kmalloc(rsize, GFP_KERNEL);
  1032		if (!rdesc)
  1033			return -ENOMEM;
  1034	
  1035		hid_set_idle(dev, interface->desc.bInterfaceNumber, 0, 0);
  1036	
  1037		ret = hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
  1038				HID_DT_REPORT, rdesc, rsize);
  1039		if (ret < 0) {
  1040			dbg_hid("reading report descriptor failed\n");
  1041			kfree(rdesc);
  1042			goto err;
  1043		}
  1044	
  1045		ret = hid_parse_report(hid, rdesc, rsize);
  1046		kfree(rdesc);
  1047		if (ret) {
  1048			dbg_hid("parsing report descriptor failed\n");
  1049			goto err;
  1050		}
  1051	
  1052		if (hdesc->bNumDescriptors > 1)
  1053			hid_warn(intf,
  1054				"%hhu unsupported optional hid class descriptors\n",
> 1055				hdesc->bNumDescriptors - 1);
  1056	
  1057		hid->quirks |= quirks;
  1058	
  1059		return 0;
  1060	err:
  1061		return ret;
  1062	}
  1063	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

