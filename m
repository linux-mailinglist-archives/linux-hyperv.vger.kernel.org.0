Return-Path: <linux-hyperv+bounces-9397-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0N34Kz3es2ktcQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9397-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 10:51:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41622280DA1
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 072F131ED9D0
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 09:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144D388E75;
	Fri, 13 Mar 2026 09:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgXKGB+J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17732ED32;
	Fri, 13 Mar 2026 09:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395245; cv=none; b=oWVNwkDabPNKX2YDtrnoqaUbIqpTnISmgm/Dtm3JW0GGRwP6Q3JzrVic7XpDyWLgGFDZRfdWfpdeh+ysk8oD/GsipJWEqmgzp9NQQrHWHMA6lF0Ujpaep9C1TGqh7n3obUJNfZxDQ/Q9CCLlivmcipBj1QgSCip8ZGJ0RfUu1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395245; c=relaxed/simple;
	bh=shbEn4UYXRSF/93kbIkRAJWzAwqCM62LTnDiD1zvGnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRLrYPUOSepWif2dLfUGrx8JLTNUMHAeKotkqqRBzAGtGmjNMvXIgm3Amx26FoNImheeZgZVxj12QidjdpsWnBJTw44vQcJLAXuLf0xaRairhz6o3x7HO6DPwL2NXQzzqtmUVDvuRnfNkuI3fXjzLXlYaRI++7y99STC5nObBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgXKGB+J; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773395244; x=1804931244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=shbEn4UYXRSF/93kbIkRAJWzAwqCM62LTnDiD1zvGnQ=;
  b=DgXKGB+JvS21y7vHgIVpacnu+0eX0C0Q2yW6tGXOaUfH9SHhtBJoq/5G
   lALqC6e+ckEbhZ+PVBr9CzPUyaVama3PvbKqHPRej93s0d68zZPFYoA4C
   nkNRpskDfI731Bbk+j0kfK3AsEfpOR3YODzG1iI5gS7nWuEG4rpQiJkha
   EbvxnP2DQ82l/1LB4Dv/CUtaB53K8306VWew5VawDqflhcUMfew3aiUeh
   YAgDwHpFh8Ard5LleH1Zk0/USU7/VymoOmqEvct/yePKDcnBqaPoTt0R8
   A8eqYn/1HAHNkKC/QdDOoO2JxNCRTCY5Tdm9wiyC7XELEbAYkZjSMcrFP
   w==;
X-CSE-ConnectionGUID: UZm1B10dTAeJKABAv0tdhA==
X-CSE-MsgGUID: KjR92nrcQR6XarHRWVWOfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="99961773"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="99961773"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:47:23 -0700
X-CSE-ConnectionGUID: GsebdnTlT/SDLdY0V6biEA==
X-CSE-MsgGUID: 10eCGMq3Tca5BCiKpXMAoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="251629178"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 02:47:17 -0700
Date: Fri, 13 Mar 2026 11:47:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Mark Brown <broonie@kernel.org>, Steve French <sfrench@samba.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abPdItJ152oMzGd6@ashevche-desk.local>
References: <20260312230817.372878-1-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312230817.372878-1-ynorov@nvidia.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,ziepe.ca,samba.org,amazon.com,soleen.com];
	TAGGED_FROM(0.00)[bounces-9397-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,intel.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,soleen.com:email,ashevche-desk.local:mid]
X-Rspamd-Queue-Id: 41622280DA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> 
> The 32-bit behaviour is inconsistent with the function description, so it
> needs to get fixed.
> 
> There are 9 individual users for the function in 6 different subsystems.
> Some arches and drivers are 64-bit only:
>  - arch/loongarch/kvm/intc/eiointc.c;
>  - drivers/hv/mshv_vtl_main.c;
>  - kernel/liveupdate/kexec_handover.c;
> 
> The others are:
>  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
>  - rzv2m_csi_reg_write_bit(): ARCH_RENESAS only, unclear;
>  - lz77_match_len(): CIFS_COMPRESSION only, unclear, experimental;
> 
> None of them explicitly tweak their code for a word length, or x == 0.
> 
> Requesting comments from the corresponding maintainers on how to proceed
> with this.
> 
> The attached patch gets rid of 32-bit explicit support, so that both
> 32- and 64-bit versions rely on __ffs().

> CC: "K. Y. Srinivasan" <kys@microsoft.com> (hyperv)
> CC: Haiyang Zhang <haiyangz@microsoft.com> (hyperv)
> CC: Jason Gunthorpe <jgg@ziepe.ca> (infiniband)
> CC: Leon Romanovsky <leon@kernel.org> (infiniband)
> CC: Mark Brown <broonie@kernel.org> (spi)
> CC: Steve French <sfrench@samba.org> (smb)
> CC: Alexander Graf <graf@amazon.com> (kexec)
> CC: Mike Rapoport <rppt@kernel.org> (kexec)
> CC: Pasha Tatashin <pasha.tatashin@soleen.com> (kexec)

Please, move the Cc: list to the...

> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---

...comments block. It will have the same effect on emails, but drastically
reduces unneeded noise in the commit message in the Git history.

You may also read this subthread (patch 18) on how to handle it locally:
https://lore.kernel.org/linux-iio/20260123113708.416727-19-bigeasy@linutronix.de/

>  include/linux/count_zeros.h | 9 +++------

...

> +#define COUNT_TRAILING_ZEROS_0 (-1)

Shouldn't we also saturate this to BITS_PER_LONG?

-- 
With Best Regards,
Andy Shevchenko



