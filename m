Return-Path: <linux-hyperv+bounces-372-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAD97B4971
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Oct 2023 21:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 045592817F0
	for <lists+linux-hyperv@lfdr.de>; Sun,  1 Oct 2023 19:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860941946A;
	Sun,  1 Oct 2023 19:35:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B09945A;
	Sun,  1 Oct 2023 19:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909AFC433C8;
	Sun,  1 Oct 2023 19:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696188928;
	bh=2fAkwl7Bkul3eesFHp5NXfQdxux8bozgy2kPSkCSopE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HNOARcbYjlQr9J1v44b4w03Q78QjwiFErN/19dIHTWjJvTieOjhaSLih78RV4ezpq
	 NFn1mOZV4aQDnOTCxsjz9TfXU68StlzPcMqrwdkg0XTFHw9CLke4TFwVr+mkxs8Lhv
	 wI5CeQPMLfS2Mc3f8z5Ev1coO3+olABJB0LVmirI2w4kdEcPn5SNnxz8vf2Dr6/2pB
	 bBJoWTlb95OvPpxyT+/Y6I0rLNTVJCQrUOO7rtAMgRV/5R4bjwwqjh1zRVPGy8TF6s
	 14lWfZXpnSmDpPrYbAtiIy1coTSr5IYW0H14o5uyIaoSpCWC0pEL3p/WT/imdl3ITS
	 LYVufo6RBtdWg==
Date: Sun, 1 Oct 2023 21:35:21 +0200
From: Simon Horman <horms@kernel.org>
To: Sonia Sharma <sosha@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, sosha@microsoft.com, kys@microsoft.com,
	mikelley@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v6] net: hv_netvsc: fix netvsc_send_completion
 to avoid multiple message length checks
Message-ID: <20231001193521.GV92317@kernel.org>
References: <1695849556-20746-1-git-send-email-sosha@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1695849556-20746-1-git-send-email-sosha@linux.microsoft.com>

On Wed, Sep 27, 2023 at 02:19:16PM -0700, Sonia Sharma wrote:
> From: Sonia Sharma <sonia.sharma@linux.microsoft.com>
> 
> The switch statement in netvsc_send_completion() is incorrectly validating
> the length of incoming network packets by falling through to the next case.
> Avoid the fallthrough. Instead break after a case match and then process
> the complete() call.
> The current code has not caused any known failures. But nonetheless, the
> code should be corrected as a different ordering of the switch cases might
> cause a length check to fail when it should not.
> 
> Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>

Reviewed-by: Simon Horman <horms@kernel.org>


