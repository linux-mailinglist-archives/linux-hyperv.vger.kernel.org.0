Return-Path: <linux-hyperv+bounces-403-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFF57B5A49
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id C1BCA282D36
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A801F163;
	Mon,  2 Oct 2023 18:40:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B41DA4D;
	Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3C9CC433C9;
	Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696272030;
	bh=6KsLZI9g7UhiN89nAcewKJ5x/HxWt4mFru++XEczoDg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kl1bxsepo+ybIiREqjgx6wx0ShnxoUpHhOb8jw0rJC74J5TAO1gXryRFhSr8JahB/
	 /U1aL71EW62ZKhgkUaTwq9dYMPVnXluHHp8RfWlW/Fnl9xoRLQo05UmgxLgYOHDSnY
	 3HaLBufuykE0Ga8nAS2DRgiVfBkDp9jrO99Of5B2PPzAw8vdWyaWr9hPGW/q2rGQbz
	 2zEGRxCOI8Wa53iD7jmbL0foJ3xzr489GnEki+zvjJQnvfGcx8xlSfUq4yB20KHE6r
	 jcnLoUwUjTGvxMf1j53okC4H8YotaXjn6zPVplQyypMYcNxtstzlnfG07Fx9eGxmVM
	 UmYqlnBxHMSsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85DCAE632CE;
	Mon,  2 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/14] Batch 1: Annotate structs with __counted_by
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169627203054.11990.6492371681347182041.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 18:40:30 +0000
References: <20230922172449.work.906-kees@kernel.org>
In-Reply-To: <20230922172449.work.906-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: kuba@kernel.org, jhs@mojatatu.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com,
 martin.lau@kernel.org, gustavoars@kernel.org, ast@kernel.org,
 yisen.zhuang@huawei.com, salil.mehta@huawei.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 sharmaajay@microsoft.com, elder@kernel.org, pshelar@ovn.org,
 zhangshaokun@hisilicon.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 dev@openvswitch.org, linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 22 Sep 2023 10:28:42 -0700 you wrote:
> Hi,
> 
> This is the batch 1 of patches touching netdev for preparing for
> the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> [...]

Here is the summary with links:
  - [01/14] ipv4: Annotate struct fib_info with __counted_by
    https://git.kernel.org/netdev/net-next/c/5b98fd5dc1e3
  - [02/14] ipv4/igmp: Annotate struct ip_sf_socklist with __counted_by
    https://git.kernel.org/netdev/net-next/c/210d4e9c732f
  - [03/14] ipv6: Annotate struct ip6_sf_socklist with __counted_by
    https://git.kernel.org/netdev/net-next/c/5d22b6528073
  - [04/14] net: hns: Annotate struct ppe_common_cb with __counted_by
    https://git.kernel.org/netdev/net-next/c/5b829c8460ae
  - [05/14] net: enetc: Annotate struct enetc_int_vector with __counted_by
    https://git.kernel.org/netdev/net-next/c/dd8e215ea9a8
  - [06/14] net: hisilicon: Annotate struct rcb_common_cb with __counted_by
    https://git.kernel.org/netdev/net-next/c/2290999d278e
  - [07/14] net: mana: Annotate struct mana_rxq with __counted_by
    https://git.kernel.org/netdev/net-next/c/a3d7a1209bbb
  - [08/14] net: ipa: Annotate struct ipa_power with __counted_by
    https://git.kernel.org/netdev/net-next/c/20551ee45d7d
  - [09/14] net: mana: Annotate struct hwc_dma_buf with __counted_by
    https://git.kernel.org/netdev/net-next/c/59656519763d
  - [10/14] net: openvswitch: Annotate struct dp_meter_instance with __counted_by
    https://git.kernel.org/netdev/net-next/c/e7b34822fa4d
  - [11/14] net: enetc: Annotate struct enetc_psfp_gate with __counted_by
    https://git.kernel.org/netdev/net-next/c/93bc6ab6b19d
  - [12/14] net: openvswitch: Annotate struct dp_meter with __counted_by
    https://git.kernel.org/netdev/net-next/c/16ae53d80c00
  - [13/14] net: tulip: Annotate struct mediatable with __counted_by
    https://git.kernel.org/netdev/net-next/c/0d01cfe5aaaf
  - [14/14] net: sched: Annotate struct tc_pedit with __counted_by
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



