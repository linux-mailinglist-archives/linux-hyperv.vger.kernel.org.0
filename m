Return-Path: <linux-hyperv+bounces-3706-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2D2A146FE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 01:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0C9188E7E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 00:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46DB4430;
	Fri, 17 Jan 2025 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qff67ldd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B392925A62F;
	Fri, 17 Jan 2025 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737073049; cv=none; b=ZlAhOr/4934mXaDnOU67BG1osaSnuv85Qjou5G58ysrrcJfwZzpWY3VzaqpxDFItfCLtyL0bKg4KANu+kDMmlMF7TdRJ+eAcFcU1A85Ytkz9m+KIIoIRN49Agt8rr6qV9c19jrkVN8yA3CHyZ7FJaQeLtj4Ogc9g4umu2oe2dVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737073049; c=relaxed/simple;
	bh=a/+eIgBYU6NyUzeRruBfxpDtxqLfwtNUZUkOPdqV+qE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOvYNX+X0o3BfusX67eSPRRf6yFCxlqGRj3ZUSD58OYCmfWNoAnksIA4Oee0PBN1QVK/wHapTitsLDddOCaS7bIHTnbxp7u2bnjT5rJylxB51eUB1t+/K+roHGKo58lk+520BLDPnMlhELmsq9wEXvjH3rTyU9OvR0Db4I7BXd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qff67ldd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60EEC4CED6;
	Fri, 17 Jan 2025 00:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737073049;
	bh=a/+eIgBYU6NyUzeRruBfxpDtxqLfwtNUZUkOPdqV+qE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qff67lddtY+hcjOQuwaA234+g9CsctOX+DCNiwvdHTmX7clnPNfJ/InGVdoNGnZgX
	 S6phN9HpeUcUotBGrtfTnnolLmQtbIl4vtFL+a4YnCdY4sxZPO6oweIhTCzLYw/QZQ
	 Fmqq4ZD8Cg3qa0DGIE3Dnq5qtIZl8DpC7eDh8sua69mpnYW6/qwBrkZ3QxsfisVJn2
	 pAtLxeCbcojE03O/M/AoZsSNHv7sDEUlZmDGsb8Vs4WiHIPXKCiv0HoC2B+/21vhjy
	 qMDbp3wK0MGK2tiC748c35bHa2yipubJ0vD1NhbGhznHpY9/q0zQIpVU2YEuwMKuxH
	 Zo2MsNgSctslg==
Date: Thu, 16 Jan 2025 16:17:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hv_netvsc: Replace one-element array with flexible
 array member
Message-ID: <20250116161727.19a3bbb0@kernel.org>
In-Reply-To: <0927ebf9-db17-49f5-a188-e0d486ae4bda@linux.microsoft.com>
References: <20250116211932.139564-2-thorsten.blum@linux.dev>
	<0927ebf9-db17-49f5-a188-e0d486ae4bda@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 13:39:52 -0800 Roman Kisel wrote:
> On 1/16/2025 1:19 PM, Thorsten Blum wrote:
> > Replace the deprecated one-element array with a modern flexible array
> > member in the struct nvsp_1_message_send_receive_buffer_complete.
> > 
> > Use struct_size_t(,,1) instead of sizeof() to maintain the same size.  
> 
> Thanks!
> 
> > 
> > Compile-tested only.  
> 
> The code change looks good to me now. I'll build a VM with this change
> to clear my conscience (maybe the change triggers a compiler bug,
> however unlikely that sounds) before replying with any tags. Likely next
> Monday, but feel free to beat me to it, or perhaps, someone else will
> tag this as reviewed by them and/or tested by them.

Doesn't look like a real bug fix, so would be good to get some signal
soon. The merge window is soon so we'll likely close the trees very
very soon ..

