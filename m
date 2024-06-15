Return-Path: <linux-hyperv+bounces-2437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7909098A6
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2024 16:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F47B1C20A2D
	for <lists+linux-hyperv@lfdr.de>; Sat, 15 Jun 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAF84596E;
	Sat, 15 Jun 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhnKZD7e"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2A49624;
	Sat, 15 Jun 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718461703; cv=none; b=Xzcokv287ys2zKOWeDrTcShxFwuEYtKLak9Oh/fws16sqscfWsGtLkZgrHfC82YGtrjhhpZf840C32/jIdeWzKRZ3DYyXA4CpvYFNIBEdLkXDeYLyBL0ueIumej9QeBk3sDmRLMHUiLjcvKpZdFn/iDoYaHebPg+DMC+TggbIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718461703; c=relaxed/simple;
	bh=uapNe6daeUuo6aEAI9k9slBYeR6ie3LDPRu+C4G/1NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1CQiskAkdYErOfbkrRq5WWpcxF/V2RhJJgE8wrSq6vDEqlF0aDTFp5q7nN9oe81VgPKSPfTDR7gS9uWOrUJkpN4et/cEf/pCb18WjwLvT4uRAqDAIv4d2WHGsI0cN9LTVMdt0WhOqHc2ObXK3xkB7Cs2nfNsJFRsb2lyP0CVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhnKZD7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A83C116B1;
	Sat, 15 Jun 2024 14:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718461702;
	bh=uapNe6daeUuo6aEAI9k9slBYeR6ie3LDPRu+C4G/1NU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VhnKZD7eaNQtOLKIQsKbOXbEK5Re7tDo7eav4A6VztwGZ0lMNDnyhSSeiFu9ETIYn
	 v2+swGmpyvzsyrpkBbaf6XJIXS8t2DPm8PuS2NcCRmK2XmYbdyPreBPKRtocyP30VZ
	 i64RLcXmQSpNY6iAg540YyKldnGd3BFwztl5SmbJgkt4T7rVWhT/LoT7li1pIgUupC
	 v94AljzRFAb8Yt0ELLmaBGxanZttDE3JLwv9XhHbGplgSlmQgC6EcOC+OHr7quhlWO
	 huPCqqAOYRHdF95cGbjEu+PyH9c8ePumTDg7T8IRGyfQTFUzT0iFXzTxRB2PpyllAK
	 BYDkg7icd23Lg==
Date: Sat, 15 Jun 2024 15:28:17 +0100
From: Simon Horman <horms@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	Erick Archer <erick.archer@outlook.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH net-next] net: mana: Use mana_cleanup_port_context() for
 rxq cleanup
Message-ID: <20240615142817.GD8447@kernel.org>
References: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718349548-28697-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, Jun 14, 2024 at 12:19:08AM -0700, Shradha Gupta wrote:
> 
> To cleanup rxqs in port context structures, instead of duplicating the
> code, use existing function mana_cleanup_port_context() which does
> the exact cleanup that's needed.
> 
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>

Thanks for following-up with this clean-up, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>

