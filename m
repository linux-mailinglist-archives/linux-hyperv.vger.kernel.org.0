Return-Path: <linux-hyperv+bounces-649-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8AD7DC1E2
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6492828160B
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Oct 2023 21:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A9C1C2A8;
	Mon, 30 Oct 2023 21:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/oYgCeN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79E199D9;
	Mon, 30 Oct 2023 21:25:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3F5C433C7;
	Mon, 30 Oct 2023 21:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698701144;
	bh=+b0YC2uQr6Lu6xgNwJdj0UnPpjDCBGsTQO6PZ1T3PWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=g/oYgCeNvrQ+caweHyevJAr7jN2Lt2kIc0lD3tiZBcWyxUqYhCAk4ETl32LBLt9R/
	 4EYJj7jcvKJgAgsTg7nShwfTlAnd3GONwDEM5HGvu/LfTmdIrjs4Td0ze50ti4IUa+
	 15fVLZ8GjGn9QZMIGxu+p6A3XoJWGUTjVVmFtWtKXg+np0DkEjGUh/lQs4MDqTHqJM
	 oiSUvv8U5XOLSRrKxQOcX3nvjmTkSwsT6Arrr6hFsmQnVA+ODctbZaKlW2V4Snh3F6
	 RvKiSn+jVUtfMaa13F5Njsm0Tnp51qcxApx+dw/pa3cQeRdsOEJNpLvKGsr1+PqF7x
	 4LncKzFYsGizQ==
Date: Mon, 30 Oct 2023 14:25:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [Patch v2] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Message-ID: <20231030142542.6640190b@kernel.org>
In-Reply-To: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
References: <1698440390-13719-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Oct 2023 13:59:50 -0700 longli@linuxonhyperv.com wrote:
> When a VF is being exposed form the kernel, it should be marked as "slave"
> before exposing to the user-mode. The VF is not usable without netvsc running
> as master. The user-mode should never see a VF without the "slave" flag.
> 
> This commit moves the code of setting the slave flag to the time before VF is
> exposed to user-mode.

Can you give a real example in the commit message of a flow in user
space which would get confused by seeing the VF netdev without
IFF_SLAVE?

You're only moving setting IFF_SLAVE but not linking the master,
is there no code which would assume that if SLAVE is set there 
is a master?

