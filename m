Return-Path: <linux-hyperv+bounces-1955-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 843F28A1792
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 16:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F1B1F21F3D
	for <lists+linux-hyperv@lfdr.de>; Thu, 11 Apr 2024 14:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043E1400B;
	Thu, 11 Apr 2024 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOnEcr4i"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B4413FE7;
	Thu, 11 Apr 2024 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846410; cv=none; b=fsGBAuRXYL9rg2KNCSm5skYlGtBN1nKF9GzITAvKtXjE8dkZvwse/DklpCVqmpS4o1b04/sgC4xDaJOOZOaNm4Lk/GxdhFFHQTdg2aMZOGZm/PnVioYUaqe1AcwY4UV2GU8wOOHb6PD4DKdliQCZqyRcAXnxiQpByvINaTa+gM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846410; c=relaxed/simple;
	bh=v7xu8aHGMOmzRWDzQT1VMpjnmvWW56s5ws8lgB6X6WE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5wtLVMHsVymroJW0mpQ0FkCInBoN36WBuwctgQqgKppSATyDl6f6ei5bSGJLK7yU986jEJNRoO3yo4XHJqIxq8nvg9XZS96KDyhqQR7r4Nyk/5eB6HxOTY0RXcYZdQIJIFr6xxFXh4Si53Hti+3SkGj7SJM6AtBCKnkN8jA/dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOnEcr4i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BE6C113CD;
	Thu, 11 Apr 2024 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712846409;
	bh=v7xu8aHGMOmzRWDzQT1VMpjnmvWW56s5ws8lgB6X6WE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BOnEcr4iT+QDMBY0YeWzqFDyryz6nD2Z1ucfJpB2TjsEROXQPYOXb388WYt+UCB0m
	 798x9sdpFXwX9/ve1lF/arewiTUFI9uv1o3gw0CBxYRKcQxqIEH1KtytlSRAfF4kFJ
	 OA7uyt9Y3vmqSfKz1TZ7PltzJdRiy+T0pAGKcTVa/Hj10bhQA5lzOSecH881a1oUkh
	 tf7e2Nd3GjBMsAD++i8poGtmjA4eFfNXMUFZzoDaWZiR2eIHqti9iVxdHKnmITQu6O
	 wHA+ext4FodQQelluMAns0wYpaX5wldxV7jcCBxPES6QZi43IIdXaERylFo6FVBayq
	 vcyDKPpVld0ZQ==
Date: Thu, 11 Apr 2024 07:40:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>, Erick Archer
 <erick.archer@outlook.com>, Long Li <longli@microsoft.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Kees Cook
 <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID: <20240411074007.3f4d2b2f@kernel.org>
In-Reply-To: <20240411105839.GN4195@unreal>
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
	<20240408110730.GE8764@unreal>
	<20240408183657.7fb6cc35@kernel.org>
	<ca8a0df8-b178-31ff-026f-b2d298f3aa84@gmail.com>
	<20240409144419.6dc12ebb@kernel.org>
	<20240411105839.GN4195@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Apr 2024 13:58:39 +0300 Leon Romanovsky wrote:
> I prepared mana-ib-flex branch https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/log/?h=mana-ib-flex
> and merge ti to our wip branch https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/leon-for-next&id=e537deecda03e0911e9406095ccd48bd42f328c7

Thanks!

