Return-Path: <linux-hyperv+bounces-852-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4277E835D
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 21:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E96FB20B38
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 20:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BA23B2BD;
	Fri, 10 Nov 2023 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onhJ+OYE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5963AC1E;
	Fri, 10 Nov 2023 20:05:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB22C433C8;
	Fri, 10 Nov 2023 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699646714;
	bh=lOmC1RzpzPbrRuQaSQab3+Pr63qCgL2kSiNOgA19+Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=onhJ+OYE89lq0qaOjb/9sr+He8iR14eZe4EF4w6zrjdNLZuShjUZAp2j98eZsYJjP
	 bkc4+1foYY5yLwf4Cg8QU/AkQR5cFc26UEEKSP3Zb8TMH08XTJiKLrvnmgp0yh+hDy
	 nG7kBdHW1WTcXfgbucz7MU0b7ZFEKV07WoIzvDj8HlMUXmjYuZG6t2puccltiDV0aZ
	 CnfwaqOHqH2yrbFe7thLKwSKRYwoq1rpvNAm5AzhnqTd6AwgQ/j3nsc4tVNoAFrYth
	 uvrhfADdetNB6oTFF9x7neuLM2BoQtlnhqunhZUc7vOJjWxbdgIXCfEgM3dC2Yaq5F
	 7wAlr8BqOx84A==
Date: Fri, 10 Nov 2023 12:05:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>, KY Srinivasan
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231110120513.45ed505c@kernel.org>
In-Reply-To: <PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
	<20231108181318.5360af18@kernel.org>
	<PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Nov 2023 00:43:55 +0000 Long Li wrote:
> The code above needs to work with and without netvsc (the possible
> master device) present.

I don't think that's a reasonable requirement for the kernel code.

The auto-bonding already puts the kernel into business of guessing
policy, which frankly we shouldn't be in.

Having the kernel guess even harder that there will be a master,
but it's not there yet, is not reasonable.

