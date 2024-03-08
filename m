Return-Path: <linux-hyperv+bounces-1694-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9623876BD3
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 21:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EF12828C7
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Mar 2024 20:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFB55B5DD;
	Fri,  8 Mar 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoOteGE2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FC7524A2;
	Fri,  8 Mar 2024 20:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929670; cv=none; b=BLnk936tUB/XA6UrprqKIMgn8gndBuwzV4m82FtQGJlcafeEGRHlaax3W1ZsBinOCiimP4HaAds4shsmvVB5qL4Aa7QoQFZF78fMuN/yn7DpDrjjSIJdx1T2Fcf7KlnhwacHLDlKGfY+JIEjdSNyEWjEQx/JCeZiFjX0LglLTP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929670; c=relaxed/simple;
	bh=3NTsnRHMBLe0tb+2l4cedCjA/tS1VlSVd90rkwF9yXk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOYR2N2oiexgy0IbTpEb4wuzdQEH1HcKS42sP7VCy2gY8Abmn4FJ7m5Tv/4+zB+RmG2Ua5TJxDdgmGukLG7Xyq9Kx2G2FFqi6aQ8eJj4wptam5yVJ1G7hDtcgjQyIlCp/XGOZLlYd914IyKyi3TKg6lrSeWmqhOayqOf6I7d0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoOteGE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F73EC433C7;
	Fri,  8 Mar 2024 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709929669;
	bh=3NTsnRHMBLe0tb+2l4cedCjA/tS1VlSVd90rkwF9yXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AoOteGE2ZlnNfsRJ82oxMqGKp/TdZlsemCQIptPjNqmX4h2kWKjkwwHOeuz0eOyZq
	 sm3qgWgYlem+xE6q3rJltAhD/se6FDrHvqmk3x8b5A6OByXkYzaNqWWfLgUdN0B52/
	 X06nMiph4NSLCzrfdAa2Wy6mFajR89JNmvUdGL68/24x+DlpXEMaE70HwK4A5TG/nv
	 7fGfdMCPTI2QP2MyX+RFnDlB3265VnsSd150bJ0KlxiFjXc+cK6C6pVSpdwobWBjOw
	 yEWD5Mu7uBypXWs6wA59GcGGWsEOmjF1SrQwnJFl/YDFaOnsUKd6M+FCPIsfTdAu9U
	 753L9VuXKP8RQ==
Date: Fri, 8 Mar 2024 12:27:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>, Shradha Gupta
 <shradhagupta@microsoft.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ajay Sharma <sharmaajay@microsoft.com>, Leon
 Romanovsky <leon@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, KY Srinivasan
 <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Paul Rosswurm
 <paulros@microsoft.com>, Alireza Dabagh <alid@microsoft.com>, Sharath
 George John <sgeorgejohn@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240308122748.47c7dda5@kernel.org>
In-Reply-To: <CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<CH2PR21MB1480D4AE8D329B5F00B184A7CA272@CH2PR21MB1480.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 19:43:57 +0000 Haiyang Zhang wrote:
> > Seems unlikely, but if it does work we should enable it for all
> > devices, no driver by driver.  
> There are some existing drivers, like mlx, rmnet, netvsc, etc. using percpu 
> counters. Are you suggesting we add a common API for all drivers?

Hm, I don't think mlx does. The typical use case for pcpu stats so far
has been software devices which don't have queues, and implement
lockless Tx. In that case instead of recording stats on a local queue
struct we can count per-cpu and not worry about locking.

