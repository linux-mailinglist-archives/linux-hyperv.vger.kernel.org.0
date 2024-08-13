Return-Path: <linux-hyperv+bounces-2768-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC1F950B70
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFB811F23FF3
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Aug 2024 17:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F651A2562;
	Tue, 13 Aug 2024 17:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oex9KA0u"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799271A08D1;
	Tue, 13 Aug 2024 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570104; cv=none; b=iCwKrIQYerP5MX2e4U7tYPxJH4g8yhfC/ULALF76vyq+k+vm4pOIF7W25KVPz4Wj9wGYiGxuvTH+a22cTWFZ0dDu01WamMPrl/tTgrtGWmsHoc4nuhimjyYSTi57RaW6qi2rC2z3sSrXJcvzTdZZqArNCTX/pzqMFkc0qdMk/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570104; c=relaxed/simple;
	bh=ndNGlNI76XmLb9K3XXhXrivbtO13RGCPS9qc0tSh6x4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pUxOqLxnRQ2INSwDS/l5oNhUBS9XpBwdRbhI83zabhinVc7zZV+bl44rVL7QF0opqedZ6zkQ5urMt5RxKxDChBZtXRTIJ4zn/YCvcYaNGmkVY3jCa6Y4UO/vgXmO+23dRzsyvh2LukUx/ejELVbfemRbyGfYUHWajZAIKMUW+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oex9KA0u; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723570103; x=1755106103;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ndNGlNI76XmLb9K3XXhXrivbtO13RGCPS9qc0tSh6x4=;
  b=Oex9KA0ugYNaiQobHMwT4zx1aw+KM7vgVeq603uzUH6LOwV2AcRqFAeH
   fC/DglIii2w1Mm5d3zFYEQbJpkfDGcTtQWTfDAfXpGfnJDGKWMav5pg9E
   ZgvQ2ZjY82+VSdUJVobK0E553eUrZR4rFtppOGT7gw5ArctEdtCh/Cj0o
   afoCxp7BcB3icjB3jooU4+LJWDpt5Sa/YnAzqfq8Dk/T3x/ExlWf/z5vS
   HCHcnK5IAEwG59z6BBj+FykHf1c0YNGIebUSQfK/ATBwScOHtHF4Vbg0b
   nMTei0q8ipH+U9KvRlZFh3NI+adoSouaM9AeMYkOKuT2oMLjbQThh6KMp
   A==;
X-CSE-ConnectionGUID: GZGBwi97S8Ko+P1KKluRMw==
X-CSE-MsgGUID: mmgiJ8KpRkyQqQZxAjLQvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25540709"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="25540709"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:28:22 -0700
X-CSE-ConnectionGUID: AoXMvM4RQl2MaarUe1at7Q==
X-CSE-MsgGUID: IobEv8uXSsSBvO99duqDOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="63582081"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.124.83.191])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 10:28:21 -0700
Date: Tue, 13 Aug 2024 10:28:19 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Question to hv_vtl_real_mode_header in hv_vtl.c
Message-ID: <20240813172819.GA6572@yjiang5-mobl.amr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, Srinivasan and Dexuan,
	I have a question to the hv_vtl_real_mode_header in
arch/x86//hyperv/hv_vtl.c when addressing one patch review comment.
	In hv_vtl_early_init(), the real_mode_header is set to
hv_vtl_real_mode_header, but there is no setup to the real_mode_header, since
the realmode_init() is marked x86_init_noop in hv_vtl_init_platform.
	How is the real_mode_header(in another word, hv_vtl_real_mode_header)
used? Is it to meet the access requirement from do_boot_cpu(), so that
real_mode_header->trampoline_start64 will work, although the start_ip is not
used?
	If it's really to support the do_boot_cpu() requirement, how does the
non-VTL guest meet the access requirement? The hv_vtl_init_platform() is
unconditionally called from ms_hyperv_init_platform(), so I assume all hyperv
guest will have the realmode_init() set as x86_init_noop.

Thank you
--jyh

