Return-Path: <linux-hyperv+bounces-11538-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C93zDjUGJ2pAqQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11538-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 20:13:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3339659955
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 20:13:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iOfrT7oT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11538-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11538-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA421302EDD7
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 18:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2101F356740;
	Mon,  8 Jun 2026 18:09:47 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7282E9729;
	Mon,  8 Jun 2026 18:09:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942187; cv=none; b=mk6zDtBgX81R85mdjZ2gx1ITT4FzJVu3oTK9g+cAQThqv/PMRglUsYqIuukYO+Zt1ijjBjO/bN+rdRoF7sRM8XHRfRWRpnw80nQ7onVq/j2oCYnPoNEK7NNTCejBXhP1MxmIiLZyccGrAv/U3NCIQIjwzfx3Oj1Wi33qWHfnLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942187; c=relaxed/simple;
	bh=yQi0FehVr0hnoiorPe50JtCERf51hXdcTjU/5ztdS7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=DZzox2d2tQ+KysJ4OhdhCZcqzxAA9gEGk+MpzBRijU4raDW6noHw128WgU3mGZTjDoAFaXiAeMX9B1+3Dm69aWXCWEfXJpqqZZXGhnaJmj1z4R4swxaH7p+/0cBFsE7GJm7f7JQEbLTYW1IN6GhWBhsiEDqqFA58zMGy4DcBg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOfrT7oT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02341F00893;
	Mon,  8 Jun 2026 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942185;
	bh=w6Sj9KBVpWBu0IRBBMFLVz+Qm72fUyU8TG/ZcqyT+mQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=iOfrT7oT1QEv19CjUppniUxpZRLrPye+538+5g/gjz57wWECexZHVxWR24m6NuN9I
	 m8PgHRimnwWufc3+eE3slC2N+r5IXlAQj+v6g9U/HjqNbrujNxOZIghMt4V57rM/0D
	 3Agrc/ozlytPfSNzJLxRD7NTONUSKNqZm5GGY+oBQfNFb81bnWCjgu0vuBPk2Kvax9
	 1wtamivtMZZbWQvpr3RzXFoIs49Ihu9Kn9m2edgYFRY/zDkeR74v02PJAfNoxb0Ql3
	 hFpn4DgBvYBRLXPPxFgY65Y6YL/b6pso964+Csv5zA0MZqiSX5BYL5QP8O98EBoFcR
	 oOvrRw5Acxrdw==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 20:09:40 +0200
Message-Id: <DJ3VBAU543O4.1MCNNBJ7U9IRN@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/4] Convert remaining buses to generic
 driver_override handling
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <driver-core@lists.linux.dev>, <linux@armlinux.org.uk>,
 <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <kys@microsoft.com>,
 <haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
 <longli@microsoft.com>, <nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>,
 <linux-remoteproc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
 <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11538-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:driver-core@lists.linux.dev,m:linux@armlinux.org.uk,m:andersson@kernel.org,m:mathieu.poirier@linaro.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:nipun.gupta@amd.com,m:nikhil.agarwal@amd.com,m:linux-remoteproc@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jianhao.xu@seu.edu.cn,m:runyu.xiao@seu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D3339659955

On Thu Jun 4, 2026 at 5:52 AM CEST, Runyu Xiao wrote:
> Runyu Xiao (4):
>   amba: use generic driver_override infrastructure
>   rpmsg: core: use generic driver_override infrastructure
>   vmbus: use generic driver_override infrastructure
>   cdx: use generic driver_override infrastructure

Given that you changed the approach to use the new driver_override
infrastructure, I assume you read the message in [1]?

In this message I also explained that this all has been addressed and was m=
erged
into driver-core-next already.

[1] https://lore.kernel.org/all/DIYPR0K2CZW7.254R8K7ONBX5D@kernel.org/

