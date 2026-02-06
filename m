Return-Path: <linux-hyperv+bounces-8758-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6h58Cl2ShWm4DgQAu9opvQ
	(envelope-from <linux-hyperv+bounces-8758-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 08:03:57 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCBFACD2
	for <lists+linux-hyperv@lfdr.de>; Fri, 06 Feb 2026 08:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91BC73034335
	for <lists+linux-hyperv@lfdr.de>; Fri,  6 Feb 2026 07:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E4730BB9D;
	Fri,  6 Feb 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="taPb5JQM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4C30BB95
	for <linux-hyperv@vger.kernel.org>; Fri,  6 Feb 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361431; cv=none; b=JeGOe0i8uLU4jnuVlzdKCSc33qCsr0xD/v6R42AXT7zDWZ9BByc4txlrYPZjVI1Cn8b/fvX7zP0Tg/LAfT/MMr4t4MwwA6iqIcjtoAGIlA1YnMGBqimO2Aof+/tHm+EFm2nOwrK+3A193G/uQf01ifeiK6oV5BvgOABke6XKU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361431; c=relaxed/simple;
	bh=4OK5qqHBlvNn0gAEtrhsq+6YvoNnFZ9aP1R/tk9wp8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEsMrnX4ufaL5Js+JKZAVwW+cy9FagF+NJoiuAvroZ2/EAa0wmYN13TcwcxrmisO8TrF85MMS/XZR1MZ568PZBNjXelhNRfr1iMmv0T0VUcn/RMTbst6QdluJRmy23lP/FZ8G0cLAZ3bp+uedc4yW1CCTn/LyqKtocsKh8ZHOEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=taPb5JQM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326CAC16AAE;
	Fri,  6 Feb 2026 07:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770361431;
	bh=4OK5qqHBlvNn0gAEtrhsq+6YvoNnFZ9aP1R/tk9wp8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=taPb5JQMOEVklPb5ayCFOD+vuOBlbtDTz5HhOqmXo/1z9rylY59zNIiA/BlFP7mMw
	 m9R4o4T5OTLwC6F3RX20o+c5a9ollMyQm7h8QFwOWQ7fQDKswWyJ9ZLBzA1QNzc+j+
	 bALz6yKLt//+J4vsj7UhMcM8Dbr6pkb/V6K9gX8Cn9o97z+TkWRibXDdg3vgdkKe93
	 7ZqO6CTSrwHXzjJw5ZxkESLvVSfmDAOxAsrzBqpI/P5JgSgzsBidyuojWqF1pSv+Sy
	 8hfx8XawL3SJPBpVslQqo6gqb6tDEAKYZ/nD8uvY8BSsSw6OA2mVAwWsd9IrRZvPBE
	 YQIGaEYE43TeA==
Date: Fri, 6 Feb 2026 07:03:49 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh R <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, wei.liu@kernel.org
Subject: Re: [PATCH v3] mshv: make field names descriptive in a header struct
Message-ID: <20260206070349.GA691451@liuwe-devbox-debian-v2.local>
References: <20260204202328.196690-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204202328.196690-1-mrathor@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8758-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94FCBFACD2
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 12:23:28PM -0800, Mukesh R wrote:
> When struct fields use very common names like "pages" or "type", it makes
> it difficult to find uses of these fields with tools like grep, cscope,
> etc when the struct is in a header file included in many places. Add
> prefix mreg_ to some fields in struct mshv_mem_region to make it easier
> to find them.
> 
> There is no functional change.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
> V3: rebase to afefdb2bc945 (origin/hyperv-next)

Applied.

