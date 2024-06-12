Return-Path: <linux-hyperv+bounces-2404-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8DA905AAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 20:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4296F1F22AA9
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Jun 2024 18:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319D138F98;
	Wed, 12 Jun 2024 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJRfooWj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F248820DF7;
	Wed, 12 Jun 2024 18:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216447; cv=none; b=EPy7nG7BCzGffmcDSrG8tBm3/vhkEwSKqlypsahglCgemEgq5hqnBs9AJZaB7KYvgQpaw/ZlLNpmR0/wsKKR471BAp7UEIw4NdlcX0P+Mz29lx3OkS9Df5vz9RztVevh1xu4nPi8QbRg9PDxPSRosSQlRl0Z4d9x8SFSC2VWyrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216447; c=relaxed/simple;
	bh=arXJKii7hZO7vb4B/vvN+V1nOiJPnwFUFK+yxQZsqQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WiEI8QLd6yXVdj9wNwIGgMO8lZXzxb4Fti0wgZyCfR3ZUN00gbWbi4LacmsKYpgzTJide962ymg2DsfCCK/i+fF3n8Ip0xd7cjiNExrpkY+QXP/qYVoN8/q5xXUj/Zv4PMLEDAJNtTdBxiiA1/9kVwMbyBajhe+ZVtqO3QQfwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJRfooWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F332CC116B1;
	Wed, 12 Jun 2024 18:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718216446;
	bh=arXJKii7hZO7vb4B/vvN+V1nOiJPnwFUFK+yxQZsqQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HJRfooWjtcllpqykEnyB0p3CzWNiAY3VMVaTGyZMfLl0+Zv5lLVZKHr28vDla+jzy
	 3hLtnhklRrH4djyDuE/+XyIHfjmrqLtrvuIB/pOVyec3A7JszCBBux91+NOpjGgzdD
	 paA9gawZMJTPjiIBL8DGRUQ70yTTVvAgZ45osiWMwuyM85nEJ3pxNO6S2rdoU1oynH
	 9Ye1pQIwKNZjeGrkQ5caAFbZQveXWUISbQEgaQCP5hgJyw+up5JuZGUe1cWmkVrsuG
	 cMPP2WXwAsN/rs7hKit2CVN0ZKSOhRUfhOkTTbDfRWVXHT9tq/92mxBJXi4x4ZM+Iz
	 Ym4ZrINN9jnRA==
From: Leon Romanovsky <leon@kernel.org>
To: linux-hardening@vger.kernel.org, netdev@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, 
 Ahmed Zaki <ahmed.zaki@intel.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
 Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Haiyang Zhang <haiyangz@microsoft.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Long Li <longli@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>, 
 Kees Cook <kees@kernel.org>
In-Reply-To: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1718015319-9609-1-git-send-email-shradhagupta@linux.microsoft.com>
Subject: Re: [PATCH net-next v4] net: mana: Allow variable size indirection
 table
Message-Id: <171821644166.505049.8840755139752392962.b4-ty@kernel.org>
Date: Wed, 12 Jun 2024 21:20:41 +0300
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev


On Mon, 10 Jun 2024 03:28:39 -0700, Shradha Gupta wrote:
> Allow variable size indirection table allocation in MANA instead
> of using a constant value MANA_INDIRECT_TABLE_SIZE.
> The size is now derived from the MANA_QUERY_VPORT_CONFIG and the
> indirection table is allocated dynamically.
> 
> 

Applied, thanks!

[1/1] net: mana: Allow variable size indirection table
      https://git.kernel.org/rdma/rdma/c/7fc45cb68696c7

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


