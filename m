Return-Path: <linux-hyperv+bounces-7522-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67374C51CF0
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 12:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8EB3A9D9B
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82B72FDC3C;
	Wed, 12 Nov 2025 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Fsz/g+Uu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E65429BD9B;
	Wed, 12 Nov 2025 10:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944583; cv=none; b=lMKAlXL5jYxp6L1ED3KhxDRZvmAA3Pt7YFvFEVYGQrn9yjJyhPKs9+kfHUTTNqdLi6yKGnh7yppOBz3+VRNgvrbakUPXgUz3v6v9Hw4gXET/nzjIi1MBQ3ITN+Snniu04F/uPXf8xk2FlNhp1XdU2b5uOAD24u6pJH0Kal8IBqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944583; c=relaxed/simple;
	bh=IX8qUzUk3b50d98YAIPFiw12dnof336Skxvj7fpuE1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PsmatbMSgEDpcLwzl2csm+yd3sW5sBTfJ+TpjecMwSJncWslqh2cG60q8Mtgj78vYyorZ23XcEvF9YjjoOExZ4Etqht1EKA7UCGbFWyFm4sQ0qW1oPpboqtWlCLxx0obDwxrJsXSbjuUUfZH6wzASeTlTe170fAHlYQZdJvZ8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Fsz/g+Uu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.76.239] (unknown [167.220.238.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 993352013353;
	Wed, 12 Nov 2025 02:49:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 993352013353
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1762944575;
	bh=reATR7Vd96fAhYPF9PhiaC2fKXVLrWC6D+RVNdAQn/c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Fsz/g+Uuur8Zt7TR/S5q3RyNfjAJF1wKUlPa2HNMw5mHuKV20pBflG8/yzqDc8qs1
	 2FEwFycNntX9fJUjRZEDaLEKaibXeFQsmnEJiJCzwJFAjUXiiZf3JqBIfVly8+tlO5
	 /rCKSgBgnDct4+aegi1YLk/Ww8zQY/Jru4jiphiQ=
Message-ID: <e7740f58-34cd-4bee-9786-8f3f6654ff3f@linux.microsoft.com>
Date: Wed, 12 Nov 2025 16:19:26 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/2] Drivers: hv: Introduce mshv_vtl driver
To: Peter Zijlstra <peterz@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 Mukesh Rathor <mrathor@linux.microsoft.com>,
 Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Christoph Hellwig <hch@infradead.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>,
 ALOK TIWARI <alok.a.tiwari@oracle.com>
References: <20251110050835.1603847-1-namjain@linux.microsoft.com>
 <20251110050835.1603847-3-namjain@linux.microsoft.com>
 <20251110143834.GA3245006@noisy.programming.kicks-ass.net>
 <f32292e6-b152-4d6d-b678-fc46b8e3d1ac@linux.microsoft.com>
 <20251111081352.GD278048@noisy.programming.kicks-ass.net>
 <SN6PR02MB4157C399DB7624C28D0860AAD4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251112093704.GC4067720@noisy.programming.kicks-ass.net>
 <SN6PR02MB4157F3F565621B32AC29EC92D4CCA@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20251112101038.GE4067720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20251112101038.GE4067720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/2025 3:40 PM, Peter Zijlstra wrote:
> On Wed, Nov 12, 2025 at 09:44:20AM +0000, Michael Kelley wrote:
> 
>> Thanks. If that symbol is referenced only by these few lines, I'd
>> go with something even shorter and simpler. Perhaps:
>>
>> .section		.discard.addressable,"aw"
>> .align 8
>> .type	vtl_return_sym, @object
>> .size	vtl_return_sym, 8
>> vtl_return_sym:
>> .quad	__SCK____mshv_vtl_return_hypercall
>>
>> Regardless of the choice of symbol name, add a comment about
>> mimicking __ADDRESSABLE(). That feels less messy to me, but
>> it's Naman's call.
> 
> Right, that'll work.

Thanks Michael, Peter and Paolo for your inputs.
I'll use a simpler name and add a comment to explain it.

Regards,
Naman

