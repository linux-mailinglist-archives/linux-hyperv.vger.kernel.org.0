Return-Path: <linux-hyperv+bounces-1751-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A987B6B2
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 04:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 913641C217F6
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Mar 2024 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2844A08;
	Thu, 14 Mar 2024 03:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="2Vshv+GJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D194AC13B
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Mar 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385550; cv=none; b=k8ky6VX5XSSdQgKtoQla5g02uJTR5yKVcj4UZFpB8qLjTVgL7TErLwe8BmB4hyAy6kdRYHpWxB3joQLfUecz8AEs7KrWIqbNp9LWfcywH+CAoOkjm2GD82e10qHVb9aHjJ2oyfpAR/r9cahh4H241Yap0iz78ZDa6OabT21sPis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385550; c=relaxed/simple;
	bh=nzHsNFvD08F/Zbn2c2LaSTkT6hmpbR0tfRVGn4qDRZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/CEuru44Czf/KjsHpeqFRXQ0yKItJy/F5PGj1t/GdSq+mqan6bUxID2mA0g/iN7HpPxmmoHkFwyz9YwdY7Im+MdP8NTLLi7C5x/e1AJ0C8fWtyOSYUV1Dcn52Np5hvFoavlaK1UNd1ceiOGQLmxDzEPHf3B2sImrlUXLuCWvOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=2Vshv+GJ; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c1e992f069so270192b6e.3
        for <linux-hyperv@vger.kernel.org>; Wed, 13 Mar 2024 20:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1710385548; x=1710990348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98hcDOBZvaroc2+oacr4ZrQ8unl3av3V7BSDIFqC1Do=;
        b=2Vshv+GJWxLZ1eHZa0kp8b0uIQBQKArMYFafxYYKUKAG9oa7qIBZctluHpc5HKX1PS
         H1Aik0YpEypBpq0+l2q3IZdG17pet2ItYw7NKBGZZk1mpZEB0TSnrYthWc5e+9tLKai4
         AjUG+70IRFoSEuKkHcngZjzy/ibAypTbmwJEDP4HWwLu73v+CqwtYkosLyxD6RQyTMyG
         i7STeaKb6r10Tu8NwCyygIxqoX8y/DQHxy5hTZl3yFGZqIbJJY4AbTfz2A6qHCMD03J/
         PZVgQnzf637Jk8BmqN0JqGEzwv2LBXUwsxjpkYJ0mALLZ7mtgRFKR6kvEMYtU9eof/KI
         GoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710385548; x=1710990348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98hcDOBZvaroc2+oacr4ZrQ8unl3av3V7BSDIFqC1Do=;
        b=flijPeAfGUUNYBpQ/WTJKutoHzaVNtcBTQFwnnjtdSz6dddKyRvq/m3LPeQMWIsNgS
         fWjrUt4xTmOBIHTjWZCFf3mD1eUm9L1e8g7XNNAcoBjf5rvDDsASxp/SYoYIpvCpgnHG
         A3QdxQGIJvsMyikQMh8AnXjKxF5P/k6zUee4SUpdNbDqPC/5J0mC8Lr8bFE7UEqE/fX2
         nJDJy76zEY1OJ1kaRowQ9N2i2kKlkhi8k+zOg8m5lYVgg7MnefkjYPQl7n9kB6sAIptR
         nZIMCjlIs7Oho48ZKRwDPXgrGokeHq4NsAQ/oZvfX1uA1kskkv2uft3XUqq4UV87JnCp
         gszw==
X-Forwarded-Encrypted: i=1; AJvYcCWNeSigXxXPe2Mj8SGB+h05x6HVzWGYEgCmHto2FFQNWqUksuoBY4xav/eQHPMr4l2XSFbLr0g3o3t6soeJBvjZZZjqQDKkKYXy1v99
X-Gm-Message-State: AOJu0YynssKMEcqhCs89o01texf7PlFgGRm5xZzNSBkcNtqRs/6biHc2
	d1qU79GjJoerLuN1lhW2bYr8vCgWJSH2l6nyuC7CfCyvBFScvzdhhBasWCxzA0c=
X-Google-Smtp-Source: AGHT+IH8jXxx+hI00ezBUfySDM1W3l88QP5JU2OGTxkoAjI8sgm/aK0LBANljHKg3KhJEKs+gsv5Mw==
X-Received: by 2002:a54:480d:0:b0:3c2:1d9e:b7fe with SMTP id j13-20020a54480d000000b003c21d9eb7femr441294oij.30.1710385547828;
        Wed, 13 Mar 2024 20:05:47 -0700 (PDT)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id i4-20020aa787c4000000b006e6ab7cb10esm325263pfo.186.2024.03.13.20.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 20:05:47 -0700 (PDT)
Date: Wed, 13 Mar 2024 20:05:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, Shradha Gupta <shradhagupta@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Leon Romanovsky <leon@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, KY Srinivasan <kys@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, Long Li
 <longli@microsoft.com>, Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] net :mana : Add per-cpu stats for MANA device
Message-ID: <20240313200545.656f6dd6@hermes.local>
In-Reply-To: <20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1709823132-22411-1-git-send-email-shradhagupta@linux.microsoft.com>
	<20240307072923.6cc8a2ba@kernel.org>
	<DM6PR21MB14817597567C638DEF020FE3CA202@DM6PR21MB1481.namprd21.prod.outlook.com>
	<20240307090145.2fc7aa2e@kernel.org>
	<CH2PR21MB1480D3ACADFFD2FC3B1BB7ECCA272@CH2PR21MB1480.namprd21.prod.outlook.com>
	<20240308112244.391b3779@kernel.org>
	<20240311041950.GA19647@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
	<20240314025720.GA13853@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 19:57:20 -0700
Shradha Gupta <shradhagupta@linux.microsoft.com> wrote:

> Following is the data we can share:
> 
> Default interrupts affinity for each queue:
> 
>  25:          1        103          0    2989138  Hyper-V PCIe MSI 4138200989697-edge      mana_q0@pci:7870:00:00.0
>  26:          0          1    4005360          0  Hyper-V PCIe MSI 4138200989698-edge      mana_q1@pci:7870:00:00.0
>  27:          0          0          1    2997584  Hyper-V PCIe MSI 4138200989699-edge      mana_q2@pci:7870:00:00.0
>  28:    3565461          0          0          1  Hyper-V PCIe MSI 4138200989700-edge      mana_q3
> @pci:7870:00:00.0
> 
> As seen the CPU-queue mapping is not 1:1, Queue 0 and Queue 2 are both mapped 
> to cpu3. From this knowledge we can figure out the total RX stats processed by
> each CPU by adding the values of mana_q0 and mana_q2 stats for cpu3. But if
> this data changes dynamically using irqbalance or smp_affinity file edits, the
> above assumption fails. 


irqbalance is often a bad idea.
In the past, doing one shot balancing at startup was a better plan.

