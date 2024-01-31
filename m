Return-Path: <linux-hyperv+bounces-1485-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F908433EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 03:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F181F280A3
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 02:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16215697;
	Wed, 31 Jan 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLurfqV3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21A566B;
	Wed, 31 Jan 2024 02:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668160; cv=none; b=IjL156YLHjoonktwONE0asgCrBKA4J1dU5gq03Ml4Gq4ovUAtB9i5T4jRU1z2DK75phL75SXWBHU+J1spHk+5QycSk9KOI65IKW3utT8yHK3bwS0Yc8pZob//tFv1/nhFcbRGCh9a3RAwb5YpBDyLhlP5M5TU332G/lTv310KfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668160; c=relaxed/simple;
	bh=910yomUN6JMNLUnTqhPO0ELsf6H1TuwMgNISeOv85TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbhrWNTkLcRFgcGXGUuNLvMOibuUev9ZWjhug+GBSRUSo9Li6guKjbuVMgx4Rt8UU7z0vlDxJAogIyNm2OG1DcbxD5q0W7oGrR1VAzVZmyPC42Iw0h/DlImRrAXhs4WhQKCqH0R6S+9oyA9dN3wen3q1MrUPHuEcBliwAoE5Ls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLurfqV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F628C433C7;
	Wed, 31 Jan 2024 02:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668159;
	bh=910yomUN6JMNLUnTqhPO0ELsf6H1TuwMgNISeOv85TQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HLurfqV3AipRAOjQ/059RQFQH/vQgAGmjPNBiIMB7Na59959hxOqppqrYqm4ZS/BA
	 JtD09BAIkJs4QpDrzx4DW5v3MK93BKgRaS4aXNlr4FMNB3GTWpNVgOU1zFITj48lO7
	 rQClZxN4fYz1zvTVZ3Uc9DpkGHOx6f8jytvpv+CZtptKylgVx7G6pf82VtpF7O9sgE
	 YlhsZLE4v+nPowLxAl0tmRPsvfmPk9KJRSyWusy8KqFOfR5vkvpfzV0qoqTscqbA0J
	 CuqObP3HXjyDDDuTDsX95oSkhtU3v7uRQD9G/39+0srswqjQzIgcBr1Lmny/zD0LOl
	 eO73fcf+Ypg8A==
Date: Tue, 30 Jan 2024 18:29:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Wojciech
 Drewek <wojciech.drewek@intel.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shradhagupta@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Message-ID: <20240130182914.25df5128@kernel.org>
In-Reply-To: <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 23:18:55 -0800 Shradha Gupta wrote:
> If hv_netvsc driver is removed and reloaded, the NET_DEVICE_REGISTER
> handler cannot perform VF register successfully as the register call
> is received before netvsc_probe is finished. This is because we
> register register_netdevice_notifier() very early(even before
> vmbus_driver_register()).
> To fix this, we try to register each such matching VF( if it is visible
> as a netdevice) at the end of netvsc_probe.
> 
> Cc: stable@vger.kernel.org
> Fixes: 85520856466e ("hv_netvsc: Fix race of register_netdevice_notifier and VF register")
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Does not seem to apply to net/main, please respin

