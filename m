Return-Path: <linux-hyperv+bounces-9860-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCGDL64OzGnGNgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9860-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 20:13:02 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C012536FCA7
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 20:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 920AE30D23EE
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FCF426D3F;
	Tue, 31 Mar 2026 17:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gH4zDWf3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D8D2D77F5;
	Tue, 31 Mar 2026 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774979905; cv=none; b=JVeF8dyrG3Gy56iK0eFcUXwAZQntkqL8ufaTZPTWomhPUoKy7NRWK+rtO5TARBWKIVy5hg9s6soMhfsZYChPldcJoZrGYnjq/d8PlZ7FFRpwK3AJTxVLvvNgV2B50nZ8CwEWlXead7Q9Cevc4evF3KtjA3jVyjDL/emcBSsy3p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774979905; c=relaxed/simple;
	bh=o4JQSRMSrZkTH0rTDnWxywy+ATTRE1+/o1CIMTObSyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXF4JkX65SJGX5l4/KU/VEpEzINO/Sswgjg1/jk2ucVav1+jAPKCN6ZG6kEQBHd+R6Fx0JlmsIwvsnGxHAXOyUo2pvlr0n7AGToR5r2CYIoAM9CuQNjNyNGimRuC1Gv8RCEQtDlqc0Q+/WIwJYcxHt9kBxzCwXITYxCQlaFexNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gH4zDWf3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 373DE20B712B; Tue, 31 Mar 2026 10:58:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 373DE20B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774979904;
	bh=DP28GbdRwa/FfrIzPEzx5BeaVDcFUHdYnAJ06F+116I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gH4zDWf3vg47RlWXfZ/asHM8JIoBOB7S7tUJr4DZ3WB+O3TIdsJH90ZxlMoPqj/CA
	 UjrCrsbUWowNNBe6yImcEjMKWFKzEfwLTLQ6GCZ0cXgGFTJpB0a4iuP3Q8wNuyFFLQ
	 PaECQJZkRFINwtHeaboT/LLgU6Fz+vuxuIbpRk7o=
Date: Tue, 31 Mar 2026 10:58:24 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
	dipayanroy@linux.microsoft.com, yury.norov@gmail.com,
	kees@kernel.org, ssengar@linux.microsoft.com,
	gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <acwLQMvJc/Q25mJa@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260319070926.1459515-1-ernis@linux.microsoft.com>
 <20260323174444.2717da3d@kernel.org>
 <acK56AlPfVW8cDPe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <acrKgG0USsGABqYT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260330152318.144c1b30@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260330152318.144c1b30@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9860-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernis@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.microsoft.com:dkim,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid]
X-Rspamd-Queue-Id: C012536FCA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 03:23:18PM -0700, Jakub Kicinski wrote:
> On Mon, 30 Mar 2026 12:09:52 -0700 Erni Sri Satya Vennela wrote:
> > Just a quick follow‑up on this. Since these issues were pre‑existing and
> > not introduced by this patch, would you prefer that I send them as a
> > separate fix patch, or fold the fixes into the current patch?
> 
> Anything that's pre-existing should be a separate patch, before any new
> code. If the bug exists only in net-next - earlier in the same series,
> if the bug exists in net - posted separately for the net tree.

Thankyou for the explanation. 
I will send it in a separate patch.

- Vennela

