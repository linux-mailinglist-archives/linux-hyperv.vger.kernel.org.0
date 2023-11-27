Return-Path: <linux-hyperv+bounces-1063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532AE7FA896
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 19:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E811CB20F20
	for <lists+linux-hyperv@lfdr.de>; Mon, 27 Nov 2023 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD13BB46;
	Mon, 27 Nov 2023 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTllf2c1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A4931A69;
	Mon, 27 Nov 2023 18:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951BCC433C9;
	Mon, 27 Nov 2023 18:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701108401;
	bh=SXk9TLrwLgA89r0jB1vEwVRH5/KUIw8Zo/Yl4z5i8aA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTllf2c1P+/VCxnAZyt0dJ2ZWye5KhMZHmjnEfgbaJzDY6/gy3B0Wht68/UXA9Wpd
	 Whn4CgI1lV1q1c2XJTsQW3hRIkfkhwFZB7a5s0PFPNEtNdfbopZenbA3oGS6cfZU9S
	 /F4Mro6jJe5ltMEUuRo7VkIhis3M4oGsJ71lWsOkejDi2HX65plhJDKSm6IFiNCYEE
	 xMscVCvaYXsxCCfF9s5Bqu5HvEwCKa2YkMVmoQEEHfymuoVeXf6iSXNhtx/hubpbZz
	 dOszSU4xj4q2V6CQpWjy+aUN1RHyKdg1YCaCa3UB7qxY9WoacNhzH+9muL9bk7C62q
	 uttN3Qv44zL/Q==
Date: Mon, 27 Nov 2023 10:06:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@microsoft.com>
Cc: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Long Li <longli@microsoft.com>,
 "sharmaajay@microsoft.com" <sharmaajay@microsoft.com>, "leon@kernel.org"
 <leon@kernel.org>, "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, Paul Rosswurm <paulros@microsoft.com>
Subject: Re: [EXTERNAL] Re: [PATCH V2 net-next] net: mana: Assigning IRQ
 affinity on HT cores
Message-ID: <20231127100639.5f2f3d3e@kernel.org>
In-Reply-To: <PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
	<20231121154841.7fc019c8@kernel.org>
	<PUZP153MB0788476CD22D5AA2ECDC11ABCCBDA@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Nov 2023 09:36:38 +0000 Souradeep Chakrabarti wrote:
> easier to keep things inside the mana driver code here

Easier for who? Upstream we care about consistency and maintainability
across all drivers.

