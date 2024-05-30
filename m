Return-Path: <linux-hyperv+bounces-2263-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BD68D4F49
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 17:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22D13280C58
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 May 2024 15:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7387B18307E;
	Thu, 30 May 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4j9SunI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42939143C40;
	Thu, 30 May 2024 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083777; cv=none; b=Uvg3QdjAtUzR5ApjL2FPwd+5zViGVF3Kwoe10np0BSWr0t8Cvpm6qUY5N9DpD5dd4JUJur1z+tU2ijGqmA9aF7Hv08Vha3hgg4SdYNJ4zTgDew40i4QwvhSgNRAvpjNV7EpkTHhdbzLzzSOSAdRWGTrI66uYA2VCesjqRl0fdCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083777; c=relaxed/simple;
	bh=FvgUqKbCwTMGuyq+WCkzYfAToo/noscKFADcKO1XZTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dmliX+GT9V8UFG2IMgCU7lL/qAizhVzYWnyEUSo1Mi2BqOy/S9iKcYxenCGt1dm8zatgkqmMfp71tKCPn5z5ULvfCXkyDhb1+ib/Fgr0S/mjgf73QmAvGSWzlQ/sGX/u8qt3WG1e/8cheSl8fkz0iIxJd/wjIxoWW3+hs8Y3BXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4j9SunI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109D3C2BBFC;
	Thu, 30 May 2024 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717083777;
	bh=FvgUqKbCwTMGuyq+WCkzYfAToo/noscKFADcKO1XZTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a4j9SunIZXxZvoQpSFFfeXqP1YaEE5f73KgkqD5K7sqCLCuyexuxW9moMGKcx7Vmj
	 Fe6u7g9P6dkwq88ERfm1GfLHzALr/5xxIXEirxm1DExbpAhxAHV8n/mGDBHlqHsk9L
	 MgNySsGXv94WBacmz4Ip5GJ3ECHKjofNvNgB1QNup0jH8JxiVNF709LcXeOOJmh01q
	 ZVl+UX+g/6UPQpeeszJxj5WIHg5B4fdNfZ80hMuflkBE/9HC8TyFhDrAq3ic/eyU7B
	 1v7Oy6nGeIjnYZSgMIaZt3esnkd/PN9gI7SMvmEP+7CfwrY3+6lTxzG/Pm3lwtrzFF
	 HhC9rVXE7Mj+A==
Date: Thu, 30 May 2024 08:42:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
 linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, Colin Ian King <colin.i.king@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Konstantin
 Taranov <kotaranov@microsoft.com>, Kees Cook <keescook@chromium.org>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Dexuan Cui <decui@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Jason Gunthorpe <jgg@ziepe.ca>, Ajay
 Sharma <sharmaajay@microsoft.com>, Long Li <longli@microsoft.com>, Shradha
 Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next v2] net: mana: Allow variable size indirection
 table
Message-ID: <20240530084255.0b550d35@kernel.org>
In-Reply-To: <20240530143702.GB3884@unreal>
References: <1716960955-3195-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240530143702.GB3884@unreal>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 17:37:02 +0300 Leon Romanovsky wrote:
> Once you are ok with this patch, let me create shared branch for it.
> It is -rc1 and Konstantin already submitted some changes to qp.c
> https://lore.kernel.org/all/1716366242-558-1-git-send-email-kotaranov@linux.microsoft.com/
> 
> This specific patch applies on top of Konstantin's changes cleanly.

Yeah, once it's not buggy shared branch SG! Just to be sure, on top
of -rc1, right?

