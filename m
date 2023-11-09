Return-Path: <linux-hyperv+bounces-816-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131957E622B
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 03:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C157D281107
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Nov 2023 02:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC7510FD;
	Thu,  9 Nov 2023 02:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DUr3DwBI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3B253A0;
	Thu,  9 Nov 2023 02:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864A7C433C7;
	Thu,  9 Nov 2023 02:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699496780;
	bh=bvkrLtnAeHE0QC2OdmfX8Hg2tktQ7eKe6WDZsBHFo1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DUr3DwBIu27FhAKrid+Jirzy8lFaAV0ao2SEx4/SFo6q40YtjpLlneu/slcP93h0F
	 kyXqzDD0cUFDJUG769F23SX5dH6/dYZVF3lKMdEvE+p5zW0yyugCc0H0d3IdAsoLn4
	 iFTD9mdC9sHQwo39naD8w0oqdguPdY+TGnGc5VCwCKoZ4o9djS8ZXxvB8r3sbCCL5M
	 KuhDPO/wZcC9N5bc6CPsN9aRjWfsUOFx4VIJLc0dvyToz1Bla6ayDV8o+G0G62iIhX
	 c1F2YnqyhdnTGMtGdEz4dn7Bkw6wuHup1xZMVLyMaGpR/e6dZ4hzQZOTcbPs5RYDr2
	 m7xb2/QMUYmlQ==
Date: Wed, 8 Nov 2023 18:26:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, kys@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, edumazet@google.com,
 pabeni@redhat.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net,v3, 2/2] hv_netvsc: Fix race of
 register_netdevice_notifier and VF register
Message-ID: <20231108182618.09ef4dfe@kernel.org>
In-Reply-To: <1699391132-30317-3-git-send-email-haiyangz@microsoft.com>
References: <1699391132-30317-1-git-send-email-haiyangz@microsoft.com>
	<1699391132-30317-3-git-send-email-haiyangz@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Nov 2023 13:05:32 -0800 Haiyang Zhang wrote:
> If VF NIC is registered earlier, NETDEV_REGISTER event is replayed,
> but NETDEV_POST_INIT is not.

But Long Li sent the patch which starts to use POST_INIT against 
the net-next tree. If we apply this to net and Long Li's patch to
net-next one release will have half of the fixes.

I think that you should add Long Li's patch to this series. That'd
limit the confusion and git preserves authorship of the changes, so
neither of you will loose the credit.

