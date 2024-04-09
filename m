Return-Path: <linux-hyperv+bounces-1944-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D97889CFE0
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 03:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57711285B1E
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 01:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D6F79FD;
	Tue,  9 Apr 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd2hHsiK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC12C79CC;
	Tue,  9 Apr 2024 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712626620; cv=none; b=pQ2cUbhvIzUVI209GVbmKPAg46jqUBQfKORs+b/4BCLU/yGmpXtLRaGQsiDppGofdOVc78CYhxPwPFahN6b/DEwUYHQirxKiEiibhyWqZtgGyi1XJ6LsDzrqW1kKe5WlIHiQKACTSUI2QcCbYAihWWZ83/R0quJ5Pv0/ckLVWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712626620; c=relaxed/simple;
	bh=QiC3HcFltPSH+8IPm65nID/AeFgYSMHRNQTGacGvZOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlPqDd7RN0xVGYqCyLckxZdSrBruv7BJqGjA5gzZYl0lhggzNEGg6kQw1XhVPIc/gehyogbbjW6BMZcEFRZABnOSTrNU//o3hjpm3bnxDMD0M2/lereEiUP0sMev4hyeV/Rog7edsb/pGGxWrtXDZvYbNP8bFYBSy4lF85yVdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd2hHsiK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F4070C433F1;
	Tue,  9 Apr 2024 01:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712626620;
	bh=QiC3HcFltPSH+8IPm65nID/AeFgYSMHRNQTGacGvZOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hd2hHsiKY2UEOVT1Qo8Is9fP+8NlV9vFq1pFkwShK1QSb4PyHre9do08np2q02862
	 9enyc9/neSjA2H8IQzUSAIuI0Jg9bInVlMeeSkFbjKLFEkKfXYH3E23E8aaf0Mgc47
	 aozIVu8MqpYNnSRp5AIC7reAeGwKCQsOGD/kFGd3AOSu/uGW82z66dTTQ8ERoCjF1O
	 8ALULnvzgVnkSN/RrFC3K/qe6yD1Ze5FMw/FCgYVYiAX7yZ+1ldaqB21TVvl3/CHzv
	 C6fWmup12uvWZv2IePJduWEJq1PkVuk2mlhVheHPL97CX/t0wZPBdkIeeQp4C3mDsX
	 Uuok8x4qQIcNQ==
Date: Mon, 8 Apr 2024 18:36:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, Long Li <longli@microsoft.com>,
 Ajay Sharma <sharmaajay@microsoft.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Kees Cook <keescook@chromium.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shradha Gupta <shradhagupta@linux.microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, linux-rdma@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID: <20240408183657.7fb6cc35@kernel.org>
In-Reply-To: <20240408110730.GE8764@unreal>
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
	<20240408110730.GE8764@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Apr 2024 14:07:30 +0300 Leon Romanovsky wrote:
> Jakub, do you want shared branch for this series or should I take
> everything through RDMA tree as netdev part is small enough?

Shared branch would be good. Ed has some outstanding patches 
to refactor the ethtool RSS API.

