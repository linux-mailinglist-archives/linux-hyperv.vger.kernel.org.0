Return-Path: <linux-hyperv+bounces-3669-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3A2A0A044
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2025 03:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 292A43AA5D3
	for <lists+linux-hyperv@lfdr.de>; Sat, 11 Jan 2025 02:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C4D41C71;
	Sat, 11 Jan 2025 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AurIVOLp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405A17BA9;
	Sat, 11 Jan 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736562014; cv=none; b=gOy55Hf1bc6wfIFmO36O0PN2vh/iA6VPAARPT1y4gSPzJPrCm3L+zsnASAtxQBn9wlg4TMNQV+M4B4zLhb9yFkF7s50uNjk+VzY3pTj/0WRxOoXT2qeMNDwwT7FJlFLJdKR7DfGupvKbu6ZPPcndChg3jme3eaGq2s/QEm2jZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736562014; c=relaxed/simple;
	bh=/YzOyCCjnowMGeeKkVtKlwiR7xf5IHuLvAHARdpgdcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OimlcCaOmynaYf866/saReFnThjGk1m+6O6gxkgXtnR0UmAFVyKYqLc/CaYrDvxgQqM1R9w3N5htlBZZAVO8pfBGifRsytDp1Jp31iCBGL0d/1KjwrjmUcmxvLDetBYz8Lvt7EtqiG+i/xlCRWukvEsfvOtKbXUo2pFYy0ZyE0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AurIVOLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC75C4CED6;
	Sat, 11 Jan 2025 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736562013;
	bh=/YzOyCCjnowMGeeKkVtKlwiR7xf5IHuLvAHARdpgdcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AurIVOLpRjBMPRSw4dPuJImZGIvB9TxTmCdchOPN+Vh/Xi5hckoMVFhk+7bb1cG+I
	 fIQ01nEOjPn8h4UiQNlqTGNh/yIk57uxIb5yWh0E+WLLSvXwR6sUnppll+fz0W5nm9
	 xizUTg7X+22513JVo9/VzOCghvYTZ0c6lzsZWxJK5IZhM2UAv082awydrvWZl/Lscu
	 /DLltlzoN52mHIwYu4CIjl2zYfcbrB+dq8a1yrirrd8rym9Qgj66v9zyPb5WW1I0S2
	 N0kWFduuhrViBX79mgdNqpfXhtP8PRsfzdikdFJ/MtDCSFK3nA1cyr03a7rnxGMRFI
	 oirK/7yDXQApg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE33380AA57;
	Sat, 11 Jan 2025 02:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mana: Cleanup "mana" debugfs dir after cleanup of
 all children
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173656203552.2269660.2980906900507865213.git-patchwork-notify@kernel.org>
Date: Sat, 11 Jan 2025 02:20:35 +0000
References: <1736398991-764-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1736398991-764-1-git-send-email-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 longli@microsoft.com, kotaranov@microsoft.com,
 schakrabarti@linux.microsoft.com, yury.norov@gmail.com,
 michal.swiatkowski@linux.intel.com, kalesh-anakkur.purayil@broadcom.com,
 mlevitsk@redhat.com, peterz@infradead.org, shradhagupta@microsoft.com,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 21:03:11 -0800 you wrote:
