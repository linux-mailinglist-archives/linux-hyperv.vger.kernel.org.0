Return-Path: <linux-hyperv+bounces-6255-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1330B05AC4
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 15:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10CED7A7BE6
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Jul 2025 13:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6341E2E041E;
	Tue, 15 Jul 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vG8xap+x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CABF2561AE;
	Tue, 15 Jul 2025 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584753; cv=none; b=WcuTSRb/rbs0Ij3CgFnPPrg9Xy/F1JyeX59BSOzIdGcmT+JP3eCZMp/L7FD+K3bTvzvbKCp+zZgHq8C+vtSdId10S/5TyLiHU9XN6GZXjMHrb3eTetopYPDIWGDoGCLW+Uo9+9ugd1g2v6o9LvGEEFyMJYVbBU08GkNAozip74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584753; c=relaxed/simple;
	bh=0uPpU45llipC3TzVqDMQ5evN4sRa1g4MKHiGLtm5jEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZLmWZ5IW0YJ7dgbePttZsNzNrLUIQ4RGEEPo6aPvhH8oohQpjFeGrV0yeRvYzsejF6ZuqrKJdWVmnuqe+IcLYZr0Buv9CLuLg0F2iBA1drfGkISa4Ix6htH9soabKm/0AotZiueF6WetImN4zN6H1C/7iVc0bkDKPjOGSCJC7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vG8xap+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F2AC4CEE3;
	Tue, 15 Jul 2025 13:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752584752;
	bh=0uPpU45llipC3TzVqDMQ5evN4sRa1g4MKHiGLtm5jEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vG8xap+xPani99WC7EezMokh7vHK7xaU73nUyI6x6jK3v2jEwl9hx+p0kvDxS6E+T
	 VRAfURHh72NhMJEHFyQBie+ArNzs6KztNn011inS+zewEb/VCU8mbrogOFRVK9OT1F
	 3PcWZskbZ9XmD+CP0YpY4rcFSIf8tuu3NUyNkB2vc4xpTPUayXDeniP5qsG3toEpql
	 APGb/pzZqRMnBC1D/94iC9dFaHNrO93pVYfT3up8JiMiUKgoH59f4wVgETVJaKgxwf
	 gIhj+5zf8e0VbRSpPm47rjMGQYATWXXwLvTbgiZ+fPGn0o+BW/2OpzybqFtaJ63DjF
	 QrzFlzRXBsnNg==
Date: Tue, 15 Jul 2025 14:05:47 +0100
From: Simon Horman <horms@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	haiyangz@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	cavery@redhat.com
Subject: Re: [PATCH net,v2] hv_netvsc: Switch VF namespace in netvsc_open
 instead
Message-ID: <20250715130547.GV721198@horms.kernel.org>
References: <1752511297-8817-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752511297-8817-1-git-send-email-haiyangz@linux.microsoft.com>

On Mon, Jul 14, 2025 at 09:41:37AM -0700, Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> The existing code move the VF NIC to new namespace when NETDEV_REGISTER is
> received on netvsc NIC. During deletion of the namespace,
> default_device_exit_batch() >> default_device_exit_net() is called. When
> netvsc NIC is moved back and registered to the default namespace, it
> automatically brings VF NIC back to the default namespace. This will cause
> the default_device_exit_net() >> for_each_netdev_safe loop unable to detect
> the list end, and hit NULL ptr:
> 
> [  231.449420] mana 7870:00:00.0 enP30832s1: Moved VF to namespace with: eth0
> [  231.449656] BUG: kernel NULL pointer dereference, address: 0000000000000010
> [  231.450246] #PF: supervisor read access in kernel mode
> [  231.450579] #PF: error_code(0x0000) - not-present page
> [  231.450916] PGD 17b8a8067 P4D 0 
> [  231.451163] Oops: Oops: 0000 [#1] SMP NOPTI
> [  231.451450] CPU: 82 UID: 0 PID: 1394 Comm: kworker/u768:1 Not tainted 6.16.0-rc4+ #3 VOLUNTARY 
> [  231.452042] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/21/2024
> [  231.452692] Workqueue: netns cleanup_net
> [  231.452947] RIP: 0010:default_device_exit_batch+0x16c/0x3f0
> [  231.453326] Code: c0 0c f5 b3 e8 d5 db fe ff 48 85 c0 74 15 48 c7 c2 f8 fd ca b2 be 10 00 00 00 48 8d 7d c0 e8 7b 77 25 00 49 8b 86 28 01 00 00 <48> 8b 50 10 4c 8b 2a 4c 8d 62 f0 49 83 ed 10 4c 39 e0 0f 84 d6 00
> [  231.454294] RSP: 0018:ff75fc7c9bf9fd00 EFLAGS: 00010246
> [  231.454610] RAX: 0000000000000000 RBX: 0000000000000002 RCX: 61c8864680b583eb
> [  231.455094] RDX: ff1fa9f71462d800 RSI: ff75fc7c9bf9fd38 RDI: 0000000030766564
> [  231.455686] RBP: ff75fc7c9bf9fd78 R08: 0000000000000000 R09: 0000000000000000
> [  231.456126] R10: 0000000000000001 R11: 0000000000000004 R12: ff1fa9f70088e340
> [  231.456621] R13: ff1fa9f70088e340 R14: ffffffffb3f50c20 R15: ff1fa9f7103e6340
> [  231.457161] FS:  0000000000000000(0000) GS:ff1faa6783a08000(0000) knlGS:0000000000000000
> [  231.457707] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  231.458031] CR2: 0000000000000010 CR3: 0000000179ab2006 CR4: 0000000000b73ef0
> [  231.458434] Call Trace:
> [  231.458600]  <TASK>
> [  231.458777]  ops_undo_list+0x100/0x220
> [  231.459015]  cleanup_net+0x1b8/0x300
> [  231.459285]  process_one_work+0x184/0x340
> 
> To fix it, move the VF namespace switching code from the NETDEV_REGISTER
> event handler to netvsc_open().
> 
> Cc: stable@vger.kernel.org
> Cc: cavery@redhat.com
> Fixes: 4c262801ea60 ("hv_netvsc: Fix VF namespace also in synthetic NIC NETDEV_REGISTER event")
> Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>

With this change do we go back to the situation that existed prior
to the cited patch? Quoting the cited commit:

    The existing code moves VF to the same namespace as the synthetic NIC
    during netvsc_register_vf(). But, if the synthetic device is moved to a
    new namespace after the VF registration, the VF won't be moved together.

Or perhaps not because if synthetic device is moved then, in practice, it
will subsequently be reopened? (Because it is closed as part of the move
to a different netns?)

I am unsure.

