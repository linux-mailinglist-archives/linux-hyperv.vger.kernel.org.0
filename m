Return-Path: <linux-hyperv+bounces-4242-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D97A50F3C
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 23:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D1141884AE9
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 22:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD17208978;
	Wed,  5 Mar 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maZyxnQm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CC206F0D;
	Wed,  5 Mar 2025 22:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215365; cv=none; b=mUUft4b/sdy+a1DMw7idgmAO+t3ZkWVdez1e4xcazvzyCHnGk4Ee27Dh/7NCpdXCR/qDfG4ulnN/jWDD16oJfX/YJjk3lg4kFjkm6RbE08K/ScL12IP3W2qMLWU87L3pvf0f/rmRH10RQdR7ITbohLd/eeOH9CQoJhB0QwmSTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215365; c=relaxed/simple;
	bh=yOnBm+2kaZIJl8AlUKOtc2CoToj5nxyG3PWHCosgmcI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sIfnYhLarOOasyFbKgOFhE7DTk9uJ5/9+s+cv56GD0UjMChtBc4VRX+oJGYTVtxpXPWsd4dh81iYhSPBL+oMF8FvwC0Fgi5HLAK6E1CFgvDWxkO16HmWQExQmPu6BOyEFBMuZCKTEtsFBtdtU3N7UgfX+XTm8GJr5CMnsqNntrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maZyxnQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5CD7C4CED1;
	Wed,  5 Mar 2025 22:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741215365;
	bh=yOnBm+2kaZIJl8AlUKOtc2CoToj5nxyG3PWHCosgmcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=maZyxnQmOtbQRSSUlz/TVIFGYOffQLWuohSqKLHUpj2slasW4u+8tGz9lut/bmtTa
	 iRO0Z1RIvZvGFiwcpY0okGVp6BdumyxlAUNmEhtZLVCFvZvaKqMVR0hCi34f/ZZvGd
	 0uMGzXmszqlk3ZBcFnTmLm4fvHWFXf0jm/68pLKw+cpojcgjRpcKcFxoVZ54U/MgVY
	 AWXVYbAXwyN/C8dwXDq03u7BhWPyluwI4gocMqjp5jzUrYRnxQXMDuvoGuORLnpKCX
	 hlyRct6TfFksoolUS2q2XbuYWHpCJ1BYTb71yFzKn+qEm9I0TqCSx+uWED6HvB31RM
	 TKABgeIoFHyHw==
Date: Wed, 5 Mar 2025 14:56:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Long Li
 <longli@microsoft.com>
Subject: Re: [patch rdma-next v4 1/2] net: mana: Change the function
 signature of mana_get_primary_netdev_rcu
Message-ID: <20250305145604.56855467@kernel.org>
In-Reply-To: <1741213360-14567-1-git-send-email-longli@linuxonhyperv.com>
References: <1741213360-14567-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  5 Mar 2025 14:22:39 -0800 longli@linuxonhyperv.com wrote:
> +	netdev_hold(ndev, NULL, GFP_ATOMIC);

=F0=9F=98=85=EF=B8=8F

I asked you to use this API for the tracker functionality, obviously.
Please don't pass NULL in.

