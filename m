Return-Path: <linux-hyperv+bounces-1498-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDF7845C13
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5FEA1F2589F
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Feb 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717F6626B2;
	Thu,  1 Feb 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5R878vL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5E762179;
	Thu,  1 Feb 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802593; cv=none; b=S3bviHYw9djl7w+eUzo/njOaiqlQpszHzSdE9H/gabzsqil21ZbOhdAg/cug3fU4oMxOjPFIM+PuqxCImNXQ4//Lkp5I4XQu3UHA7Zqxrs8KhmHQ7WlDCQLnNV+zo2o4SDRQQBooVCLSfZ5kErGkmqy+TKGmRmSY+AG0/9B0C68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802593; c=relaxed/simple;
	bh=yyG+tXwMfUAMz3ARIk0tUpjcZeb5q7dyZl3guKF9XEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgqkK9iJ1q0u9l4EEUFePCRy4x/k9HZOspVlZV1zmykWabBWvm3Jo579rP5LQRH7oUnASR9d5TFYuFHNnjVyintuTnFPhX2srRMsCvRPPutU1lwGzUOKaNMOvrlS86SrwVVkHqgRKrB4z5j9qUHzxtGYhq65WiUGza0xn+q0rZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5R878vL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4578CC433F1;
	Thu,  1 Feb 2024 15:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706802593;
	bh=yyG+tXwMfUAMz3ARIk0tUpjcZeb5q7dyZl3guKF9XEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D5R878vLpp+NEpb12DzhTaXiVuha7CUkYaNGVUv4HFeSDPDHQwIZJPMu6bS+/ov/u
	 W0I3xHDNHJ1I7+jUfB0OPmO80Km5O8eRExbsn/LLkytdUHQY0SxKimRQYvxrHiIksl
	 9l/KCxMV06+LvGm/VEVnI1vCOipD8duidStMHMTculmhtdoPDYgBUCN22PDZMQSvQ4
	 ZK38poOGk2Anq8mZ4w+g7d8xLK//MOvO7OAgpUKuHmnBkqwLuf617V1jTVNjpv3coj
	 dXd454290CsnfBqsmdVRHewoj3XSx4nFQvHCMLvsoqIfUdqZHHzwBAa+DuZbiTYGpJ
	 vtS2mBiIppf4w==
Date: Thu, 1 Feb 2024 16:49:45 +0100
From: Simon Horman <horms@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	yury.norov@gmail.com, leon@kernel.org, cai.huoqing@linux.dev,
	ssengar@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
	stable@vger.kernel.org
Subject: Re: [PATCH V2 net] hv_netvsc: Fix race condition between
 netvsc_probe and netvsc_remove
Message-ID: <20240201154945.GH530335@kernel.org>
References: <1706686551-28510-1-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706686551-28510-1-git-send-email-schakrabarti@linux.microsoft.com>

On Tue, Jan 30, 2024 at 11:35:51PM -0800, Souradeep Chakrabarti wrote:
> In commit ac5047671758 ("hv_netvsc: Disable NAPI before closing the
> VMBus channel"), napi_disable was getting called for all channels,
> including all subchannels without confirming if they are enabled or not.
> 
> This caused hv_netvsc getting hung at napi_disable, when netvsc_probe()
> has finished running but nvdev->subchan_work has not started yet.
> netvsc_subchan_work() -> rndis_set_subchannel() has not created the
> sub-channels and because of that netvsc_sc_open() is not running.
> netvsc_remove() calls cancel_work_sync(&nvdev->subchan_work), for which
> netvsc_subchan_work did not run.
> 
> netif_napi_add() sets the bit NAPI_STATE_SCHED because it ensures NAPI
> cannot be scheduled. Then netvsc_sc_open() -> napi_enable will clear the
> NAPIF_STATE_SCHED bit, so it can be scheduled. napi_disable() does the
> opposite.
> 
> Now during netvsc_device_remove(), when napi_disable is called for those
> subchannels, napi_disable gets stuck on infinite msleep.
> 
> This fix addresses this problem by ensuring that napi_disable() is not
> getting called for non-enabled NAPI struct.
> But netif_napi_del() is still necessary for these non-enabled NAPI struct
> for cleanup purpose.
> 
> Call trace:
> [  654.559417] task:modprobe        state:D stack:    0 pid: 2321 ppid:  1091 flags:0x00004002
> [  654.568030] Call Trace:
> [  654.571221]  <TASK>
> [  654.573790]  __schedule+0x2d6/0x960
> [  654.577733]  schedule+0x69/0xf0
> [  654.581214]  schedule_timeout+0x87/0x140
> [  654.585463]  ? __bpf_trace_tick_stop+0x20/0x20
> [  654.590291]  msleep+0x2d/0x40
> [  654.593625]  napi_disable+0x2b/0x80
> [  654.597437]  netvsc_device_remove+0x8a/0x1f0 [hv_netvsc]
> [  654.603935]  rndis_filter_device_remove+0x194/0x1c0 [hv_netvsc]
> [  654.611101]  ? do_wait_intr+0xb0/0xb0
> [  654.615753]  netvsc_remove+0x7c/0x120 [hv_netvsc]
> [  654.621675]  vmbus_remove+0x27/0x40 [hv_vmbus]
> 
> Cc: stable@vger.kernel.org
> Fixes: ac5047671758 ("hv_netvsc: Disable NAPI before closing the VMBus channel")
> Signed-off-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> Reviewed-by: Dexuan Cui <decui@microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>

