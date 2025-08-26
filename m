Return-Path: <linux-hyperv+bounces-6601-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDD3B35069
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 02:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501A1203893
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Aug 2025 00:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CF6263F3C;
	Tue, 26 Aug 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r30lphcZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597D260582;
	Tue, 26 Aug 2025 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756168894; cv=none; b=hO8DrvaY5NmE54vk6H3doxRvz2iifU3PX5+JEPlS9sOLB/Ydwi6R7TiKQkAgRJTkBUndo4xKKa3UbjYI1rxeCaevjTMXsLBhhL3sWwc47E1t+vyBxzBZe73L3VOlYzT4WHTTOUc8Cnfnc+rmUW9KMmVRwIxUVo/6+pvQRooGNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756168894; c=relaxed/simple;
	bh=PHvg8cMhUd35TeLpMoQp4ZbPSJkQAR394vpGl4+tNGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxlPwPMEEMwbtWYF7Qd3N03c2Aee7TtpzNPV7mdFvW1WqQeI1EVRsY37J+4tlF+y92XqXHHEWxof+p8Hil1Zix4NO0z1KJfT7Nt89a799jgM2azV04QLfMk6L6IDKoZtOsiwD01KTU+ZSEpZDP1a6GMa7gNV4oTCq2qUGdPcTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r30lphcZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8882C4CEED;
	Tue, 26 Aug 2025 00:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756168894;
	bh=PHvg8cMhUd35TeLpMoQp4ZbPSJkQAR394vpGl4+tNGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r30lphcZ5VT6rYM1JYCLJTbZUxm+Y3UhppH5XpASIdngmfRTHq4ia5ely1Wv9ylHl
	 GLVetL522ckX0hoM1eQC2wEzthtQg9ulGkbIOH6aODi3SDwR4wF2/TEPN8rBxlS4zv
	 WAoCZrkNN9TnPCvzlk/bLIqIBVRMT+/WMFHmuJLFOI757HJA2YP0nY6Y5+9aohcpd2
	 P7AyX116qX0rM44AONYJuS+F1gvgPxYsdwSVfGusWvrF4+vlqwBnsJOqf4KH+zRAD+
	 Pg8rxIROTGOY1JRB5mfg3L4Wnbd8HAjV5efwhE27+b9KqTKzM426qbB/vN3+apDaA7
	 Cf5tOsIrM2xiw==
Date: Mon, 25 Aug 2025 17:41:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, shradhagupta@linux.microsoft.com,
 ernis@linux.microsoft.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssengar@microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH net] net: mana: Remove redundant
 netdev_lock_ops_to_full() calls
Message-ID: <20250825174133.30e58c60@kernel.org>
In-Reply-To: <1756119794-20110-1-git-send-email-ssengar@linux.microsoft.com>
References: <1756119794-20110-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 04:03:14 -0700 Saurabh Sengar wrote:
> NET_SHAPER is always selected for MANA driver. When NET_SHAPER is enabled,
> netdev_lock_ops_to_full() reduces effectively to only an assert for lock,
> which is always held in the path when NET_SHAPER is enabled.
> 
> Remove the redundant netdev_lock_ops_to_full() call.
> 
> Fixes: d5c8f0e4e0cb ("net: mana: Fix potential deadlocks in mana napi ops")
> Cc: stable@vger.kernel.org

If the call is a nop why is this a stable-worthy fix?
-- 
pw-bot: cr

