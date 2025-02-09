Return-Path: <linux-hyperv+bounces-3865-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C7BA2DBD7
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Feb 2025 10:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD603A5589
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 Feb 2025 09:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A9914AD3F;
	Sun,  9 Feb 2025 09:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8AzZrEv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56793E57D;
	Sun,  9 Feb 2025 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739094416; cv=none; b=BirrTQ1PzaT0SaN8QKU6wMkg85rY+6FqOxCUwFbDb+8XOJiVqc37eOTqA9kVvMKa3I400LN8yh1g2WuqP0AP8Efa8YPT2KPJMKL5Ruc8gwh4rq7zsJ1fgFjlM6qM3YXZEWcC2oEilmHrT/ZvWK5qsR68+p03FwJ7g9xUxDgdvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739094416; c=relaxed/simple;
	bh=YA/WTmAdd+gegJ8AlmZln8OQb2ZI4OKXMQnRdTeThhc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NS2ON+pkOmINoAbgoT4RV0zw5Ny2hu8qir3y4Jn9XUajhuqaWdnXC6NeRDe7bJExjnFcUjOizeCDz6wACRf7kLee5gJxFyRJyeegihUQUcJyr7+/fhkL5no1+cAeN11P3UrvRZ4AWXlAwi1GTO4cEcAeAaSfzhQggLZuHh0i/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8AzZrEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360F8C4CEDD;
	Sun,  9 Feb 2025 09:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739094415;
	bh=YA/WTmAdd+gegJ8AlmZln8OQb2ZI4OKXMQnRdTeThhc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=p8AzZrEvMWIFh071DrlbP1Pj1czC/VlYs6bTRM+fH/y1bGZuC5YysPfPNX7t+oaRQ
	 yb5URbxBX4l6CI6itnUHS34Zv6BSREZsRPfK7C872B8SQ95MW4d2K1LCHlVmEcVsCS
	 SABTKrjwwg26MWsB57fTWwaLJ4dkpXQChpkKEz/NcO4d3BssmHBkLxHBKYYkoY/mOg
	 uviFyewV/xed6riow3HPuWW13ZFYi2eOh36mmaimI6ex2yAC8wUGKvBeSBhgOdjnKd
	 8ANU7MFcY+fqAZROxS0P30C1qtGfxggVA9KMhTvBD80ohQ21rfaEP5UH0eXr8BCk0V
	 aiZ8C5YoV7OVQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Ajay Sharma <sharmaajay@microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 longli@linuxonhyperv.com
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Long Li <longli@microsoft.com>
In-Reply-To: <1738964792-21140-1-git-send-email-longli@linuxonhyperv.com>
References: <1738964792-21140-1-git-send-email-longli@linuxonhyperv.com>
Subject: Re: [PATCH rdma-next] MAINTAINERS: update maintainer for Microsoft
 MANA RDMA driver
Message-Id: <173909441228.5130.2489800826083268776.b4-ty@kernel.org>
Date: Sun, 09 Feb 2025 04:46:52 -0500
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811


On Fri, 07 Feb 2025 13:46:28 -0800, longli@linuxonhyperv.com wrote:
> Ajay is no longer working on the MANA RDMA driver.
> 
> Konstantin Taranov has made significant contributions to implementing RC
> QP in both kernel and user-mode.
> 
> He will take the responsibility of fixing bugs, reviewing patches and
> developing new features for MANA RDMA driver.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: update maintainer for Microsoft MANA RDMA driver
      https://git.kernel.org/rdma/rdma/c/ee9d1619ef6e4a

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


