Return-Path: <linux-hyperv+bounces-3052-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8910997D2E0
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 10:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC4BB1C22B7A
	for <lists+linux-hyperv@lfdr.de>; Fri, 20 Sep 2024 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E17F55897;
	Fri, 20 Sep 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KFAIcEyz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBD2209D;
	Fri, 20 Sep 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726821581; cv=none; b=LaROp3EcN4fq+yUlvthI/UU9QkD2GYpNFxW02aQ+9J6ABYfX6EeieupAF5xjf4vhQLnnSUHYz16Ty+Lq+FwV6cNQg2XGQLc7uQ7XyglGsFkphwBYnnA/+3XcKF8pPWKZNxaLnRvOR2pT5dZYYVBH6HAX2stvESdupIQNlnDr3AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726821581; c=relaxed/simple;
	bh=qSFC0CPXsAs0/QR/Ub6gPzLAUS0VertXsdiCQtyDBXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VtvyS9Ub8+QcntiZyTLoTvhUQMeiNwgZtZatzRAl5sjEbaIOGT9daUPsDCOQvVnnmkJMmDYm8z2NAzLOiXiCwUDtw8ItZMFuMpVcGjll4AgG6ftqImNoxgP6TytQ8KoNUsiNn+I7B6dHelIi3TgdW4Oh8+PoSGvbra29gGU5Zkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KFAIcEyz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 6CD9020C0B12; Fri, 20 Sep 2024 01:39:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CD9020C0B12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1726821573;
	bh=y9iGzqI1llZBex/f3DgwQ0iyDZreXOsN5uFJeLWLC0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KFAIcEyzo3N44wnyUjHX+yIfCxoZ1f7IibIH4VM1q7HchqKc+rvjqtldgg1EMPqoq
	 XyQSIijTzQDrLGMFPrvgN5Qn6S5A3m0bgeZXbtEszQXcQGS4FY1Xu75D3S4Z6G+sOj
	 vIyMyOKk+656L1YCg7aggu7p7T9BS/aLgtM6okP4=
Date: Fri, 20 Sep 2024 01:39:33 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <20240920083933.GA15696@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1726376184-14874-1-git-send-email-shradhagupta@linux.microsoft.com>
 <20240915180835.GA167971@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915180835.GA167971@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Sep 15, 2024 at 07:08:35PM +0100, Simon Horman wrote:
> On Sat, Sep 14, 2024 at 09:56:24PM -0700, Shradha Gupta wrote:
> > Through some experiments, we found out that increasing the default
> > RX buffers count from 512 to 1024, gives slightly better throughput
> > and significantly reduces the no_wqe_rx errs on the receiver side.
> > Along with these, other parameters like cpu usage, retrans seg etc
> > also show some improvement with 1024 value.
> > 
> > Following are some snippets from the experiments
> > 
> > ntttcp tests with 512 Rx buffers
> > ---------------------------------------
> > connections|  throughput|  no_wqe errs|
> > ---------------------------------------
> > 1          |  40.93Gbps | 123,211     |
> > 16         | 180.15Gbps | 190,120
> > 128        | 180.20Gbps | 173,508     |
> > 256        | 180.27Gbps | 189,884     |
> > 
> > ntttcp tests with 1024 Rx buffers
> > ---------------------------------------
> > connections|  throughput|  no_wqe errs|
> > ---------------------------------------
> > 1          |  44.22Gbps | 19,864      |
> > 16         | 180.19Gbps | 4,430       |
> > 128        | 180.21Gbps | 2,560       |
> > 256        | 180.29Gbps | 1,529       |
> > 
> > So, increasing the default RX buffers per queue count to 1024
> > 
> > Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Hi Shradha,
> 
> net-next is currently closed other than for bug fixes.
> Please consider reposting once it re-opens, after v6.12-rc1
> has been released.
Noted, thanks Simon
> 
> -- 
> pw-bot: defer

