Return-Path: <linux-hyperv+bounces-11528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r2EFGIdaJmo9VQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11528-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 08:00:39 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFC765300C
	for <lists+linux-hyperv@lfdr.de>; Mon, 08 Jun 2026 08:00:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZjMkEf3d;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11528-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11528-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72FFE3007E12
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Jun 2026 06:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C3A29C33F;
	Mon,  8 Jun 2026 06:00:37 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EF02E7369;
	Mon,  8 Jun 2026 06:00:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898437; cv=none; b=iaeSUyXFbyoe0j8Wn6knmPyNV5Bhu4S2nxJqVtym8VHZSpRzK3HgsddowPCDWaFa/AOdo7vbp3Mr55xx0NLl9c9EHSqR+ttSS0iO5NoUUV/hmaElKgeFZqLG0zGr88yN0NIjjSAGtpk1gCsCbvj3wmYxkqIeBlD9AFesUsOcgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898437; c=relaxed/simple;
	bh=4XSdySNC6ADz9P8KbUcNklDk+9Rvn9ooMDG3UVATMnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8nTPI9IwordVcOvMiAMWxMQJID4ncUEIxieiPAIYb4023DhtqTP/389o0gqTXzUaWzfsLci0z7V4GIkUS8wLR17hS4W350w0zNaBsDFhJwECjZxtMcTJoj+aLJgT6h4hCLI1GXEVQq1NLfzvo1dpMKwFzTzYBg7o+dGFepVUVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjMkEf3d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91AE01F00893;
	Mon,  8 Jun 2026 06:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780898435;
	bh=TJIqRbcVuZGfZowRQTnAoA4n6W2NjIkeKA4nRugIc+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjMkEf3dqgBnPcx/ttCI1ltijDWBQbChhlRd4huUNbWNBOYDg2rYhXjTszVYTEDis
	 hg/cI3TJiD26RpCQd+WxU1FxzCSXGaDOmfeY/WZLipJZyR0qJDDAKcih2GTw2t457G
	 uSbMu+hOhjFGvVD53JR7yrDIlnmo2mqfGjofUvOxpG/ILpsLVniIt9J/JuASp185Qv
	 rbyVFAXvPRobmRs6S2MYAWp42aGRhuEIdj0wBRkVku2E+QEHcxvZvm3LrAdrMWsYok
	 wxKRz5xADptuwZbJWpBs2YcMjymJ7k5xe9EuVi6mKpHQ3FfkvIwtSBdpagSGkUSEja
	 l/d8rBYXMTaPw==
Date: Sun, 7 Jun 2026 23:00:34 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyperv: Cosmetic changes in irqdomain.c for
 readability
Message-ID: <20260608060034.GB1555293@liuwe-devbox-debian-v2.local>
References: <20260601225116.956392-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601225116.956392-1-mrathor@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11528-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mrathor@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wei.liu@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,checkpatch.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AFFC765300C

On Mon, Jun 01, 2026 at 03:51:16PM -0700, Mukesh R wrote:
> Make cosmetic changes:
>  o Rename struct pci_dev *dev to *pdev since there are cases of
>    struct device *dev in the file and all over the kernel
>  o Rename hv_build_pci_dev_id to hv_build_devid_type_pci in anticipation
>    of building different types of device ids
>  o Fix checkpatch.pl issues with return and extraneous printk
>  o Replace spaces with tabs
>  o Rename struct hv_devid *xxx to struct hv_devid *hv_devid given code
>    paths involve many types of device ids
>  o Fix indentation in a large if block by using goto.
> 
> There are no functional changes.
> 
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>

Applied to hyperv-next.

Wei

