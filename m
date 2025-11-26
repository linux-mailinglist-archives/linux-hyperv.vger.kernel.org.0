Return-Path: <linux-hyperv+bounces-7824-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E7C87B05
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED3C73B06EA
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D824A2F60B2;
	Wed, 26 Nov 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaQABkY8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA8249EB;
	Wed, 26 Nov 2025 01:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764120252; cv=none; b=enW25E0Ss+7D3HP8aKK8JfwfHyFqntf+5SqiC3pCdxBC9rO4W1aUQ0L/2S0KbobI9slmG3U1lPU1fgCfPuPkogdN+fhEjCRVFzKbtJIGuptWJubSZ+MKEJVWrjif+jHj1OoYFmKzKnSx1bhQWOQzsFpuDZVQLXyW6upYOAbyiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764120252; c=relaxed/simple;
	bh=GLj4prEKIPiMdsxFheckPZ2kGP9oA58mW2Ph+HORJVM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQ93wtBkprX99ntialiXntY2KklZAucLkhIown81PLuh5DRvgRJMtyPJn02L0q5rpTa4dXla9zYOAIcebu2FqKJ7quofb4aUvWMIVgU3Y46Da8R0oM1auKdUaQj7Y+UxezprGDsxE5ox7+2f5i2OT/0//20xecZQR435hmdSRFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaQABkY8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D60C4CEF1;
	Wed, 26 Nov 2025 01:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764120252;
	bh=GLj4prEKIPiMdsxFheckPZ2kGP9oA58mW2Ph+HORJVM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaQABkY87QiHXyNa0Cc499L8aC6ums31LQWlBvqYU5ZaWL32iqFNWvZx7ADjLmjAP
	 iyrCJCMdmf4tFo4bxmCjE4YIRf82EZM1Tg2iykrU7o9J+0HsAUalpKTm7bIR31VJQh
	 og97fVlR/6uMZSXnkq0R5lRIrx5RJ1mAqRiohOTuGXNOa560Wl7+fhejRsxdCB0Hbc
	 URoWM9UhCOD9aV5duUlpGgQ9wPC7Cv2vl8sSCKfwE7E55PlRj+F0h0pDvs+jevDR7R
	 v9zFgghzW1/A6bdb6Y1E5lOXS/c/cTn3vS6r3Ap7tKiGu9StxqXkTkmCvKc4MX8bbr
	 ZOCynVZwqR/9Q==
Date: Tue, 25 Nov 2025 17:24:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: Simon Horman <horms@kernel.org>, "longli@linux.microsoft.com"
 <longli@linux.microsoft.com>, KY Srinivasan <kys@microsoft.com>, Haiyang
 Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <DECUI@microsoft.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shradha
 Gupta <shradhagupta@linux.microsoft.com>, Konstantin Taranov
 <kotaranov@microsoft.com>, Souradeep Chakrabarti
 <schakrabarti@linux.microsoft.com>, Erick Archer
 <erick.archer@outlook.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [Patch net-next v3] net: mana: Handle hardware
 recovery events when probing the device
Message-ID: <20251125172410.124e2eba@kernel.org>
In-Reply-To: <DS3PR21MB5735CC21A800623D2DB5D144CEDEA@DS3PR21MB5735.namprd21.prod.outlook.com>
References: <1763680033-5835-1-git-send-email-longli@linux.microsoft.com>
	<aSWKLefd_mhycGDv@horms.kernel.org>
	<DS3PR21MB5735CC21A800623D2DB5D144CEDEA@DS3PR21MB5735.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Nov 2025 00:40:08 +0000 Long Li wrote:
> > tags (with a blank line in between).  
> 
> Can we keep the "Fixes" tag and queue the patch to net-next?

No.

> There are other MANA patches pending in net-next and they will
> conflict with each other when merging.

We merge the trees every Thursday.

