Return-Path: <linux-hyperv+bounces-7706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C478C71290
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 22:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C85D42F30E
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Nov 2025 21:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10AF2EC57D;
	Wed, 19 Nov 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlimW9Ul"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774A728F935;
	Wed, 19 Nov 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763588079; cv=none; b=fNxAKcjfFfKn83u1orOSRFpAxRpmdOIYoMcADlquN1AbdxyTDcnOUaL2xY//xOAKK2kAFJXA2wtTd1U1av7OkEj4tBt8jlfy0xofX25yaicl8E2nYHBGNwqHu6PlXqKAMERHjJ6O6lrWR7R4L+s9irkm5vjs3/FV8AIR7/qwyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763588079; c=relaxed/simple;
	bh=KPaBSLRAdIZ3HfXiKCtKJStDf567xE0DOeK+Gm5iN8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgztjGjQ0Xj/6Yh3IdZaHikG4mpo1kzvd88HG78eoiwy44HF7biVuI++QjXm837rWC0m95vLfs1PADC9rrslbr/Z0C4CBf6zCKphimUVtdSEIxnelfFi32+TE79SmJ7tktriQGHK0+ksGcV3g+/IVwht/KH8bVRTMwCR5VazSZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlimW9Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC81BC4CEF5;
	Wed, 19 Nov 2025 21:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763588079;
	bh=KPaBSLRAdIZ3HfXiKCtKJStDf567xE0DOeK+Gm5iN8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlimW9UlKDX22gQloF71wyklvPyRb5kyUWk0NnXYiV2SxiNph175Xm+/tT3CawdFC
	 OxnRxmHiXYRRK93bgyqyZvM136M4HXG9CRUnIAVTWIstfSGt5IlG5GHbGmjGZbQiac
	 Jq2bWGU0J2F+gQNFpA8DPgFUOhAH2RKtcKZuD46Lrlx75Awzi1CAc1lM4Ti8w3aPIu
	 H2EkS2DVbM0w1/MJ9V23wEfG613i3JvKSOvBoUohGxiP2yiHtWmnBDhrCzRJXIyImb
	 RdtCPOd95gah2YC6XwHQVAwaAlV5c7IROguVn+5abhP/Jji1VHjUn4/enLFkT2B6dy
	 7vYsQnZTDteNA==
Date: Wed, 19 Nov 2025 21:34:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Drivers: hv: ioctl for self targeted passthrough
 hvcalls
Message-ID: <20251119213437.GA2848327@liuwe-devbox-debian-v2.local>
References: <20251119171708.819072-1-anirudh@anirudhrb.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119171708.819072-1-anirudh@anirudhrb.com>

On Wed, Nov 19, 2025 at 05:17:08PM +0000, Anirudh Rayabharam wrote:
[...]
> +static inline bool mshv_passthru_hvcall_allowed(u16 code, u64 pt_id)

There is no need to add inline here. The compiler can decide itself.

I can drop this when committing.

Wei

