Return-Path: <linux-hyperv+bounces-2981-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408D996D229
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B8228846A
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78AA2193424;
	Thu,  5 Sep 2024 08:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="Cq7Nsl98"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0563D1487C0;
	Thu,  5 Sep 2024 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525083; cv=none; b=H9qS/hinrwE2syAh/S1SEDSrfE8G5AOciYNP8g40sChew0IcKc0PsX9BAG9CbrzWm2wKA2GEUgQsXEydZNPWDGH3pF8CQMfkEndY46J32J2HTISKkPqhoLA4H4N1Qpf/SufXJnvl9fgr3xOSy1RB4f+xlCw8U0+WmJlT9IMxJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525083; c=relaxed/simple;
	bh=Mo3pv8nna+g3MgtN4jCHH0Q7EFRuxFLuDvY0BG0S0aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FhmzKdl8mO7mCTDn5HXosrX38Pfs5VJM2UxGjCixUA83XgKe2t2rTilyk1dr6nCyVJWvWhvdf7nKVuJ++2/hng2QszLIGpRopB19ntBGOjoM0Klf59kFau6Sozo+4yiEjbcn4j1b/C5Yszuqo7grBBhT+hX44TzQYh47E0YVZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=Cq7Nsl98; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725525058; x=1726129858; i=deller@gmx.de;
	bh=Mo3pv8nna+g3MgtN4jCHH0Q7EFRuxFLuDvY0BG0S0aY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Cq7Nsl98uPJDCt7m2WmN9rM7oAxG0VH97r2yKTiBIBgWbivhz+tGUi3lqicwPNcL
	 AVXdZbsQtCxUfh4G1W9kKyTubrj/WbtWlF2AJBEb/veUyPLv3mIEaPIuQBTXpL98O
	 LYGcZzd8RQVnhAuGYNXsKdTx4axvUgC85iE4xX1NipcwDY5ulG5of9nCzoAab37l5
	 SCLcE23HVJJoyWJezYL4PePmi1C/hL94h5/LQ3jE47/+TLUPFHuKbCbcspcunr92d
	 /Vp6Mbi1n5+AbJ0Rkj5pTUbkYHOZVx16s6Can59rsSxDu2R5MSDwVEjoMQcb19KEW
	 x5/cyoLubdgEjKGvKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MybKf-1rpd5r2mHF-00ywNM; Thu, 05
 Sep 2024 10:30:58 +0200
Message-ID: <5f6ce496-15cc-45d1-b3d0-10e362543a3c@gmx.de>
Date: Thu, 5 Sep 2024 10:30:56 +0200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev/hyperv_fb: Convert comma to semicolon
To: Wei Liu <wei.liu@kernel.org>, Chen Ni <nichen@iscas.ac.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 gpiccoli@igalia.com, mikelley@microsoft.com, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240902074402.3824431-1-nichen@iscas.ac.cn>
 <Ztlc52c6fIz3azbn@liuwe-devbox-debian-v2>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <Ztlc52c6fIz3azbn@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cMBy/c8U9lDq5XB93f6BZ342XLrpxBeKJowrfuymtYdmXw6J1ax
 HPFxbxP42tnNiBBM2IrRtDuWjA1mWAu6vVHz2nuWZqs4wlYHUQk5KvMPW/ALXtt0+qiX/gJ
 Gc6Sr+eg9mSg95bu3TE07rIlAM2utPHBARFDBHtWx+Y/RUB56itqNNTKVQf3WBXNd7kPCMG
 sWb9EZzckQTka7cuA9X0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EGT4DGNMYqo=;082i0+0KVEi/vGisvb43p2mSlDr
 HTn8xrazGEeNsV7GjZkimBRYhyarvQuGs13EOLJ4K3rdLB4nUXz3cnnMe7kCAXaSdf2Qdyr4T
 Z+7WXBxnelqRQYHq+zk4N0NqGZWMTeuClk+Mgbsu4HODbxuLUf7hjQ7/dCTrIsgQcKby2sdg9
 A7D7xdp7lEqKu6XXh/QC7YZzgiBh7KoVG7P2vEc4DzwTv2QJgBNj9SYYrDZealCiWgXhYQCAG
 9mbCpqPJkHq7nEjHK3bOwYWqeDy2c5jP7ffS5Scv4n3LrWZT6mL5Oa0YFI9zcrtSijuNi2gJC
 aqtjUyX01Lbvk+oxUIK9U0GRvV9OdNZ4quMB/Xq1HUhVQryKTkHW6HKTeYkG9CHTtlPCIlvup
 hqp0h+Cg0JaLOaMwAF0e3XD7ha+IAnoeMz5qtq6w6OKtZXsAlpTeRMzBPoILaYldkDw27ENqq
 7G9D1sg/hIkj6wTUvSEJsVNBOF1mR/4oIv4fhW8bMzVZJ6gPzWdRveaGZRBn9HSkGtYep6j4t
 o7CpWFvXG3N3RfG3OgFYnyDq4f7Xy2nHiri6j/ErSvAIen0LpI2QzMNqiROQTn440Zku0UlAL
 +jD4cAaZ3CvP8OZx1Zb90ioczRcIeC19ABZ6KZP40Hw1sj6kdKmZP4/rwWbsil8T7tnVz3/oI
 Eqi+QYlwz098bje6f+jQVACO2tHZY2KKbHJskLtSbo5jzsdEJATCYhg/Pv251RUeb7xwCpTuT
 BayxediaoxRzsOAV8AW9TvSSj61GefPfMgNJDmYTn5XyMXYR9hWHvJ9bW+Sq0z68gRyIHWy1w
 H3KTiZjtSKVvwUd/FdFy9GDw==

On 9/5/24 09:25, Wei Liu wrote:
> On Mon, Sep 02, 2024 at 03:44:02PM +0800, Chen Ni wrote:
>> Replace a comma between expression statements by a semicolon.
>>
>> Fixes: d786e00d19f9 ("drivers: hv, hyperv_fb: Untangle and refactor Hyp=
er-V panic notifiers")
>> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
>
> Applied to hyperv-fixes, thanks!

I added it to the fbdev git tree 3 days ago.

Either you or me should drop it from our trees.
Please let me know what you prefer.

Helge


