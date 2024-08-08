Return-Path: <linux-hyperv+bounces-2753-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A589A94C04C
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 16:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6FF31C25529
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Aug 2024 14:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC618C346;
	Thu,  8 Aug 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9ggPhsj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64189B674;
	Thu,  8 Aug 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128906; cv=none; b=nWhyOntdLISmutJwg2BI0N6O6WSNhk+gzfwyczr0HvHzAhq4xPKWNeaE9lps6kjK9u/+Vmz6ef5Pg5DgJhiorp6v4XAU8lv19KgruXT+H/69bjzUhIUwovzqPO5bz06Txe86AV8sn5ttzwn5Ytr+hIZi96sFL0H/jeNGkbYCcFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128906; c=relaxed/simple;
	bh=9wj+Sw1FGnzP/7OJw4pkUts8rOKnpd8OWHW4ZPjweFA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgFpO+4mrdzr0AHIo1TqgBLH3RPIaF1DVmbSMAIHnvP6SHNP7LCZwDA+ovHITpPXr9Qsq/Q8VAHAwKT+rglJuyOhCHwXaURxcI/YEx69Ku18NY7WirmJlBSlWrtgvaKGmjXlEV1YrWAAD3WzZO4u89k0i+N2S00d+7xEsrhOzZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9ggPhsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D63C32782;
	Thu,  8 Aug 2024 14:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723128905;
	bh=9wj+Sw1FGnzP/7OJw4pkUts8rOKnpd8OWHW4ZPjweFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E9ggPhsjjxGhFYrvyL35Cqxdz3a2aj6OT2cebRHYHe5e8iD3P1mfsuaOM/w5SS82V
	 GQxdH2HDAT+nz6/UkhP5GbkbNCy1uhs3SkakapAuC7IGQNoR81/nxpHSR5nXbOZlwS
	 b6Kp9ImIazIHdMpwdXIaUwO5vn0iGHsSAB4PJSnnfRiH/YRe2sxm81arjzUt5TfTqG
	 L7Q2sqgxqAdyGXOrYbTnw+4qh/uyki0Wqy+6AL7yEVnw5saWGAOGNFm+WsJVaupjDk
	 /+uv5XLI93oLGXjcSV7Ur+IP2DdqoTRQQhFYtYCkOJDNo3u0ixMeDE7/gR1RSDsp8D
	 qZamv4PQ6jWzw==
Date: Thu, 8 Aug 2024 07:55:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: longli@microsoft.com, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shradha
 Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>,
 Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: mana: Fix doorbell out of order violation
 and avoid unnecessary doorbell rings
Message-ID: <20240808075504.660a5905@kernel.org>
In-Reply-To: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
References: <1723072626-32221-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  7 Aug 2024 16:17:06 -0700 longli@linuxonhyperv.com wrote:
> Cc: stable@vger.kernel.org
> Fixes: e1b5683ff62e ("net: mana: Move NAPI from EQ to CQ")
> 
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

no empty lines between trailers please

