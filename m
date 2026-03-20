Return-Path: <linux-hyperv+bounces-9668-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJBqFJDQvWlOCQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-9668-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:56:16 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2242E2288
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 23:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00D9030374B3
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Mar 2026 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119D737AA86;
	Fri, 20 Mar 2026 22:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gf38N31f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F45358382;
	Fri, 20 Mar 2026 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774047373; cv=none; b=k5T51eMyyO7HEYQg21PeooUuED37TpAMhlT8EIio1xaN5suHMd6W0qEm7g9b2QK5RWKv1UJLNTxkWeYuaMAaA6bi38/91X/+huWDcdP3QB7bF63YTkk4YyuzmMVdkpDo7nTQUBDqrevnydDPCc2Eqi5dH6VeGp3xcQ6NGdzLBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774047373; c=relaxed/simple;
	bh=0SSVuwpq3GSKbcBxi7YA4+TEwdkv6PE+svVUsxApjpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJ97e5RVy4GmzfCn3ysTS8zvXuz+t/WTyDmCKev9TSeQAqn6yRqDDRcmpHT76Itwmyd48vVb3SHKu3TtmPAAuYmK0mHOM/JMUoS7cQnX3ODUpChCpvOWxS1OfgKEMIInd0cQTNqPOZKPXaTVzfQECXQI1JiHFCaua7T6mRjQzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gf38N31f; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774047372; x=1805583372;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SSVuwpq3GSKbcBxi7YA4+TEwdkv6PE+svVUsxApjpQ=;
  b=gf38N31ftvsyKVoucoIXtO8OK1lM2tl0rrxBt2PzBPrYJQi5tOdUDqCy
   EaUBddVUYaoOY8p4Cc8U6umEwxYyJqtC8JE1diduo7Iyyo81XKr9MAREB
   J0bzipFCLpA2RR1AsHnOyGkGkKyKVXgMYJyqxDYoon2cdoZ5wA5UshfAU
   /je51EE37yfylACAcyDR9QcsEANBFamOF0ghEg81IZG5UbLSE5cOj9wt4
   1W9HTNln9e9haImmI9s24kD7nbQllU72biQhRZdZMucKB9pecVmU20UaO
   ROMwdRY+k3WRjbjRB1bcewv4foRk8Xh706czHX5YCbl43Sw6uSF/2ZvsW
   Q==;
X-CSE-ConnectionGUID: D3HrGr+LS7+6hYWcxT5SDg==
X-CSE-MsgGUID: eVEuKT/PQ3OpxkAb1t77jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="75169421"
X-IronPort-AV: E=Sophos;i="6.23,132,1770624000"; 
   d="scan'208";a="75169421"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:56:11 -0700
X-CSE-ConnectionGUID: kq9PfVflQsWIohQI8Q0ISw==
X-CSE-MsgGUID: 8JtmPvhoQe+rUaQHGS2BMw==
X-ExtLoop1: 1
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 15:56:10 -0700
Date: Fri, 20 Mar 2026 16:01:47 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>,
	linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ricardo Neri <ricardo.neri@intel.com>,
	Yunhong Jiang <yunhong.jiang@linux.intel.com>
Subject: Re: [PATCH v8 09/10] x86/hyperv/vtl: Mark the wakeup mailbox page as
 private
Message-ID: <20260320230147.GA31320@ranerica-svr.sc.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
 <20260107-rneri-wakeup-mailbox-v8-9-2f5b6785f2f5@linux.intel.com>
 <20260309175733.GA3083831@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309175733.GA3083831@liuwe-devbox-debian-v2.local>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9668-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,microsoft.com,outlook.com,linux.microsoft.com,vger.kernel.org,intel.com,linux.intel.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,ranerica-svr.sc.intel.com:mid]
X-Rspamd-Queue-Id: 0D2242E2288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 09, 2026 at 05:57:33PM +0000, Wei Liu wrote:
> Dexuan, are you happy with the patch? You can also delegate to Saurabh
> if you think it's more appropriate. Thanks!

Hi Wei,

I just realized you replied to an older version of the patch. Here is the
most recent version:

https://lore.kernel.org/all/20260304-rneri-wakeup-mailbox-v9-9-a5c6845e6251@linux.intel.com/

The whole series:

https://lore.kernel.org/all/20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com/

Thanks and BR,
Ricardo


