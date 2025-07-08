Return-Path: <linux-hyperv+bounces-6138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8873FAFC1F8
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 07:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8F24A4DCC
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 05:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F991FC109;
	Tue,  8 Jul 2025 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="icyvUmFA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D714185955;
	Tue,  8 Jul 2025 05:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751952217; cv=none; b=t38OQTVfJJlJWBHMCPxLD8D5MJtUFzK8Pc4ntvkyMazA3vTJKIdvn107CQ6PB/HQDNJ8incc7K8vHeVAoGr/m5M01GW6v9tkERLER3yRXuW0Y5ap1/e2J0PoZggeZ0NQnARAZ0q1MVtFd1KOf2q105JG0LnBeXiW8NlsBWJAjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751952217; c=relaxed/simple;
	bh=thPndo6dlWTfZeTyIzp/4+EhMFDLJTB+q35Ha5618eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pPDZBVAIxX9GDvG8HKOCb/9uGyhhLw0NVuH+6dRJ5K9CZXMY4qffSI/QmjjTEDFb407Zdi24v7ReQUF/mJtll1ofmhlPajhH8nEH1b2YMz4BIIYAUCwE+AfQapuVwf89LpjpBfGuAVnzjvsLMtgpuqEWzUCFvGNbGXXcdJ/8o9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=icyvUmFA; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751952195; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cMZqnaTHDwkxEpl+JaYOXi3Kcl7BjC2nVgGg3nctPaY=;
	b=icyvUmFAJ53Rt7JLVDbPMDBDooYQrgbDcoO0GKOTu7dS6jRp0g2648PjOL3+IfMbgtgNgXo0WTlCUcEJ+qPcVDT6llLGbnKS7AuER5N5QdnWAlAL4Ta0G5FVnRRnhjukaRWAvSj3uHILl8/Y3hNfXuKVNj7UIs92tah94uEc4aA=
Received: from 30.172.244.77(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhHy2Tm_1751952194 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 13:23:15 +0800
Message-ID: <9d9adafc-71d8-4e24-b5a0-7acd1b538ae7@antgroup.com>
Date: Tue, 8 Jul 2025 13:23:13 +0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/4] vsock: Introduce SIOCINQ ioctl support
To: Stefano Garzarella <sgarzare@redhat.com>,
 Xuewei Niu <niuxuewei97@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fupan.lfp@antgroup.com
References: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
 <yx44jpqxyi5yujwgdvyzajsjyf6rjqht5ypvp7q72imc6cfs2e@7yzhohzyilpq>
Content-Language: en-US
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
In-Reply-To: <yx44jpqxyi5yujwgdvyzajsjyf6rjqht5ypvp7q72imc6cfs2e@7yzhohzyilpq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2025/7/7 21:44, Stefano Garzarella wrote:
> On Sun, Jul 06, 2025 at 12:36:28PM +0800, Xuewei Niu wrote:
>> Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
>> bytes.
>>
>> Similar with SIOCOUTQ ioctl, the information is transport-dependent.
>>
>> The first patch adds SIOCINQ ioctl support in AF_VSOCK.
>>
>> Thanks to @dexuan, the second patch is to fix the issue where hyper-v
>> `hvs_stream_has_data()` doesn't return the readable bytes.
>>
>> The third patch wraps the ioctl into `ioctl_int()`, which implements a
>> retry mechanism to prevent immediate failure.
>>
>> The last one adds two test cases to check the functionality. The changes
>> have been tested, and the results are as expected.
>>
>> Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>
>>
>> -- 
>>
>> v1->v2:
>> https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
>> - Use net-next tree.
>> - Reuse `rx_bytes` to count unread bytes.
>> - Wrap ioctl syscall with an int pointer argument to implement a retry
>>  mechanism.
>>
>> v2->v3:
>> https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
>> - Update commit messages following the guidelines
>> - Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
>> - Move the tests to the end of array
>> - Split the refactoring patch
>> - Include <sys/ioctl.h> in the util.c
>>
>> v3->v4:
>> https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
>> - Hyper-v `hvs_stream_has_data()` returns the readable bytes
>> - Skip testing the null value for `actual` (int pointer)
>> - Rename `ioctl_int()` to `vsock_ioctl_int()`
>> - Fix a typo and a format issue in comments
>> - Remove the `RECEIVED` barrier.
>> - The return type of `vsock_ioctl_int()` has been changed to bool
>>
>> v4->v5:
>> https://lore.kernel.org/netdev/20250630075727.210462-1-niuxuewei.nxw@antgroup.com/
>> - Put the hyper-v fix before the SIOCINQ ioctl implementation.
>> - Remove my SOB from the hyper-v fix patch.
> 
> Has I mentioned, that was not the issue, but the wrong Author.

