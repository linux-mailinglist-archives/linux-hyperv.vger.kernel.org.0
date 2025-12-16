Return-Path: <linux-hyperv+bounces-8042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66297CC555A
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 23:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A67A300BB95
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Dec 2025 22:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A4313E3B;
	Tue, 16 Dec 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gQBDsMYm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591752DECC2;
	Tue, 16 Dec 2025 22:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765923691; cv=none; b=Pt0TfGWVISoGbR2q8JDp5Qe6tT1/Sr0XeGWS+YPyx29n0NdqM9UTDOVKhTyXh/0kfOlxxoQu8oUs/At7MWuQJ/PiK2E8xFj+8QlBzXX29DnmCdFzKFOuCt0j4sfBBE6n9RBxLUMudd5dVO8xuG1P/TuYEc0xvxNP9iATyPPqK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765923691; c=relaxed/simple;
	bh=GljtvhY3xPUVL34Rl0YQZ3nbIGjjH+GA+gXuttSg1/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nLz2W5IJnRSB39bPumkA5EpfRIvHFnnoWWv2fjkKJaXlbMkDJkPVCADvv6ho2MecEQMAhmVUaSjwUNws/ApipGFNYbtsS1SXnHKzL5VunzdKzYYdETFqhiz7qV58OL7qyHW64gZ9+7/SS4Uc5hV5Zv2Sy/FkaMjb7+GFNZJxles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gQBDsMYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1492C4CEF1;
	Tue, 16 Dec 2025 22:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765923690;
	bh=GljtvhY3xPUVL34Rl0YQZ3nbIGjjH+GA+gXuttSg1/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gQBDsMYmOBZWasH/AyR/E/KE5ZkL65qDQn0m6aYD9mWMJ7AN3siaYlRLr3FOrxEcM
	 8zY8ptFQIAqcGoyCWGxf3pA/dFkQoRJTXFmuqY8BTSGFQ2p/nFJ7bB6k9Ni5opKI1E
	 haczagZYdqF9ZWSP45gGCvYMu6sZKX4OOQ3QgyWxqpUStDtnPbltHIAVrlfi4Ld0nO
	 h603n1olih7EybdZrp4kDWvdgKnVKkBMAPZn3v5cHRbxw6tlpED87JSOquusWgZhp2
	 2e5r7SAdlKjAvfGgWzz+8jbesPxdMPjR/OeoFX+cruUlh3xEybEqneAImLXr1XvByn
	 txWL8yVEN6mWA==
Date: Tue, 16 Dec 2025 22:21:29 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Stansialv Kinsburskii <skinsburskii@linux.miscrosoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Anatol Belski <anbelski@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sean Christopherson <seanjc@google.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: hide x86-specific functions on arm64
Message-ID: <20251216222129.GA1300707@liuwe-devbox-debian-v2.local>
References: <20251216213619.115259-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216213619.115259-1-arnd@kernel.org>

On Tue, Dec 16, 2025 at 10:36:12PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The hv_sleep_notifiers_register() and hv_machine_power_off() functions are
> only called and declared on x86, but cause a warning on arm64:
> 
> drivers/hv/mshv_common.c:210:6: error: no previous prototype for 'hv_sleep_notifiers_register' [-Werror=missing-prototypes]
>   210 | void hv_sleep_notifiers_register(void)
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/hv/mshv_common.c:224:6: error: no previous prototype for 'hv_machine_power_off' [-Werror=missing-prototypes]
>   224 | void hv_machine_power_off(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> 
> Hide both inside of an #ifdef block.
> 
> Fixes: f0be2600ac55 ("mshv: Use reboot notifier to configure sleep state")
> Fixes: 615a6e7d83f9 ("mshv: Cleanly shutdown root partition with MSHV")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd. I have a queued up a patch which make available the
declarations to arm64. Let me think about whether to use your patch
instead.

Anyway, this issue will be fixed one way or the other once I send a PR
to Linus.

Wei

> ---
>  drivers/hv/mshv_common.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
> index 58027b23c206..63f09bb5136e 100644
> --- a/drivers/hv/mshv_common.c
> +++ b/drivers/hv/mshv_common.c
> @@ -142,6 +142,7 @@ int hv_call_get_partition_property(u64 partition_id,
>  }
>  EXPORT_SYMBOL_GPL(hv_call_get_partition_property);
>  
> +#ifdef CONFIG_X86
>  /*
>   * Corresponding sleep states have to be initialized in order for a subsequent
>   * HVCALL_ENTER_SLEEP_STATE call to succeed. Currently only S5 state as per
> @@ -237,3 +238,4 @@ void hv_machine_power_off(void)
>  	BUG();
>  
>  }
> +#endif
> -- 
> 2.39.5
> 

