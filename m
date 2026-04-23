Return-Path: <linux-hyperv+bounces-10340-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCIVEggW6mlHtwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10340-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:52:24 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6751B452557
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 14:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26DA930BC9A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Apr 2026 12:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7119F3EE1CB;
	Thu, 23 Apr 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IQuj429Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3405B306B11;
	Thu, 23 Apr 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948492; cv=none; b=n+w7vHqBCrq3q/RAcyw1XYAwH7CWf5tC3h/MLMN8Vc9bpAPnaMlWlJL3kU6lTBVKS2gDMuOTUkqiYNwjpkPEuM6hp2ihjnuIJZKJbc8sD6wSuPxqR2j3e+Rpmj2RtZF/9QwR+4CbALiOuVvYG9aC663WfOkqIa7R5N2DiprLnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948492; c=relaxed/simple;
	bh=vCN2HlAnO4nmInBDUaHYmYFdEuWV6o0FtfKcw/RZ274=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py6lm2vZUdgFbnj/EoD7Vhp/st6XFfZnteSC9uPSInOCxrEEazLbRdLNydtYs8Y0HBHcja605FKM8NAZoAlDIttw6uCuT2bdh8o8eFHljqWYTjtdVVdTtRI1LqCt8p+8zWNI38e9G1ZObEKhzqLSp4y1jx+ZKXWdf6e5Hivl4tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IQuj429Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1204)
	id 5634620B716C; Thu, 23 Apr 2026 05:48:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5634620B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776948491;
	bh=tYfcCNmDGFuPmCFHrVbO62C1GJgiMfAx2nXRPGoKCIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQuj429ZBmOmbg4rZqnFcreE9tkZ61WuRRZHeOxFdwtV4YVrKTb16ajeM4V2TL68H
	 2K+v4HirZDKf6EWy8eRi/dP4GCcYtuyJr2k2fwlZ1uWQm6ycpQqKg1tziwdzylBrOG
	 b+hgLqvIKcM2lljxSeqrlyJaLAAA/BC+KyUPN8GA=
Date: Thu, 23 Apr 2026 05:48:11 -0700
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
	leitao@debian.org, kees@kernel.org, john.fastabend@gmail.com,
	hawk@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	ast@kernel.org, sdf@fomichev.me, dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <aeoVC27mIzoKytqA@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
 <20260409183509.0b24dea6@kernel.org>
 <20260412125917.4fa8fc8d@kernel.org>
 <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260416083146.0bb94d2b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260416083146.0bb94d2b@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10340-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dipayanroy@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: 6751B452557
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 08:31:46AM -0700, Jakub Kicinski wrote:
> On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
> > I still see roughly a 5% overhead from the atomic refcount operation
> > itself, but on that platform there is no throughput drop when using
> > page fragments versus full-page mode.
> 
> That seems to contradict your claim that it's a problem with a specific
> platform.. Since we're in the merge window I asked David Wei to try to
> experiment with disabling page fragmentation on the ARM64 platforms we
> have at Meta. If it repros we should use the generic rx-buf-len
> ringparam because more NICs may want to implement this strategy.

Hi Jakub,

Thanks. I think I was not precise enough in my previous reply.

What I meant is that the atomic refcount cost itself does not appear to
be unique to the affected platform. I see a similar ~5% overhead on
another ARM64 platformi (different vendor) as well. However, on that platform
there is no throughput delta between fragment mode and full-page mode; both reach
line rate.

On the affected platform, fragment mode shows an additional ~15%
throughput drop versus full-page mode. So the current data suggests that
the atomic overhead is common, but the throughput regression is not
explained by that overhead alone and likely depends on an additional
platform-specific factor.

Separately, the hardware team collected PCIe traces on the affected
platform and reported stalls in the fragment-mode case that are not seen
in full-page mode. They are still investigating the root cause, but
their current hypothesis is that this is related to that platform’s
PCIe/root-port microarchitecture rather than to page_pool refcounting
alone.

That said, I agree the right direction depends on whether this
reproduces on other ARM64 platforms. If David is able to reproduce the
same behavior, then using the generic rx-buf-len ringparam sounds like
the better direction.

Please let me know what David finds, and I can rework the patch
accordingly.


Regards
Dipayaan Roy

