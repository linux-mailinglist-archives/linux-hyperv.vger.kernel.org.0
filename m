Return-Path: <linux-hyperv+bounces-6187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4187BB011EE
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 06:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258C11C2562E
	for <lists+linux-hyperv@lfdr.de>; Fri, 11 Jul 2025 04:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC311991C9;
	Fri, 11 Jul 2025 04:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="sXc00bXc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E171C8F7D
	for <linux-hyperv@vger.kernel.org>; Fri, 11 Jul 2025 04:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206855; cv=none; b=UapHaspMtXMIklovRpghG01R+29kFgwHR4RIsoEVmZ2i7id8Ui5O4hzZGBGoINZ4dgV5tQqAKeAxq7VzgOwuQGJUX748he81DtNAcnAvtSpQ8FOmF+xroNaSf7Nr8cOfkky79Dq350gCp1oeXVc74+t2CTpsyy4nYWkqA2DuLfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206855; c=relaxed/simple;
	bh=j5AsxP9ygZ+4fLvkZ8fLF8g1ByH0EVRv6XFYqy13y9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2nQnT1K1DZ5/agdDm4vItUBOt7oJ+d3UnTbPtSddO+pkH3St+fKnie/tVQI5p6jqfCf+IBMtlJ1XB0BIYEZUa+J6QhIb/p47V0PPtF0Mi3vECNVyo0FfHMbxgF3n22poKUfhRHbkH04x/17hlY/50nPX/dp2/OUa56IQ81B8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=sXc00bXc; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6fadd3ad18eso16085946d6.2
        for <linux-hyperv@vger.kernel.org>; Thu, 10 Jul 2025 21:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752206853; x=1752811653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozI0Im86wAHsju6y0mF3RNQgE8ARNsXr6q3IFbk6UJ4=;
        b=sXc00bXcfY//854jxpkgbeajZbi/4pJxuXVtTx/S8LQqvfCJ0U0W4P2ZATrRyyj9Pr
         ZwQNnbzEJ2oLMAgTPrR4yOW0WlaGXqLhnelZ42mOP8PQIaxhxjPcgatGj+2Si6eKxcYr
         4HgC5SnuXYfMC6fx/le02PODrjm4HWI06CKe9ciemBaRuV92Ge8/OAmnNeqUPWUVV7v5
         vD/eZb84OYw9NkCObB2JAMtQRYOFIqwwnM3O5I7KUxMR/RfFJuFG87IVpOB4V5itG2IV
         Ikjjwod1duvI8dncTCPk7SVYRRpx43m5feJtseMPCFvhOFiR9pP40jL9Hz3K/avkcawh
         SyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752206853; x=1752811653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozI0Im86wAHsju6y0mF3RNQgE8ARNsXr6q3IFbk6UJ4=;
        b=oEk6YjP9xJZppm1tnFvquh7PWgAyfVVEkkJIsaG+qzkUFmMSbHjUWNUJIrzcboNc1U
         Ow3LWPnR2NAWfMli/Ebq4fvGpJAixKv831I/dTFiIYmavy12USwWelfKwmULbzR8ESFA
         tzvaSMq/3xLgH9vLnsCtqGH0ou/Fg69NH5UxhuGj1KARThVoVQuAMh4go52cyZ7Qm744
         CqXWfttQIHhswf9706wKTMFCviOXDuf/QAKRfDPJHONtgOnXQLUfj8QJqDemylr95f09
         /1ZAREwkD5euT1ZVOiAFjA70VbD0xpdIIOMVQnsL7UV3/+FBilzdBIQ+4sY4QKHXvafw
         F3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtiaiUdLxgP1rs8RVcMXcNNB+LB0cBv3z0kWrembLL6an1q0ocYunVF57dn5JYWV2VtH4oXLcD8mDetxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHDpAzLFJh8Ux/vcJDNWCvy5rlBmAvo9re6AqMuAvvLcBwtcY9
	rHDR73ZDSeFUhc1CpUTowLpiWcT3YDqhre/lXiZ6yHq+P8XyOjbVDh7olXtiSdFJJww=
X-Gm-Gg: ASbGncu7I97yW1hR/JhPdYJAi3fWlGmgZRJNAMvdHHljiWHuq5ep5uSRn5kHuKfMWQb
	JyhEDJ3CEFI74vGiItISzJ17nMegNlHONnvVCSxjE1wx1kfT+W+6ZxsvRvCguuI0EIMkN5v3bJu
	aiq1svLp2tZUeZqlik3BUcuU/NaAH5fnT1XDPS4zs59bpt2wH6EtjPVWozV2t9KTecL4mAHCuG/
	NbLzcFKS2r1elzSbVx/QMEJGfPJ68Z1FRgQodSLQ+cO2XhJ1ARZrxO/k/q8J/1cLVyHHeummvXd
	yV67tNnjH0oBdtkMQbeSS+JKBr/jHhXrt85aUpbRxKHHPy4SvOSHV8lZ4CMcH8232QxHO7huio7
	rzCY+pvTaXcbs86qz5ocw+clydyrFRfLhWcIGuypG5FtBn2AtiJNdYXx6ki52LmFuczkUvyFFVv
	ifjNfjkXBeJA==
X-Google-Smtp-Source: AGHT+IFg+opR7QKrPek/aiw2KMWIeqj6WMrtKH54JNMGj4ISErFzTHBHopOhx9PIfMQ8GfRP14PjZg==
X-Received: by 2002:a05:6214:21e1:b0:6fd:ace:4cf8 with SMTP id 6a1803df08f44-704a39721a0mr25881386d6.30.1752206852620;
        Thu, 10 Jul 2025 21:07:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979e3146sm15991256d6.41.2025.07.10.21.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 21:07:32 -0700 (PDT)
Date: Thu, 10 Jul 2025 21:07:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Add IFF_NO_ADDRCONF to VF priv_flags
 before
Message-ID: <20250710210729.36231c98@hermes.local>
In-Reply-To: <20250711034021.11668-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711034021.11668-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 11:39:58 +0800
Li Tian <litian@redhat.com> wrote:

> Add an additional flag IFF_NO_ADDRCONF to prevent ipv6 addrconf.
> 
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> 
> This new flag change was not made to hv_netvsc resulting in the VF being
> assinged an IPv6.
> 
> Suggested-by: Cathy Avery <cavery@redhat.com>
> 
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/hyperv/netvsc_drv.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index c41a025c66f0..8be9bce66a4e 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -2317,8 +2317,11 @@ static int netvsc_prepare_bonding(struct net_device *vf_netdev)
>  	if (!ndev)
>  		return NOTIFY_DONE;
>  
> -	/* set slave flag before open to prevent IPv6 addrconf */
> +	/* Set slave flag and no addrconf flag before open
> +	 * to prevent IPv6 addrconf.
> +	 */
>  	vf_netdev->flags |= IFF_SLAVE;
> +	vf_netdev->priv_flags |= IFF_NO_ADDRCONF;
>  	return NOTIFY_DONE;
>  }
>  


Thanks this worked originally but got broken, please add:

Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
Cc: lucien.xin@gmail.com

Looks like team and failover have the same problem.

