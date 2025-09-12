Return-Path: <linux-hyperv+bounces-6834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D76B53FF3
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 03:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C52363A3A8E
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Sep 2025 01:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136FB1509A0;
	Fri, 12 Sep 2025 01:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m028My3p"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA7C15C0;
	Fri, 12 Sep 2025 01:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641206; cv=none; b=oiJQ6ECu3gA0+eeamDsotFmikU04Lmmge0JmbZLcQxXvhTuB3GCIJTri9wP+rW9bki9yylWncphIVeF3B7dmoes+FwhXtsDPjzzeCoqXSZCV4za/jKh/gw9FzcCZSknsG5f7Hwg9Aa5IcG0xV9OZ8vsL7S8TZ0sD2irU1cn/0i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641206; c=relaxed/simple;
	bh=XlBrkjUQ/I0LH5kjwZ6InFrcPg3fHynml0VhGQfQObc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ub0cNQXTMJItO7ctjpeYCVeviQ9kl9zifn4vYg4E3a4irz1V4mh4tiFbGB31jfmzcgmhNd+mpX7VjE64MNDarwqkOukINm1JIK0rSefe/btSxtdMJg+g+/R4HBDRysUKt/95Cj+wXdvMxxAlPJX9w/B/tx21Llrvm5ytXvuOCnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m028My3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71454C4CEF0;
	Fri, 12 Sep 2025 01:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757641205;
	bh=XlBrkjUQ/I0LH5kjwZ6InFrcPg3fHynml0VhGQfQObc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m028My3p2DfYni/SH1nR5n6JDQfR08yR+cqYqk1yrlrQc/o2Oi6y+h3tA839YLb2+
	 oiEcq3Qzamor0chCVW2Hb9AtvBhfIEHZckbC+uITnynRw8WNzykbiSzhDDlDMPPyIz
	 J26kYEa2JTnKc1WHWwRjAboD6KgHRNQguCA3b2q3ER4e+hHDNv7qF9TjBvwv1Smvrt
	 kWHiYF40ssCNYFMGi1IaJwpwp2qDwnNFJ3NFGLzrOMWAd42KefhJlxqA+ZdsbNEt0D
	 a7W6+u3dc+m/3pByKFUih2pwZ4zFXLZ6P2FNiKwE0TNeesb5ieRWiQkDXlh82lDIqy
	 99ugTBnhOwaBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DBB383BF69;
	Fri, 12 Sep 2025 01:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/mlx5: Not returning mlx5_link_info table when
 speed is unknown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175764120782.2369958.686511043382466099.git-patchwork-notify@kernel.org>
Date: Fri, 12 Sep 2025 01:40:07 +0000
References: <20250910003732.5973-1-litian@redhat.com>
In-Reply-To: <20250910003732.5973-1-litian@redhat.com>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org, saeedm@nvidia.com,
 tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 haiyangz@microsoft.com, bpoirier@redhat.com, vkuznets@redhat.com,
 cjubran@nvidia.com, shshitrit@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Sep 2025 08:37:32 +0800 you wrote:
> Because mlx5e_link_info and mlx5e_ext_link_info have holes
> e.g. Azure mlx5 reports PTYS 19. Do not return it unless speed
> is retrieved successfully.
> 
> Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Li Tian <litian@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net/mlx5: Not returning mlx5_link_info table when speed is unknown
    https://git.kernel.org/netdev/net/c/5577352b5583

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



