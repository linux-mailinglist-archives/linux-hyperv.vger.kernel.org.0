Return-Path: <linux-hyperv+bounces-7466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4656C413C6
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEBF53A3042
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 18:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C30335076;
	Fri,  7 Nov 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfVyGJEi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB512B94;
	Fri,  7 Nov 2025 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762539118; cv=none; b=gd2qmfC4puINVDB+WHm2ZB1irKtJQV8YZR7yv/eCmYvGPL8tim+uEpgL19QpA2WXw7WZL6UdZLXhBO83mbNtlhq2A0aPyzGScn0GCZLX66oo+GvpE3d23XBUsPioMj481d/vZNwSXAjXY0pHSOlzK0Kfranqvp8kcRQIkxzXWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762539118; c=relaxed/simple;
	bh=MjhieHuDTwnq2/h0Al1iDcokqMxDvbpcUEx6bOyTdPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXFn78JUlwBpE9L5Z8eeNs+yiQeEYlNlLgIhCKxDPh0Mr2f7d/kHfpio6E5czsIX+NW/4AgQdGoh9P8/0l644GEvtHOCjqdZbZf3ySe8seGeO/iwUuZIizFzEO2DJ+5WbCwgkMo1HAAnCktnEc7QJ2S6i5P6C5EfpRPGGvz/Ats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfVyGJEi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12521C19423;
	Fri,  7 Nov 2025 18:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762539118;
	bh=MjhieHuDTwnq2/h0Al1iDcokqMxDvbpcUEx6bOyTdPE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfVyGJEil8dJtFsbbZ96UUWxXpNjYfiBAluSWpTiAMqTWKoiZdIk11806YuLPL0tQ
	 95e9QrRloWJXexP42nO+CrVYcd4QXQQr2CfmjDaN3NGlXt/rycTZkfKLb0+aYB5nBx
	 os3Bwyo14S1pQ6YOYK7y3yH8okSBP7cqN6jwRDCMNexHyHLNQWm9F1XvS2jeIpN0sI
	 ZM3qPdeczxkgkLcC7/Ic2Av1Qh4DwFU4gJ6ynEchSh150AWOstYdLFjCIB/YPCrVct
	 Q6ZolcPHxOYUu/QIMpnR3OR8zvuayu/Nf3VHfzDd9pqp9I9tNuqUvSqylTWgGWcu60
	 OlLG+FB45swzw==
Date: Fri, 7 Nov 2025 18:11:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] mshv_eventfd: add WQ_PERCPU to alloc_workqueue users
Message-ID: <20251107181156.GA4041739@liuwe-devbox-debian-v2.local>
References: <20251107132712.182499-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251107132712.182499-1-marco.crivellari@suse.com>

On Fri, Nov 07, 2025 at 02:27:12PM +0100, Marco Crivellari wrote:
> Currently if a user enqueues a work item using schedule_delayed_work() the
> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
> schedule_work() that is using system_wq and queue_work(), that makes use
> again of WORK_CPU_UNBOUND.
> This lack of consistency cannot be addressed without refactoring the API.
> 
> alloc_workqueue() treats all queues as per-CPU by default, while unbound
> workqueues must opt-in via WQ_UNBOUND.
> 
> This default is suboptimal: most workloads benefit from unbound queues,
> allowing the scheduler to place worker threads where they’re needed and
> reducing noise when CPUs are isolated.
> 
> This continues the effort to refactor workqueue APIs, which began with
> the introduction of new workqueues and a new alloc_workqueue flag in:
> 
> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> This change adds a new WQ_PERCPU flag to explicitly request
> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.
> 
> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
> any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
> must now use WQ_PERCPU.
> 
> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> become the implicit default.
> 
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Applied to hyperv-next. Thanks.

I modified the subject prefix to "mshv" and added a new line in the
commit message body to separate the first two paragraphs while at it.

Wei

> ---
>  drivers/hv/mshv_eventfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 806674722868..2a80af1d610a 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -592,7 +592,7 @@ static void mshv_irqfd_release(struct mshv_partition *pt)
>  
>  int mshv_irqfd_wq_init(void)
>  {
> -	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", 0, 0);
> +	irqfd_cleanup_wq = alloc_workqueue("mshv-irqfd-cleanup", WQ_PERCPU, 0);
>  	if (!irqfd_cleanup_wq)
>  		return -ENOMEM;
>  
> -- 
> 2.51.1
> 

