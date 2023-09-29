Return-Path: <linux-hyperv+bounces-321-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABEB7B2C02
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 07:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 02F25282115
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Sep 2023 05:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790518825;
	Fri, 29 Sep 2023 05:48:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDBA17E1;
	Fri, 29 Sep 2023 05:48:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A6BC433C7;
	Fri, 29 Sep 2023 05:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695966504;
	bh=95yNdcgmvuWqj13LeqKRmbFxH0PYoXNj1UcdpQc657w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uC0QUc4mTdlmCuyvnpcIEbWCTxUawh6C1ODrSbxb/fACwjk8XLcBSJOE7NKCsjOLE
	 rKnHRR6su640o9XroQbTu8xGHyfD0zJ8QAQ1sb/6anjfFGJKA4ZUAbDX2+lQDrEwYs
	 mp8x89IvpSrhytSd/4nGMkLGPibEM1tZjpy1ZhZMm3C+ZwJvlimFvU2RyXEC+cczVI
	 l5kJp26mN758vJoZ7i2szS91vj0Zt6gAPZLJq55XvHpOqj8MgH+OG+2XLqy6KhrRMt
	 nZNdqmi9BfZBBEb/gPBElmKpgfv/Lii7WZNs0aPb4kjB90kOfunAnKQlCBD5ftWg9I
	 1r17WqBgKpfmw==
Date: Fri, 29 Sep 2023 07:48:17 +0200
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	decui@microsoft.com, kys@microsoft.com, paulros@microsoft.com,
	olaf@aepfle.de, vkuznets@redhat.com, davem@davemloft.net,
	wei.liu@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, leon@kernel.org, longli@microsoft.com,
	ssengar@linux.microsoft.com, linux-rdma@vger.kernel.org,
	daniel@iogearbox.net, john.fastabend@gmail.com, bpf@vger.kernel.org,
	ast@kernel.org, sharmaajay@microsoft.com, hawk@kernel.org,
	tglx@linutronix.de, shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net, 2/3] net: mana: Fix the tso_bytes calculation
Message-ID: <20230929054817.GR24230@kernel.org>
References: <1695519107-24139-1-git-send-email-haiyangz@microsoft.com>
 <1695519107-24139-3-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695519107-24139-3-git-send-email-haiyangz@microsoft.com>

On Sat, Sep 23, 2023 at 06:31:46PM -0700, Haiyang Zhang wrote:
> sizeof(struct hop_jumbo_hdr) is not part of tso_bytes, so remove
> the subtraction from header size.
> 
> Cc: stable@vger.kernel.org
> Fixes: bd7fc6e1957c ("net: mana: Add new MANA VF performance counters for easier troubleshooting")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


