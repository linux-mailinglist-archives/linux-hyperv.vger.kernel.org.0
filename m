Return-Path: <linux-hyperv+bounces-7500-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5FBC502C0
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 02:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3FFE4E6F40
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 01:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14399221555;
	Wed, 12 Nov 2025 01:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6OJqJ2j"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DCD21A457;
	Wed, 12 Nov 2025 01:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762909720; cv=none; b=RooikhWgIWMA9gMTEeW1NW5GTkwGtSRjsN3Wk7KUbLF2te0fOq99JSPKaIP77b/jyWx7P2uoUzwkDwzm6ogofixhzANa1kyISFKEYRahewpW3MQL3Hvj6CdXwLSNT0SrIHQDZHk2JLHGP0a81fvYVI5YYpZjpdsK3/CoWDXFGO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762909720; c=relaxed/simple;
	bh=6i8DPHusq7iBz5T7AQ++bJHhaj2jmtcMe+HUMRFDASM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nbNkVVOA6bQDu0G0UI+k62HjjduhZSkjdtMYxKEeR/8EMw2lufdipOZq3CTNup8lULolI2C+J30RqqTw2MjbIOPiZYBQ48GwhXPLufc0gM/tAygnM0G1ukkbgzwx/ViF2NJh1DZ2RtpOEisqkMeGH/3lqNoSKqflihShqQn6KX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6OJqJ2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42079C4CEF5;
	Wed, 12 Nov 2025 01:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762909719;
	bh=6i8DPHusq7iBz5T7AQ++bJHhaj2jmtcMe+HUMRFDASM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i6OJqJ2jM81nRBtViQtU+aJefUBjhbK+gpRrIaRwwKk9KHidu/eOoI1o4kPxT/h9c
	 KGFXQmgi7r0K3bm26kxvw33Mmvx/Qk0PpS95nkbm1yiG0QXFUF6GwBxpNmAuMp4StL
	 MDSRvodXIVtedWCv58zoCp3mj55ntRfXg1nfURBHrxJrNqvA9Oaq4519Q0DThe9KuS
	 AtVvUPD0lBJnAETUPLy5QAVugQhmji5XUA7+AhhyACMMRAUVkgI+/luc6v78JFBkYi
	 SIaBDukd3PSbYHbW1C1UrvGbg0X8NbngwIYmuFMsc9Bmfh3L1nYN2t9jzb7+p680Ev
	 RAu7bwQ12FzWg==
Date: Tue, 11 Nov 2025 17:08:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, ssengar@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 gargaditya@microsoft.com
Subject: Re: [PATCH net-next v3 2/2] net: mana: Drop TX skb on
 post_work_request failure and unmap resources
Message-ID: <20251111170837.602904ee@kernel.org>
In-Reply-To: <1762848781-357-3-git-send-email-gargaditya@linux.microsoft.com>
References: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
	<1762848781-357-3-git-send-email-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 00:13:01 -0800 Aditya Garg wrote:
> Drop TX packets when posting the work request fails and ensure DMA
> mappings are always cleaned up.

drivers/net/ethernet/microsoft/mana/gdma_main.c:1303:23: warning: variable 'gc' set but not used [-Wunused-but-set-variable]
 1303 |         struct gdma_context *gc;
      |                              ^
-- 
pw-bot: cr

