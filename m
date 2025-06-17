Return-Path: <linux-hyperv+bounces-5938-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704D5ADDE61
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Jun 2025 00:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA4E83BA511
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9907829293F;
	Tue, 17 Jun 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9lbGFqH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638173594C;
	Tue, 17 Jun 2025 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197610; cv=none; b=Xgj9gWOMsxy0ijvs3VzTvT3E+rMFAkualJCYn6DtsR11qKhdKxhMuQoFEtuF6539aCiBgcbTmT7z+GFwKSfeCYBpthqy6knRSZJgJhKp6MlmocqaJ6MH0CWvUpeBjxxspj0yqSAiI+eN0p4c02ToIkTIjivRZEbajGyOXYuyKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197610; c=relaxed/simple;
	bh=w85DzPEHKnEH32aJad7kpo9/EdvqI8PTVlSwnc+CrQs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uPT4A5tQfZTG3cdPX+kGViSl0ylZkoBqinUNjzeHKRKsZq2hIK7PTskMgjqinW0o6AfD1F4oG6lgtGDq2tt+uznBGxgcqKOJKjmL/ru1JH+cPPECR5H/JMMbYKuBLwtKc+BL+Eil+Km/EPLWAhVRWdxL3wLv2ZPtWbOPjTp3/m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P9lbGFqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED36CC4CEE3;
	Tue, 17 Jun 2025 22:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750197610;
	bh=w85DzPEHKnEH32aJad7kpo9/EdvqI8PTVlSwnc+CrQs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P9lbGFqHPkdvRR0T4aHKak6RRg6FwdYV4a7essTNdtxm8GYS2NwIDEzfXBn3SvoIl
	 GXRkXgPHG1gs7KyJQ9FkR4/ExK2Po4UEHM9igSC/rFKVWPFgBZsXhXn4SbMzV1LJzU
	 O40aTsLYE2vi6W/7BkfXpp+4Ooyzzav4510VEfwHh028qKqnVBv8EOFTaNt/aEIWgI
	 E82DZLsO0ndttEow8G9iCS9+5mAivSGfU9eWCCQ4a/jAN6Zm+ouW7DeQWCPCLWyGXC
	 paCqNxBFHz8yQd6Er+iNj35SOcofofofCBSq6loQGI7YprZK9p5uOi1SwetqYtbltZ
	 dxwGQucw7Hm7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4F38111DD;
	Tue, 17 Jun 2025 22:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/5] Allow dyn MSI-X vector allocation of MANA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175019763850.3710346.12665177654858419970.git-patchwork-notify@kernel.org>
Date: Tue, 17 Jun 2025 22:00:38 +0000
References: 
 <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: 
 <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, nipun.gupta@amd.com, yury.norov@gmail.com,
 jgg@ziepe.ca, Jonathan.Cameron@huwei.com, anna-maria@linutronix.de,
 kevin.tian@intel.com, longli@microsoft.com, tglx@linutronix.de,
 bhelgaas@google.com, robh@kernel.org, manivannan.sadhasivam@linaro.org,
 kw@linux.com, lpieralisi@kernel.org, decui@microsoft.com, wei.liu@kernel.org,
 haiyangz@microsoft.com, kys@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, leon@kernel.org,
 mlevitsk@redhat.com, ernis@linux.microsoft.com, peterz@infradead.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, paulros@microsoft.com,
 shradhagupta@microsoft.com

Hello:

This series was applied to netdev/net-next.git (main)
by Shradha Gupta <shradhagupta@linux.microsoft.com>:

On Wed, 11 Jun 2025 07:09:44 -0700 you wrote:
> In this patchset we want to enable the MANA driver to be able to
> allocate MSI-X vectors in PCI dynamically.
> 
> The first patch exports pci_msix_prepare_desc() in PCI to be able to
> correctly prepare descriptors for dynamically added MSI-X vectors.
> 
> The second patch adds the support of dynamic vector allocation in
> pci-hyperv PCI controller by enabling the MSI_FLAG_PCI_MSIX_ALLOC_DYN
> flag and using the pci_msix_prepare_desc() exported in first patch.
> 
> [...]

Here is the summary with links:
  - [v6,1/5] PCI/MSI: Export pci_msix_prepare_desc() for dynamic MSI-X allocations
    https://git.kernel.org/netdev/net-next/c/5da8a8b8090b
  - [v6,2/5] PCI: hv: Allow dynamic MSI-X vector allocation
    https://git.kernel.org/netdev/net-next/c/ad518f2557b9
  - [v6,3/5] net: mana: explain irq_setup() algorithm
    https://git.kernel.org/netdev/net-next/c/4607617af1b4
  - [v6,4/5] net: mana: Allow irq_setup() to skip cpus for affinity
    https://git.kernel.org/netdev/net-next/c/845c62c543d6
  - [v6,5/5] net: mana: Allocate MSI-X vectors dynamically
    https://git.kernel.org/netdev/net-next/c/755391121038

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



