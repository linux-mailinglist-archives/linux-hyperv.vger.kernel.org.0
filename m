Return-Path: <linux-hyperv+bounces-72-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A90827A0544
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 15:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62ECD1F239A6
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Sep 2023 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9AF1D68F;
	Thu, 14 Sep 2023 13:15:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B2A241E0
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 13:15:58 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640DB1BEB
	for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 06:15:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so13426935e9.1
        for <linux-hyperv@vger.kernel.org>; Thu, 14 Sep 2023 06:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1694697356; x=1695302156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QLvdeLJFaVHjTuDoy38D6XQS7QdszFti2O5CeB4RYlA=;
        b=H79lOWAX5BPBFOdAn1Ls5n/4U5LrplNHBcu1rIc7moNmBpym0HelwhDGyK3yWrCkK6
         YAnVKR5qigfI+orFzxqnSf+VxYJ/OAgSD2+fPBosbnB3Dg6ODx4xFcF8Y5OfLIazP0q+
         +JJvOLGq1e7SwSoTNzHpPwoBD7HAV3nLiof+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694697356; x=1695302156;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QLvdeLJFaVHjTuDoy38D6XQS7QdszFti2O5CeB4RYlA=;
        b=I0EnRK5hTEr8JH7iFlDDEor72clpbKgaHUaTrQsFJ09tlVBCNqaH/FQYlNQontnfp0
         Yogswicul0AzXXf6asHcisW7lsxfWOVSCG8+D3+dk96LbQIcnG3gMhQsTnFA8i4eBdm6
         n8/+SY0OIV1+MEETO3z0IS/gqt5oTlF0WxrRTLTmApc7GKpwZUjy15o0QgX/WM36BiOK
         Xck/F/2AjjGyRYDR93nKB8NHtLakx3NN2r4tgBWroRBh6mZdiMeWxwrJgRT7XCXVizSN
         6VO1aqhG2xGzjRPGSxfRplG97DcqOcLVjgsMzNkipFyrO9rqOZMVDp81jG8y4Wgioz6Z
         Fd/A==
X-Gm-Message-State: AOJu0YyewY2M0jLZSV74Nee1AF1XL8tH2H0Bf/f9veg3hxoJVbNUNtTp
	lbQGYmD53xpdOURBkpuZbHj5XQ==
X-Google-Smtp-Source: AGHT+IEIu7wWXsXFgmC0TpcZPq12QhcsescNI+urHKtYHceqhxoChsC2ACdOD0NH7oyI9K+8uKKgUg==
X-Received: by 2002:a05:6000:4013:b0:319:735f:92c5 with SMTP id cp19-20020a056000401300b00319735f92c5mr1634592wrb.32.1694697355769;
        Thu, 14 Sep 2023 06:15:55 -0700 (PDT)
Received: from [10.80.67.28] (default-46-102-197-194.interdsl.co.uk. [46.102.197.194])
        by smtp.gmail.com with ESMTPSA id r10-20020adfdc8a000000b0031aeca90e1fsm1775995wrj.70.2023.09.14.06.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:15:55 -0700 (PDT)
Message-ID: <7d907488-d626-0801-3d4b-af42d00a5537@citrix.com>
Date: Thu, 14 Sep 2023 14:15:54 +0100
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From: andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 08/38] x86/cpufeatures: Add the cpu feature bit for
 FRED
Content-Language: en-GB
To: Jan Beulich <jbeulich@suse.com>, Juergen Gross <jgross@suse.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, luto@kernel.org,
 pbonzini@redhat.com, seanjc@google.com, peterz@infradead.org,
 ravi.v.shankar@intel.com, mhiramat@kernel.org, jiangshanlai@gmail.com,
 Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-9-xin3.li@intel.com>
 <d98a362d-d806-4458-9473-be5bea254db7@suse.com>
 <77ca8680-02e2-cdaa-a919-61058e2d5245@suse.com>
In-Reply-To: <77ca8680-02e2-cdaa-a919-61058e2d5245@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/09/2023 7:09 am, Jan Beulich wrote:
> On 14.09.2023 08:03, Juergen Gross wrote:
>> On 14.09.23 06:47, Xin Li wrote:
>>> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>>>
>>> Any FRED CPU will always have the following features as its baseline:
>>>    1) LKGS, load attributes of the GS segment but the base address into
>>>       the IA32_KERNEL_GS_BASE MSR instead of the GS segment’s descriptor
>>>       cache.
>>>    2) WRMSRNS, non-serializing WRMSR for faster MSR writes.
>>>
>>> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
>>> Tested-by: Shan Kang <shan.kang@intel.com>
>>> Signed-off-by: Xin Li <xin3.li@intel.com>
>> In order to avoid having to add paravirt support for FRED I think
>> xen_init_capabilities() should gain:
>>
>> +    setup_clear_cpu_cap(X86_FEATURE_FRED);
> I don't view it as very likely that Xen would expose FRED to PV guests
> (Andrew?), at which point such a precaution may not be necessary.

PV guests are never going to see FRED (or LKGS for that matter) because
it advertises too much stuff which simply traps because the kernel is in
CPL3.

That said, the 64bit PV ABI is a whole lot closer to FRED than it is to
IDT delivery.  (Almost as if we decided 15 years ago that giving the PV
guest kernel a good stack and GSbase was the right thing to do...)

In some copious free time, I think we ought to provide a
minorly-paravirt FRED to PV guests because there are still some
improvements available as low hanging fruit.

My plan was to have a PV hypervisor leaf advertising paravirt versions
of hardware features, so a guest could see "I don't have architectural
FRED, but I do have paravirt-FRED which is as similar as we can
reasonably make it".  The same goes for a whole bunch of other features.

~Andrew

