Return-Path: <linux-hyperv+bounces-7523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE5C523B0
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 13:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DC634EC6CF
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 12:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900B231A803;
	Wed, 12 Nov 2025 12:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N8dKgF+b"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1834231A567;
	Wed, 12 Nov 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762949588; cv=none; b=HJUCH7NJ8bF7Ec2ploKFUsDIRqaD26H7GOQWJto7EKLDqUMenTILaisYzpFv7gxz6KYBmnVXW1Qvjp516aZtYdOW6/o+/Q1J9VTyA5ZoeLVBuqYQhXW4tbqhu3lU1OARgdJcwU+UhdgDFfP2yJHMkQRAiVreyOpApZlZkJalj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762949588; c=relaxed/simple;
	bh=uHeWggc4Y+HBu8JcrFCdpsRNnnvcG7IPVDYv7jeArcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2Ib2DCwu18u1D7591ULrCDWYUXpg98s7CyZGZ4RgDpwu6DdzihFXQA+oeNDX9zBV0Re8dd5QZUecLYdNZym4ptcbXm8FLkXVMlW/ddTMH+MMuPNVNHtX4l7ng2mQV2zsDI7gpi5xW1AsS5nENr21SVACpvs+51GbUfoXoMFGj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N8dKgF+b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.18.184.99] (unknown [167.220.238.131])
	by linux.microsoft.com (Postfix) with ESMTPSA id C49782013350;
	Wed, 12 Nov 2025 04:13:00 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C49782013350
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762949586;
	bh=t2jH1NsioqiNKq4LlkFnbTBTGq5SSypFVXS+iRXhH7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N8dKgF+byg3Nyhdhxhp4/xD4c47fuUZVVHvqPcppsuvp6YFHPl/JWOBqCoqXvqFGc
	 raGhrIQWJsg9Y8ZAnSkRDj0rZnH7RtwYwN2eBslj+FvyxYj3KhNMg6SldfsXdA9Eut
	 czhPt2jfGz0kDu8F8qH4Y7+NJUn8qzuTWJgCfITM=
Message-ID: <112034e2-8177-44f1-8bd4-91e44d643ff4@linux.microsoft.com>
Date: Wed, 12 Nov 2025 17:42:58 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: mana: Drop TX skb on
 post_work_request failure and unmap resources
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, longli@microsoft.com,
 kotaranov@microsoft.com, horms@kernel.org, shradhagupta@linux.microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com, leon@kernel.org,
 mlevitsk@redhat.com, yury.norov@gmail.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, gargaditya@microsoft.com
References: <1762848781-357-1-git-send-email-gargaditya@linux.microsoft.com>
 <1762848781-357-3-git-send-email-gargaditya@linux.microsoft.com>
 <20251111170837.602904ee@kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20251111170837.602904ee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12-11-2025 06:38, Jakub Kicinski wrote:
> On Tue, 11 Nov 2025 00:13:01 -0800 Aditya Garg wrote:
>> Drop TX packets when posting the work request fails and ensure DMA
>> mappings are always cleaned up.
> 
> drivers/net/ethernet/microsoft/mana/gdma_main.c:1303:23: warning: variable 'gc' set but not used [-Wunused-but-set-variable]
>   1303 |         struct gdma_context *gc;
>        |                              ^

Thanks for pointing this out. Will fix this in next revision.

Regards,
Aditya

