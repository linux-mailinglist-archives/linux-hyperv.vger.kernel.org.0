Return-Path: <linux-hyperv+bounces-5924-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A88ADBCCA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Jun 2025 00:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BC0165EB4
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jun 2025 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3784A214A9E;
	Mon, 16 Jun 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbOUHcOc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05357205AB6;
	Mon, 16 Jun 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750112600; cv=none; b=rKNrrR2W20Tx4y5hFK8JzZY8FyFQuTyUQiYLKlKZ2AKJ0x3zyblEWaXGiHErbiCjPCi8aMXv9pOOxg4Rr8B5IcbqY5hQ6IkEjr/R5NuNg7VTMWsPg8iUSb8+OHOysYjEAQ+iAtEYCAgXA0wWwWOIq1jVIQcsJ5dDaioeFevjPVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750112600; c=relaxed/simple;
	bh=5DcPMaS2QcixZD9QjmCLF62HkWJvZo207lXJbnyTsFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H0kTRpJRlwfl+kYhdRVZuTo+vElk7YypRlGnia10dXN4DGVeGhrODUO/4VaIxjgZoYcahEyNIa9MifpM3QRhzKE7gKfEfhbmk339+TbqwAkx/N5VjibMV2JYQQ+L/S6KbPRWSkJOKmkAqiWBacQygeTGSRexsIw/Jf94FmLuRcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbOUHcOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A74C4CEEA;
	Mon, 16 Jun 2025 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750112599;
	bh=5DcPMaS2QcixZD9QjmCLF62HkWJvZo207lXJbnyTsFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KbOUHcOcN669RMZ0PjqSZx+F61SgXJIdFdgvFCqfU8+z1Sh/lC+G2c8pbO6Q63sfq
	 SzE7rwGiP4iB1tvHiUDntIXe+PmotGvOKRrKJM1broS4E8yjGz5n4l3fyacUNB/3XG
	 Z6hC4+G/NxXmiW8wJxBgHg1ZOdf8oD8jOiws6c/xDiqxk0FZXnbCmRcdmZmW/nWYj+
	 416TgB7ax+pqJt6l/JY0jMlOf7Ukyd94I7Kx0Bj31PYsa6yGtZ1PfsWk3dezv46b6J
	 /XDdrjErMJqfDBU8nYVzaMZ3KfX0K647ToAf99+QnjtS580dMaqfS9IzNfjrmgtHx9
	 6Go3ibydDAYwg==
Date: Mon, 16 Jun 2025 15:23:18 -0700
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
 linux-rdma@vger.kernel.org
Subject: Re: [Patch net-next v2] net: mana: Record doorbell physical address
 in PF mode
Message-ID: <20250616152318.26e1ea3e@kernel.org>
In-Reply-To: <1749836765-28886-1-git-send-email-longli@linuxonhyperv.com>
References: <1749836765-28886-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 10:46:05 -0700 longli@linuxonhyperv.com wrote:
> MANA supports RDMA in PF mode. The driver should record the doorbell
> physical address when in PF mode.
> 
> The doorbell physical address is used by the RDMA driver to map
> doorbell pages of the device to user-mode applications through RDMA
> verbs interface. In the past, they have been mapped to user-mode while
> the device is in VF mode. With the support for PF mode implemented,
> also expose those pages in PF mode.

It'd be good to indicate if the PF mode support is implemented as in
ready to be posted to the list, or implemented as in already in the
tree? If it's in tree then please quote the commit. If upcoming please
rephrase.

This commit msg is much better, thank you, but to a person handling
backports it will still not be immediately clear whether this is prep
work for a new code path, or a bug fix.
-- 
pw-bot: cr

