Return-Path: <linux-hyperv+bounces-3909-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FBDA31A61
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 01:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA1573A54C9
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Feb 2025 00:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C591C15A8;
	Wed, 12 Feb 2025 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRWhCO8g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5101876;
	Wed, 12 Feb 2025 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319628; cv=none; b=jcl6JXjXw5ir+D+4xTnknIYJyeFSjoP4N+HBOd2w2LHoPsFK3/7EL96O6vnV1NMy7jhR5uHj4GMPoLRIchomxFirmPS6PLjUQSP6R/O7NhrrlQc3b2T/v6r/aO4V4LW5Z7zxKz2FQcBZ/1aoOLrz7zmBKl0ZBSx2dgOnSF95ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319628; c=relaxed/simple;
	bh=rkXJ4ojrxXejsrw5mkPHS1Cu0FVzEY8Zj+jxcDkuHGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=olz+HjlLFPA7XQgp86Q51I2t7HT9xy2abdq1CxZqu6O6dky7vdaj6FM9HFG97RmBgKggSJV3J2+pxVHWd/UkpMhg2w0fat4XiYL1u8qlzngZHR8xlnBR8q392se6emVFWHpcthbGl9NGPDaVwTPmD25WnZiRM/fDeRDq1C1xDx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRWhCO8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C91C4CEDD;
	Wed, 12 Feb 2025 00:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739319628;
	bh=rkXJ4ojrxXejsrw5mkPHS1Cu0FVzEY8Zj+jxcDkuHGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aRWhCO8gN5RuVlCVR6ZhyhGQxIVBakqyCm6HyUTB3oCV6jv537uUU0n+z20aEzn7t
	 RFCZD2JYJbAriGxMELvE9j1ClMgp25Ofzr/OOQBiZcz30zZIHqMWmVvqX+Ydtm3gMS
	 O8FzJpHui4iV5C8ijZjTtXeaOMj2pgahrdcCw048XucsttEwqO0ihY8or9gMXrvTsR
	 pXjTAbJB0oGoDjTyEEGsh0rLuYnTLgQVNYsTICQfpY0E+t6XcShDTvn7mIydy4xl7i
	 ygBVuPG3TQaxR9eWZYB+Tlmg3vhkLTgWMHCuvoHI1KiDxIgiN/HZ4VZOLya/hnBFrG
	 JjmLi3872VvIw==
Date: Tue, 11 Feb 2025 16:20:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: longli@linuxonhyperv.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Ajay
 Sharma <sharmaajay@microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Long Li
 <longli@microsoft.com>
Subject: Re: [PATCH net-next v3] hv_netvsc: Set device flags for properly
 indicating bonding in Hyper-V
Message-ID: <20250211162026.593b0b93@kernel.org>
In-Reply-To: <1738965337-23085-1-git-send-email-longli@linuxonhyperv.com>
References: <1738965337-23085-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 13:55:37 -0800 longli@linuxonhyperv.com wrote:
> On Hyper-V platforms, a slave VF netdev always bonds to Netvsc and remains
> as Netvsc's only active slave as long as the slave device is present. This
> behavior is the same as a bonded device, but it's not user-configurable.
> 
> Some kernel APIs (e.g those in "include/linux/netdevice.h") check for
> IFF_MASTER, IFF_SLAVE and IFF_BONDING for determing if those are used in
> a master/slave bonded setup. Netvsc's bonding setup with its slave device
> falls into this category.

Again, this is way too much of a hack. You're trying to make
netif_is_bond_master() return true for your franken-interfaces
with minimal effort. 
-- 
pw-bot: reject

