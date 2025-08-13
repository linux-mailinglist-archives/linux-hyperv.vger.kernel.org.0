Return-Path: <linux-hyperv+bounces-6519-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E007B23CDF
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Aug 2025 02:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA4EF7B4607
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Aug 2025 23:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCBE2C0F7A;
	Wed, 13 Aug 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUDh9sR5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870F62C0F8F;
	Wed, 13 Aug 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043249; cv=none; b=GBXGomT49Scl/zjCskTzc8BIGybS6AbYF3ihlbxfa8squ6UjJnVdxWwkvPsDfrLW2+d9w5cq755nLh3aKA7k4SWPJilxbrqTkUeCYBVgW+SBFbCaNNxHKnh2FLRe9psfzLbYKmXaIZOBmsceEecxgHuUeLtz1v9WWWNMA/U8o/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043249; c=relaxed/simple;
	bh=QrOiOF47ri4aPRUpZUrkbIHzpQeRsM917B4y71IYzXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuazfJ4JxSbDg3maaHPsTUuIeiOjydjb9kL6iwG9DZqZdho0JRIE2PjNcYwLPGbDCHpUsnPZtJfWQ3XwU3rARxJlInmGZ31mOb5A5U2EitUMMtWe4IhlvkowVNIvhd8l6oxpPJPtRgJIvZ9ixMd5QXHI3qJ8NieZuot5qEYch3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUDh9sR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E55C4CEF0;
	Wed, 13 Aug 2025 00:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755043249;
	bh=QrOiOF47ri4aPRUpZUrkbIHzpQeRsM917B4y71IYzXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUDh9sR5VGg/zIwOmCXtZBsu9zcfsEY9G0I64WdW8b945JoAfJdf32v5aZUUV1wBj
	 6uE9+2ZukZXMFttKS8So1eR9X9vPtr0WsyTnwx7vqgw38RM1ilWqSodHtEanXhPV6G
	 g/B897LmYaWWy4Me9+SN+aj7N/mA0r6MK/cPNZ8Sp+q+A/+ONAzf0zpFITVGow+HGI
	 PwF5oSH9kBWT37W/YMwQqpm6vZBB8uYiHwURJJScLPWsKjBCPC0+asO1/AuqxOuuDU
	 v5zD9c9gxOBaMwdiQu90SaTzJsB5BLRE2UPGmTeYXyD1kfSkqb/GUsiIkTGZkYuZuq
	 BqkaWtht/aa/g==
Date: Wed, 13 Aug 2025 00:00:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v7 0/2] Drivers: hv: Introduce new driver - mshv_vtl
Message-ID: <aJvVr0R1JZEnYBLj@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250729051436.190703-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729051436.190703-1-namjain@linux.microsoft.com>

On Tue, Jul 29, 2025 at 10:44:34AM +0530, Naman Jain wrote:
[...]
> 
> Naman Jain (2):
>   Drivers: hv: Export some symbols for mshv_vtl
>   Drivers: hv: Introduce mshv_vtl driver

Queued for hyperv-next, thanks!

