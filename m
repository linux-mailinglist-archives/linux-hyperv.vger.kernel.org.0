Return-Path: <linux-hyperv+bounces-2775-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9310A9537EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 18:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26911C2374C
	for <lists+linux-hyperv@lfdr.de>; Thu, 15 Aug 2024 16:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629819FA87;
	Thu, 15 Aug 2024 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tWeGID1d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB83E1714CF;
	Thu, 15 Aug 2024 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738138; cv=none; b=mxr3Xr7S7VnPLtrPh7COx/Kn4GlCd5giPPOEJE70ZBP4SkCB4cMBC8Al4ubH9gVkL6+L5jczYkOgarKzyjmcxdsedCallrJ4dWxDiHJzszELO9hmvMDA40kAhugA6XEVpqQ/miZXsE/AuatiSLuf3+CkevIXuNRlXq9lfzb48gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738138; c=relaxed/simple;
	bh=Pwhcosg/2481mlBnXLoezww6CFiK4+irt0TdYQPusVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J9bBHN8Cjz0SrpLgMr5Qs4Ntnicw0SAXLTKF6104VHlo7jmBIp3SxhzVvM8YC1LR+M6VDcqd+cAE8GVLG1KiTXUif4I31GNqs5B7u9uNBQm6PN+JRLHoi9N3lbOhHa06Q1a2Q0bqOvK9nEXfy7bwKG0STL9EPoYd6Geo1VhTnJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tWeGID1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323CC32786;
	Thu, 15 Aug 2024 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723738138;
	bh=Pwhcosg/2481mlBnXLoezww6CFiK4+irt0TdYQPusVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tWeGID1dqVq0A4zE/XNllRjdBT2rj0QtMLBrKwIqtyv/SH0wW05FKVpXZ8tHcytNj
	 cFlcmLItIXJXGiRIXbniBYnsJGo1lsT5TEGe3nD6tMNX/SUAgNlz5OyuukwWk+0/1D
	 QsrhMrtGSDdtieIN/iFTEiIvpqYrg3h5h2/GZg7qfCWJQhFnvfM1yZqBv0P3Ksd0JC
	 aONCoBHm7hvxUanrGZR5zuJ8CZWJy+L67QCluLcDnNPeX+yNOaG+VBG7e6EKtE6y7Q
	 h5RoRbjPCKbe7T8SJ2W67gmq+Hq65QAyWQ8ck2qoO2v7UDlYBxZXBpHPROpfj+AC9g
	 pmcMZLEuMcJjw==
Date: Thu, 15 Aug 2024 09:08:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ernis@microsoft.com
Subject: Re: [PATCH v2] net: netvsc: Update default VMBus channels
Message-ID: <20240815090856.7f8ec005@kernel.org>
In-Reply-To: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
References: <1723654753-27893-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Aug 2024 09:59:13 -0700 Erni Sri Satya Vennela wrote:
> Change VMBus channels macro (VRSS_CHANNEL_DEFAULT) in
> Linux netvsc from 8 to 16 to align with Azure Windows VM
> and improve networking throughput.
> 
> For VMs having less than 16 vCPUS, the channels depend
> on number of vCPUs. Between 16 to 32 vCPUs, the channels
> default to VRSS_CHANNEL_DEFAULT. For greater than 32 vCPUs,
> set the channels to number of physical cores / 2 as a way
> to optimize CPU resource utilization and scale for high-end
> processors with many cores.
> Maximum number of channels are by default set to 64.
> 
> Based on this change the subchannel creation would change as follows:
> 
> -------------------------------------------------------------
> |No. of vCPU	|dev_info->num_chn	|subchannel created |
> -------------------------------------------------------------
> |  0-16		|	16		|	vCPU	    |
> | >16 & <=32	|	16		|	16          |
> | >32 & <=128	|	vCPU/2		|	vCPU/2      |
> | >128		|	vCPU/2		|	64          |
> -------------------------------------------------------------
> 
> Performance tests showed significant improvement in throughput:
> - 0.54% for 16 vCPUs
> - 0.83% for 32 vCPUs
> - 1.76% for 48 vCPUs
> - 10.35% for 64 vCPUs
> - 13.47% for 96 vCPUs

Is there anything that needs clarifying in my feedback on v1?

https://lore.kernel.org/all/20240807201857.445f9f95@kernel.org/

Ignoring maintainer feedback is known to result in angry outbursts.

