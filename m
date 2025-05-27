Return-Path: <linux-hyperv+bounces-5665-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE62AC490A
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 09:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32339188F011
	for <lists+linux-hyperv@lfdr.de>; Tue, 27 May 2025 07:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0521F91C7;
	Tue, 27 May 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrgbPE5q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778DB1F582A;
	Tue, 27 May 2025 07:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748329802; cv=none; b=I7ZraOQPgK/6ZrkTYCDFZQh+j16WLFHrIjDcSlWT0jagLx1EZQ223qDviulneK/1rcChj3UbU4YC3RYx3FHkfnfFVFmztF2F07LyEogJFAElW9MwqSoh7als3gPD0drlzShhg6gcSZiKkaY9BbpfEbp6x9uvRy32PnFiXAnbcn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748329802; c=relaxed/simple;
	bh=xzocwWaxsjqNHkYeqf5FJ8YRMOeK+a1p789rrCvbcaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5b7USDQk5JlzMOoAKyo2MlPbOaD4RqQzJ5PzHtS7KOYu0L0yUaBrZg+AaA+vorsECI0OLepHkR/N7ougQOqm2+JMen3B3NrnI3ym4kmKr9TT78+SWUE+07ychReITS2gfKrWfpAyOBjx555DPzxxVrG90S7WruaSjqVREd3FAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrgbPE5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C58C4CEEA;
	Tue, 27 May 2025 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748329801;
	bh=xzocwWaxsjqNHkYeqf5FJ8YRMOeK+a1p789rrCvbcaI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UrgbPE5q4jkBMJPBz0vBsgfEVAEjT8rQtASyZM66x7/l2vsgjoMEDe4YFAyOw2/Fp
	 MYFicSzJNkJQPk13KM7yMcj34YPqaP9hbPhluW66y0Q7O17srHfP2Tun7T5CVpbYve
	 C7RK0i5ryfbfDxL4v2+e/lvDC3x1SVtXtlAbOQit4jH/c5Hj8R+cE0cUWFR28YwGUN
	 IidlV185WTMCyWB2ReejMkcYX05KWvxhPJvpL2VH73QkrMNvRFtsM2aADgK2g9Y01J
	 N+hsNnfYc4LXpAhl/NnN01iegKwJzty3MQVJGETldQvNIRcTj350ps34FPuwKVTiS/
	 3WU2iphe/13Iw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D18380AAE2;
	Tue, 27 May 2025 07:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/8] net: Convert dev_set_mac_address() to struct
 sockaddr_storage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174832983626.1188942.1099978775563244121.git-patchwork-notify@kernel.org>
Date: Tue, 27 May 2025 07:10:36 +0000
References: <20250521204310.it.500-kees@kernel.org>
In-Reply-To: <20250521204310.it.500-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: kuniyu@amazon.com, willemdebruijn.kernel@gmail.com,
 martin.petersen@oracle.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michael.christie@oracle.com, mgurtovoy@nvidia.com, mlombard@redhat.com,
 d.bogdanov@yadro.com, mingzhe.zou@easystack.cn, christophe.leroy@csgroup.eu,
 horms@kernel.org, linux@treblig.org, gustavoars@kernel.org,
 andrew+netdev@lunn.ch, sdf@fomichev.me, cratiu@nvidia.com,
 leiyang@redhat.com, idosch@nvidia.com, sam@mendozajonas.com,
 fercerpav@gmail.com, alex.aring@gmail.com, stefan@datenfreihafen.org,
 miquel.raynal@bootlin.com, hayeswang@realtek.com, dianders@chromium.org,
 grundler@chromium.org, jv@jvosburgh.net, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 jiri@resnulli.us, jasowang@redhat.com, vladimir.oltean@nxp.com,
 florian.fainelli@broadcom.com, kory.maincent@bootlin.com, glipus@gmail.com,
 olek2@wp.pl, phahn-oss@avm.de, ebiggers@google.com, ardb@kernel.org,
 viro@zeniv.linux.org.uk, ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 shaw.leon@gmail.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, netdev@vger.kernel.org,
 linux-wpan@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 13:46:08 -0700 you wrote:
> v2:
>   - add conversion of dev_set_mac_address_user() (kuniyu)
>   - fix missed sockaddr/sockaddr_storage conversion (kuba)
>  v1: https://lore.kernel.org/all/20250520222452.work.063-kees@kernel.org/
> 
> Hi,
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/8] net: core: Convert inet_addr_is_any() to sockaddr_storage
    (no matching commit)
  - [net-next,v2,2/8] net: core: Switch netif_set_mac_address() to struct sockaddr_storage
    https://git.kernel.org/netdev/net-next/c/161972650d67
  - [net-next,v2,3/8] net/ncsi: Use struct sockaddr_storage for pending_mac
    https://git.kernel.org/netdev/net-next/c/db586cad6f45
  - [net-next,v2,4/8] ieee802154: Use struct sockaddr_storage with dev_set_mac_address()
    https://git.kernel.org/netdev/net-next/c/7da6117ea144
  - [net-next,v2,5/8] net: usb: r8152: Convert to use struct sockaddr_storage internally
    https://git.kernel.org/netdev/net-next/c/79deac8d538d
  - [net-next,v2,6/8] net: core: Convert dev_set_mac_address() to struct sockaddr_storage
    (no matching commit)
  - [net-next,v2,7/8] rtnetlink: do_setlink: Use struct sockaddr_storage
    https://git.kernel.org/netdev/net-next/c/6b12e0a3c3c9
  - [net-next,v2,8/8] net: core: Convert dev_set_mac_address_user() to use struct sockaddr_storage
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



