Return-Path: <linux-hyperv+bounces-11379-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKb4I/TXGWqjzQgAu9opvQ
	(envelope-from <linux-hyperv+bounces-11379-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 20:16:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D928C60726B
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 20:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8399307D7C4
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 May 2026 17:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DE8399375;
	Fri, 29 May 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ImV7sPhj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1638643B;
	Fri, 29 May 2026 17:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780077464; cv=none; b=gvZgD8oQdOQivOXI+vQi96KjUZF2ra1BKbvHo7QTD79YbX5gr8NKILTKR0X1PyPAxmtXo/Pawr0DSjFBLQRdozMOSxHv1vrOG3BWHtPTxvzq2Ms99mz9w5Ir3zZgGxHhNVuxct1pEIje3vgXdBZEM5QEepYCRMC9Xl2M2/jnXyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780077464; c=relaxed/simple;
	bh=Lm8IWsb2xfE7LV51mxxlGd0Up3SqIMd44fqpOboAiDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXsn3PLLSEyK61YW8GzkmXJpEb3jJGd8wF4Pq3tbGddVZnAlwkh+eqdEV0qfVb/IUNtzYUM/pvurjeKuowrp7YtQoZhOLiccVljw+qRrzgLyLjWJkd1Dd9gWpSskkJwRB2GieWZlOmkJWtPSPV5OcVn3IKRvZLFy2Qy040Yd+jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImV7sPhj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080191F00893;
	Fri, 29 May 2026 17:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780077462;
	bh=mTS/LzRHK0T4/O+G33hajsBVG4Fv+EkP5Xqc1J5ho7g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ImV7sPhjHWc3LCOoBtfTrOF0qet65QmoHU2tlCmMcyVL1wLcSurL4O9tFYBv+K+/2
	 Cks7cU3IoX8Mb1gIv7/xdvrMys/T2cRS3pnn1N2kBoVOsvNzsCHOssES+fOEfoyik0
	 QJzAQxiDsGSaPJz+f+lg2UpQYJ/dW7KkG/rsY03T+7iFcoPR9da6WBPzWvDcpzQjAL
	 vlB9jztV0Puq/ybNV9R+xzVxdmbyeQCtSUM32FZnHI0w/WT8gC6d5F1xeuI1NePJ94
	 LiU+RyK6rSPMwVmuda/v/6Ji61rPBFF9eMZP3AIp1H3LmeBA/17NiyCZYRZMzFI24/
	 wL+KfdBwyj+Nw==
Date: Fri, 29 May 2026 10:57:39 -0700
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
 stephen@networkplumber.org, jacob.e.keller@intel.com,
 dipayanroy@microsoft.com, leitao@debian.org, kees@kernel.org,
 john.fastabend@gmail.com, hawk@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, ast@kernel.org, sdf@fomichev.me, yury.norov@gmail.com
Subject: Re: [PATCH v8 2/2] net: mana: force full-page RX buffers via
 ethtool private flag
Message-ID: <20260529105739.5fc5fdf5@kernel.org>
In-Reply-To: <ahkAG/EN2YhKIKpi@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260508115100.488506-3-dipayanroy@linux.microsoft.com>
	<20260512022133.856196-1-kuba@kernel.org>
	<aguFpq8+LV+I9oH0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<ahkAG/EN2YhKIKpi@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11379-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,vger.kernel.org,networkplumber.org,intel.com,debian.org,gmail.com,iogearbox.net,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[33];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D928C60726B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 19:55:23 -0700 Dipayaan Roy wrote:
> As the pre-requisite fixes patches are accepted now:
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=17bfe0a8c014
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=5b05aa36ee24
> 
> Can this series be merged now? Let me know if it needs a rebase or
> anything else.

If there's any dependency, functional or otherwise on the fixes you
need to wait until they make their way to net-next.

Otherwise you can rebase and repost now.

