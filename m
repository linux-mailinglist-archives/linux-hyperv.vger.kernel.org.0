Return-Path: <linux-hyperv+bounces-9069-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I8+IMJHo2l//AQAu9opvQ
	(envelope-from <linux-hyperv+bounces-9069-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 20:53:38 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC561C77CD
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 20:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03D543284B17
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Feb 2026 19:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B024ADD88;
	Sat, 28 Feb 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hke8etZ8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C7447CC62;
	Sat, 28 Feb 2026 17:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301312; cv=none; b=A9zEbU/ikI0LBcgpi1ao7n8HYWMTGmx/hFciQBRPdRDewRvTo1BvCKGeYB1bFVOpXZBo4d/5J6bnleGXcx2K6vymXMHmgCZB2n3mn/L3TBKJShzElh185ffDt41pOtKP8EFV/LZDbzb9SD0GoSKHXAFqpXBewxpxT3TLS7h0/QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301312; c=relaxed/simple;
	bh=BPC0ZAhSoYLqEk8i4/eWc/N+TngjWgfaqRoabhQOknQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kC3c85saYE/7wehl//aF7VWyhNSFGWJ6lUtr92A06q+5aGFb9j6TzPTFdYk6/T1YzTv7HkWbCibiKTJfs9Yw2aOL0nP4MRPBmoKEGk+cvlhfviBzMMjNTGTtSOrlGFT3z6gL7W9UessgnifUvKO0OOiQBP0/s5adhpzmkAcfK3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hke8etZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C6C19423;
	Sat, 28 Feb 2026 17:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301312;
	bh=BPC0ZAhSoYLqEk8i4/eWc/N+TngjWgfaqRoabhQOknQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hke8etZ8c+QcBGoap+zE20YYUy7S5ng+anwqlDQd7sqtQqHl0e8zk07FIDbsSYwSs
	 YwELrOOxWdPcX5Kw7Pumj4o0uBUTgGRhzUvjM69iiwpXqOtRfWsZ82SICUU4WZ92Gm
	 WgnI8JiYBn7s/qd2327+0jdcrCwjbURUGVfAoqLW/Tbx74GkrhOP22u0C9UtRUqkCO
	 R1qdJxUlgzXPoTR0bfikXsAC196DLY5eh9Cvui4cOqV3ImM+nvak8yi+hwz4Rhm+dY
	 qJcgyNpbNzOuLF7Q2sDd+MCslWJIoiIZhkqfMWX19/QS8Zd867QGVNXxG5AvblkJVR
	 fFMnPE0Kj2kyA==
Date: Sat, 28 Feb 2026 09:55:10 -0800
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
Message-ID: <20260228095510.7d5dec24@kernel.org>
In-Reply-To: <20260225192252.943534-1-ernis@linux.microsoft.com>
References: <20260225192252.943534-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9069-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BC561C77CD
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 11:22:41 -0800 Erni Sri Satya Vennela wrote:
> -			dev_err(hwc->dev, "HWC: Request timed out: %u ms\n",
> -				hwc->hwc_timeout);
> +			dev_err(hwc->dev, "%s:%d: Command 0x%x timed out: %u ms\n",
> +				__func__, __LINE__, command, hwc->hwc_timeout);

Please don't include __LINE__, they are meaningless given the amount of
backporting that usually happens in the kernel. The string should be
unique enough to identify the error, which I think yours is given the
__func__ + text you have.
-- 
pw-bot: cr

