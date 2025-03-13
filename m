Return-Path: <linux-hyperv+bounces-4466-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E25A5F3BC
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 13:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F2617F233
	for <lists+linux-hyperv@lfdr.de>; Thu, 13 Mar 2025 12:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AAC2676C0;
	Thu, 13 Mar 2025 12:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hK6mGsH3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E19267399;
	Thu, 13 Mar 2025 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867408; cv=none; b=MOGYJ5X8pBcK3oXdRorC8oj1mQw+QoqUw2zTwV5TIwypqJU4Y/lSQ3YxyHiZxTRB9KYE/GJWEAI03Oh4JG4cQQ3gGfxAsfb/1cH84xiX5olxOH+lk347dHUkdo5PFDUuLaPgZuWEXjuWq0QGjO7APotIeYbsljaGX/9zPHTQvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867408; c=relaxed/simple;
	bh=CPtuIJFPbVn0H1c4e5GFM0xMz0llPlIszfF5oAWZMQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JVzHQ1wSC9/klSk8w62HlArMU8ydlyPMdyntvgV7uYomK3yevpqSxe2Coh7/AhnRy9QnCs/dasZ3Kclb7/W3BEIW33vtYSAeZXhABhfdm0MF0/3qyJ1CExNlRrl55TR9Cd7d7KrVcITeKutnXzplQPO2Qa6zY/yw6+HzI7qOHVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hK6mGsH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCBDC4CEDD;
	Thu, 13 Mar 2025 12:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867407;
	bh=CPtuIJFPbVn0H1c4e5GFM0xMz0llPlIszfF5oAWZMQs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hK6mGsH3rg4vRaCqNpeuDMLvnHjtrzA8hEOrVGlDuIMCXElvLAdF+pCTVgk4GzDUD
	 AlMr/OsZUbPc61VpeBcung5hoDwP3QKeHWTm3aa09PtvYRx4VWif5eqxAhAqhKiZF2
	 5VuiDyX0VebFTq6FRmcaJBaAvItv1UQa9MwQOZHXGJ9vmM1MEETfmK5LI9hY6+pRQL
	 UlHzuS3ahTwu2nnXtUNwLzhVSrIIyijRN3D9JykbtQDJXB7zOSql3aTM0e3rGFTsjL
	 t3dB0FZlzrz3FlRHqVkQ1YX8JPHaV27jawP4V3jCjPV2wvA3NKXNRzFPMRyQrLO/9b
	 1wMLrMgm8Q4cQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 longli@linuxonhyperv.com
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Long Li <longli@microsoft.com>
In-Reply-To: <1741821332-9392-1-git-send-email-longli@linuxonhyperv.com>
References: <1741821332-9392-1-git-send-email-longli@linuxonhyperv.com>
Subject: Re: [patch rdma-next v6 1/2] net: mana: Change the function
 signature of mana_get_primary_netdev_rcu
Message-Id: <174186740244.531606.4287471152182071574.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 08:03:22 -0400
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Wed, 12 Mar 2025 16:15:31 -0700, longli@linuxonhyperv.com wrote:
> Change mana_get_primary_netdev_rcu() to mana_get_primary_netdev(), and
> return the ndev with refcount held. The caller is responsible for dropping
> the refcount.
> 
> Also drop the check for IFF_SLAVE as it is not necessary if the upper
> device is present.
> 
> [...]

Applied, thanks!

[1/2] net: mana: Change the function signature of mana_get_primary_netdev_rcu
      https://git.kernel.org/rdma/rdma/c/a8445cfec101c4
[2/2] RDMA/mana_ib: Handle net event for pointing to the current netdev
      https://git.kernel.org/rdma/rdma/c/bee35b7161aaae

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


