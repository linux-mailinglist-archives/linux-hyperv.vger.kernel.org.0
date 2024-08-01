Return-Path: <linux-hyperv+bounces-2638-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A75D943BDD
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98DB1F21EB3
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 00:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F091A01D5;
	Thu,  1 Aug 2024 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tL/67TfL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A7E1A01C6;
	Thu,  1 Aug 2024 00:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471320; cv=none; b=MhMs5DT5isHB3jys3ME39Dt2xq0nOBMU2xoHzcjKIWG73g34WmwkM/pNMaSSEifSFo8BNNRJUhYsBjVpIvzjyCMbJir2OeAfheK2450hFbpbEaRfyPdu/DMEGCnuZN0c1/JetbgB6yEKshCo6OREh2Xq0MTKL8RKwYjSuggcXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471320; c=relaxed/simple;
	bh=tN2t7khHaEb7/sJNl3MkmyoQOcGu2mCD4aKPuGRNyA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FdZ2i6aSUfNHrWmyFBKWsCTZ7YNjgISO5z84JBtfvCT5+KXCDSRDdvUnTC3Oef/MPa4CfuOD2NjrtxruxXWbjtGu99BubzuLDmHTWHMxLagsLxaX9xhUTVP4waTt9xmiXcBh1uWRXYH+uGIucuD1OK7CM8d1GRb11Ucxee/99Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tL/67TfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45513C4AF0E;
	Thu,  1 Aug 2024 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471320;
	bh=tN2t7khHaEb7/sJNl3MkmyoQOcGu2mCD4aKPuGRNyA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tL/67TfLWcV3FjB8nQlmDYxTBFdhS3Xiq5mFW/CJz5VookDDEOcOqgTWsurmGF5NK
	 UG/re3/EzpuxAlvfEOmGXrY2GJjKmucOsneMk1ojFAYl2lmmcofQm45l70gnljsgDT
	 +fK9t9yHaYYlTlO5IjHJWV25glCfXFa6YFS2V0JuqlPa2OZGfKXmKHMTdMpoMYpT9F
	 mF+fLN87kRc0C/nYOOzSVhSNaz7hm2aXjjsF/ptxZer+JwyZe08+lZzdOXtN4lfJg+
	 CPDFyCAFvbeMJk7sXzh/efLEqKm4hZYeWQg4uUud1GGvCx1/KQtBFJQEbcxh1ezQkY
	 gHgR/Vr3CG1cQ==
Date: Wed, 31 Jul 2024 17:15:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Long Li <longli@microsoft.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Simon Horman <horms@kernel.org>, Konstantin
 Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240731171518.3cbfc83b@kernel.org>
In-Reply-To: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 10:01:35 -0700 Shradha Gupta wrote:
> +	err1 = mana_detach(ndev, false);
> +	if (err1) {
> +		netdev_err(ndev, "mana_detach failed: %d\n", err1);
> +		return err1;
> +	}
> +
> +	apc->tx_queue_size = new_tx;
> +	apc->rx_queue_size = new_rx;
> +	err1 = mana_attach(ndev);
> +	if (!err1)
> +		return 0;
> +
> +	netdev_err(ndev, "mana_attach failed: %d\n", err1);
> +
> +	/* Try rolling back to the older values */
> +	apc->tx_queue_size = old_tx;
> +	apc->rx_queue_size = old_rx;
> +	err2 = mana_attach(ndev);

If system is under memory pressure there's no guarantee you'll get 
the memory back, even if you revert to the old counts.
We strongly recommend you refactor the code to hold onto the old memory
until you're sure new config works.
-- 
pw-bot: cr

