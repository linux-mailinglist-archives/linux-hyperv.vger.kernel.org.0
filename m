Return-Path: <linux-hyperv+bounces-3109-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BF98F324
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 17:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0DF283D76
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Oct 2024 15:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BFC19DF7A;
	Thu,  3 Oct 2024 15:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="0GCuKNno"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FE1474D9
	for <linux-hyperv@vger.kernel.org>; Thu,  3 Oct 2024 15:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970522; cv=none; b=nuJaNJp1Mg8zlEbTNp24inIpdRmrCUBkC6PtRLePFxyTyyP5MX+s9T2t8WnMpm1p1YC93qZmcpGYon/4WcXJaVelAcTq/Ye6zYNsO0U/T79tr3s4TwPMARyliAR0sRIiecOlujZR7cpqhbk0DXD4w3Hygl/4JQpe0cPypW4Vqso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970522; c=relaxed/simple;
	bh=nbEOgFC3s9ck5TkxzHUY8vXD6F8G+GkMfGCvlkFyLUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqXuG3iGvdC1iaeToYEXafZcokQJ+tEQlFFjokXsKX0lOwAgX0LJbBw4YzbyXq+rlq844QkdAukdkva7wAewDAJB5ir9gdOXiQ0yaRZN2E2WO63LAeHine9zHzJ+bFAHZwbNT0lLYnm5QjFREu19urh2N9gxjTPy4C1d0WlykEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=0GCuKNno; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e7b121be30so719438a12.1
        for <linux-hyperv@vger.kernel.org>; Thu, 03 Oct 2024 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1727970520; x=1728575320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWcf7zt+3dbw6XyFZUCjqYVpAh8NDWskQ4AR46WCv8w=;
        b=0GCuKNnoaFOPyjwqaEG7ng213Irl+IXLv8lhULirECXo9tgRUUr+lwJyhpl65nX08p
         HDZyee9vnb9PLeZN1SAFD7t0PjSGc2FtwrilPKcH9vYOnIwlzDs28FJBeE/uPEiLr0kZ
         FYAVZI2N1fhXB7upO0SfAdpMADoHKSXu9IjHgp80gN+pnOgrgED+HadS0PhlIMO0Ctug
         dQCEkhDRYC9ZVxaIyD47TsWpRV9QdPdGoY0VHYG7CuedqXTngzKZfRxbdVU/WQRmhfNk
         7FmMbTKBRoO/3J//wYRXyUpo/cf3FRJ6Ilhq1X7l/gdH263F2kMSgI90lq4SXIZHN6dT
         RVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970520; x=1728575320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GWcf7zt+3dbw6XyFZUCjqYVpAh8NDWskQ4AR46WCv8w=;
        b=oyZMckU7HOvnO7azOZigPYlDecPOxoNr58Cdpsbz3i/4u9Nko6lFRNp35bK9PKwEzb
         F3526xXeQEEkyCxufP8O+XqcsgGwsWh3YnsAjpa27nNn3OnMhthTxIK1/B8s11CXdHRW
         s45UqZZ7Zgv78siMbpr+Qo0vu/lyR+KP3pyaJC3fIMP97AYsNUynDjlPBpY3DpP7Mf26
         tOf1iJ1HhlRZr1zjgRJc87gbkS/n3VQiNZeHX7MHfaoDTn1kRa5OUwG8HzJpMoJXAFbK
         TUThybn7cIUp3ufU/FBr9NDncJXGnlx7tdn5sg4UfHg+kFRpsp9xpuEqrz/9vMKMLAcX
         cuwg==
X-Forwarded-Encrypted: i=1; AJvYcCWMw0kqP3dvpmAuoN6icYheR7hVaxeya09jw98rWmutTGY9jmcnlE3LFlCgHyZXCiPxXJii9k1iPkeSmWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTHEDTinDpsMboaA/i21W5VNOoSRzm8p6aigK9K2F5lMhytbCZ
	bfZaKVPbWzsjAPLvaGjXsr6xkPkMEj2gaGrIf1nA6/9DpzMF5577352boTOYKXQ=
X-Google-Smtp-Source: AGHT+IGXF/os+Jbd4kMUMUnMTR8RzWyvw5p0drzkab3E15H6sbrW06lt/w3l+0VNhmLYeVWZgRv2Qg==
X-Received: by 2002:a05:6a21:8cc8:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1d5ec4952f5mr10009617637.42.1727970520130;
        Thu, 03 Oct 2024 08:48:40 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9e08422sm1474227b3a.210.2024.10.03.08.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 08:48:39 -0700 (PDT)
Date: Thu, 3 Oct 2024 08:48:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, kys@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, edumazet@google.com, kuba@kernel.org,
 davem@davemloft.net, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] hv_netvsc: Fix VF namespace also in netvsc_open
Message-ID: <20241003084838.32c3b03b@hermes.local>
In-Reply-To: <a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
References: <1727470464-14327-1-git-send-email-haiyangz@microsoft.com>
	<a96b1e00-70e3-46d8-a918-e4eb2e7443e8@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Oct 2024 11:34:49 +0200
Paolo Abeni <pabeni@redhat.com> wrote:

> On 9/27/24 22:54, Haiyang Zhang wrote:
> > The existing code moves VF to the same namespace as the synthetic device
> > during netvsc_register_vf(). But, if the synthetic device is moved to a
> > new namespace after the VF registration, the VF won't be moved together.
> > 
> > To make the behavior more consistent, add a namespace check to netvsc_open(),
> > and move the VF if it is not in the same namespace.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: c0a41b887ce6 ("hv_netvsc: move VF to same namespace as netvsc device")
> > Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>  
> 
> This looks strange to me. Skimming over the code it looks like that with 
> VF you really don't mean a Virtual Function...

In Hyper-V/Azure, there is a feature called "Accelerated Networking" where
a Virtual Function (VF) is associated with the synthetic network interface.
The VF may be added/removed by hypervisor while network is running and driver
needs to follow and track that.

> 
> Looking at the blamed commit, it looks like that having both the 
> synthetic and the "VF" device in different namespaces is an intended 
> use-case. This change would make such scenario more difficult and could 
> possibly break existing use-cases.

That commit was trying to solve the case where a network interface
was isolated at boot. The VF device shows up after the
synthetic device has been registered.


> Why do you think it will be more consistent? If the user moved the 
> synthetic device in another netns, possibly/likely the user intended to 
> keep both devices separated.

Splitting the two across namespaces is not useful. The VF is a secondary
device and doing anything directly on the VF will not give good results.
Linux does not have a way to hide or lock out network devices, if it did
the VF would be so marked.

This patch is trying to handle the case where userspace moves
the synthetic network device and the VF is left in wrong namespace.

Moving the device when brought up is not the best solution. Probably better to
do it when the network device is moved to another namespace.
Which is visible in driver as NETDEV_REGISTER event.
The driver already handles this (for VF events) in netvsc_netdev_event()
it would just have to look at events on the netvsc device as well.




