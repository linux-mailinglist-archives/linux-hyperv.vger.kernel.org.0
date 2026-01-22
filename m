Return-Path: <linux-hyperv+bounces-8447-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GjnIialcWmgKQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8447-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 05:18:46 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F0A61A9D
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 05:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4A8542154F
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 04:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA11393406;
	Thu, 22 Jan 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsdJwD4W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914862877DA;
	Thu, 22 Jan 2026 04:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769055254; cv=none; b=LfIqIuLowvfm1aziessMn0itMKQab7hKsTEB2KAd3RGn/wqBQzuztkBKjvnSwcBhwANXxTKvWUNxNMyLX6/aqoxm7hQACoIo5/bJQPyBgD4B9ZoBX995JOkP0dnJvcJ5sqkl/1xf2PDwjp96XIbfkGnrZ68uBR8QP1evdsjRyiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769055254; c=relaxed/simple;
	bh=zhu6dGIyVP2+d4I1Exe97UZ2YxP6FnkSl+SLZz3GaN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNjPC6r1qIop0jMs6rNVtcEgRLSTgAkVXnXGZyJxR0/c/d/nwy3aB2OaK2cxJlJUda5IdAgMu6A9AG4Mqlqt/T6zFHsNvZ6WZRCJ4zrPfrBKYzQOgpEJZgdpcFSaJTn9+Avs/D8aUedKLfFyo5dZpYdzrWHEkF4jl9M2QKJw7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsdJwD4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3B5C116D0;
	Thu, 22 Jan 2026 04:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769055254;
	bh=zhu6dGIyVP2+d4I1Exe97UZ2YxP6FnkSl+SLZz3GaN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EsdJwD4WZpNEC6Gs24HPVI2+457fEHk0nMywpxvfOPvOk8GmhhhGzrxAiXESdP7Tq
	 HMxsK/oX3L/sArPcvyjQy0NcJwvNAN8un6g8QbkAMEtqp63W421cIYcxwQXibUIclj
	 PQkruEYUCZQBIsrer3fE7XcPZ8Uvl7is8cxuz2ZAXZhHcTyIPPyOGykOLFp8E/gtvY
	 WGGP4CEgzEZ/9fQlUgu+2/CkD5XRvz/lQ0Hb876VDYNsvyoaL3oVrrun8AWh//hC/u
	 4NxJVUDG94D/NyWzLZKsz6gDrFhPPt7zN1BjVgft9gL6B8Kdf3px7OCYYYgneNVT+B
	 Y0+uSJqvIAiMQ==
Date: Wed, 21 Jan 2026 20:14:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 leon@kernel.org, kotaranov@microsoft.com, shradhagupta@linux.microsoft.com,
 yury.norov@gmail.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, ssengar@linux.microsoft.com,
 gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Improve diagnostic logging for
 better debuggability
Message-ID: <20260121201412.179f9b37@kernel.org>
In-Reply-To: <20260121065655.18249-1-ernis@linux.microsoft.com>
References: <20260121065655.18249-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8447-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 70F0A61A9D
X-Rspamd-Action: no action

On Tue, 20 Jan 2026 22:56:55 -0800 Erni Sri Satya Vennela wrote:
> Enhance MANA driver logging to provide better visibility into
> hardware configuration and error states during driver initialization
> and runtime operations.

> +	dev_info(gc->dev, "Max Resources: msix_usable=%u max_queues=%u\n",
> +		 gc->num_msix_usable, gc->max_num_queues);

> +	dev_info(dev, "Device Config: max_vports=%u adapter_mtu=%u bm_hostmode=%u\n",
> +		 *max_num_vports, gc->adapter_mtu, *bm_hostmode);

IIUC in networking we try to follow the mantra that if the system is
functioning correctly there should be no logs. You can expose the debug
info via ethtool, devlink, debugfs etc. Take your pick.
-- 
pw-bot: cr

