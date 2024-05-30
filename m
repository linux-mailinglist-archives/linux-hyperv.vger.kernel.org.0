Return-Path: <linux-hyperv+bounces-2262-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B0E8D4F43
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 17:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA71281B50
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8188183079;
	Thu, 30 May 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sot9rohC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44CB187543;
	Thu, 30 May 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083681; cv=none; b=ISdjkT5Ir54+h9h/Wum9R4Ba0D5a/Xj18CWj2pVoR09csK2Bkuz596zHAlHSqQwRPQg+DDAsHvS27SONfcTCkwq89fAH/B66nM/JIIotHeLUCkX/knNbg4F9Lsf7JiPhjAIxJw31QCUOhxC1Cf2dCxM5VitOa5Vb3ses/eAr/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083681; c=relaxed/simple;
	bh=NwfGqdfxzjzjhOXdJq835OhUNndnxLH4UuU7x1o2AL8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XU7LbncKQ3NfgLj+TjhTOWX+pFe9qgWymJPzvJiKdNVL/CV6gSrTmwYodWMLLB/HVQjX3eSnFFBxzNkbtgSzQX6VVwZidWbAE9+r9zTFjwAeOU7kUgbnW5Q4OPOiDQ1yuSwqGSMgBzdrsDIhYDVDKTgvpghaoss8qUbM3jD0/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sot9rohC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B849C2BBFC;
	Thu, 30 May 2024 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083681;
	bh=NwfGqdfxzjzjhOXdJq835OhUNndnxLH4UuU7x1o2AL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sot9rohCiNWd6ooi8uxRP4cd/ft0bRvarq7GQ1AYbxkLH09GCCCYRivqbbrPXkXSq
	 qO8Y3qbvZMwYIBhBh5IEaqJSX+9IcCUB6z+5M/gwlRdsFJIdmDTe52/7wtUUVQNH59
	 ga8kVq+X0113fWtY9xNa13vgchtDg+YS5kK9UqH8c/Bhrt2oAq1ezI5zM7HX4UMzRo
	 NGW8kVuYj0SrjNzDo1N/iZ55ncGxgbCV2wZhh3EU1BII1JkIehOtDWcnS3y6ADF3qg
	 7x7DaZkXDhrwlUMis+lXhiMTgQypDvtUgOiVl7BKcJf3wDcKaCYzRBsCYIT9aLLIdK
	 OI+R1wGhQpGFw==
Date: Thu, 30 May 2024 08:41:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Kees Cook <keescook@chromium.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Jason
 Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>, Long Li
 <longli@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v2] net: mana: Allow variable size indirection
 table
Message-ID: <20240530084119.684e2783@kernel.org>
In-Reply-To: <1716960955-3195-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1716960955-3195-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 22:35:55 -0700 Shradha Gupta wrote:
> +	save_table = kcalloc(apc->indir_table_sz, sizeof(u32), GFP_KERNEL);
> +	if (!save_table)
> +		return -ENOMEM;
> +
>  	if (rxfh->indir) {
> -		for (i = 0; i < MANA_INDIRECT_TABLE_SIZE; i++)
> +		for (i = 0; i < apc->indir_table_sz; i++)
>  			if (rxfh->indir[i] >= apc->num_queues)
>  				return -EINVAL;

leaks save_table

