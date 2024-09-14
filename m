Return-Path: <linux-hyperv+bounces-3021-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D7B978D1C
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Sep 2024 05:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58071F23C2D
	for <lists+linux-hyperv@lfdr.de>; Sat, 14 Sep 2024 03:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B771171AF;
	Sat, 14 Sep 2024 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plFPg7ue"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0F438C;
	Sat, 14 Sep 2024 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726284229; cv=none; b=rinss6rohUdxzO9iK4FRuZCdTWGHEUzThLe4xuDlRfc8Cyatjv/iaLd7H1uPVjlT2O9q7yNTrgfC/5tpmGozae7kjqRylbIaLm6H3mVlPBDKyVJxjDDFbOKlsocK36K0JeNDnUmoQBrnDyV2E8Z8svLO2RV1OgcqLH7bQRcObnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726284229; c=relaxed/simple;
	bh=t8ACe+kBe17ftvgZRD57F7hxmi2YhhPH6Tq5XKVYETg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C7MXPGLuAx88h87Ogv9P4WiQwFKOd0ODd7j/HYwtxEOy48mhjxCw5ZCDbAQZmIHVrW4YWXR/oexhBY0l1puQyCiF2m0Eo5SMrO9zmUX3tl3Z+15iG5iI+9z05cOHaShNoMT13qtCC7Y0TnhUt2n9E3HE7YR5XV9d61ITkVnACx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plFPg7ue; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154ABC4CEC0;
	Sat, 14 Sep 2024 03:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726284228;
	bh=t8ACe+kBe17ftvgZRD57F7hxmi2YhhPH6Tq5XKVYETg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=plFPg7ueWM1ycxvsHQy2y7MgxyRyUXmihmPPwRDQu08A4BpXoNxMjtP625TopzuQo
	 nERqnBD6YU8TNQ340AL8ms9xt/n980Qhx+YuGbWCl+lxzRlzI5/+wHY/MmDaOHhN6W
	 v1KY6GApyxuqyc1Y3nbf8n+i9WkQJddfyrTjJOJ3ZliL2tJbSP33ibmVLXwJnN/sAJ
	 wO1rN1nnSkTogjn9HaLVWj7SpdbkZe72XEfOJHqUKd7NYkwJ303h/BW+ikO36AIDUV
	 JcC/1QBod+szL71vU8477adOBJ2knlT8N55kiHDp2dx506dPOUqyVpaX93wzbgDgiC
	 mASD2dA1vE8Uw==
Date: Fri, 13 Sep 2024 20:23:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, shradhagupta@linux.microsoft.com, ahmed.zaki@intel.com,
 colin.i.king@gmail.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mana: Add get_link and get_link_ksettings in
 ethtool
Message-ID: <20240913202347.2b74f75e@kernel.org>
In-Reply-To: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
References: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 00:44:43 -0700 Erni Sri Satya Vennela wrote:
> Add support for the ethtool get_link and get_link_ksettings
> operations. Display standard port information using ethtool.

Any reason why? Sometimes people add this callback for virtual
devices to expose some approximate speed, but you're not reporting
speed, so I'm curious.

> +static int mana_get_link_ksettings(struct net_device *ndev,
> +				   struct ethtool_link_ksettings *cmd)
> +{
> +	cmd->base.duplex = DUPLEX_FULL;

make sense

> +	cmd->base.autoneg = AUTONEG_ENABLE;

what's the point of autoneg if we show no link info?
DISABLE seems more suitable

> +	cmd->base.port = PORT_DA;

Any reason why DA? I'd think PORT_OTHER may be better?
-- 
pw-bot: cr

