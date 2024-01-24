Return-Path: <linux-hyperv+bounces-1468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0783AD26
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 16:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3F6B2E3F9
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jan 2024 15:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037FB7C0AE;
	Wed, 24 Jan 2024 15:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOGtnf61"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698E17C0A8;
	Wed, 24 Jan 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109632; cv=none; b=AxhQbWji12Ul2ZK2nfxu3uWKQioLthcW4Z7lFFXFgQxP2xgZ7jjUwegDv4nfX7Xd5IPyI8NQl9rdYZubHSftd7O5U/Qo8nSPyE3fvVw+HparNWUWMbUPmH/zqtLILbutapJXIGBrC8NJoN/hppdBxCyb5HClDbc7ZJ5ghHxAb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109632; c=relaxed/simple;
	bh=yl+lF/nSLhu4DOrgjpjqsY/EIrxDU6VhvxzHFjldzhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyXH+2uuNcvHemoXVjLl4wZCQvW2II8iptpeDwUglhXXtWDEuzUsqbDqa6F1YtkN64IX+K2rP22tWYcKZvV6eV65a40M94C6L4Lq3oJJonPekejRyDizgv+u9HasOTecXm+N7TVTjnNCC3RAUwyrpilBtQ3cMX7ZmslDOpPIvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOGtnf61; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-da7ea62e76cso4627221276.3;
        Wed, 24 Jan 2024 07:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706109630; x=1706714430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vBrnRIicx5pIHGkAjgFXGDh8NZNQs8Sa9JhNIEiHKg=;
        b=iOGtnf61tZDsAiHZiiszBLVV1/POqhATNfnGLR8vv+J6vE50aecVsV1j2bwF8+f36U
         7/N2dZtxYe0lacPFYArkqcBAuqSg8VzArt8qNfhHactpOLPMxgK6opNGFB+/MJJyWDgl
         Kha9v462UgGnl0zhRHA8IOA5E06dfX5Uhac7rLy8LSx3jLP2lvSxoR6OzWqYSiMas5EM
         hKqkAlU8u0IuNH7LftL9uLOe/ZGSmd0z8o1/ke+jweOxW84FZ2ixAoLNldOfxAGdOMEw
         BhRuMnbJvrj5VCPuuY6B/1IVcZYfVsKk2Uv0ECk5tjvGi0vDRUw3feHoMVAWYOX0WtVh
         Dlzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706109630; x=1706714430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vBrnRIicx5pIHGkAjgFXGDh8NZNQs8Sa9JhNIEiHKg=;
        b=gWcbyesfldPUBSykpM8ql7+AGDavLdmehC3YVslmIIY0+cLoXs94XVEKMW6BcfI8va
         hZm4dVeR9PQBxBrWlhngtjLEkMxv2EiF+nr1ht9+/EKULHPfotklG5u3d00HcRznTaXk
         q+iFrYyVPC07SADUbHVeOsTZCmDGfd0I3zKPtkZfBozcvh0JmRi6yGcyMF013mYA4lBC
         cQ01ov0mDbCQq6s2WIFGaWgJjyKgpXLAM6NIYZPhS/fY9ncv4Cms8/WwMyswVzWs0AiR
         5pq2VMnBV/Ebzbvr+RaBmUZR943C1QpWzkT9jwWOqIwjTz1+e/rPNnNegTJpKfk8xsk6
         dHqQ==
X-Gm-Message-State: AOJu0YwalUifS519Tpet5HuSyc361gwdMEf9HYGz0f21Nwd59EO+T+EU
	N9+sZ2wcg9Xsbzl75Byh0Y+apq7hKX4G94nUvxC39E+0fCgTUaRI
X-Google-Smtp-Source: AGHT+IERVG+64Qw6cNxzILHtVXa3i4+0rPfmcDUrLp45sk1QkdaktdxCBMKuQ0ojt690g3KthLLZKA==
X-Received: by 2002:a25:dcd2:0:b0:dc2:2888:e3d1 with SMTP id y201-20020a25dcd2000000b00dc22888e3d1mr745356ybe.80.1706109629562;
        Wed, 24 Jan 2024 07:20:29 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:abdb:7236:6977:9ab5])
        by smtp.gmail.com with ESMTPSA id i12-20020a25f20c000000b00db41482d349sm2812032ybe.57.2024.01.24.07.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 07:20:29 -0800 (PST)
Date: Wed, 24 Jan 2024 07:20:27 -0800
From: Yury Norov <yury.norov@gmail.com>
To: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, longli@microsoft.com,
	leon@kernel.org, cai.huoqing@linux.dev, ssengar@linux.microsoft.com,
	vkuznets@redhat.com, tglx@linutronix.de,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	schakrabarti@microsoft.com, paulros@microsoft.com
Subject: Re: [PATCH 4/4 V2 net-next] net: mana: Assigning IRQ affinity on HT
 cores
Message-ID: <ZbEqu68J3f9W8nIM@yury-ThinkPad>
References: <1705939259-2859-1-git-send-email-schakrabarti@linux.microsoft.com>
 <1705939259-2859-5-git-send-email-schakrabarti@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705939259-2859-5-git-send-email-schakrabarti@linux.microsoft.com>

On Mon, Jan 22, 2024 at 08:00:59AM -0800, Souradeep Chakrabarti wrote:
> Existing MANA design assigns IRQ to every CPU, including sibling
> hyper-threads. This may cause multiple IRQs to be active simultaneously
> in the same core and may reduce the network performance.
> 
> Improve the performance by assigning IRQ to non sibling CPUs in local
> NUMA node. The performance improvement we are getting using ntttcp with
> following patch is around 15 percent against existing design and
> approximately 11 percent, when trying to assign one IRQ in each core
> across NUMA nodes, if enough cores are present.
> The change will improve the performance for the system
> with high number of CPU, where number of CPUs in a node is more than
> 64 CPUs. Nodes with 64 CPUs or less than 64 CPUs will not be affected
> by this change.
> 
> The performance study was done using ntttcp tool in Azure.
> The node had 2 nodes with 32 cores each, total 128 vCPU and number of channels
> were 32 for 32 RX rings.
> 
> The below table shows a comparison between existing design and new
> design:
> 
> IRQ   node-num    core-num   CPU        performance(%)
> 1      0 | 0       0 | 0     0 | 0-1     0
> 2      0 | 0       0 | 1     1 | 2-3     3
> 3      0 | 0       1 | 2     2 | 4-5     10
> 4      0 | 0       1 | 3     3 | 6-7     15
> 5      0 | 0       2 | 4     4 | 8-9     15
> ---
> ---
> 25     0 | 0       12| 24    24| 48-49   12
> ---
> 32     0 | 0       15| 31    31| 62-63   12
> 33     0 | 0       16| 0     32| 0-1     10
> ---
> 64     0 | 0       31| 31    63| 62-63   0

Did that omitted lines mean 5-24 : 15%, 25-31 : 12% and 33-63 : 10%?
Or that means that you didn't test those?

Would be nice to have full coverage...

Thanks,
Yury

