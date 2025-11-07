Return-Path: <linux-hyperv+bounces-7469-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D25B4C415AF
	for <lists+linux-hyperv@lfdr.de>; Fri, 07 Nov 2025 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98B8C4E3F9B
	for <lists+linux-hyperv@lfdr.de>; Fri,  7 Nov 2025 18:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CB833B6E6;
	Fri,  7 Nov 2025 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gWXqy87Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F20F2F83A5;
	Fri,  7 Nov 2025 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541697; cv=none; b=Y627MIPZ+AQqRYct1DMTPFa3uucW9GnPVlhH/b4PB1g1AxaTooN3nJS1gEuXbOb2b2sR30RuSC/9v4ZiZ4hcbyOOxh2kaLQJ9w7VpholhyoGCjJSquwSyrMTbwBCVJ3ONR1h+vlXV9HArh6j9U0forVuXU0hT8etiizqv27Cdrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541697; c=relaxed/simple;
	bh=Gt7M6TvmbPVEnVHc+m2Qlrw4lJaSgvuDjqGiqmRkhQQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Enwl/Z8kOgg8UksXG2GesyI31kiDywZ9O+0xngqj0euypq6qING+2N3oPMATjxd3avJaJhdVc93GerIJ/xprbLLtCte4cjEzbFBI+HL5fGw47h6FEXC4gHw1IdrXhGJIhz34ZHnpr1EhnNmSKkTTFd7/63nLP6rsBDd8KM+PlTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gWXqy87Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.201.246] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4AB5B201209F;
	Fri,  7 Nov 2025 10:54:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4AB5B201209F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762541690;
	bh=AsvG4/AVmdCT1R9teXGFMlUfCqRmKhnjLGXUPdWX5JE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=gWXqy87QJctZ8cONqwSbD3oxF1lilgIW6UEqbaGcKCq3uSYhTlVw7GgBkv7j5ZxyB
	 wge1609GEoSXAa6ugdJ/93Wt0T3mbzlFIVTN1NsgpcAczaJnCIVJO/YW3nZGYNZKl7
	 encS+zWyeHA6w9MEXSdEg9ZuzPd4zcWufbD4ccpA=
Message-ID: <b6a7f974-75ee-42fb-944c-e61d1e0238a1@linux.microsoft.com>
Date: Fri, 7 Nov 2025 10:54:41 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, Tejun Heo <tj@kernel.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] mshv_eventfd: add WQ_PERCPU to alloc_workqueue users
To: Marco Crivellari <marco.crivellari@suse.com>
References: <20251107132712.182499-1-marco.crivellari@suse.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20251107132712.182499-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/2025 5:27 AM, Marco Crivellari wrote:
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
> ---
>  drivers/hv/mshv_eventfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thank you for the well-written commit message.

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Thanks,
Easwar (he/him)

