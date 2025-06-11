Return-Path: <linux-hyperv+bounces-5873-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCEAD5B2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913DA17A137
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jun 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C241DED4C;
	Wed, 11 Jun 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HibdP8nS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209AE1B4F1F;
	Wed, 11 Jun 2025 15:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657258; cv=none; b=HcZsgWW1bsOK+wtqZIWu8+U6wp/3UJUBEmsIbwpKiF7bBqbBHUSdzTyzGZWRj5Q+fJDmLmLSgE3IGVKkzDuUvdBwVQ6/7wUc5gjfjSBxqUiUx/t3yV7pyJ8ouTEKNPxEqJC0ioJPC0jKcOWeKmZXBQMafK2PBqKEsL41mvLGgUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657258; c=relaxed/simple;
	bh=UYXVFykziYf4HlZyi1nlqGaFI0VW+AOph8trUZpswK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+tpnYAhHaORx5K0gmcb2n6ihQK4ygqp0F/+JHh/9eFLxflkDkZ2htmXcToSSK8v2NjTaSg7C872aI9pM/gRKL6qeRIKGxhsnAJwkKlnp3Hzwg4oGsg1UXCzxjkW3BnFwC56HBU0kDzY7VcqiZHg6VKb8nig7i3xqWvvVPVzk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HibdP8nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4EFFC4CEF4;
	Wed, 11 Jun 2025 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749657257;
	bh=UYXVFykziYf4HlZyi1nlqGaFI0VW+AOph8trUZpswK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HibdP8nSrHQpNR03veiQzsIlfXwCqLr9bZDKhe5xHwwfGAT9keM4D1YuPNjpdh8c9
	 b0dcCYMmsQpg/lXsRM2umnqf0jxW84aM8SReJN4infHzTrizuOad/BtzD/3wFPTHNE
	 Dhr8lRchehLFq+Q8f8MQOIwuPJVFyQd2TYYuPBLAGghQoAzazUwUwrxcLfUMP5L4zM
	 p0S+tGW4vOMVCoFwnegCbiiPs9pgLYPwaGE7X+1XDNEze/aX3GYavFCL1erjnFISk2
	 x4jSwTXx0lxhbbPcBrMRIxE719JCHe4gJvy7cz6FN6k11Wxs5iH8mNA4Ti9pyp9MAe
	 Ey6oE9JkxCbZQ==
Date: Wed, 11 Jun 2025 08:54:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Nipun Gupta <nipun.gupta@amd.com>, Yury Norov
 <yury.norov@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Cameron
 <Jonathan.Cameron@huwei.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Kevin Tian <kevin.tian@intel.com>, Long Li
 <longli@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas
 <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Krzysztof =?UTF-8?B?V2lsY3p577+9fkRz?=
 =?UTF-8?B?a2k=?= <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Konstantin Taranov <kotaranov@microsoft.com>, Simon
 Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>, Maxim
 Levitsky <mlevitsk@redhat.com>, Erni Sri Satya Vennela
 <ernis@linux.microsoft.com>, Peter Zijlstra <peterz@infradead.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Paul Rosswurm
 <paulros@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v6 0/5] Allow dyn MSI-X vector allocation of MANA
Message-ID: <20250611085416.2e09b8cd@kernel.org>
In-Reply-To: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
References: <1749650984-9193-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Jun 2025 07:09:44 -0700 Shradha Gupta wrote:
> Changes in v6
>  * rebased to linux-next's v6.16-rc1 as per Jakub's suggestion

I meant a branch, basically apply the patches on the v6.16-rc1 tag
and push it out to GitHub, kernel.org or somewhere else public.
Then we can pull it in and maintain the stable commit IDs.
No need to repost the patches, FWIW, just share the branch here
once you pushed it out..

