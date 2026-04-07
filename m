Return-Path: <linux-hyperv+bounces-10055-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHFhKiZb1Wmu4wcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10055-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 21:29:42 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F36253B39CE
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 21:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE543017503
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 19:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B0E359A8B;
	Tue,  7 Apr 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aNTqmThZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884B337689;
	Tue,  7 Apr 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590152; cv=none; b=O0Sijqf3v488FpJTGgxigdxmaYxiOo20/C1C718j+lLJCcEcf4ochTII4UDs/wWOQgp/b+6cwW3Wet1UT0qQk3XHdn+pwraWTitl+IHY5dZ7fJ6kjSF+Y08DTzIU88KV+sTGEisu+30tjJkzHCYQyx71uFTI3zKVMkZFbuuALYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590152; c=relaxed/simple;
	bh=Z5cSxs8CdrAAv+eEphOC9PKCyt1jwDGbNVkb5hrQA5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3HgYlp44Z27Eu3mSSoYqBUkMgUQrPBiaSssDqUXgfgLT5NXxBaC4azg0sZNi2TDE4VSmhosYl0LNtjm8Gcq9S3Xs8aj8mSaQlj8RJ7CCUoJpy4jmrzC2WLH7/fzbxbyfRPM3ZzShxIUiQpaw2b5yaBpoIErwTXzZfcLWdAKtRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aNTqmThZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 0814120B710C; Tue,  7 Apr 2026 12:29:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0814120B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775590151;
	bh=bdE3F4YaK3BzruHWXINYEwJ2N8SXLL4lsici64Al1S8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aNTqmThZNIBzer1RR1sBU4J5JZE01UCMdv/YAkbzWAKJafEolkp04z3H/seasjYJq
	 NWOTXa5Zdab/SmhWXnvaLe/4xL9FskAGuzq0fzYgg22pAyVB7jo/YeS3Nn2W52e+lQ
	 VGzEUYH+9LZKbCiQ1/pjcL0B6GCsa1RBIiQmyZL4=
Date: Tue, 7 Apr 2026 12:29:11 -0700
From: Dipayaan Roy <dipayanroy@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
	longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
	ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	stephen@networkplumber.org, jacob.e.keller@intel.com,
	leitao@debian.org, kees@kernel.org, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next,v4] net: mana: Force full-page RX buffers via
 ethtool private flag
Message-ID: <adVbBj/5x8K6s0uQ@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <acrkwuIFyBXhwICF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260330154755.6a8c73a6@kernel.org>
 <adHTm2SvjDrezEdv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260406105136.5e02420e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260406105136.5e02420e@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10055-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F36253B39CE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 10:51:36AM -0700, Jakub Kicinski wrote:
> On Sat, 4 Apr 2026 20:14:35 -0700 Dipayaan Roy wrote:
> >   Function                        Fragment   Full-page   Delta
> >   ─----------------------------   ─-------   ---------   -----
> >   napi_pp_put_page                  3.93%      0.85%    +3.08%
> >   page_pool_alloc_frag_netmem       1.93%         —     +1.93%
> >   Total page_pool overhead          5.86%      0.85%    +5.01%
> 
> 
> Thanks for the analysis, and presumably recycling the full page is
> cheaper because page_pool_put_unrefed_netmem() hits the fastpath
> because page_pool_napi_local() returns true?
yes right, thus avoiding atomics.

Regards


