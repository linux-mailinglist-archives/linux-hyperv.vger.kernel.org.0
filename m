Return-Path: <linux-hyperv+bounces-6166-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A32B3AFF4E9
	for <lists+linux-hyperv@lfdr.de>; Thu, 10 Jul 2025 00:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03E61179E53
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Jul 2025 22:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00DC199934;
	Wed,  9 Jul 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq9eMn9Z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598B72610;
	Wed,  9 Jul 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101155; cv=none; b=RxnWFMVBWQ5QaSjKgHALWNrz43mLS7UzwL4oTe38IIC0GAZ+qbHAgYl5pZ8iRpJpBcYOnNSGQ9r/g8D4MwrpYkunfI684/cb8Otx5/9SHopmjjVyYghp7x9HeinwyXG/qn88X088+NABgR+1Z3WN/nwiKEvm4vil3ej0aysteIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101155; c=relaxed/simple;
	bh=GrAeSpsc9kqclAfShSt30hKBE8+ntB6SvXTTc6+lDYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLNrJtCzO7Ko487dpKX5XDDE/Ua/++/cfoStj/7Qv2zOnHzcU1eawcncygUCo33SUfDrQUfKO1+abirtSqSdkzOC5zEhjtSLMQhhyOJeO2mJCNd6nbncVkCfwyJwfYaaWpJlpGxtwAJt28uxoEJYv2D5BrSBP3KYUj6oWa+9VpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq9eMn9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3059C4CEEF;
	Wed,  9 Jul 2025 22:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752101155;
	bh=GrAeSpsc9kqclAfShSt30hKBE8+ntB6SvXTTc6+lDYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gq9eMn9Z3kXG3KGcUPp3wCj5rpPRBjcFcngOKHc1l4IaD1S0vPrkvS+1ClsMhKR6V
	 aoRg5vw0ULQxm9VPibb7qh/AgRSNePryFxmtJnHMXHfkpc1/hVts1MBTSonFGYjOOK
	 7xb+TtzrUI2qyIt0Cj/qY+9RjAj52ygYjtCZWyq5M+BsUhjXvJ4sB+7g2XAoalyiXP
	 D2Ng+DyOlAHduPaNpSN/etczu6L/sbj5SSJCuBvqi494DrLdi5+YAm2hDVDXgE5x3l
	 T2+3oMfVSpcBoI+xHay/jDrsSWwVXfKTlK8d/8GTWG5GgfbvtIGcujehzK5G3LGeZD
	 3hzh2pXnMEHUQ==
Date: Wed, 9 Jul 2025 22:45:53 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Prevent similar logs in
 kvp_key_add_or_modify()
Message-ID: <aG7xIUYTMvq9McCv@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1750310761-13302-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1750310761-13302-1-git-send-email-shradhagupta@linux.microsoft.com>

On Wed, Jun 18, 2025 at 10:26:01PM -0700, Shradha Gupta wrote:
> When hv_kvp_daemon is started in debug mode, in function
> kvp_key_add_or_modify() too many similar logs are logged for
> key/value being too long.
> 
> Restructured the logs to prevent this extra logging
> 
> Suggested-by: Olaf Hering <olaf@aepfle.de>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Applied to hyperv-next.