I see it now. I'll update the author in v6. 
> There are also other issue, not sure how you're sending them, but I guess there are some issues with you `git format-patch` configuration:

I was using my personal email. I have changed to the right email now.

Hope everything goes fine with the next version.

Thanks,
Xuewei

> 
> $ ./scripts/checkpatch.pl -g net-next..HEAD --codespell
> -----------------------------------------------------------------------------------
> Commit ed36075e04ec ("hv_sock: Return the readable bytes in hvs_stream_has_data()")
> -----------------------------------------------------------------------------------
> WARNING: 'multpile' may be misspelled - perhaps 'multiple'?
> #23:
> Note: there may be multpile incoming hv_sock packets pending in the
>                    ^^^^^^^^
> 
> ERROR: Missing Signed-off-by: line by nominal patch author 'Xuewei Niu <niuxuewei97@gmail.com>'
> 
> total: 1 errors, 1 warnings, 0 checks, 29 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Commit ed36075e04ec ("hv_sock: Return the readable bytes in hvs_stream_has_data()") has style problems, please review.
> ------------------------------------------------------------
> Commit 4e5c39e373fa ("vsock: Add support for SIOCINQ ioctl")
> ------------------------------------------------------------
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Xuewei Niu <niuxuewei97@gmail.com>' != 'Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>'
> 
> total: 0 errors, 1 warnings, 0 checks, 28 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Commit 4e5c39e373fa ("vsock: Add support for SIOCINQ ioctl") has style problems, please review.
> ------------------------------------------------------------------------
> Commit 3eb323b2d9f4 ("test/vsock: Add retry mechanism to ioctl wrapper")
> ------------------------------------------------------------------------
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Xuewei Niu <niuxuewei97@gmail.com>' != 'Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>'
> 
> total: 0 errors, 1 warnings, 62 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
> 
> Commit 3eb323b2d9f4 ("test/vsock: Add retry mechanism to ioctl wrapper") has style problems, please review.
> 
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> 
>> - Move the `need_refill` initialization into the `case 1` block.
>> - Remove the `actual` argument from `vsock_ioctl_int()`.
>> - Replace `TIOCINQ` with `SIOCINQ`.
>>
>> ---
>> Xuewei Niu (4):
>>      hv_sock: Return the readable bytes in hvs_stream_has_data()
>>      vsock: Add support for SIOCINQ ioctl
>>      test/vsock: Add retry mechanism to ioctl wrapper
>>      test/vsock: Add ioctl SIOCINQ tests
>>
>> net/vmw_vsock/af_vsock.c         | 22 +++++++++++
>> net/vmw_vsock/hyperv_transport.c | 17 +++++++--
>> tools/testing/vsock/util.c       | 30 ++++++++++-----
>> tools/testing/vsock/util.h       |  1 +
>> tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
>> 5 files changed, 137 insertions(+), 12 deletions(-)
>> ---
>> base-commit: 5f712c3877f99d5b5e4d011955c6467ae0e535a6
>> change-id: 20250703-siocinq-9e2907939806
>>
>> Best regards,
>> -- 
>> Xuewei Niu <niuxuewei.nxw@antgroup.com>
>>


