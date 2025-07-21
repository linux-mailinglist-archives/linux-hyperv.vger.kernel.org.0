Return-Path: <linux-hyperv+bounces-6314-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4ACB0CE23
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Jul 2025 01:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5895F6C5DDC
	for <lists+linux-hyperv@lfdr.de>; Mon, 21 Jul 2025 23:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FD724676C;
	Mon, 21 Jul 2025 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VowoiBt8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6B2459DD;
	Mon, 21 Jul 2025 23:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140520; cv=none; b=GRWyBIfnZ0fACZfWmnZDGBdkN1Sf7tGZDjj/PhaebZk6QwC2libPbvsqLPgLdQDhsE2AYDVC8IKdlHFHIPZWvHfOZXlsVkL+HusSrWgvW6cKPk7QLNZkOBFAMaOTQfql7G3EpOhfcRiRYQMrbK7QGJ0N4RZ5+6UZe5Xv4sV+r0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140520; c=relaxed/simple;
	bh=tjRvtZvqHLvHFuSD2THYDAy+IcQttqUl0WDOh1eGyII=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gqA/c/rtmRti9kaP1QDCsRY8YsavlzDdD64QH9jHQgmWPA7l+QbcYUVzlEanSwN5r1m1cEDgsxg2+HYTzJQXcSoUcKdtOlCPd77HNvz9oCymiqsygOwv8sRGbfWWP4K6iyVTfaJpW8+rqHmXnQtSoPh+IyIJQr7E4Jmra7WlPmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VowoiBt8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BD5C4CEED;
	Mon, 21 Jul 2025 23:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753140516;
	bh=tjRvtZvqHLvHFuSD2THYDAy+IcQttqUl0WDOh1eGyII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VowoiBt8qCj4Ma3q9cisgGoZRsUihcaxJ/3b/kqagxs7ueqWwLddt1xpWeTrN/gyv
	 J6hhWI3pYvfyrx3Qz0ZgAgz0+lhwcdqnRdFZJL7KKUM5DktOEgLlD3UacP3SjQhSEQ
	 RYJI6HJJJG+RAFaMhOPdrsuPU3HD3lSTXKX3Tux4jWxBEbYSdYngk5oARmmhpcweIa
	 wAe0KAy4NPcxqsGUqOxVZIsnTAtlvJXiwTeIIhd9YXcipqL+cBc8Equbr8IKqKa0mn
	 D6q9fMPMA071FvfXSjmlhCMBKQdulsspBNCAR5R9N43zm08JWxzHsY1OdaOkmqW4Na
	 Vxr6SD9XpfsTA==
Date: Mon, 21 Jul 2025 16:28:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cindy Lu <lulu@redhat.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Michael Kelley
 <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Kees Cook <kees@kernel.org>, Jason Wang <jasowang@redhat.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault
 <gnault@redhat.com>, Joe Damato <jdamato@fastly.com>, Ahmed Zaki
 <ahmed.zaki@intel.com>, linux-hyperv@vger.kernel.org (open
 list:Hyper-V/Azure CORE AND DRIVERS), netdev@vger.kernel.org (open
 list:NETWORKING DRIVERS), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
Message-ID: <20250721162834.484d352a@kernel.org>
In-Reply-To: <20250718061812.238412-1-lulu@redhat.com>
References: <20250718061812.238412-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> Subject: [PATCH RESEND] netvsc: transfer lower device max tso size

You say RESEND but I don't see a link to previous posting anywhere.

I'd rather we didn't extend the magic behavior of hyperv/netvsc any
further. We have enough problems with it.

