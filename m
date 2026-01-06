Return-Path: <linux-hyperv+bounces-8160-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 14426CF6453
	for <lists+linux-hyperv@lfdr.de>; Tue, 06 Jan 2026 02:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1724F3023D0F
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Jan 2026 01:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55DC1DBB3A;
	Tue,  6 Jan 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bm1DeggK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BE141C71;
	Tue,  6 Jan 2026 01:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663058; cv=none; b=effQKOphf+O02DHAq03O98ye82zMqZ4LL/sNaa/mwDuH8cez21xIC2MfMVxfogn4nPViJUcn8H/6QPQehhBQAwwZqTrFe1WmBhLctc908YW7FtdT/1WWAFzXxUEDR4cHlM2MVkouy7G2Zg8wAqkFKCY6DMyo/wVcZEmEfLFuCB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663058; c=relaxed/simple;
	bh=4uAVm2ZWkiuaol1HXlcytM5IJJy/t7P3QPqqjdvoEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVOyormnhTyzukfGSjOPc4OxgSe/9W+3sytvd2cnyRAC+RVdYOAAeQrdSRS/Gar3Cr5Q2SjP1EfiOExe2B219AMWyBZk+IzIncPbgxCe3Rngura1G8rgElLNOjjcUn4HtUPiu6mcMslmDXbyEEsFndJ5OPCYlAztB/pdEt+O8sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bm1DeggK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A5C19421;
	Tue,  6 Jan 2026 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767663058;
	bh=4uAVm2ZWkiuaol1HXlcytM5IJJy/t7P3QPqqjdvoEqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bm1DeggKLEYdAQ0O/D1NZ5NhYiEfNHIfgb5AEOQ11rU3vesRjtutDI56YlV0dCuBr
	 zYi6uVZ96gupWKqg1IUC5S80mC6SYBdACc3ypMAQmcW+QLAaVUIrUjLiojFMIKlR6l
	 dvStgBAJ1BiL23pbccrRVW/rkCRO2qHHt9qaFtXowIIcMjVSzsl8RjEqJss8VMKUBX
	 2MfVSJZmBexaGCRqY+ALgbwc+9J8WDLDDuZ1Rw0yf4EWMuu6iWlimWKspLoZuibTdP
	 o/3mGbhA3mGhxMQ0jtWyCwvJ+KDIdfcOmFouNf2l/jf34nvI3WTimW1c4xojBbsIte
	 GrOgH6ED9woow==
Date: Mon, 5 Jan 2026 17:30:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, shirazsaleem@microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 dipayanroy@microsoft.com
Subject: Re: [PATCH net-next, v6] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20260105173056.7c2c9d0a@kernel.org>
In-Reply-To: <20260103045705.GA3757@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260103045705.GA3757@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 2 Jan 2026 20:57:05 -0800 Dipayaan Roy wrote:
> +		apc = netdev_priv(ndev);
> +		disable_work_sync(&apc->queue_reset_work.work);

AI code review points out:

  In mana_remove(), disable_work_sync() is called for each port's
  queue_reset_work. However, when resuming=true, mana_probe() creates a new
  workqueue but does not call mana_probe_port() (which contains INIT_WORK),
  and there is no enable_work() call for queue_reset_work in the resume path.

  The existing link_change_work handles this correctly: it is disabled in
  mana_remove() and re-enabled with enable_work(&ac->link_change_work) in
  mana_probe() when resuming=true.

  Should enable_work(&apc->queue_reset_work.work) be called for each port in
  the resuming path of mana_probe(), similar to how link_change_work is
  handled? Otherwise TX timeout recovery appears to remain disabled after a
  suspend/resume cycle.
-- 
pw-bot: cr

