Return-Path: <linux-hyperv+bounces-9050-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBrJEFA8ommB1AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9050-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 01:52:32 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB831BF7F9
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 01:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 269ED30630D4
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 00:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AB526A0DD;
	Sat, 28 Feb 2026 00:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFJX9w/a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DF725A659;
	Sat, 28 Feb 2026 00:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772239948; cv=none; b=Nbl3myXs/Eejs2uMIolfMCw7KXTvGOBI1lA7vt0BNDRbtp2bKo9o7dFsFnqY4/ACho09oaQxI51kXfl2jOojG0uImtjNmmp8iv3dXa4FbVel46pLt/V0gwGn5mFPO4yzu/46z5tgHAWX5DDomug+hoxg8FqE9UsS1KiaR2AamkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772239948; c=relaxed/simple;
	bh=HbIaXmlTQV8BcoyoLbcvKjegmAiJziZwViXNHyzXJrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZWZWGc2XcbpejkKP803/0BLXgJQKezFRpcaZI2gwEam0PiZ2yk15iAok9nfNFokRu+ltzMB+4jOAXUb8O1eGi7c4fRcDal/boq/PnMrOqrTfoqz7EStWPJup5pPchN1Gu4q+W5JQAyDOqeGwJhrYrcSTvOpr5QnwddooApGYcEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFJX9w/a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB78C19425;
	Sat, 28 Feb 2026 00:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772239947;
	bh=HbIaXmlTQV8BcoyoLbcvKjegmAiJziZwViXNHyzXJrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vFJX9w/ahjIUCmxx7noxqX7LuQwN41vQQiizcVgzycPBxQcx9BV3+4G+QbPI9hRR2
	 7CgjF/pUT3mfsgKpi78ZFylhJ7HyGcY2VzSrABnMi1bUP6yixtDb4dEgQWzH3aDyxC
	 k6e530dHoFXLlzw9t5QTcZ/bqFG2B6K1OssRT6GVmHCXKs3o23EV6VOthPyyr2o4rL
	 0wQ8W+C06KsXd4UgsK9PEX6cS57kQ/nDGaIyEU80CdqIzR+WFC2/B6dgTQ1k9CEhl8
	 tUSwoVqDyZHQYo8qZFAc/qm7wxYkaEf+6UACWEDhrMFv++IIZhZMTLUEEHh+mjZb8O
	 BhADpuQL7QQSg==
Date: Fri, 27 Feb 2026 16:52:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Add MAC address to vPort logs
 and clarify error messages
Message-ID: <20260227165226.07efbefd@kernel.org>
In-Reply-To: <aaHrN+spIIaswoX6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260225192252.943534-1-ernis@linux.microsoft.com>
	<aaHrN+spIIaswoX6@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9050-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DCB831BF7F9
X-Rspamd-Action: no action

On Fri, 27 Feb 2026 11:06:31 -0800 Erni Sri Satya Vennela wrote:
> On Wed, Feb 25, 2026 at 11:22:41AM -0800, Erni Sri Satya Vennela wrote:
> > Add MAC address to vPort configuration success message and update error
> > message to be more specific about HWC message errors in
> > mana_send_request.
> >=20
> > Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com> =20
>=20
> Gentle ping =E2=80=94 I sent this patch on 25/02/2026 and would appreciat=
e any
> feedback when you have time. =20
> Happy to rebase or add more details if needed, thanks for your review.

What are you trying to achieve with this ping? Just look at patchwork,
there are 61 patches ahead of you in the queue.

These are Microsoft review contribution scores:
  Author score negative (-42)
  Company score negative (-1118)
so you expecting that someone in the community will jump onto reviewing
your patches is... odd. How about you review something?

Read the process documentation, and please have some basic
understanding of what is consider good manners when communicating
upstream.

