Return-Path: <linux-hyperv+bounces-9356-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEWuJSi+smmvPAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9356-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 14:22:48 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EF4272710
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 14:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A1843001BD8
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Mar 2026 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F437082D;
	Thu, 12 Mar 2026 13:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="OzKjA9cL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0C38D690;
	Thu, 12 Mar 2026 13:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773321764; cv=none; b=nv/gGXUPxRKc1XNQLNJ0Btk1P/LTvExFe1MJYkhBMBjIV2SKbQF/azOybAeozHH07g5dW6cDILIxBVQfLx/63y8yOzB2a2gfHFoPlWegFmZjILpQaZPN/xgi8m8rd9jAJ7JOC3xQ4QGwwchSyo7a22/kIrVKfYtGaizvWBqbOuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773321764; c=relaxed/simple;
	bh=wgoNF3FgzQSFKh1lASStofgWUiDg+uwX4hGjVpznImc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzxe5K84/q6+kcpr4OLvyqmptMDaLXqee4DeagMCiPZ+EZraFX60JGNlat92wgW1wUgNgusDlA5eeVZMMmuIBHM6p7lue0Eer4m5Sf0KJP+A2UXAqsRTIBNV3ADMsFYLTG8V8wr8dfyYIdDCOZV3H8mtygV+S0AZTnJJ/deCz3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=OzKjA9cL; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1773321761; x=1804857761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rs5gwRcVJZNkX0BWP9+fIBemaJcQfrjY0HQhwZ1xtI4=;
  b=OzKjA9cLA2sXZ8rCrp5sKwlXCyJ+1WvIx4Vtq4r8QVPSVfFBKg8GX0wt
   2n+qV0HmluZtEsJ42LOVrXf7RIjs7uOp3Kt/rjWvFkLXMgPVPF+8HpFy7
   JGQLtxvEKSMz1x3EvdJ4sh5SS5yG/rnhd56EPPirKwHN2MWa9ijNEYuQw
   cQFHNoaScF55PL99uiqYcfw+5utNg33JJ/1j2yrTgZ4u3o8SotCAm2w7T
   VHXnA/sL9hc4LOPUHc5QvD6ZKanzj1v2210tiR6fu4zm46o/3r2Vy9tBc
   4pKyvAlmVRHhKtEs6OzsOaAJ/Tikn/nGVpighuF2PnOebHo6uRyZ1qaQK
   g==;
X-CSE-ConnectionGUID: 2Tz6uGxVRiq3XcGY22TRfA==
X-CSE-MsgGUID: Lq0jKYbqR+2kCJONlCZkIw==
X-IronPort-AV: E=Sophos;i="6.23,116,1770595200"; 
   d="scan'208";a="14885162"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 13:22:37 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:17478]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.153:2525] with esmtp (Farcaster)
 id d07cbfda-1c55-4ebc-8202-4d178c25255f; Thu, 12 Mar 2026 13:22:37 +0000 (UTC)
X-Farcaster-Flow-ID: d07cbfda-1c55-4ebc-8202-4d178c25255f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Thu, 12 Mar 2026 13:22:36 +0000
Received: from dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com
 (10.253.103.172) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Thu, 12 Mar 2026
 13:22:32 +0000
Date: Thu, 12 Mar 2026 13:22:24 +0000
From: Michael Margolin <mrgolin@amazon.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Gal Pressman <gal.pressman@linux.dev>, Abhijit Gangurde
	<abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, "Broadcom
 internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
	"Bernard Metzler" <bernard.metzler@linux.dev>, Bryan Tan
	<bryan-bt.tan@broadcom.com>, Cheng Xu <chengyou@linux.alibaba.com>, Junxian
 Huang <huangjunxian6@hisilicon.com>, Kai Shen <kaishen@linux.alibaba.com>,
	Konstantin Taranov <kotaranov@microsoft.com>, Krzysztof Czurylo
	<krzysztof.czurylo@intel.com>, Leon Romanovsky <leon@kernel.org>,
	<linux-hyperv@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Long Li
	<longli@microsoft.com>, Michal Kalderon <mkalderon@marvell.com>, "Nelson
 Escobar" <neescoba@cisco.com>, Satish Kharat <satishkh@cisco.com>, "Selvin
 Xavier" <selvin.xavier@broadcom.com>, Yossi Leybovich <sleybo@amazon.com>,
	Chengchang Tang <tangchengchang@huawei.com>, Tatyana Nikolova
	<tatyana.e.nikolova@intel.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Yishai Hadas <yishaih@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH 10/16] RDMA/efa: Use ib_copy_validate_udata_in_cm()
Message-ID: <20260312132224.GA3624@dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com>
References: <10-v1-2b86f54cda42+7d-rdma_udata_req_jgg@nvidia.com>
 <cf3bbf89-0bb1-4c58-b78f-37afdb2ff99c@linux.dev>
 <20260312112020.GE1448102@nvidia.com>
 <20260312120858.GH1448102@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260312120858.GH1448102@nvidia.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[linux.dev,amd.com,broadcom.com,linux.alibaba.com,hisilicon.com,microsoft.com,intel.com,kernel.org,vger.kernel.org,marvell.com,cisco.com,amazon.com,huawei.com,nvidia.com,gmail.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9356-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dev-dsk-mrgolin-1c-b2091117.eu-west-1.amazon.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrgolin@amazon.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 14EF4272710
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 09:08:58AM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 08:20:20AM -0300, Jason Gunthorpe wrote:
> > On Thu, Mar 12, 2026 at 01:03:59PM +0200, Gal Pressman wrote:
> > > On 12/03/2026 2:24, Jason Gunthorpe wrote:
> > > > Add the missed check for unsupported comp_mask bits.
> > > 
> > > Is it really missed? IIRC, it's intended.
> > > 
> > > See the comment above your hunk, and efa_user_comp_handshake()?
> > 
> > No, that is an illegal way to use a field called comp_mask.
> > 
> > If the driver wants that it needs a new field "suggested feature flags
> > to enable"
> > 
> > comp_mask is strictly to say that new fields are present and must be
> > processed by the kernel, and nothing else.
> 
> We could also rename the struct field away from comp_mask ? It is
> easier to add a comp_mask later..
> 
> Jason

Agree that this field should be renamed as we shouldn't fail when
unsupported value is requested. I'll send a patch.

Michael

