Return-Path: <linux-hyperv+bounces-8056-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC01ECCE4DA
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Dec 2025 03:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6439F305BFDE
	for <lists+linux-hyperv@lfdr.de>; Fri, 19 Dec 2025 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1028A3F8;
	Fri, 19 Dec 2025 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="P4PjLmrh"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E82BDC03
	for <linux-hyperv@vger.kernel.org>; Fri, 19 Dec 2025 02:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766112811; cv=none; b=MLtRodpgaVmvmIsRpk85BQPEosXc3buWhbDB/aqY++dU+Pb/YqVVAGEBiK/c59f8ClII/9ZXCu/P3jFafDjEdKN8RBt6U7RE3kkWur3lEvot3wqkDOmUcQ+0i8ZenChGC9WjNXGimfFYYdRFhHmY/3ing1w6fgr5d8MtupxrjhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766112811; c=relaxed/simple;
	bh=AuTX65V3JLnGhvP/vnLYKJptahJFmpjAno8GOEofUPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa3aWpJ/BGx5BWtiPqAsOZvNjYj+jc7EsZoX/KprUwicNWWi00hFd5lKnMc77Eyo27dF49JJCR973PIBBlzi6UF8jEOR06X2OIfaHbmtn/w9nRQTqaXSSRMeHywPwquCPzRB14QVKpmfloOZCgeoSBm8a8xbWpLGmzjFoAm04Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=P4PjLmrh; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5001b.ext.cloudfilter.net ([10.0.29.181])
	by cmsmtp with ESMTPS
	id WPmovHZ6oKXDJWQcNvBJyT; Fri, 19 Dec 2025 02:53:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id WQcMvHwgVMvWIWQcNvipuR; Fri, 19 Dec 2025 02:53:23 +0000
X-Authority-Analysis: v=2.4 cv=Ud5RSLSN c=1 sm=1 tr=0 ts=6944be23
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=ujWNxKVE5dX343uAl30YYw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=XhWbaVAy7xEXXl44f-sA:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ALKBGoGMdPGtSNDGcZh3KUBZxKBEajnQ+q5oKWA11Zk=; b=P4PjLmrhutqtkBl0Du9R+rta+r
	HaVRlHkqZJ5MVj7FGrZRdJhfJbhu3nTnK1TvO+vl9JvyV+JH0yC1qNHg7ZN+aOlcCprUqVwJPjlDK
	Fyr9NSYNpB+OoUxDj0U+iNY2bsG6BWTxwTbCvXi/3NhRJBLpH8CFD3SljluihYN68WD+7k0L0mio5
	Ex6WDLn0kAwh5gL60DUFaBOqUHPahP87/XYf/+SFXfjFA1zFo8kSDwmPuDaCXIO7oW18L0+Jf6fWF
	8zgQSj1Et8p6Zl96ViOPrf8XZ3sO1h/0mvL5MM2HtnRk5xyCdxLlGzMSiALQZKgM/AjLqSBKNAS5r
	Nzgr3D6g==;
Received: from i118-18-233-1.s41.a027.ap.plala.or.jp ([118.18.233.1]:60394 helo=[10.83.24.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1vWQcM-00000003cGZ-0Hjm;
	Thu, 18 Dec 2025 20:53:22 -0600
Message-ID: <cb7d056c-1647-409a-a6ca-0be264137041@embeddedor.com>
Date: Fri, 19 Dec 2025 11:53:16 +0900
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hyperv: Avoid -Wflex-array-member-not-at-end
 warning
To: Wei Liu <wei.liu@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <aTu54qH2iHLKScRW@kspp>
 <20251218194231.GC1749918@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20251218194231.GC1749918@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 118.18.233.1
X-Source-L: No
X-Exim-ID: 1vWQcM-00000003cGZ-0Hjm
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: i118-18-233-1.s41.a027.ap.plala.or.jp ([10.83.24.44]) [118.18.233.1]:60394
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 11
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCuD+1cwJUXwuIInTTHoZzWPfsxydmw01x/k+dXDZ9LZsuo4SbIt0TouU1wtLzDjWxLH35l4F3bIKVO2UeoEDjIKBvd+MZZuTPS+KaWCuXcA11J10f1W
 quX/ppIYleStiy3Gd8M1a0bnSdtOSYIBdiudWiX8JIrb+e6hYoewbDAOZR50JoRtBLOW+JbZb5EsawVw5XSCompLB/I8+v7sPXqvHKrObLEIpef7uK5tMnii



On 12/19/25 04:42, Wei Liu wrote:
> On Fri, Dec 12, 2025 at 03:44:50PM +0900, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Use the new __TRAILING_OVERLAP() helper to fix the following warning:
>>
>> include/hyperv/hvgdk_mini.h:581:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> This helper creates a union between a flexible-array member (FAM) and a
>> set of MEMBERS that would otherwise follow it.
>>
>> This overlays the trailing MEMBER u64 gva_list[]; onto the FAM
>> struct hv_tlb_flush_ex::hv_vp_set.bank_contents[], while keeping
>> the FAM and the start of MEMBER aligned.
>>
>> The static_assert() ensures this alignment remains, and it's
>> intentionally placed inmediately after the related structure --no
>> blank line in between.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied. I fixed a typo in the commit message ("inmediately" ->
> "immediately").

Awesome. :)

Thanks
-Gustavo

