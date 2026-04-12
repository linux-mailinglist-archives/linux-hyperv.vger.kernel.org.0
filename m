Return-Path: <linux-hyperv+bounces-10114-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOA0KIyV22mxDgkAu9opvQ
	(envelope-from <linux-hyperv+bounces-10114-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Apr 2026 14:52:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 024663E3DA3
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Apr 2026 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6909300EAA6
	for <lists+linux-hyperv@lfdr.de>; Sun, 12 Apr 2026 12:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F091311968;
	Sun, 12 Apr 2026 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAOyzisz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64038D;
	Sun, 12 Apr 2026 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998346; cv=none; b=OUxMcNohMnAG+5VNhp0naHNaopN0iQRkhgRfpP1uwotYiQnFMGaB9ZtxAEue7I0J+O/pldRqCyZoHQjsmIhzlgp3/zvQOqjrsOj9bq1mWUoY5bJwBofZnJz9y7Ui1fxrIwqqoZrwlibZagWyKDcDZghs8QmQ7ni/fuETMIOKvE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998346; c=relaxed/simple;
	bh=B07c9IpAqwmdNh4stWbJRCwZXUhJsWch4tfxxAyVLMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWPK3qWsHjP4tvkBwU9g7MqxQwVK4MjyjCfdE+4wLp81wqepP9KR4v4eNBmeHp8zUdBRTsCgGZQL+EHGiUyxFM0NWv3RHkv2Wi0wY1o+pqt5KCsgd1RL38k9g/BnllXe5gIQvRL1n78lsUKFd0Hj4kv64yCz7HLolsRTpz8P1ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAOyzisz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41037C19424;
	Sun, 12 Apr 2026 12:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998346;
	bh=B07c9IpAqwmdNh4stWbJRCwZXUhJsWch4tfxxAyVLMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VAOyziszs0Sk0fSw2Xxw16cc17NihM6n4WqZWxel+8U5awV3eLvFpcnahiG+jN+0C
	 s07PA2M/+ciUjt2U7uKty8Ex2QiYTMrxYWi+rmiza3bBfM4umWktsEz8fJwt554qqR
	 ZECdGjBFgSJWEVm7+SM6Ekcemo2nE2+Jzs1ZqKUiGl6E6B7BIY25c1a/RbzBJAUcCf
	 InHXunXvsITd1Kaq8ISO+90zXNlZzFLYU7RP+vHLAkseTlGhGib5LdRCliaJBFnqJx
	 VesETRe6oWD9a3591g+ArqamQeNtDkno/Zg/pwC63YP7KFDjbqCnuDjuatsTJxMQNl
	 oVIDqbhHv7fIA==
Date: Sun, 12 Apr 2026 13:52:19 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shradhagupta@linux.microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: mana: Use pci_name() for debugfs directory
 naming
Message-ID: <20260412125219.GI469338@kernel.org>
References: <20260408081224.302308-1-ernis@linux.microsoft.com>
 <20260408081224.302308-2-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408081224.302308-2-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10114-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,linux.microsoft.com,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 024663E3DA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:12:19AM -0700, Erni Sri Satya Vennela wrote:
> Use pci_name(pdev) for the per-device debugfs directory instead of
> hardcoded "0" for PFs and pci_slot_name(pdev->slot) for VFs. The
> previous approach had two issues:
> 
> 1. pci_slot_name() dereferences pdev->slot, which can be NULL for VFs
>    in environments like generic VFIO passthrough or nested KVM,
>    causing a NULL pointer dereference.
> 
> 2. Multiple PFs would all use "0", and VFs across different PCI
>    domains or buses could share the same slot name, leading to
>    -EEXIST errors from debugfs_create_dir().
> 
> pci_name(pdev) returns the unique BDF address, is always valid, and is
> unique across the system.
> 
> Fixes: 6607c17c6c5e ("net: mana: Enable debugfs files for MANA device")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


