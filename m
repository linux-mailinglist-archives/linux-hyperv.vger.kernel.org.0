Return-Path: <linux-hyperv+bounces-7912-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6913BC994A6
	for <lists+linux-hyperv@lfdr.de>; Mon, 01 Dec 2025 23:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12C9E341C4D
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Dec 2025 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C963F2765C4;
	Mon,  1 Dec 2025 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egvMglHW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAAE42AB7;
	Mon,  1 Dec 2025 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764626679; cv=none; b=toPnylYS3nyQzOQGmhVll13LyMay68QwDEUdDK44FVh+DmwTFGTyvgN7X1s5dYzgGHAYGTkv0v7DltBa3COqCmKB/e/EMibEYJwK7QT+L91vkoeNWzvHFxiafWq/qbzsA1uluRTdWtNGpU9krbYFPOibwbgX5iFD7ACE1Uqq1uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764626679; c=relaxed/simple;
	bh=o36oAC3a3ejjjsYgUK0joMtnOWdWqpfGsXI9FEPrH50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnbwbIWLcid1vFjPSbldAFO/rH8r/BU0hQsZyJmLs35E73NJ23E6C1j6/k3pccbQMY/aSvrGaikD7I1Gg5q5yovko5AeXTblt2SeIiXtQacoMcIKL9cnhEE/OAebJJgFnzTEYJPy6r9+4dpY0IAb2lmtHYRP5YN9F0TPJxVHnkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egvMglHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4993CC4CEF1;
	Mon,  1 Dec 2025 22:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764626679;
	bh=o36oAC3a3ejjjsYgUK0joMtnOWdWqpfGsXI9FEPrH50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egvMglHWiyti2nvOWBObxyPBYt9Hbo1KfWsy5nEaoBUPlx0AnkgsiXoE4y1jnA7iE
	 DcteEG48bPWvF7MKMM+oyFFmWrzeqB4qDTIXTHwfzHDbGSim6QWZsPsObueJDbCPjv
	 DKUujUTH6mqYFzVaILYZEpSEaa2d0dh2v3OlwxARMVD38kgCek4BSKEhNMWmaSqg1y
	 9ETzypDVM+5ii5Li8jLGlXTH7tDF1l5UutQW4xJwdw5m3ULZXvBAr0D44A0jJQbvqQ
	 f4GDta/2zzYvC4c7uECthakGc+Bpr9Xxk1F24DrdQAuATdClzOlrG1uIp7LV8cSJlD
	 u1aQmfMJ3FdCQ==
Date: Mon, 1 Dec 2025 14:04:37 -0800
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
Subject: Re: [PATCH net-next, v5] net: mana: Implement ndo_tx_timeout and
 serialize queue resets per port.
Message-ID: <20251201140437.6da93be4@kernel.org>
In-Reply-To: <20251127135849.GA8411@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20251127135849.GA8411@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 05:58:49 -0800 Dipayaan Roy wrote:
> Implement .ndo_tx_timeout for MANA so any stalled TX queue can be detected
> and a device-controlled port reset for all queues can be scheduled to a
> ordered workqueue. The reset for all queues on stall detection is
> recommended by hardware team.

no longer applies, please repost after net-next reopens
-- 
pw-bot: cr

