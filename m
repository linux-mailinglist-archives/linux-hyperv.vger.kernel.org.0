Return-Path: <linux-hyperv+bounces-2644-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DE8944DC5
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D5C28348F
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Aug 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E569D1A489E;
	Thu,  1 Aug 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhxHll3f"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478E171658;
	Thu,  1 Aug 2024 14:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722521811; cv=none; b=eBNE/aPHDO8nwhNIzIMsZTsCO7MUh2ZhG1FQ36r983ulMSN6pt/fXrnY3lToTWgRR6dXnn1BWZklQIR+thNT4ZvR6Lwzha0qFgjEqOCsiz60lxYxpeDIrwi5m0+FlrFgK3bCUYorzL4vfKtSKAwXam5JBVYySgALSLgix1Bl0X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722521811; c=relaxed/simple;
	bh=veBPImXNnXaF06UW5uo2rMAiqAUxNKnWTRyP8Z1gAII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dzk6mcyi7sjQjMKIRTWbTK/euhbxoKFCT4+lkswCtwS0nES+5dE7GILnvU2p9XMR3HNQhfXiWq9Pmq9CAdh0He9vibbCERHoVyhgQmm+6VL2lJ/8Kr/F1kns31oNlfWGtqQZfFDQx9Wvi+mPmXTzBZEa7/RZ7fBLKpdbs6NAeoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhxHll3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9009EC4AF0A;
	Thu,  1 Aug 2024 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722521811;
	bh=veBPImXNnXaF06UW5uo2rMAiqAUxNKnWTRyP8Z1gAII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhxHll3fsZ8JoesX5+ACZDhxK4nZLYaUS8iZfa90yomDe64mXLbqtVaSZTSFTR9rl
	 WZrwMkCEDstZh4k6GvyZzFasTC91fR6oRumqnCwgN95K4Pa44JyKd3od7hgEdbPVVY
	 B9dXl0RUsr5zrfMx/gKZrW/bgSVtq9artXIzroXzRhHsz3dcuOO9wAmv+x0dE19v0b
	 J0X+z0xykebFmadyAfRXPjsyjttxGy/MVQBm4UVmDXNRFSbIBTNdOCyvLt/kjDVFip
	 yD58L4zFA8fnocixi1lU28YTEIO3DwcWKFffcTSYh8c5noooyyvM6Q0UaQXMYEaN+H
	 jALbcIqUquANA==
Date: Thu, 1 Aug 2024 07:16:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Long Li
 <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>, Simon
 Horman <horms@kernel.org>, Konstantin Taranov <kotaranov@microsoft.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>
Subject: Re: [PATCH net-next v2] net: mana: Implement
 get_ringparam/set_ringparam for mana
Message-ID: <20240801071649.386b4717@kernel.org>
In-Reply-To: <20240801034905.GA28115@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1722358895-13430-1-git-send-email-shradhagupta@linux.microsoft.com>
	<f9dfaf0e-2f72-4917-be75-78856fb27712@linux.microsoft.com>
	<20240801034905.GA28115@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 20:49:05 -0700 Shradha Gupta wrote:
> It is a pretty standard support for network drivers to allow changing
> TX/RX queue sizes. We are working on improving customizations in MANA
> driver based on VM configurations. This patch is a part of that series.
> Hope that makes things more clear.

Simple reconfiguration must not run the risk of taking the system off
network.

