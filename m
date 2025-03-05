Return-Path: <linux-hyperv+bounces-4220-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F33A4F3AA
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 02:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537D516F4F0
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 01:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4701142903;
	Wed,  5 Mar 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obn8b3M3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B688613F434;
	Wed,  5 Mar 2025 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138103; cv=none; b=t97XO8fjBDw9kz12XuSTYo8WdQ45IIjYaoyOz0iYKdvatiHKDYbyIFHjZ7R6KPZnBykDcO15D0+bY21JFpTjt0RgnglYgWzf5nJzGmNCtLGulcMZJ0/ato/HwEynPpaRLBYz2vHFygIMDRpv68HlFiz3kS3cnDemm7M9s69je/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138103; c=relaxed/simple;
	bh=bNcSDPHrhTEPOmyizjPeRBoa8Pte+ssFEKlN8jUZHBU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p27tTHluCecpsgYwiV7CFzrS3mwkA6mLU91y6Q+nF5G5d7a6349Yxf8LvAYEgTstDqeKdb5VYClUl8MqxYbeMqZFqHhbjHwfa2SNx7Iz/Rj9/vKDpienWSnLRwWUCLhW6Phs7Ia9PHRxo2Jf0Ie8gFDRdHboi2QlkIHg3vOgA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obn8b3M3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7393C4CEE5;
	Wed,  5 Mar 2025 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741138103;
	bh=bNcSDPHrhTEPOmyizjPeRBoa8Pte+ssFEKlN8jUZHBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=obn8b3M3tX5P2Y4u9lSRjR38yNWPxU36tortAKsc+CodDM3Dw8oZ91YsJbk92HxQd
	 OhyY/MOv8TXm2b2/kvfJmbJmvxaH0UvSqWUGboDxHE80qi7CLa/0ed35cnA0AGBKB4
	 3D6L+Khhc9T7xiCtqUkiRf+JJaBUdhijLwq4SemROLGMmrajNWXc3FNqpiH+LG3Vml
	 QDCSoGwlTyYQzYOGFmA13djOC+XEjKwodyxXn4GpmL9iqhWipRUGsSUhEB+0KBari5
	 QHQcja3kv1B+NWW8BRX0HxAiiv5lWikQ4Ksey/uUnC+2dek37R1gU/d1wp8vQIeALc
	 mAHOS+YlsZZrQ==
Date: Tue, 4 Mar 2025 17:28:21 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Long Li
 <longli@microsoft.com>
Subject: Re: [patch rdma-next v3 1/2] net: mana: Change the function
 signature of mana_get_primary_netdev_rcu
Message-ID: <20250304172821.5cbfad8a@kernel.org>
In-Reply-To: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
References: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 16:00:01 -0800 longli@linuxonhyperv.com wrote:
> +	dev_hold(ndev);

netdev_hold(), please

