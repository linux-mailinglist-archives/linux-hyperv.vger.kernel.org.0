Return-Path: <linux-hyperv+bounces-5927-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EE1ADC23C
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 08:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4FC31896C74
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 06:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798723B60E;
	Tue, 17 Jun 2025 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MLNQdKQP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B74430;
	Tue, 17 Jun 2025 06:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750140993; cv=none; b=QSMvN/CRs3d3bxJ1GfMfKvB0KgALL0BVaZxoMaJsRjAkj0rFMLUWIni0NKuFr5nUJR2TylzIJ5f6CmfZbvSrBKRZH4IyUfH0yyOFM4knSOAkyxMsDi8+g1s0sM32jyFEiu5ES9pQaiuIUIGjT+kNvcoGv8rjURZM8wYQ+Iuan3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750140993; c=relaxed/simple;
	bh=em5afbSxDVZTWjiIIfEt3ro5pNH4iDv1ddey82xb5k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpmfcWM31C6+gxsbrAjdOb4eyo7f2zoxdSL8V85AVA5J30oQv9hsd4po6kCcdLz0f+wWPd2ZMKqB3hs0xXP6gZEUepZFxYEU4h+SC1S1mq9AkXllSuSU3wVNhj/wEdp+37PbRtbieLXM8w0IA73wYvNhvmz1mFMMTFvHV54wtuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MLNQdKQP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 12CB02115DDF; Mon, 16 Jun 2025 23:16:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12CB02115DDF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750140991;
	bh=KzS9ZS6fAvo4puvySZm9ixLEffc5yo2/sxVEQs2cdqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MLNQdKQPFuyylGJu0lRnPbIsyUPkT/7uauh3pgrAFlT7B4qXM5Zzs4mQYZTPPCHgN
	 AA4B/1p5BZThRtiT3pAvtQpiKOlV1RvjIRYXbFX+4EQa0tb2WUYR4oEEKOJwhiP7Ou
	 f7MPIxQTtGfs/RIvQR2dr8BD8sKoE4ohEFGGTeAY=
Date: Mon, 16 Jun 2025 23:16:31 -0700
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
	kotaranov@microsoft.com, horms@kernel.org,
	shirazsaleem@microsoft.com, leon@kernel.org,
	shradhagupta@linux.microsoft.com, schakrabarti@linux.microsoft.com,
	gerhard@engleder-embedded.com, rosenp@gmail.com, sdf@fomichev.me,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Support bandwidth clamping in mana using
 net shapers
Message-ID: <20250617061631.GA19561@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1749813627-8377-1-git-send-email-ernis@linux.microsoft.com>
 <20250614130354.0a53214e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250614130354.0a53214e@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Jun 14, 2025 at 01:03:54PM -0700, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 04:20:23 -0700 Erni Sri Satya Vennela wrote:
> > This patchset introduces hardware-backed bandwidth rate limiting
> > for MANA NICs via the net_shaper_ops interface, enabling efficient and
> > fine-grained traffic shaping directly on the device.
> > 
> > Previously, MANA lacked a mechanism for user-configurable bandwidth
> > control. With this addition, users can now configure shaping parameters,
> > allowing better traffic management and performance isolation.
> > 
> > The implementation includes the net_shaper_ops callbacks in the MANA
> > driver and supports one shaper per vport. Add shaping support via
> > mana_set_bw_clamp(), allowing the configuration of bandwidth rates
> > in 100 Mbps increments (minimum 100 Mbps). The driver validates input
> > and rejects unsupported values. On failure, it restores the previous
> > configuration which is queried using mana_query_link_cfg() or
> > retains the current state.
> > 
> > To prevent potential deadlocks introduced by net_shaper_ops, switch to
> > _locked variants of NAPI APIs when netdevops_lock is held during
> > VF setup and teardown.
> > 
> > Also, Add support for ethtool get_link_ksettings to report the maximum
> > link speed supported by the SKU in mbps.
> > 
> > These APIs when invoked on hardware that are older or that do
> > not support these APIs, the speed would be reported as UNKNOWN and
> > the net-shaper calls to set speed would fail.
> 
> Failed to apply patch:
> Applying: net: mana: Fix potential deadlocks in mana napi ops
> error: patch fragment without header at line 23: @@ -2102,9 +2108,11 @@ static void mana_destroy_rxq(struct mana_port_context *apc,
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config set advice.mergeConflict false"
> Patch failed at 0001 net: mana: Fix potential deadlocks in mana napi ops
> 
> please rebase
Hi Jakub,

Thank you for your reply. I will rebase and repost.

- Vennela
> -- 
> pw-bot: cr

