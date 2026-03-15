Return-Path: <linux-hyperv+bounces-9416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5r/kMknatmnfJgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9416-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 17:11:53 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 193B8291599
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 17:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2C2830210E1
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Mar 2026 16:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE6371056;
	Sun, 15 Mar 2026 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3Mm/T6g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D97366546;
	Sun, 15 Mar 2026 16:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773591110; cv=none; b=EbMbyQ/etrpKKrq6Yb45lauWbn+3/UMFOB8NW9qOoaj6QBcEG2cVbVPb5B3LiaAxT+8F/uZPR+Yr7mxX4NeoO/z3pfcfXpEzq2KgdXZKNm9Y86znCwg0ZtahSBpYFUOKmp7hcxqaHJZhfGrIXeIuwUomagzlq/S/ZEuk8f2+Ti8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773591110; c=relaxed/simple;
	bh=ysGCy3hRZ0k9cAzYYMnSd2CSwEnVozMuThlxlhsUDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2qepmCS+eGzCbNvbspHMz6dnH5ZpgAaixFJ99XASzjy6jbZLS88idhdF8G5c6edwlb8P2bAlPRUrm/c2uU20eD/qpaFJ9yZtOHBn9pTq9PSVeCQSn15pVkQsF69MwPH8w76vb8G1AF3jJhKvetaycmKtwuVDBd7xQnRigUovN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3Mm/T6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48962C4CEF7;
	Sun, 15 Mar 2026 16:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773591110;
	bh=ysGCy3hRZ0k9cAzYYMnSd2CSwEnVozMuThlxlhsUDm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N3Mm/T6gJRYibqZqBNZ9YIx1+/oFvQxBnOlBL7Ry6RpGLwocK8vPcKRx5St0EZqw6
	 3W5kfYyBqXsPwDpjCD+qPX/zb1D452Lqiroy/9h13YUVQcDyFPagZguYwrVvmYiMSU
	 tuFCtW+2bKNP5So1fj0i/tse5owRoIkW5s5kOSqKuTTKDRd3t4A6fejohvD1QWsEDk
	 tqqDmnsdggfRA7Zur140Z/pRjnWhRbtRiMxrKn4pcbxu+kCl9vOJ1qMCFftp2O4QUC
	 2Swz9g+b1pwQWsFzYooiCVIFzt9IcQxBVGN/mrOMMZbA4vwrMrkW1noH/btEcv6QbK
	 YO+S5TZAcMYkw==
Date: Sun, 15 Mar 2026 16:11:46 +0000
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH net-next v5 0/3] add ethtool COALESCE_RX_CQE_FRAMES/NSECS
 and use it in MANA driver
Message-ID: <20260315161146.GA1369074@kernel.org>
References: <20260312193725.994833-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312193725.994833-1-haiyangz@linux.microsoft.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9416-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 193B8291599
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 12:37:03PM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Add two parameters for drivers supporting Rx CQE Coalescing.
> 
> ETHTOOL_A_COALESCE_RX_CQE_FRAMES:
> Maximum number of frames that can be coalesced into a CQE.
> 
> ETHTOOL_A_COALESCE_RX_CQE_NSECS:
> Time out value in nanoseconds after the first packet arrival in a
> coalesced CQE to be sent.
> 
> Also implement in MANA driver with the new parameter and
> counters.
> 
> 
> Haiyang Zhang (3):
>   net: ethtool: add ethtool COALESCE_RX_CQE_FRAMES/NSECS
>   net: mana: Add support for RX CQE Coalescing
>   net: mana: Add ethtool counters for RX CQEs in coalesced type

Thanks for the update addressing my review of v4.
Overall, this looks good to me.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>


