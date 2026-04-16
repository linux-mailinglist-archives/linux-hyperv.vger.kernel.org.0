Return-Path: <linux-hyperv+bounces-10191-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF4rMnoB4WmJoQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-10191-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 17:34:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8B3410EC6
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 17:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE7F9300CC32
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Apr 2026 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0168E3DF004;
	Thu, 16 Apr 2026 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJeQKmWH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04E431D372;
	Thu, 16 Apr 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353513; cv=none; b=pUrbQPVrNMSq0DRTXsNoO9ojmJG1WWPVGP030yYAPuqOposg8iIYyZAAJi4y3TXxEZxMBtvVuaotysQN3AlwfRsI1hZiO1W5p2uhqEEpAu7dz8AbOmO6G2b0/u/QE8vw54SPdkEdGH+WFoihNFi4wX15kja1BBhxnPT7l+OtLcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353513; c=relaxed/simple;
	bh=jssH9UnmqcByLPfuDr/larPx0BO5IHoq0niW0tXf3+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5wazEPCbZqc2k1QS2aDSmg5gBki2ecGV820MSlqhV7sYguEREIPevT9VewpgAr9Nc+bgxKnK9GMAEOjDKoM+bxog+5tO/Ky3pD1eouDEL1SafmwnkH4oIIuuJFVZDLMP/Akj8r3fH0mewR3Z/qvJXmEmMrR6i749+wDdkOKdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJeQKmWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F8FC2BCAF;
	Thu, 16 Apr 2026 15:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353513;
	bh=jssH9UnmqcByLPfuDr/larPx0BO5IHoq0niW0tXf3+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rJeQKmWH9lDUzBvTjARIDU98AO0+auPSAoka02Vtd1q2HWyFeHjfPxrliSbxxkM1b
	 RTKMoYRGIOENlqhwZEfa0zuUiHFOyu5bWVFvVHDRYd40Rg/cotfqdg3HDtOOWzuv/J
	 FndVfnAcgyJ5yBjbW8QLsf4JJ4CfMNahcsWg0d6wYpnJbOEgq+du9T0bHoWjx9eDMi
	 AkgTiJ1Lnn3cArm8BA1E2d1LFPBhTnko5yW/56Q2Spx8My+14LjXoMYeQ7qBaNXPb6
	 MrQ6EN4LludV/tbqrwNcmTY8tyRoyltnryGLp70Nch/VjCpf8E1/ZZ1vEQmE0XehmR
	 MGoi9BpIGfCiA==
Date: Thu, 16 Apr 2026 08:31:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, leon@kernel.org,
 longli@microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 stephen@networkplumber.org, jacob.e.keller@intel.com, leitao@debian.org,
 kees@kernel.org, john.fastabend@gmail.com, hawk@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next v6 0/2] net: mana: add ethtool private flag for
 full-page RX buffers
Message-ID: <20260416083146.0bb94d2b@kernel.org>
In-Reply-To: <ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260407200216.272659-1-dipayanroy@linux.microsoft.com>
	<20260409183509.0b24dea6@kernel.org>
	<20260412125917.4fa8fc8d@kernel.org>
	<ad5kuCZz+gR1TlSh@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10191-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2C8B3410EC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 14 Apr 2026 09:00:56 -0700 Dipayaan Roy wrote:
> I still see roughly a 5% overhead from the atomic refcount operation
> itself, but on that platform there is no throughput drop when using
> page fragments versus full-page mode.

That seems to contradict your claim that it's a problem with a specific
platform.. Since we're in the merge window I asked David Wei to try to
experiment with disabling page fragmentation on the ARM64 platforms we
have at Meta. If it repros we should use the generic rx-buf-len
ringparam because more NICs may want to implement this strategy.

