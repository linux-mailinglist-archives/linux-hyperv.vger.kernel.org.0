Return-Path: <linux-hyperv+bounces-9850-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCIfByL4ymmlBwYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9850-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 00:24:34 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0653361E48
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2026 00:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3672302704A
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E1C3E3C4C;
	Mon, 30 Mar 2026 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X0rYMfry"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F8B3DDDB1;
	Mon, 30 Mar 2026 22:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774909402; cv=none; b=e+5oWSvHIo/LgktVmgT4y7GPTXg1jQUSY3RRMaSdG1GSXfzmZ7Uyy+Rbcq7b2S81pwJuVqQxkH7oH9BYP3yhhSFtpqNT2yf7Wzo90HFanPqienxF835FmcoSo5bpShl0vrVspDn+zMsWU5IcCazQ+XydEzj2coD9pOOBEfkPSG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774909402; c=relaxed/simple;
	bh=R/RTYULXwMk5jUyXPTlsjfkiAucxmpo5A8GIlmR+4pI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9KpfDNy8+zTgr1/k/4XYi/iDabxRdad8LGqd8W2+xW6D6gO+HeLMxiAC94a0Kx57gpzG+FMe8e9Xp8BBX1/LMvIFjwx7fj84EsAZtU6dK/LRhTRPrDi+CLRrC8p3oMF6sLqRQf+T7nnpu/7CWzm2giYXApEmbXmrEYCDQZtPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X0rYMfry; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EB4C4CEF7;
	Mon, 30 Mar 2026 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774909401;
	bh=R/RTYULXwMk5jUyXPTlsjfkiAucxmpo5A8GIlmR+4pI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X0rYMfryywhutY6O4h5DcOtft954Mqqbo5clo1gTAQiKIfqI2gr263Ib68H1c878N
	 aGehaKv/M3SGBbBhpXye4W0sHfhmB8v4XkbiBdXXcBxxL2fnDNcTKLhhjZ05/W3O2Z
	 a3RZ/iE5LeQEwlH6m7zKLtHtmXxotgZFzO7x/YhOPVdbqMXzpxDP0xYmnKPAxu7Cl5
	 RA+Zlj9AJ4u6oV0vwBYzfr3tunqPhVC+ja03upecAu/kYlEKe5BF2AtxoEMpIBbnMY
	 O7FWd9HlrjlCgG++1J0ODjkGg/q15snobTvSXA8Ra5P1rsxU+5CZcs3xXyydDLxOGb
	 mcrPri0YQjK/w==
Date: Mon, 30 Mar 2026 15:23:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, shirazsaleem@microsoft.com,
 dipayanroy@linux.microsoft.com, yury.norov@gmail.com, kees@kernel.org,
 ssengar@linux.microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Expose hardware diagnostic info
 via debugfs
Message-ID: <20260330152318.144c1b30@kernel.org>
In-Reply-To: <acrKgG0USsGABqYT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260319070926.1459515-1-ernis@linux.microsoft.com>
	<20260323174444.2717da3d@kernel.org>
	<acK56AlPfVW8cDPe@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<acrKgG0USsGABqYT@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9850-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0653361E48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 30 Mar 2026 12:09:52 -0700 Erni Sri Satya Vennela wrote:
> Just a quick follow=E2=80=91up on this. Since these issues were pre=E2=80=
=91existing and
> not introduced by this patch, would you prefer that I send them as a
> separate fix patch, or fold the fixes into the current patch?

Anything that's pre-existing should be a separate patch, before any new
code. If the bug exists only in net-next - earlier in the same series,
if the bug exists in net - posted separately for the net tree.

