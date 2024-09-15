Return-Path: <linux-hyperv+bounces-3023-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3101097980E
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Sep 2024 20:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FCB1F214D3
	for <lists+linux-hyperv@lfdr.de>; Sun, 15 Sep 2024 18:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586620B22;
	Sun, 15 Sep 2024 18:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HzwUWc3r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446F1DA21;
	Sun, 15 Sep 2024 18:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726423752; cv=none; b=XM5R3uXhRQIPeUazBxWM5zPCkLX8xmdsQVFRMHYKa8Ke9gu5a2MGhED3MSV6VTL3xTGi3F411W2rNMzzlIXkegP9SVM5Mq4Wrle/kIe3UqoMOabZJ3YsjjCLDp8bnE3WKtgQL4BzuRnlbr+qv+pOrJTbNnf7LZZDQEt4AN+byUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726423752; c=relaxed/simple;
	bh=AhRhu73/ZHh9YOfiIGSm+rRFXWuJkHfivxwYeFFjvnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwh67BiKNYmtbNaiAl/pN5FnEsYluX2Dqj07bdTJEKohMLk/2eIGJu0L2BiFmyZ2ICDS3h+XKriDz3hmaONVwUl02Oym2JAb01S9JceSqI1E/1zNyPdBqqXVQBvpwqo2oMkJoi9hVnTwMIrM/2TSqJwalweohWoWcfjrPQBBTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HzwUWc3r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BF9C4CEC3;
	Sun, 15 Sep 2024 18:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726423751;
	bh=AhRhu73/ZHh9YOfiIGSm+rRFXWuJkHfivxwYeFFjvnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HzwUWc3riPr5RkxkVrUG1A2X9KBN5i8Y8IyCrayouA7GZbndZcBbU4WSKWK/74WPB
	 SGGOlovYiePnjqUB15MHyXH2KE0eU0W8YmRRnKbinmw7qsSXfe6fzSBH6GFgv1hHSZ
	 DV9QZS8xANQhC/43R/iSXBZbXArPrZDB43ttKpBMDAYsFZGrzyEAym3F4xBsO8Pbut
	 Qmcc+Hg4pA+/WMDlfLgAhLSNZvNHz3VJyEH9p3+QKv7feVg6mP+MP8lxo6/8lHfOdC
	 dCKgitvmSQl2qHO2VmVHycRjiF1qtbW/w6U11J6KUGW5R851BB6ZsvWsGDd5NDOxFk
	 AlQIlQqxncabw==
Date: Sun, 15 Sep 2024 19:08:35 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Increase the
 DEF_RX_BUFFERS_PER_QUEUE to 1024
Message-ID: <20240915180835.GA167971@kernel.org>
References: <1726376184-14874-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726376184-14874-1-git-send-email-shradhagupta@linux.microsoft.com>

On Sat, Sep 14, 2024 at 09:56:24PM -0700, Shradha Gupta wrote:
> Through some experiments, we found out that increasing the default
> RX buffers count from 512 to 1024, gives slightly better throughput
> and significantly reduces the no_wqe_rx errs on the receiver side.
> Along with these, other parameters like cpu usage, retrans seg etc
> also show some improvement with 1024 value.
> 
> Following are some snippets from the experiments
> 
> ntttcp tests with 512 Rx buffers
> ---------------------------------------
> connections|  throughput|  no_wqe errs|
> ---------------------------------------
> 1          |  40.93Gbps | 123,211     |
> 16         | 180.15Gbps | 190,120
> 128        | 180.20Gbps | 173,508     |
> 256        | 180.27Gbps | 189,884     |
> 
> ntttcp tests with 1024 Rx buffers
> ---------------------------------------
> connections|  throughput|  no_wqe errs|
> ---------------------------------------
> 1          |  44.22Gbps | 19,864      |
> 16         | 180.19Gbps | 4,430       |
> 128        | 180.21Gbps | 2,560       |
> 256        | 180.29Gbps | 1,529       |
> 
> So, increasing the default RX buffers per queue count to 1024
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Hi Shradha,

net-next is currently closed other than for bug fixes.
Please consider reposting once it re-opens, after v6.12-rc1
has been released.

-- 
pw-bot: defer

