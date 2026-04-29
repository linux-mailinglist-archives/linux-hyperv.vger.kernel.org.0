Return-Path: <linux-hyperv+bounces-10503-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMprEsqI8mlEsQEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10503-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:40:10 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE0A49B1B6
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2026 00:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7361730151E3
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2026 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223AD3A7F52;
	Wed, 29 Apr 2026 22:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ap3swXHl"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF3194A6C;
	Wed, 29 Apr 2026 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777502408; cv=none; b=vBjDCg/Nps8g+0bxQGiPEUQx8/hi5AMIn/cX4NRSOu6G0AsniQt0o/MHr6ySQZEWn6Gm+IAaYtuauhWGwmdqItzgt1VBWXmVXBlULH7l6KEJsScrS4fkbHZzgraTLBSytiufhkwoUAUupXBEg6DxfJSGh6jXxN87ljdsmqaJMCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777502408; c=relaxed/simple;
	bh=hXB1y2ylPEmcAloNbq7aS8ySLvDCml0iWZuLDnI2OkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hShRWrZ/YDBAj0q0VnEYDg30xD8R0QfDP3xxnIYJSvfozT3FSXXfu2M60EOpa5VFDJn3eS+09Dlq6MyX0xcqws6ETn5m6XtsP4ohbxoMeSaqjZRDhCqqz/JjKQK0bS8PTMIhgRW4nntXbr7GTzkLyx+iAmbym5eETlIkAMzPnJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ap3swXHl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777502407; x=1809038407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hXB1y2ylPEmcAloNbq7aS8ySLvDCml0iWZuLDnI2OkY=;
  b=ap3swXHlA39uXXI4eido0B4lUXyMLCfbpTs/VIeeXHRc3X9TwoW/8VRy
   7n+fwyTJyWu5yHXu/cvgBBnxdofvdHCxC72AfIkbC1pXh7vaIv47tIHH1
   LJrPyUfi1apMsstV/L3uHN3HVI4rqoyr7FnvPhTPX05Czwgs03cSbLGW/
   pc1qFC97aCQuhsZGeNHmBMG9Ln8WmjNqACUurd0BEjKq18k/NEYY6KGcB
   IXHbsjmzNlAU6lwKpX+o/EPVgGE5ul84aGY3f/RVofta4YH7WSIFOS7JR
   THV0O9xvoxHnIzoNNUuwvXMoyFooSwXTfRfJbOuzfNRlpYENLYSesKxbK
   A==;
X-CSE-ConnectionGUID: d/m273qTSRiNazGzW5fYnA==
X-CSE-MsgGUID: nqFTTXRUREegnZTScYx8EA==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89135875"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="89135875"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 15:40:06 -0700
X-CSE-ConnectionGUID: /yxEjHmTTEaA4sl64NiLYg==
X-CSE-MsgGUID: fkWGh+z2SkGYFeLOdktjsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; 
   d="scan'208";a="234670644"
Received: from lkp-server01.sh.intel.com (HELO aa799cca880d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 29 Apr 2026 15:40:03 -0700
Received: from kbuild by aa799cca880d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wIDZY-00000000BbM-3Gdx;
	Wed, 29 Apr 2026 22:40:00 +0000
Date: Thu, 30 Apr 2026 06:39:33 +0800
From: kernel test robot <lkp@intel.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: oe-kbuild-all@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Add dedicated ioctl for GVA to GPA translation
Message-ID: <202604300619.sZX0K2OC-lkp@intel.com>
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
X-Rspamd-Queue-Id: ADE0A49B1B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_FROM(0.00)[bounces-10503-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
config: x86_64-buildonly-randconfig-005-20260430 (https://download.01.org/0day-ci/archive/20260430/202604300619.sZX0K2OC-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260430/202604300619.sZX0K2OC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604300619.sZX0K2OC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/mshv.h:325:14: error: use of enum 'hv_translate_gva_result_code' without previous declaration
     325 |         enum hv_translate_gva_result_code *result;
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

