Return-Path: <linux-hyperv+bounces-1017-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81DE77F3A77
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Nov 2023 00:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D361C20C83
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 23:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD045B1F1;
	Tue, 21 Nov 2023 23:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6zg6XxO"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708F584FA;
	Tue, 21 Nov 2023 23:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF57EC433C8;
	Tue, 21 Nov 2023 23:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700610523;
	bh=IuQ9syHF5a/ttnK8/3v7I9YDeXgz5xrYtfAaCkHYAm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h6zg6XxOGmLyRKK8wojFBLWbsbJAqER2kmK+0GVLbdxv1vzmN6PuLNce1Q6D/wLBt
	 3Ka6Vc/UAndkBePbQu3ooUPzWkbUtZ5a0GzQykR2kcVgqiyp/tqZga0uRrrs7m6ABP
	 Lspva4iI49ltuy8GSp1DwL6R7b1aGdawhCn+QRdmDegFDUSuIu0J8qWBEB2SgBP0w2
	 fNsuM3YuLpeSFsBP9iWXH8IkjoKHCA3i8erCKXcjh8DQbP+Btf5raw6jrgp4f0lgM9
	 1jiBWGGdTx7BjjJnQfP70oCshUiTu+SdoxJDlKyHI+tjD9JFlrWDY0EcNL+8HOlC+i
	 GdV1LB1Me0lzA==
Date: Tue, 21 Nov 2023 15:48:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, sharmaajay@microsoft.com,
 leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
 paulros@microsoft.com
Subject: Re: [PATCH V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Message-ID: <20231121154841.7fc019c8@kernel.org>
In-Reply-To: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
References: <1700574877-6037-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 05:54:37 -0800 Souradeep Chakrabarti wrote:
> Existing MANA design assigns IRQ to every CPUs, including sibling hyper-threads
> in a core. This causes multiple IRQs to work on same CPU and may reduce the network
> performance with RSS.
> 
> Improve the performance by adhering the configuration for RSS, which assigns IRQ
> on HT cores.

Drivers should not have to carry 120 LoC for something as basic as
spreading IRQs. Please take a look at include/linux/topology.h and
if there's nothing that fits your needs there - add it. That way
other drivers can reuse it.

