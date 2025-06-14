Return-Path: <linux-hyperv+bounces-5917-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74213AD9F9B
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Jun 2025 22:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7625518940ED
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Jun 2025 20:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF09328D83F;
	Sat, 14 Jun 2025 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm5OZsH8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7781BD9C1;
	Sat, 14 Jun 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749931437; cv=none; b=RTS1y44Z9h602TuX+Ti5amuacrgHA48F12zayx674QfjJOjM+3zuHnIQo1Dp+u4Upm34/8jN5RQzJD/PN6wafowdwP8eMnbKyYZjmGkgyjJmNNWRGIXB0xpwzfqtHx32elLLm+quBkR/KAvh5UoiunDttVLkcEH/RJu0rpQozrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749931437; c=relaxed/simple;
	bh=GY6P7k8VV8sKiyvFkCJ3MKhvnmt5LFjeYWjC+1yHv8g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWBhy/d9C2y1Oj57/Hrd1aCMb7ARCOOAr1fZTSI9pd/HBNIcDq0ym5yjqCeL0EDHxoB9Yg7U0xku2ahywVLdVskrxsqtMft3frygiW6hFa07MZ+oSYSywN1xxX41oBzhhI0L1rBnDKD5ykCe76hDD1qjxDyNbBnReUv2o9MqgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qm5OZsH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116F9C4CEEB;
	Sat, 14 Jun 2025 20:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749931436;
	bh=GY6P7k8VV8sKiyvFkCJ3MKhvnmt5LFjeYWjC+1yHv8g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qm5OZsH8s0jsEfRN5uVRuCXGjnpau1FUAQmhyucQC+DFTmHQqr8/YF4ptrGjelMDA
	 /EE2G7srKOlnK+wnbVccHikGz6V5zTlpTfk0pBSDhZuifFL9lVh03K2lmInSPdFK3U
	 7/CiK9qg3x4CiGF9n0QVkl3HRJWbEJvay7fB+2Qy3qUe8fjGhfEuFi5cu3AUUkE3Dt
	 urm79lUmDlhMnTqIqcca3iG1v9q7trzzxm8zsaAHjKiRj2z1S5nqyscDQUkQqFlwO0
	 ohQlYDzfE0td0gHvLO+D/OKGjsqWFU6CGoox5zHbSJOvEYCV34FaEoI/IYKr5URJoF
	 obqhc8l07Tc6A==
Date: Sat, 14 Jun 2025 13:03:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shirazsaleem@microsoft.com,
 leon@kernel.org, shradhagupta@linux.microsoft.com,
 schakrabarti@linux.microsoft.com, gerhard@engleder-embedded.com,
 rosenp@gmail.com, sdf@fomichev.me, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Support bandwidth clamping in mana
 using net shapers
Message-ID: <20250614130354.0a53214e@kernel.org>
In-Reply-To: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
References: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 04:20:23 -0700 Erni Sri Satya Vennela wrote:
> This patchset introduces hardware-backed bandwidth rate limiting
> for MANA NICs via the net_shaper_ops interface, enabling efficient and
> fine-grained traffic shaping directly on the device.
> 
> Previously, MANA lacked a mechanism for user-configurable bandwidth
> control. With this addition, users can now configure shaping parameters,
> allowing better traffic management and performance isolation.
> 
> The implementation includes the net_shaper_ops callbacks in the MANA
> driver and supports one shaper per vport. Add shaping support via
> mana_set_bw_clamp(), allowing the configuration of bandwidth rates
> in 100 Mbps increments (minimum 100 Mbps). The driver validates input
> and rejects unsupported values. On failure, it restores the previous
> configuration which is queried using mana_query_link_cfg() or
> retains the current state.
> 
> To prevent potential deadlocks introduced by net_shaper_ops, switch to
> _locked variants of NAPI APIs when netdevops_lock is held during
> VF setup and teardown.
> 
> Also, Add support for ethtool get_link_ksettings to report the maximum
> link speed supported by the SKU in mbps.
> 
> These APIs when invoked on hardware that are older or that do
> not support these APIs, the speed would be reported as UNKNOWN and
> the net-shaper calls to set speed would fail.

Failed to apply patch:
Applying: net: mana: Fix potential deadlocks in mana napi ops
error: patch fragment without header at line 23: @@ -2102,9 +2108,11 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
error: could not build fake ancestor
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"
Patch failed at 0001 net: mana: Fix potential deadlocks in mana napi ops

please rebase
-- 
pw-bot: cr

