Return-Path: <linux-hyperv+bounces-10492-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFJTFN158mnjrgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10492-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 23:36:29 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D7249A9F4
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 23:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CEFB8300C31C
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 21:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631D3AA1BD;
	Wed, 29 Apr 2026 21:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMimWFl1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA94376BE0;
	Wed, 29 Apr 2026 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498586; cv=none; b=O6+XSDEp4wKTRxLODZtn7THNWobqLozgL24p3VHapaOCsW2chudPTmh5O8I+SXiglzGmS93bMyGmv7wZRFOc2AeIAkacP/um4z2dqBmeZcDj1zEPLSbGJwcr+MquTtCL8IBzM1AiySUptoAYjYKkk3HXU9EAWVbffG6qZyurXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498586; c=relaxed/simple;
	bh=fu+MWkifpdP6zlGX+l2O4od7JpS1AC0S1kogR5b5Vl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWFdY4i8YGM1otc5k/NYU8844Oim5jWX+gaUFt95ZVBPdzPxsauzf0c/pVpcmkD/C1cETJlyR6lDMg96JqVs4zuJsnwLaBFlmBuxxRawwpRZ4JCEq/FW+CgvsvvsBOdE7KMS35l0k+j6oJaDLGB3jmcB71dG+OSZuuL+KRCqjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMimWFl1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777498586; x=1809034586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fu+MWkifpdP6zlGX+l2O4od7JpS1AC0S1kogR5b5Vl0=;
  b=TMimWFl1XyOS1yEk7v3ZKUu+9QHrkMOXQtNluCMNSMO2jozRC+/YZA+b
   h6OoUm5BXDZIUct6hKKBRJ1TV2+nHf/FL+dwqzbEMh0AyKcuVuCFdr39/
   ricO2ymvzflK8kxgimIt5j0z1xqxL2bgdsz6TwvAkQ74NFGkrqhi5IsSS
   EqauuWK/qUIWRMIky5eQ43EnfOKAGYxZpamUU+p96yhqEMSi8hoNyNtqs
   +3QRaqHt8K7P+NT97FVnq8xVZSpI9R7oeY4NpxWzxXtoHX9cvu/itctnB
   jSWVNuxG8N8WBr9f2hWoJspwImVPkTcRvjxq74IcOv+1GLgOOrikYaWUT
   Q==;
X-CSE-ConnectionGUID: lBLIlVtQRoe1+Z0CodYksg==
X-CSE-MsgGUID: aQwAS3fjRm6jyg6Kn+X6Ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="88750101"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="88750101"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 14:36:25 -0700
X-CSE-ConnectionGUID: 8zIvfJf4QWCoTXKbDnAG3A==
X-CSE-MsgGUID: sK1ryX4rSWmnWJAakzrVNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="233544782"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 29 Apr 2026 14:36:23 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wICZx-000000004a1-07x2;
	Wed, 29 Apr 2026 21:36:21 +0000
Date: Wed, 29 Apr 2026 23:36:15 +0200
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
Message-ID: <202604292359.AoPLVCEb-lkp@intel.com>
References: <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177741648871.626779.11067281081219290277.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Rspamd-Queue-Id: D2D7249A9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10492-lists,linux-hyperv=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[]

Hi Stanislav,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v7.1-rc1 next-20260429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanislav-Kinsburskii/mshv-Add-dedicated-ioctl-for-GVA-to-GPA-translation/20260429-094326
base:   linus/master
patch link:    https://lore.kernel.org/r/177741648871.626779.11067281081219290277.stgit%40skinsburskii-cloud-desktop.internal.cloudapp.net
patch subject: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260429/202604292359.AoPLVCEb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260429/202604292359.AoPLVCEb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604292359.AoPLVCEb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/mshv.h:325:14: error: use of enum 'hv_translate_gva_result_code' without previous declaration
     325 |         enum hv_translate_gva_result_code *result;
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