> In mana_driver_exit(), mana_debugfs_root gets cleanup before any of it's
> children (which happens later in the pci_unregister_driver()).
> Due to this, when mana driver is configured as a module and rmmod is
> invoked, following stack gets printed along with failure in rmmod command.
> 
> [ 2399.317651] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [ 2399.318657] #PF: supervisor write access in kernel mode
> [ 2399.319057] #PF: error_code(0x0002) - not-present page
> [ 2399.319528] PGD 10eb68067 P4D 0
> [ 2399.319914] Oops: Oops: 0002 [#1] SMP NOPTI
> [ 2399.320308] CPU: 72 UID: 0 PID: 5815 Comm: rmmod Not tainted 6.13.0-rc5+ #89
> [ 2399.320986] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 09/28/2024
> [ 2399.321892] RIP: 0010:down_write+0x1a/0x50
> [ 2399.322303] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 55 48 89 e5 41 54 49 89 fc e8 9d cd ff ff 31 c0 ba 01 00 00 00 <f0> 49 0f b1 14 24 75 17 65 48 8b 05 f6 84 dd 5f 49 89 44 24 08 4c
> [ 2399.323669] RSP: 0018:ff53859d6c663a70 EFLAGS: 00010246
> [ 2399.324061] RAX: 0000000000000000 RBX: ff1d4eb505060180 RCX: ffffff8100000000
> [ 2399.324620] RDX: 0000000000000001 RSI: 0000000000000064 RDI: 0000000000000098
> [ 2399.325167] RBP: ff53859d6c663a78 R08: 00000000000009c4 R09: ff1d4eb4fac90000
> [ 2399.325681] R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000098
> [ 2399.326185] R13: ff1d4e42e1a4a0c8 R14: ff1d4eb538ce0000 R15: 0000000000000098
> [ 2399.326755] FS:  00007fe729570000(0000) GS:ff1d4eb2b7200000(0000) knlGS:0000000000000000
> [ 2399.327269] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2399.327690] CR2: 0000000000000098 CR3: 00000001c0584005 CR4: 0000000000373ef0
> [ 2399.328166] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2399.328623] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 2399.329055] Call Trace:
> [ 2399.329243]  <TASK>
> [ 2399.329379]  ? show_regs+0x69/0x80
> [ 2399.329602]  ? __die+0x25/0x70
> [ 2399.329856]  ? page_fault_oops+0x271/0x550
> [ 2399.330088]  ? psi_group_change+0x217/0x470
> [ 2399.330341]  ? do_user_addr_fault+0x455/0x7b0
> [ 2399.330667]  ? finish_task_switch.isra.0+0x91/0x2f0
> [ 2399.331004]  ? exc_page_fault+0x73/0x160
> [ 2399.331275]  ? asm_exc_page_fault+0x27/0x30
> [ 2399.343324]  ? down_write+0x1a/0x50
> [ 2399.343631]  simple_recursive_removal+0x4d/0x2c0
> [ 2399.343977]  ? __pfx_remove_one+0x10/0x10
> [ 2399.344251]  debugfs_remove+0x45/0x70
> [ 2399.344511]  mana_destroy_rxq+0x44/0x400 [mana]
> [ 2399.344845]  mana_destroy_vport+0x54/0x1c0 [mana]
> [ 2399.345229]  mana_detach+0x2f1/0x4e0 [mana]
> [ 2399.345466]  ? ida_free+0x150/0x160
> [ 2399.345718]  ? __cond_resched+0x1a/0x50
> [ 2399.345987]  mana_remove+0xf4/0x1a0 [mana]
> [ 2399.346243]  mana_gd_remove+0x25/0x80 [mana]
> [ 2399.346605]  pci_device_remove+0x41/0xb0
> [ 2399.346878]  device_remove+0x46/0x70
> [ 2399.347150]  device_release_driver_internal+0x1e3/0x250
> [ 2399.347831]  ? klist_remove+0x81/0xe0
> [ 2399.348377]  driver_detach+0x4b/0xa0
> [ 2399.348906]  bus_remove_driver+0x83/0x100
> [ 2399.349435]  driver_unregister+0x31/0x60
> [ 2399.349919]  pci_unregister_driver+0x40/0x90
> [ 2399.350492]  mana_driver_exit+0x1c/0xb50 [mana]
> [ 2399.351102]  __do_sys_delete_module.constprop.0+0x184/0x320
> [ 2399.351664]  ? __fput+0x1a9/0x2d0
> [ 2399.352200]  __x64_sys_delete_module+0x12/0x20
> [ 2399.352760]  x64_sys_call+0x1e66/0x2140
> [ 2399.353316]  do_syscall_64+0x79/0x150
> [ 2399.353813]  ? syscall_exit_to_user_mode+0x49/0x230
> [ 2399.354346]  ? do_syscall_64+0x85/0x150
> [ 2399.354816]  ? irqentry_exit+0x1d/0x30
> [ 2399.355287]  ? exc_page_fault+0x7f/0x160
> [ 2399.355756]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [ 2399.356302] RIP: 0033:0x7fe728d26aeb
> [ 2399.356776] Code: 73 01 c3 48 8b 0d 45 33 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 15 33 0f 00 f7 d8 64 89 01 48
> [ 2399.358372] RSP: 002b:00007ffff954d6f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
> [ 2399.359066] RAX: ffffffffffffffda RBX: 00005609156cc760 RCX: 00007fe728d26aeb
> [ 2399.359779] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00005609156cc7c8
> [ 2399.360535] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> [ 2399.361261] R10: 00007fe728dbeac0 R11: 0000000000000206 R12: 00007ffff954d950
> [ 2399.361952] R13: 00005609156cc2a0 R14: 00007ffff954ee5f R15: 00005609156cc760
> [ 2399.362688]  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: mana: Cleanup "mana" debugfs dir after cleanup of all children
    https://git.kernel.org/netdev/net/c/eaeea5028fa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



