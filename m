Return-Path: <linux-hyperv+bounces-5601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A703ABF66D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 15:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 964519E2D25
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 May 2025 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913D638F80;
	Wed, 21 May 2025 13:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WqQTnP8i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB9E27D763;
	Wed, 21 May 2025 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747834993; cv=none; b=T0YB9jX5J4Z72FL1TOLG1vmvZG10R5+omXNwdSIRrMSPxKKyq8OD+m6bjNNtPVFm18xabKgY1Mle1UfNc1kQQsY6c7aP92YlxjZoU5ga24AN0ssgSwfl0BoRLc0EJLGWaKUuxmVI03lxhPXumfhiKgJxoCJPAUKXT/ctalhTQ/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747834993; c=relaxed/simple;
	bh=bJ5mEdZwI1kOkQeq6MOsfoKYiUuW+SVq7Hv8nRuVGYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uimSnUW6aYwMqcVwrFfBcGCzZ/SQ3+lfh9MzYB1OimfoPnSpa9ezwxejQ3BuUnTNij8ninH3VtQPPFgwBTuufToXm3sM9Sj8E2o7Ge0n/Wz422/LG9MaJcZPUzFLFS1mAXISi0nzYSVDEs4PCBHAIYlH/GZN0jwrQIMrYJ0NSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WqQTnP8i; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747834992; x=1779370992;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bJ5mEdZwI1kOkQeq6MOsfoKYiUuW+SVq7Hv8nRuVGYM=;
  b=WqQTnP8i3f67Q72Pqc8YxuUYmgu6RKT4N+4O9cIDY7/Wtefzj4Vt1Zk4
   DDM9usP1qdAeE12ReO4VKkCMJv9GaT0iwiRu1nh/tO9OGuk2hCTHXUXLd
   F5+fSdVaS7oVRV1N9T09CcOFiAEK+AHS3QvQJsp0K0/8dmYnYbN0Gp0vN
   gIl7oolku48J9ip5sjJdYxLg8s7nNXoHcfc8KRbtoN77CkrgVP4iV/lgT
   5Xdoj/a7BUBEFNJMi1NxB7uoUodsfm4fR9VszkjI81fFT1TUVN0xoZ5tR
   sF0Chfc5Y8gi/GUbQj2ueujCIa435fPdLpvDhWn5RwSlLUSbTEcQW95Gd
   A==;
X-CSE-ConnectionGUID: Vt0JyZpES4aSYOwweoucag==
X-CSE-MsgGUID: XmomrRa8Sya0tdcI7R6HPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49073342"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="49073342"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 06:43:11 -0700
X-CSE-ConnectionGUID: QqoCNcCuS8OQgpkyvNjCpw==
X-CSE-MsgGUID: Ochuz+B7RTO2SewZ7HfXJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="171083948"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 21 May 2025 06:43:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uHjio-000OJo-0S;
	Wed, 21 May 2025 13:43:02 +0000
Date: Wed, 21 May 2025 21:42:23 +0800
From: kernel test robot <lkp@intel.com>
To: Kees Cook <kees@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: oe-kbuild-all@lists.linux.dev, Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>,
	Hayes Wang <hayeswang@realtek.com>,
	Douglas Anderson <dianders@chromium.org>,
	Grant Grundler <grundler@chromium.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Cosmin Ratiu <cratiu@nvidia.com>, Lei Yang <leiyang@redhat.com>,
	netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-wpan@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 6/7] net: core: Convert dev_set_mac_address() to struct
 sockaddr_storage
Message-ID: <202505212149.6QGSFucw-lkp@intel.com>
References: <20250520223108.2672023-6-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520223108.2672023-6-kees@kernel.org>

Hi Kees,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-nvme/for-next]
[also build test ERROR on mkp-scsi/for-next kees/for-next/pstore kees/for-next/kspp linus/master v6.15-rc7 next-20250521]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/net-core-Convert-inet_addr_is_any-to-sockaddr_storage/20250521-063445
base:   git://git.infradead.org/nvme.git for-next
patch link:    https://lore.kernel.org/r/20250520223108.2672023-6-kees%40kernel.org
patch subject: [PATCH 6/7] net: core: Convert dev_set_mac_address() to struct sockaddr_storage
config: arc-randconfig-001-20250521 (https://download.01.org/0day-ci/archive/20250521/202505212149.6QGSFucw-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250521/202505212149.6QGSFucw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505212149.6QGSFucw-lkp@intel.com/

All errors (new ones prefixed by >>):

   net/core/dev_api.c: In function 'dev_set_mac_address':
>> net/core/dev_api.c:318:35: error: 'sa' undeclared (first use in this function); did you mean 'ss'?
     318 |  ret = netif_set_mac_address(dev, sa, extack);
         |                                   ^~
         |                                   ss
   net/core/dev_api.c:318:35: note: each undeclared identifier is reported only once for each function it appears in


vim +318 net/core/dev_api.c

   301	
   302	/**
   303	 * dev_set_mac_address() - change Media Access Control Address
   304	 * @dev: device
   305	 * @ss: new address
   306	 * @extack: netlink extended ack
   307	 *
   308	 * Change the hardware (MAC) address of the device
   309	 *
   310	 * Return: 0 on success, -errno on failure.
   311	 */
   312	int dev_set_mac_address(struct net_device *dev, struct sockaddr_storage *ss,
   313				struct netlink_ext_ack *extack)
   314	{
   315		int ret;
   316	
   317		netdev_lock_ops(dev);
 > 318		ret = netif_set_mac_address(dev, sa, extack);
   319		netdev_unlock_ops(dev);
   320	
   321		return ret;
   322	}
   323	EXPORT_SYMBOL(dev_set_mac_address);
   324	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

