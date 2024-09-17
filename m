Return-Path: <linux-hyperv+bounces-3033-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E78097B1D7
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 17:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFD71F25929
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 15:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37319FA99;
	Tue, 17 Sep 2024 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVB63rQ1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026D19754A;
	Tue, 17 Sep 2024 15:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726585453; cv=none; b=aVzNSymoM+aLvELSlGPKIQjmd60NjeptXIZfku4SwTK90fYg9zFXZ3lGtxRsITfu8BppinK9+vb8pUj5CqTYWAleDLzANdDUTinCVRPId2REvwTFOvh5MJmyUk4Za62CzBdANPJ0ciutlVoESW6xrXr4MtmmHk3bJTVpyZm2Yi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726585453; c=relaxed/simple;
	bh=zXsoH+o4A35ndDJgHDjG0rrx13JWwVadVhEYJGQjNyA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahob3qoOKwjgKpxPkCH/6j2hbDzuybHiH85OClNWeoRZn5YG50L96rICybS5DkczJ5QwJmNTfEqeuI7My6WVpFyiGvrh+D2rCR/wYdVmsoFjNsSmgkot+w5MkI963l3980Bwy4zYo2SkNlke36EI9tAe2JJ4WZQtnXH9F6K0mPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVB63rQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB286C4CEC5;
	Tue, 17 Sep 2024 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726585452;
	bh=zXsoH+o4A35ndDJgHDjG0rrx13JWwVadVhEYJGQjNyA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVB63rQ1H6gY/409ooHvZcIBSj64srzmEJffbHpBGzPJR4f2uVpt6g7dMcZ4K/ymM
	 qLmfg0ocYmWMxZysoUiRh32xQa39NwGBNk/e/ajgi33qdEz9MCGk0IhO/40K+1QTCS
	 5AHq/mqcONpGKfHGGs0hfJJfKTvYfcQSxEFzS6px1aRzn0zlH7woGjholmBE13v2yS
	 dSlMUbCOagn7LytppTUXpfpe+5fmN8nWVDTq+skykHCmDtgckyQ6FItXukH6RXF98B
	 1Ott+XMrVvoR0bKyy8NRN1l7GGE/xrk4oNPRoRAcmLtwhAwmcBsl/XksgJd3hCqmsX
	 Jj3qWS3KDKDgA==
Date: Tue, 17 Sep 2024 17:04:06 +0200
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>, KY Srinivasan
 <kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "shradhagupta@linux.microsoft.com"
 <shradhagupta@linux.microsoft.com>, "ahmed.zaki@intel.com"
 <ahmed.zaki@intel.com>, "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mana: Add get_link and get_link_ksettings in
 ethtool
Message-ID: <20240917170406.6a9d6e27@kernel.org>
In-Reply-To: <PH7PR21MB3260F88970A04FDB9C0ACCC4CA612@PH7PR21MB3260.namprd21.prod.outlook.com>
References: <1726127083-28538-1-git-send-email-ernis@linux.microsoft.com>
	<20240913202347.2b74f75e@kernel.org>
	<PH7PR21MB3260F88970A04FDB9C0ACCC4CA612@PH7PR21MB3260.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Sep 2024 14:35:21 +0000 Haiyang Zhang wrote:
> > Any reason why? Sometimes people add this callback for virtual
> > devices to expose some approximate speed, but you're not reporting
> > speed, so I'm curious.  
> Speed info isn't available from the HW yet. But we are requesting 
> that from HW team. For now, we just add some minimal info, like 
> duplex, etc.

Unless I'm misreading I don't see the answer to the "why?" in your
reply.

What benefit does reporting duplex on a virtual device bring?
What kind of SW need this current patch?
etc.

