Return-Path: <linux-hyperv+bounces-1948-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D3189E51D
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 23:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7A928459C
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 21:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AA5158A31;
	Tue,  9 Apr 2024 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBeC0vs6"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C412F381;
	Tue,  9 Apr 2024 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712699062; cv=none; b=pR3SkwVmediL7WE7q3Ps9KTQoqUd0Vr2M8+lKwUUNVfMGWQTlL0KHcEip6MaS9ciF8XCtO7BNEl/kGX8i/qx5WsXmZSv0S8ZLuqVP2JmAG2u3EBdrE+j76X2ju3+MevjM2wiL0wn/fInYQtvrSuMXCqdV7Jf8RIUdRhl77iTzEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712699062; c=relaxed/simple;
	bh=gmPhoEZQy7H8+eEDT13YM1nQeRhuIBur3SEMSC6wVTg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slKe03b1UeHzx4cD3a2XZMdVAQINfWIKxLEnq2lnnR2IHQTqq/qSc/Pgrwa/wkX4qfKqVGmQi3pYsbiUVJjki/2QlaPZVT7EOM5zY+9hZHGTg+rc3Us0djRpUe+snQSU2YxG1/MGGhueq0NUUl5LeyMWige/BP3BV2YhYS0yRG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBeC0vs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51721C433F1;
	Tue,  9 Apr 2024 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712699061;
	bh=gmPhoEZQy7H8+eEDT13YM1nQeRhuIBur3SEMSC6wVTg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kBeC0vs6D2fvf+lsS/n8G0lta7BNfZAuk1/4mf/TRvmI4GVp05cmjiZ96zfT2IRvz
	 XMzlzbe1pUq4KXjae9qBQivng6f+ciojwBrNToODd/XXXE2LiQLs12GREzh5sZPhfY
	 7rvi8THMxQKfLg+xdwQDMh9YyfjT0wLMmpmfeyRwvnsd4942DAMDc5drnu3st4ATr4
	 6Qp+B7XtXqjl/a9Elw14myYvdSHMvbMft5p3W3K33PqcXWHTA4MIGLoSDQKtGHPCU1
	 2qohVAGUHihmNDPFH0Dy+XSeGTWdSWT8KA4X3jJLzQL8Or8pRD8UqZIexkxTgCqKPG
	 b9AkuzVskncag==
Date: Tue, 9 Apr 2024 14:44:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Leon Romanovsky <leon@kernel.org>, Erick Archer
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
Message-ID: <20240409144419.6dc12ebb@kernel.org>
In-Reply-To: <ca8a0df8-b178-31ff-026f-b2d298f3aa84@gmail.com>
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
	<20240408110730.GE8764@unreal>
	<20240408183657.7fb6cc35@kernel.org>
	<ca8a0df8-b178-31ff-026f-b2d298f3aa84@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Apr 2024 18:01:40 +0100 Edward Cree wrote:
> > Shared branch would be good. Ed has some outstanding patches 
> > to refactor the ethtool RSS API.  
> 
> For the record I am extremely unlikely to have time to get those
>  done this cycle :(
> Though in any case fwiw it doesn't look like this series touches
>  anything that would conflict; mana doesn't appear to support
>  custom RSS contexts and besides the changes are well away from
>  the ethtool API handling.

Better safe than sorry, since the change applies cleanly on an -rc tag
having it applied to both trees should be very little extra work.

