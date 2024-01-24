Return-Path: <linux-hyperv+bounces-1464-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5D1839DE8
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 02:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770C228420A
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 01:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328E10E3;
	Wed, 24 Jan 2024 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW1XArYK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5427017E1;
	Wed, 24 Jan 2024 01:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058215; cv=none; b=Fx72vQYYCglw8WdFD24fWsjduxULpBnhYgWyM+Goz/fOCAGdRl5WuuLNHJR5IDV/OwQ//EUpXvqY4ZOsnDX2cqdwmB86sYFHSY9iLZ6bhRwjrFDLnYlqqNaT9HtHW45IsEXvlyFkAs+0Qs0zh4pCCKHBuPI5wBpKTxtu8ltbx6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058215; c=relaxed/simple;
	bh=1C0aclCSrTodyIiX9t1yGWxG9h2zK+4zsFmooVu0iQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tlb8qK6jGH2FMLXOCtPVx+lQ413xRMiCB6i/pZNUKKVwBfQF9gj8tnekmyhg74ccn2ueeIg/hUzGD1tipjSBjEQaEC7ebsnT+lGN/1eJ8NNThCphXlykG/7f8631V3Gg3pEJu9Eyn+1X6YN9VPl0TLUOPjD+QDqpjFdSalV5hHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW1XArYK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3A8C433F1;
	Wed, 24 Jan 2024 01:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706058214;
	bh=1C0aclCSrTodyIiX9t1yGWxG9h2zK+4zsFmooVu0iQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NW1XArYKalNgr/Ur0uwp3MhGLCPH0L2LOi6rDbWKIb9MkR0WvyeENiNmpGyAMWQ/G
	 hV21dFBePxK71+X7A7WQCo2d1SXZBU47YWrVR2Po1P5utDSQRUKivvkbLhROUxZOVG
	 HWsHNdBtIT2c+XoQbNAnlZKFEtig4zDPOgFUHrpJWYbMGLVS3xh1jdHrm4PR+tJNet
	 4KRcWRi7ouctoLF/3hQCcJ1jkMzXMbI+FcOMcn4MI05ugtxwPldukkx8q62HXLMoyR
	 TkAFj4m8DRjb3aE0/N08R7SIpeT31juXqLzvTIfMs547SX5dhpupOdh9npyETtFtQr
	 Yc4SaUOKuBJEA==
Date: Tue, 23 Jan 2024 17:03:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, longli@microsoft.com, yury.norov@gmail.com,
 leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, schakrabarti@microsoft.com,
 paulros@microsoft.com
Subject: Re: [PATCH 4/4 V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Message-ID: <20240123170332.20dd8a6b@kernel.org>
In-Reply-To: <1705939259-2859-5-git-send-email-schakrabarti@linux.microsoft.com>
References: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
	<1705939259-2859-5-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 08:00:59 -0800 Souradeep Chakrabarti wrote:
> IRQ   node-num    core-num   CPU        performance(%)
> 1      0 | 0       0 | 0     0 | 0-1     0
> 2      0 | 0       0 | 1     1 | 2-3     3
> 3      0 | 0       1 | 2     2 | 4-5     10
> 4      0 | 0       1 | 3     3 | 6-7     15
> 5      0 | 0       2 | 4     4 | 8-9     15
> ---
> ---

Please don't use --- as a line, indent it or use ... because git am
uses --- as a commit message separator. The commit message will get
cut off at the first one of those if we try to apply this.
-- 
pw-bot: cr

