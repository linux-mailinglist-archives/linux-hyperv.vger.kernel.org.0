Return-Path: <linux-hyperv+bounces-7501-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08522C504C4
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 03:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55183AAD65
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 02:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8E291C07;
	Wed, 12 Nov 2025 02:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hO6F2gkr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4198B7261B;
	Wed, 12 Nov 2025 02:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762913159; cv=none; b=Fk11oRveGL40NNYHddoEL9ZKFyIpWVfjGvM743BeVAc9Yy2PQYqykhShH0AVdO4pqyX/E85AI7+OR2RX8qHgLHSkj+Uzib8X8r28qQpBHpmdYN0Hoo6UGktbQV0rMb704ByNEtLkAgdcYEccbvtpkg/EnC9dLUOzGMotUq20ME4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762913159; c=relaxed/simple;
	bh=iXo9a81NcpxQrBwVlhIQKSSdxGoVHXdiPTVRhbzilg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ktguhm+YsaDp8Vqu0a97vHUs+oIYWgvOYhnM+6W2t+4bxTCKdO7HY5rNdM6Cpjg20YkSVB3UEW61soxeYaJewwcE93I7H3ZnXRvt+vgHeoNsuQoFska5WziYGYG+juK0bdGgngMZM+QIQdfCfrS7ZGFC0nSVHe+B1fRP8tJfzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hO6F2gkr; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762913157; x=1794449157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iXo9a81NcpxQrBwVlhIQKSSdxGoVHXdiPTVRhbzilg0=;
  b=hO6F2gkrHgzr2uLkhMGbftgGAvARCAzAuJ9OsSHKur9mEPbspSOrXlVI
   JlnSCGTXBI3np9jTHoCCJGWoFYaVrQVHYyWVBuj9BI6MaZKvqHsZ2Dey7
   dOBQeZTLpeIORNQXdtZreIVZRMMH/epA3BdCZ6hME5C4DWR85ZhbyqbzO
   hwZJz0+Nr3iqTid4PJ21mitAzSWY0wC/+VAOR1bhqWDwGWngrCxH7TPZ8
   pCx+c4Y3yJAhO53hM6rioYrLOFN9mE2/R/dnbRFbGoOtNKd82/GZKDTDI
   BHP1LmjID0dbIewU825dxhcJPUGZcz8Thb8SzfIBbDQ5vHVPs4EeOf7Na
   g==;
X-CSE-ConnectionGUID: uD8coVuZSB2Kin2TD1kpfQ==
X-CSE-MsgGUID: FFX481J3QemgTOoXTPCLTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="64177337"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="64177337"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 18:05:56 -0800
X-CSE-ConnectionGUID: 5sgceOHpRbW7OavioFYyeg==
X-CSE-MsgGUID: 4dzUsb4mQLObSejwB+iKPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; 
   d="scan'208";a="219736509"
Received: from lkp-server01.sh.intel.com (HELO 7b01c990427b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 11 Nov 2025 18:05:50 -0800
Received: from kbuild by 7b01c990427b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vJ0F1-0003kp-0T;
	Wed, 12 Nov 2025 02:05:47 +0000
Date: Wed, 12 Nov 2025 10:04:49 +0800
From: kernel test robot <lkp@intel.com>
To: Aditya Garg <gargaditya@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
	shirazsaleem@microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
	yury.norov@gmail.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, gargaditya@microsoft.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aditya Garg <gargaditya@linux.microsoft.com>
Subject: Re: [PATCH net-next v3 2/2] net: mana: Drop TX skb on
 post_work_request failure and unmap resources
Message-ID: <202511120917.rSwJ1zUm-lkp@intel.com>
References: <1762848781-357-3-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1762848781-357-3-git-send-email-gargaditya@linux.microsoft.com>

Hi Aditya,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Aditya-Garg/net-mana-Handle-SKB-if-TX-SGEs-exceed-hardware-limit/20251111-162216
base:   net-next/main
patch link:    https://lore.kernel.org/r/1762848781-357-3-git-send-email-gargaditya%40linux.microsoft.com
patch subject: [PATCH net-next v3 2/2] net: mana: Drop TX skb on post_work_request failure and unmap resources
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20251112/202511120917.rSwJ1zUm-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 996639d6ebb86ff15a8c99b67f1c2e2117636ae7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251112/202511120917.rSwJ1zUm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511120917.rSwJ1zUm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/microsoft/mana/gdma_main.c:1303:23: warning: variable 'gc' set but not used [-Wunused-but-set-variable]
    1303 |         struct gdma_context *gc;
         |                              ^
   1 warning generated.


vim +/gc +1303 drivers/net/ethernet/microsoft/mana/gdma_main.c

ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1297  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1298  int mana_gd_post_work_request(struct gdma_queue *wq,
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1299  			      const struct gdma_wqe_request *wqe_req,
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1300  			      struct gdma_posted_wqe_info *wqe_info)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1301  {
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1302  	u32 client_oob_size = wqe_req->inline_oob_size;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16 @1303  	struct gdma_context *gc;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1304  	u32 sgl_data_size;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1305  	u32 max_wqe_size;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1306  	u32 wqe_size;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1307  	u8 *wqe_ptr;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1308  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1309  	if (wqe_req->num_sge == 0)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1310  		return -EINVAL;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1311  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1312  	if (wq->type == GDMA_RQ) {
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1313  		if (client_oob_size != 0)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1314  			return -EINVAL;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1315  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1316  		client_oob_size = INLINE_OOB_SMALL_SIZE;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1317  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1318  		max_wqe_size = GDMA_MAX_RQE_SIZE;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1319  	} else {
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1320  		if (client_oob_size != INLINE_OOB_SMALL_SIZE &&
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1321  		    client_oob_size != INLINE_OOB_LARGE_SIZE)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1322  			return -EINVAL;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1323  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1324  		max_wqe_size = GDMA_MAX_SQE_SIZE;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1325  	}
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1326  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1327  	sgl_data_size = sizeof(struct gdma_sge) * wqe_req->num_sge;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1328  	wqe_size = ALIGN(sizeof(struct gdma_wqe) + client_oob_size +
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1329  			 sgl_data_size, GDMA_WQE_BU_SIZE);
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1330  	if (wqe_size > max_wqe_size)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1331  		return -EINVAL;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1332  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1333  	if (wq->monitor_avl_buf && wqe_size > mana_gd_wq_avail_space(wq)) {
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1334  		gc = wq->gdma_dev->gdma_context;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1335  		return -ENOSPC;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1336  	}
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1337  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1338  	if (wqe_info)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1339  		wqe_info->wqe_size_in_bu = wqe_size / GDMA_WQE_BU_SIZE;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1340  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1341  	wqe_ptr = mana_gd_get_wqe_ptr(wq, wq->head);
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1342  	wqe_ptr += mana_gd_write_client_oob(wqe_req, wq->type, client_oob_size,
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1343  					    sgl_data_size, wqe_ptr);
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1344  	if (wqe_ptr >= (u8 *)wq->queue_mem_ptr + wq->queue_size)
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1345  		wqe_ptr -= wq->queue_size;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1346  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1347  	mana_gd_write_sgl(wq, wqe_ptr, wqe_req);
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1348  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1349  	wq->head += wqe_size / GDMA_WQE_BU_SIZE;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1350  
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1351  	return 0;
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1352  }
c8017f5b4856d5 Konstantin Taranov 2025-01-20  1353  EXPORT_SYMBOL_NS(mana_gd_post_work_request, "NET_MANA");
ca9c54d2d6a5ab Dexuan Cui         2021-04-16  1354  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

